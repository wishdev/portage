# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/boswars/boswars-2.6.1.ebuild,v 1.5 2010/11/20 02:15:54 mr_bones_ Exp $

EAPI=2
inherit eutils scons-utils games

DESCRIPTION="Futuristic real-time strategy game"
HOMEPAGE="http://www.boswars.org/"
SRC_URI="http://www.boswars.org/dist/releases/${P}-src.tar.gz
	mirror://gentoo/bos.png"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND="dev-lang/lua
	media-libs/libsdl[audio,video]
	media-libs/libpng
	media-libs/libvorbis
	media-libs/libtheora
	media-libs/libogg
	virtual/opengl
	x11-libs/libX11"

S=${WORKDIR}/${P}-src

src_prepare() {
	rm -f doc/{README-SDL.txt,guichan-copyright.txt}
	epatch \
		"${FILESDIR}"/${P}-gentoo.patch \
		"${FILESDIR}"/${P}-scons-blows.patch
	sed -i \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:" \
		engine/include/stratagus.h \
		|| die "sed stratagus.h failed"
	sed -i \
		-e "/-O2/s:-O2.*math:${CXXFLAGS} -Wall:" \
		SConstruct \
		|| die "sed SConstruct failed"
}

src_compile() {
	escons || die
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r campaigns graphics intro languages maps patches scripts sounds units \
		|| die "doins failed"
	newicon "${DISTDIR}"/bos.png ${PN}.png
	make_desktop_entry ${PN} "Bos Wars"
	dodoc CHANGELOG COPYRIGHT.txt README.txt
	dohtml -r doc/*
	prepgamesdirs
}
