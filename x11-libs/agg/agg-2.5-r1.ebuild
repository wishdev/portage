# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/agg/agg-2.5-r1.ebuild,v 1.1 2009/03/26 14:00:32 scarabeus Exp $

EAPI="2"

inherit eutils autotools base

DESCRIPTION="Anti-Grain Geometry - A High Quality Rendering Engine for C++"
HOMEPAGE="http://antigrain.com/"
SRC_URI="http://antigrain.com/${P}.tar.gz"
LICENSE="X11"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="+gpc +truetype +X"

# preffer X with enabled xcb, really
RDEPEND="
	media-libs/libsdl[X?]
	X? ( x11-libs/libX11[xcb] )
	truetype? ( media-libs/freetype:2 )
"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
"

# taken from debian
PATCHES=(
	"${FILESDIR}/${PV}/02_maintainer_mode.patch"
	"${FILESDIR}/${PV}/03_pkg_config_pic.patch"
	"${FILESDIR}/${PV}/04_no_rpath.patch"
)

src_prepare() {
	base_src_prepare
	sed -r -i \
		-e 's:^(.*)  -L@.*:\1:' \
		src/platform/X11/Makefile.am || die "Failed to sed"
	eautoreconf
}

src_configure() {
	# examples are not (yet) installed, so do not compile them
	# sdl is harddep only sdl-tests are optional so we enable them anyway
	econf \
		--enable-ctrl \
		--enable-sdltest \
		--disable-examples \
		--disable-dependency-tracking \
		$(use_enable gpc gpc) \
		$(use_enable truetype freetype) \
		$(use_with X x)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc readme authors ChangeLog news
}