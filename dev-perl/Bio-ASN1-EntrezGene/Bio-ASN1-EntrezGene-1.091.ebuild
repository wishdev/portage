# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Bio-ASN1-EntrezGene/Bio-ASN1-EntrezGene-1.091.ebuild,v 1.3 2009/05/24 15:59:26 weaver Exp $

inherit perl-module

DESCRIPTION="Regular expression-based Perl Parser for NCBI Entrez Gene"
HOMEPAGE="http://search.cpan.org/dist/Bio-ASN1-EntrezGene/lib/Bio/ASN1/EntrezGene.pm"
SRC_URI="mirror://cpan/authors/id/M/MI/MINGYILIU/${P}.tgz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
SRC_TEST="do"

DEPEND=""
RDEPEND=">=sci-biology/bioperl-1.6.0"

S="${WORKDIR}/${PN}-1.09"
