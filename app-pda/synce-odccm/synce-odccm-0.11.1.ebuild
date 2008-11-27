# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-odccm/synce-odccm-0.11.1.ebuild,v 1.2 2008/11/13 17:11:32 mescalinum Exp $

DESCRIPTION="SynCE - odccm connection manager"
HOMEPAGE="http://sourceforge.net/projects/synce/"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="sys-apps/dbus
		sys-apps/hal
		>=net-libs/gnet-2.0.0
		!app-pda/synce-dccm
		!app-pda/synce-vdccm
		~app-pda/synce-libsynce-0.11.1
		~app-pda/synce-librapi2-0.11.1"
RDEPEND="${DEPEND}"

MY_P="odccm-${PV}"
SRC_URI="mirror://sourceforge/synce/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

src_install() {
	make DESTDIR="${D}" install || die

	insinto /etc/dbus-1/system.d/
	doins src/odccm.conf

	newinitd "${FILESDIR}"/init.odccm odccm

	dodoc AUTHORS INSTALL NEWS README ChangeLog
}