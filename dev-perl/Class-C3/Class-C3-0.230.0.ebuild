# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-C3/Class-C3-0.230.0.ebuild,v 1.3 2011/09/24 13:26:07 grobian Exp $

EAPI=4

MODULE_AUTHOR=FLORA
MODULE_VERSION=0.23
inherit perl-module

DESCRIPTION="A pragma to use the C3 method resolution order algortihm"

SLOT="0"
KEYWORDS="~alpha amd64 ia64 ppc ~ppc64 sparc x86 ~ppc-macos ~x64-macos ~x86-solaris"
IUSE="test"

RDEPEND="
	|| ( >=dev-lang/perl-5.10
		>=dev-perl/Class-C3-XS-0.07 )"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST=do
