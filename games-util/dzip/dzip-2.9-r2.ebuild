# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/dzip/dzip-2.9-r2.ebuild,v 1.1 2009/04/14 16:59:19 nyhm Exp $

EAPI=2
inherit eutils games

DESCRIPTION="compressor/uncompressor for demo recordings from id's Quake"
HOMEPAGE="http://speeddemosarchive.com/dzip/"
SRC_URI="http://speeddemosarchive.com/dzip/dz${PV/./}src.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

S=${WORKDIR}

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-system-zlib.patch \
		"${FILESDIR}"/${P}-scrub-names.patch #93079
	rm -rf zlib
	mv -f Makefile{.linux,}
}

src_install () {
	dogamesbin dzip || die "dogamesbin failed"
	dodoc Readme || die "dodoc failed"
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	elog "Demo files can be found at http://planetquake.com/sda/"
	elog "and http://planetquake.com/qdq/"
	echo
}