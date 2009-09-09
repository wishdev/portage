# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/scientificpython/scientificpython-2.9.ebuild,v 1.2 2009/09/05 01:33:12 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

MY_PN="ScientificPython"
DV="2372" # hardcoded download version

DESCRIPTION="Scientific Module for Python"
SRC_URI="http://sourcesup.cru.fr/frs/download.php/${DV}/${MY_PN}-${PV}.tar.gz"
HOMEPAGE="http://sourcesup.cru.fr/projects/scientific-py/"
SLOT="0"
LICENSE="CeCILL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"

IUSE="doc mpi"

DEPEND="dev-python/numpy
	sci-libs/netcdf
	mpi? ( virtual/mpi )"
RDEPEND="${DEPEND}"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_PN}-${PV}.0"

PYTHON_MODNAME="Scientific"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${P}-mpi.patch"
}

src_compile() {
	distutils_src_compile
	if use mpi; then
		cd Src/MPI
		building_of_mpipython() {
			PYTHONPATH="$(ls -d ../../build-${PYTHON_ABI}/lib*)" "$(PYTHON)" compile.py
			mv -f mpipython mpipython-${PYTHON_ABI}
		}
		python_execute_function --action-message 'Building of mpipython with Python ${PYTHON_ABI}...' --failure-message 'Building of mpipython failed with Python ${PYTHON_ABI}' building_of_mpipython
	fi
}

src_test() {
	cd Tests
	testing() {
		for test in *tests.py; do
			PYTHONPATH="$(ls -d ../build-${PYTHON_ABI}/lib*)" "$(PYTHON)" "${test}" || die "test ${test} failed with Python ${PYTHON_ABI}"
		done
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	# do not install bsp related stuff, since we don't compile the interface
	dodoc README README.MPI Doc/CHANGELOG || die "dodoc failed"
	insinto /usr/share/doc/${PF}
	doins Examples/{demomodule.c,netcdf_demo.py} || die "doins examples failed"
	if use mpi; then
		installation_of_mpipython() {
			dobin Src/MPI/mpipython-${PYTHON_ABI}
		}
		python_execute_function -q installation_of_mpipython
		doins Examples/mpi.py || die "doins mpi example failed failed"
	fi
	if use doc; then
		dohtml Doc/Reference/* || die "dohtml failed"
	fi
}