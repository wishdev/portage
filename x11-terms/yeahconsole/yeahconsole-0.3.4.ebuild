# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/yeahconsole/yeahconsole-0.3.4.ebuild,v 1.3 2009/02/26 16:49:52 jer Exp $

inherit eutils toolchain-funcs

DESCRIPTION="yeahconsole turns an xterm or rxvt-unicode into a game-like console"
HOMEPAGE="http://phrat.de/yeahtools.html"
SRC_URI="http://phrat.de/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~hppa ~x86"

IUSE=""
RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}
	x11-proto/xproto"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-make.patch
}

src_compile() {
	tc-export CC
	emake || die "make failed"
}

src_install() {
	dodir /usr/bin
	emake PREFIX="${D}"/usr install || die "emake install failed"
	dodoc README
}

pkg_postinst() {
	elog "Do not forget to emerge an xterm compatible terminal emulator"
	elog "(perhaps x11-terms/xterm or x11-terms/rxvt-unicode), or"
	elog "${PN} will not work ;-)."
}