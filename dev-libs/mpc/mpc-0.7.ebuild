# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/mpc/mpc-0.7.ebuild,v 1.2 2009/09/12 10:11:00 maekke Exp $

EAPI=0

DESCRIPTION="A library for multiprecision complex arithmetic with exact rounding."
HOMEPAGE="http://mpc.multiprecision.org/"
SRC_URI="http://www.multiprecision.org/mpc/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-libs/gmp-4.1.3
		>=dev-libs/mpfr-2.3.1"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc "${S}"/{ChangeLog,NEWS,README,TODO}
}