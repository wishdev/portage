# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xrootconsole/xrootconsole-0.4-r1.ebuild,v 1.16 2011/06/15 15:53:43 jer Exp $

inherit eutils

DESCRIPTION="A utility that displays its input in a text box on your root window"
HOMEPAGE="http://sourceforge.net/projects/xrootconsole/"
SRC_URI="http://de-fac.to/bob/xrootconsole/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ppc ~amd64"
IUSE=""

RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}
	x11-proto/xproto"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}.parse-color.patch
}

src_install() {
	dodir /usr/bin
	make BINDIR="${D}usr/bin/" install || die
}
