# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Astro-FITS-Header/Astro-FITS-Header-3.0.ebuild,v 1.16 2010/01/21 12:15:18 tove Exp $

inherit perl-module

DESCRIPTION="interface to FITS headers"
HOMEPAGE="http://search.cpan.org/~tjenness/"
SRC_URI="mirror://cpan/authors/id/T/TJ/TJENNESS/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc s390 sh sparc x86"
IUSE=""

DEPEND="virtual/perl-Test-Simple
	dev-lang/perl"

SRC_TEST="do"
