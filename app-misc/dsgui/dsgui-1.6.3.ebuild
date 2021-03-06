# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/dsgui/dsgui-1.6.3.ebuild,v 1.1 2011/10/05 20:22:21 scarabeus Exp $

EAPI=3

PYTHON_DEPEND="2"

inherit distutils

DESCRIPTION="GUI to access Czech eGov \"Datove schranky\""
HOMEPAGE="http://labs.nic.cz/page/740/dsgui/"
SRC_URI="http://labs.nic.cz/files/labs/datove_schranky/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/pygtk:2
	dev-python/pyopenssl
	dev-python/reportlab
	dev-python/sqlalchemy
	media-fonts/dejavu
	>=net-libs/dslib-1.6
"
RDEPEND="${DEPEND}"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	python_convert_shebangs -r 4 "${WORKDIR}"
}

src_install() {
	distutils_src_install
	rm -rf "${ED}"/usr/share/dsgui/fonts/*
	dosym /usr/share/fonts/dejavu/DejaVuSans.ttf /usr/share/dsgui/fonts/DejaVuSans.ttf
}
