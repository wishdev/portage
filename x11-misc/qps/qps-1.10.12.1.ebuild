# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/qps/qps-1.10.12.1.ebuild,v 1.1 2009/12/17 23:13:35 spatz Exp $

EAPI="2"

inherit qt4-r2

DESCRIPTION="Visual process manager - Qt version of ps/top"
HOMEPAGE="http://qps.kldp.net/"
SRC_URI="http://kldp.net/frs/download.php/5394/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="x11-libs/qt-core:4
	x11-libs/qt-gui:4"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e '/strip/d' ${PN}.pro || die "sed failed"
}

src_install() {
	dobin ${PN} || die "installing binary failed"
	doman ${PN}.1 || die "installing man page failed"
	dodoc CHANGES || die "installing documentation failed"

	newicon icon/icon.xpm ${PN}.xpm || die "installing icon failed"
	domenu ${PN}.desktop || die "installing desktop file failed"
}
