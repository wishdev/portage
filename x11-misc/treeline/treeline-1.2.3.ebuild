# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/treeline/treeline-1.2.3.ebuild,v 1.7 2010/07/14 16:33:48 arfrever Exp $

EAPI="2"
PYTHON_DEPEND="2"
PYTHON_USE_WITH="xml"
SUPPORT_PYTHON_ABIS="1"

inherit eutils python

DESCRIPTION="TreeLine is a structured information storage program."
HOMEPAGE="http://treeline.bellz.org/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="spell"

LANGS="de fr"
for lang in ${LANGS}; do
	IUSE="${IUSE} linguas_${lang}"
	SRC_URI="${SRC_URI} linguas_${lang}? ( mirror://berlios/${PN}/${PN}-i18n-${PV}a.tar.gz )"
done

DEPEND="spell? ( || ( app-text/aspell app-text/ispell ) )
	dev-python/PyQt4[X]"
RDEPEND="${DEPEND}"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/TreeLine"

src_unpack() {
	unpack ${P}.tar.gz
	for lang in ${LANGS}; do
		if use linguas_${lang}; then
			tar xozf "${DISTDIR}"/${PN}-i18n-${PV}a.tar.gz \
				TreeLine/doc/{readme_${lang}.trl,README_${lang}.html} \
				TreeLine/translations/{treeline_${lang}.{qm,ts},qt_${lang}.{qm,ts}} || die
		fi
	done
}

src_prepare() {
	# Let's leave compiling to python_mod_optimize().
	epatch "${FILESDIR}"/${P}-nocompile.patch

	rm doc/LICENSE

	python_copy_sources

	preparation() {
		# install into proper python site-packages dir
		sed -i "s;prefixDir, 'lib;'$(python_get_sitedir);" install.py
	}
	python_execute_function -s preparation
}

src_install() {
	installation() {
		"$(PYTHON)" install.py -x -p /usr/ -d /usr/share/doc/${PF} -b "${D}"
	}
	python_execute_function -s installation
}

pkg_postinst() {
	python_mod_optimize ${PN}
}

pkg_postrm() {
	python_mod_cleanup ${PN}
}
