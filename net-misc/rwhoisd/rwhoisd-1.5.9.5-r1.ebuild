# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rwhoisd/rwhoisd-1.5.9.5-r1.ebuild,v 1.1 2009/10/21 21:46:11 kingtaco Exp $

EAPI=0
inherit eutils

DESCRIPTION="ARIN rwhois daemon"
HOMEPAGE="http://projects.arin.net/rwhois/"
SRC_URI="http://projects.arin.net/rwhois/ftp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	cd "${S}"
	epatch "${FILESDIR}"/rwhoisd-destdir-${PV}.patch  || die "epatch failed"
	econf
	emake -j1
}

src_install () {
	emake -j1 install DESTDIR=${D}
	doinitd "${FILESDIR}"/rwhoisd  || die "doinitd failed"
	newconfd "${FILESDIR}"/rwhoisd.conf rwhoisd || die "newconfd failed"
}

pkg_setup() {
	enewgroup rwhoisd
	enewuser rwhoisd -1 -1 /var/rwhoisd rwhoisd
}

pkg_postinst () {
	einfo "Please make sure to set the userid in rwhoisd.conf to rwhoisd."
	einfo "It is highly inadvisable to run rwhoisd as root."
}
