# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/asedriveiiie-serial/asedriveiiie-serial-3.5.ebuild,v 1.1 2009/04/10 21:11:49 arfrever Exp $

DESCRIPTION="ASEDriveIIIe Serial Card Reader"
HOMEPAGE="http://www.athena-scs.com"
SRC_URI="http://www.athena-scs.com/downloads/${P}.tar.bz2"
LICENSE="BSD"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"
RDEPEND=">=sys-apps/pcsc-lite-1.3.0
	>=dev-libs/libusb-0.1.10"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	local conf="/etc/reader.conf.d/${PN}.conf"

	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc ChangeLog README

	dodir "$(dirname "${conf}")"
	insinto "$(dirname "${conf}")"
	newins "etc/reader.conf" "$(basename "${conf}")"
}

pkg_postinst() {
	elog "NOTICE:"
	elog "1. Update ${conf} file"
	elog "2. Run update-reader.conf, yes this is a command..."
	elog "3. Restart pcscd"
}

pkg_postrm() {
	#
	# Without this, pcscd will not start next time.
	#
	local conf="/etc/reader.conf.d/${PN}.conf"
	if ! [ -f "$(grep LIBPATH "${conf}" | sed 's/LIBPATH *//' | sed 's/ *$//g' | head -n 1)" ]; then
		rm "${conf}"
		update-reader.conf
		elog "NOTICE:"
		elog "You need to restart pcscd"
	fi
}