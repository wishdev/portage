# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/pythonscripts/pythonscripts-2.13.0.ebuild,v 1.2 2011/01/14 10:09:37 xarthisius Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 2.5 3.*"

inherit distutils

MY_PN="Products.PythonScripts"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Products.PythonScripts provides support for restricted execution of Python scripts in Zope 2."
HOMEPAGE="http://pypi.python.org/pypi/Products.PythonScripts"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-python/restrictedpython
	net-zope/accesscontrol
	net-zope/acquisition
	net-zope/datetime
	net-zope/documenttemplate
	net-zope/zexceptions
	>=net-zope/zope-2.12"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt README.txt"
PYTHON_MODNAME="${MY_PN/.//}"
