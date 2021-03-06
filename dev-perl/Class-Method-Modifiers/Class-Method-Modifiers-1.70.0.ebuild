# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Method-Modifiers/Class-Method-Modifiers-1.70.0.ebuild,v 1.2 2011/06/14 17:27:33 grobian Exp $

EAPI=4

MODULE_AUTHOR=SARTAK
MODULE_VERSION=1.07
inherit perl-module

DESCRIPTION="provides Moose-like method modifiers"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc-macos ~x86-solaris"
IUSE="test"

RDEPEND="
"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.42
	test? (
		dev-perl/Test-Fatal
	)
"

SRC_TEST=do
