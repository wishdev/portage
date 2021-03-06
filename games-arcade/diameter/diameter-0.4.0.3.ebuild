# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/diameter/diameter-0.4.0.3.ebuild,v 1.5 2010/09/11 21:01:08 mr_bones_ Exp $

EAPI=2
inherit eutils autotools games

DESCRIPTION="Arcade game with elements of economy and adventure"
HOMEPAGE="http://gamediameter.sourceforge.net/"
SRC_URI="mirror://sourceforge/gamediameter/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=dev-games/guichan-0.8[opengl,sdl]
	media-libs/libpng
	virtual/opengl
	virtual/glu
	media-libs/libsdl[video]
	media-libs/sdl-image[gif,jpeg,png]
	media-libs/sdl-mixer"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/gamediameter

src_prepare() {
	sed -i \
		-e "s:gamediameter:diameter:" \
		configure.in \
		|| die
	# bug #336812
	sed -i \
		-e '/gui nebular3.gif/s/gui//' \
		data/texture/Makefile.am \
		|| die
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	newicon data/texture/gui/eng/main/logo.png ${PN}.png
	make_desktop_entry ${PN} Diameter
	dodoc README
	prepgamesdirs
}
