# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/num-utils/num-utils-0.5-r1.ebuild,v 1.1 2011/01/03 18:11:18 bicatali Exp $

EAPI="3"
inherit eutils

DEB_PR=11

DESCRIPTION="A set of programs for dealing with numbers from the command line"
SRC_URI="http://suso.suso.org/programs/num-utils/downloads/${P}.tar.gz
	mirror://debian/pool/main/${PN:0:1}/${PN}/${PN}_${PV}-${DEB_PR}.diff.gz"

HOMEPAGE="http://suso.suso.org/programs/num-utils/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_prepare() {
	epatch "${WORKDIR}"/${PN}_${PV}-${DEB_PR}.diff
	epatch "${S}"/debian/patches/*.diff
	local x
	for x in average bound interval normalize random range round; do
		mv $x num$x || die "renaming $x failed"
	done
	sed -i \
		-e 's/^RPMDIR/#RPMDIR/' \
		-e 's/COPYING//' \
		-e 's/LICENSE//' \
		-e '/^DOCS/s/MANIFEST//' \
		Makefile || die "sed Makefile failed"
}

src_install () {
	emake ROOT="${ED}" install || die "emake install failed"
}

pkg_postinst() {
	elog "All ${PN} programs have been renamed with prefix 'num' to avoid collisions"
}
