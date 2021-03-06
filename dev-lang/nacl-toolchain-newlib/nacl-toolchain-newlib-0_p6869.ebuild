# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/nacl-toolchain-newlib/nacl-toolchain-newlib-0_p6869.ebuild,v 1.3 2011/10/11 23:14:14 phajdan.jr Exp $

EAPI="4"

inherit eutils multilib

BINUTILS_PV="2.20.1"
NEWLIB_PV="1.18.0"
GCC_PV="4.4.3"
NACL_REVISION="${PV##*_p}"

DESCRIPTION="Native Client newlib-based toolchain (only for compiling IRT)"
HOMEPAGE="http://code.google.com/chrome/nativeclient/"
SRC_URI="mirror://gnu/binutils/binutils-${BINUTILS_PV}.tar.bz2
	ftp://sources.redhat.com/pub/newlib/newlib-${NEWLIB_PV}.tar.gz
	mirror://gnu/gcc/gcc-${GCC_PV}/gcc-${GCC_PV}.tar.bz2
	http://gsdview.appspot.com/nativeclient-archive2/x86_toolchain/r${NACL_REVISION}/nacltoolchain-buildscripts-r${NACL_REVISION}.tar.gz
	http://gsdview.appspot.com/nativeclient-archive2/x86_toolchain/r${NACL_REVISION}/naclbinutils-${BINUTILS_PV}-r${NACL_REVISION}.patch.bz2
	http://gsdview.appspot.com/nativeclient-archive2/x86_toolchain/r${NACL_REVISION}/naclnewlib-${NEWLIB_PV}-r${NACL_REVISION}.patch.bz2
	http://gsdview.appspot.com/nativeclient-archive2/x86_toolchain/r${NACL_REVISION}/naclgcc-${GCC_PV}-r${NACL_REVISION}.patch.bz2
"

LICENSE="BSD" # NaCl
LICENSE+=" || ( GPL-3 LGPL-3 )" # binutils
LICENSE+=" NEWLIB LIBGLOSS GPL-2" # newlib
LICENSE+=" GPL-3 LGPL-3 || ( GPL-3 libgcc libstdc++ gcc-runtime-library-exception-3.1 ) FDL-1.2" # gcc

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=dev-libs/gmp-5.0.2
	>=dev-libs/mpfr-3.0.1
	>=sys-libs/glibc-2.8
	>=sys-libs/zlib-1.1.4
"
DEPEND="${RDEPEND}
	app-arch/zip
	app-arch/unzip
	dev-libs/mpc
	dev-libs/cloog-ppl
	dev-libs/ppl
	>=media-libs/libart_lgpl-2.1
	>=sys-apps/texinfo-4.8
	>=sys-devel/binutils-2.15.94
	>=sys-devel/bison-1.875
	>=sys-devel/flex-2.5.4
	sys-devel/gnuconfig
	sys-devel/m4
	>=sys-libs/ncurses-5.2-r2
	>=sys-apps/sed-4
	sys-devel/gettext
	virtual/libiconv
	virtual/yacc
"

S="${WORKDIR}"

src_prepare() {
	mkdir SRC || die
	mv binutils-${BINUTILS_PV} SRC/binutils || die
	mv newlib-${NEWLIB_PV} SRC/newlib || die
	mv gcc-${GCC_PV} SRC/gcc || die
	cd SRC || die
	EPATCH_SUFFIX="patch" EPATCH_FORCE="yes" epatch "${S}"
}

src_compile() {
	emake PREFIX="${PWD}/${PN}" CANNED_REVISION="yes" build-with-newlib
}

src_install() {
	local TOOLCHAIN_HOME="/usr/$(get_libdir)"
	dodir "${TOOLCHAIN_HOME}"
	mv "${WORKDIR}/${PN}" "${ED}/${TOOLCHAIN_HOME}" || die
}
