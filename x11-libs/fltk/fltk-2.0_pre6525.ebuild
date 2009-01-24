# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/fltk/fltk-2.0_pre6525.ebuild,v 1.7 2009/01/18 12:10:46 klausman Exp $

EAPI="1"
inherit multilib autotools flag-o-matic

MY_P=${P/_pre/.x-r}
DESCRIPTION="C++ user interface toolkit for X and OpenGL"
HOMEPAGE="http://www.fltk.org/"
SRC_URI="mirror://easysw/fltk/snapshots/${MY_P}.tar.bz2"

KEYWORDS="~alpha ~amd64 ~hppa ~ppc ppc64 ~sparc ~x86"
LICENSE="FLTK LGPL-2"
SLOT="2"
IUSE="cairo debug doc +jpeg +png opengl +xft xinerama zlib"

RDEPEND="x11-libs/libXext
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libXt
	xft? ( x11-libs/libXft )
	png? ( media-libs/libpng )
	jpeg? ( media-libs/jpeg )
	opengl? ( virtual/opengl )
	cairo? ( x11-libs/cairo )
	xinerama? ( x11-libs/libXinerama )
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	xinerama? ( x11-proto/xineramaproto )
	cairo? ( dev-util/pkgconfig )
	doc? ( app-doc/doxygen )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/fltk2-config.patch
	sed -i "/STRIP/d" fluid/Makefile  # don't pre-strip, bug 246694
	use opengl || epatch "${FILESDIR}"/fltk2-nogl.patch
	eautoreconf
}

src_compile() {
	append-flags -fno-strict-aliasing

	CPPFLAGS="${CPPFLAGS} -DFLTK_DOCDIR=\"/usr/share/doc/${PF}\"" \
	econf --enable-shared --enable-threads \
		$(use_enable debug) \
		$(use_enable xft) \
		$(use_enable opengl gl) \
		$(use_enable cairo) \
		$(use_enable jpeg) \
		$(use_enable png) \
		$(use_enable xinerama) \
		$(use_enable zlib)

	emake || die "make failed"

	if use doc; then
		make -C documentation || die "make documentation failed"
	fi
}

src_install() {
	einstall includedir="${D}/usr/include" libdir="${D}/usr/$(get_libdir)/fltk"

	if use doc; then
		emake -C documentation install || die "install documentation failed"
		dohtml -r documentation/html/* || die "install html documentation failed"
	fi
	dodoc CHANGES CREDITS README* TODO

	echo "LDPATH=/usr/$(get_libdir)/fltk" > 99fltk-${SLOT}
	echo "FLTK_DOCDIR=/usr/share/doc/${PF}/html" >> 99fltk-${SLOT}

	doenvd 99fltk-${SLOT} || die "installing env.d file failed"
}