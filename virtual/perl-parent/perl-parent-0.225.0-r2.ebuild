# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-parent/perl-parent-0.225.0-r2.ebuild,v 1.1 2011/06/18 20:20:50 tove Exp $

DESCRIPTION="Virtual for ${PN#perl-}"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="|| ( =dev-lang/perl-5.14* ~perl-core/${PN#perl-}-${PV} )"
