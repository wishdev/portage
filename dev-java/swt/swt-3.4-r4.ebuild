# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/swt/swt-3.4-r4.ebuild,v 1.3 2009/09/16 17:50:44 fauli Exp $

EAPI="1"

inherit eutils java-pkg-2 java-ant-2 toolchain-funcs java-osgi

MY_PV="${PV/_pre/M}"
MY_DMF="download.eclipse.org/eclipse/downloads/drops/R-${MY_PV}-200806172000"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="GTK based SWT Library"
HOMEPAGE="http://www.eclipse.org/"
SRC_URI="x86? (
			http://${MY_DMF}/${MY_P}-gtk-linux-x86.zip
		)
		x86-fbsd? (
			http://${MY_DMF}/${MY_P}-gtk-linux-x86.zip
		)
		amd64? (
			http://${MY_DMF}/${MY_P}-gtk-linux-x86_64.zip
		)
		ppc? (
			http://${MY_DMF}/${MY_P}-gtk-linux-ppc.zip
		)
		ppc64? (
			http://${MY_DMF}/${MY_P}-gtk-linux-x86_64.zip
		)"

SLOT="3.4"
LICENSE="CPL-1.0 LGPL-2.1 MPL-1.1"
KEYWORDS="~amd64 ~ppc ppc64 x86"

IUSE="cairo gnome opengl xulrunner"
COMMON=">=dev-libs/glib-2.6
		>=x11-libs/gtk+-2.6.8
		>=dev-libs/atk-1.10.2
		cairo? ( >=x11-libs/cairo-1.4.14 )
		gnome?	(
				=gnome-base/libgnome-2*
				=gnome-base/gnome-vfs-2*
				=gnome-base/libgnomeui-2*
				)
		xulrunner? ( net-libs/xulrunner:1.9 )
		opengl?	(
			virtual/opengl
			virtual/glu
		)"

# Use a blocker to avoid file collisions when upgrading to the slotted version
# We cannot use slotmove, java packages are expected to be in /usr/share/PN-SLOT
# so this is the only way to prevent collisions

DEPEND=">=virtual/jdk-1.4
		!=dev-java/swt-3.4*:3
		app-arch/unzip
		x11-libs/libX11
		x11-libs/libXrender
		x11-libs/libXt
		x11-proto/xextproto
		x11-proto/inputproto
		dev-util/pkgconfig
		${COMMON}"

RDEPEND=">=virtual/jre-1.4
	x11-libs/libXtst
	${COMMON}"

S="${WORKDIR}"

src_unpack() {
	local DISTFILE=${A}
	unzip -jq "${DISTDIR}"/${DISTFILE} "*src.zip" || die "Unable to extract distfile"
	unpack "./src.zip"

	# Cleanup the redirtied directory structure
	rm -rf about_files/ || die

	# Replace the build.xml to allow compilation without Eclipse tasks
	cp "${FILESDIR}/build.xml" "${S}/build.xml" || die "Unable to update build.xml"
	mkdir "${S}/src" && mv "${S}/org" "${S}/src" || die "Unable to restructure SWT sources"

	# Fix Makefiles to respect flags and work with --as-needed
	epatch "${FILESDIR}"/as-needed-and-flag-fixes.patch

	# Kill some strict-aliasing warnings
	epatch "${FILESDIR}/${PN}-3.3-callback-pointer-dereferencing.patch"

	# bug 241400
	if use amd64 || use ppc64; then
		epatch "${FILESDIR}/${PN}-3.4-xulrunner-1.9.1-amd64.patch"
	else
		epatch "${FILESDIR}/${PN}-3.4-xulrunner-1.9.1.patch"
	fi
}

src_compile() {
	# Drop jikes support as it seems to be unfriendly with SWT
	java-pkg_filter-compiler jikes

	local AWT_ARCH
	local JAWTSO="libjawt.so"
	if [[ $(tc-arch) == 'x86' ]] ; then
		AWT_ARCH="i386"
	elif [[ $(tc-arch) == 'ppc' ]] ; then
		AWT_ARCH="ppc"
	elif [[ $(tc-arch) == 'ppc64' ]] ; then
		AWT_ARCH="ppc64"
	else
		AWT_ARCH="amd64"
	fi
	if [[ -f "${JAVA_HOME}/jre/lib/${AWT_ARCH}/${JAWTSO}" ]]; then
		export AWT_LIB_PATH="${JAVA_HOME}/jre/lib/${AWT_ARCH}"
	elif [[ -f "${JAVA_HOME}/jre/bin/${JAWTSO}" ]]; then
		export AWT_LIB_PATH="${JAVA_HOME}/jre/bin"
	elif [[ -f "${JAVA_HOME}/$(get_libdir)/${JAWTSO}" ]] ; then
		export AWT_LIB_PATH="${JAVA_HOME}/$(get_libdir)"
	else
		eerror "${JAWTSO} not found in the JDK being used for compilation!"
		die "cannot build AWT library"
	fi

	# Fix the pointer size for AMD64
	[[ ${ARCH} == "amd64" || ${ARCH} == "ppc64" ]] && export SWT_PTR_CFLAGS=-DSWT_PTR_SIZE_64

	local platform="linux"

	use elibc_FreeBSD && platform="freebsd"

	local make="emake -f make_${platform}.mak NO_STRIP=y CC=$(tc-getCC) CXX=$(tc-getCXX)"

	einfo "Building AWT library"
	${make} make_awt || die "Failed to build AWT support"

	einfo "Building SWT library"
	${make} make_swt || die "Failed to build SWT support"

	einfo "Building JAVA-AT-SPI bridge"
	${make} make_atk || die "Failed to build ATK support"

	if use gnome ; then
		einfo "Building GNOME VFS support"
		${make} make_gnome || die "Failed to build GNOME VFS support"
	fi

	if use xulrunner ; then
		einfo "Building the Mozilla component against xulrunner-1.9"

		export MOZILLA_INCLUDES="$(pkg-config --cflags libxul libxul-embedding)"
		# the -R is a workaround for bug #234934
		export MOZILLA_LIBS="-Wl,-R$(pkg-config libxul --variable=sdkdir) $(pkg-config --libs libxul libxul-embedding)"

		${make} make_mozilla || die "Failed to build Mozilla support"

		# upstream ships libswt-xulrunner*.so even though the build.sh does not
		# build it anymore... missing this file leads to another instance
		# of bug #234934 so we build it too
		einfo "Building the xulrunner component against xulrunner-1.9"

		export XULRUNNER_INCLUDES="${MOZILLA_INCLUDES}"
		export XULRUNNER_LIBS="${MOZILLA_LIBS}"

		${make} make_xulrunner || die "Failed to build xulrunner support"

		${make} make_xpcominit || die "Failed to build xpcominit support"
	fi

	if use cairo ; then
		einfo "Building CAIRO support"
		${make} make_cairo || die "Unable to build CAIRO support"
	fi

	if use opengl ; then
		einfo "Building OpenGL component"
		${make} make_glx || die "Unable to build OpenGL component"
	fi

	einfo "Building JNI libraries"
	eant compile

	einfo "Copying missing files"
	cp -i "${S}/version.txt" "${S}/build/version.txt"
	cp -i "${S}/src/org/eclipse/swt/internal/SWTMessages.properties" \
		"${S}/build/org/eclipse/swt/internal/"

	einfo "Packing JNI libraries"
	eant jar
}

src_install() {
	swtArch=${ARCH}
	use amd64 && swtArch=x86_64
	use x86-fbsd && swtArch=x86

	sed "s/SWT_ARCH/${swtArch}/" "${FILESDIR}/${PN}-3.4-manifest" > "MANIFEST_TMP.MF"
	java-osgi_newjar-fromfile "swt.jar" "MANIFEST_TMP.MF" "Standard Widget Toolkit for GTK 2.0"

	java-pkg_sointo /usr/$(get_libdir)
	java-pkg_doso *.so

	if use xulrunner; then
		local gecko_dir="$(pkg-config libxul --variable=sdkdir)"
		java-pkg_register-environment-variable MOZILLA_FIVE_HOME "${gecko_dir}"
	fi

	dohtml about.html || die
}

pkg_postinst() {
	if use xulrunner; then
		local gecko_dir="$(pkg-config libxul --variable=sdkdir)"
		elog "You built swt with xulrunner support. For your custom applications please set"
		elog "MOZILLA_FIVE_HOME environment variable to ${gecko_dir}"
	fi
}
