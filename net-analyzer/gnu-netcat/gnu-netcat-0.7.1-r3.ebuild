# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/gnu-netcat/gnu-netcat-0.7.1-r3.ebuild,v 1.1 2010/07/26 22:42:46 jer Exp $

EAPI="3"

inherit eutils

DESCRIPTION="the GNU network swiss army knife"
HOMEPAGE="http://netcat.sourceforge.net/"
SRC_URI="mirror://sourceforge/netcat/netcat-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="nls debug"

DEPEND=""

S=${WORKDIR}/netcat-${PV}

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-flagcount.patch \
		"${FILESDIR}"/${PN}-close.patch \
		"${FILESDIR}"/${PN}-LC_CTYPE.patch

}

src_configure() {
	econf \
		$(use_enable nls) \
		$(use_enable debug)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	rm "${ED}"usr/bin/nc
	dodoc AUTHORS ChangeLog NEWS README TODO
}
