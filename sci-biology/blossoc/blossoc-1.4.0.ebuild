# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/blossoc/blossoc-1.4.0.ebuild,v 1.1 2009/02/07 18:16:42 weaver Exp $

DESCRIPTION="A linkage disequilibrium association mapping tool"
HOMEPAGE="http://www.daimi.au.dk/~mailund/Blossoc/"
SRC_URI="http://www.daimi.au.dk/~mailund/Blossoc/download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND="sci-libs/gsl
	dev-libs/boost
	sci-biology/snpfile"
RDEPEND="${DEPEND}"

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
}