# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/lsscsi/lsscsi-0.24.ebuild,v 1.4 2011/06/15 15:31:55 jer Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="SCSI sysfs query tool"
HOMEPAGE="http://sg.danny.cz/scsi/lsscsi.html"
SRC_URI="http://sg.danny.cz/scsi/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=sys-fs/sysfsutils-1.2.0"

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS CREDITS ChangeLog NEWS README
}
