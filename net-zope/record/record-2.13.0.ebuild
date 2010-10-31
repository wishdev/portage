# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/record/record-2.13.0.ebuild,v 1.2 2010/10/30 18:13:41 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MY_PN="Record"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Special Record objects used in Zope2."
HOMEPAGE="http://pypi.python.org/pypi/Record"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~sparc ~x86"
IUSE=""

RDEPEND="net-zope/extensionclass"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt README.txt"
PYTHON_MODNAME="${MY_PN}"

distutils_src_test_pre_hook() {
	local module
	for module in Record; do
		ln -fs "../../$(ls -d build-${PYTHON_ABI}/lib.*)/${module}/_${module}.so" "src/${module}/_${module}.so" || die "Symlinking ${module}/_${module}.so failed with Python ${PYTHON_ABI}"
	done
}

src_install() {
	distutils_src_install
	python_clean_installation_image
}
