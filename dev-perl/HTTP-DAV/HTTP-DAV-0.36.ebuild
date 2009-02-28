# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTTP-DAV/HTTP-DAV-0.36.ebuild,v 1.1 2009/02/25 20:54:25 tove Exp $

MODULE_AUTHOR=OPERA
inherit perl-module

DESCRIPTION="A WebDAV client library for Perl5"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-perl/libwww-perl
	dev-perl/XML-DOM
	dev-lang/perl"
RDEPEND="${DEPEND}"

SRC_TEST="do"