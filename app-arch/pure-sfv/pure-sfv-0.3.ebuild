# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/pure-sfv/pure-sfv-0.3.ebuild,v 1.16 2009/01/03 17:39:34 angelos Exp $

inherit eutils toolchain-funcs

DESCRIPTION="utility to test and create .sfv files and create .par files"
HOMEPAGE="http://pure-sfv.sourceforge.net/"
SRC_URI="mirror://sourceforge/pure-sfv/${PN}_${PV}_src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ppc sparc x86"
IUSE=""
RESTRICT="test"

DEPEND=""

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "s:-Werror -O2 -g::" Makefile
	epatch "${FILESDIR}"/${P}-asneeded.patch
}

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dobin pure-sfv || die "dobin failed"
	dodoc ReadMe.txt
}
