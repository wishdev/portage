# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-UUID/Data-UUID-1.217.0.ebuild,v 1.1 2011/08/31 12:54:41 tove Exp $

EAPI=4

MODULE_AUTHOR=RJBS
MODULE_VERSION=1.217
inherit perl-module

DESCRIPTION="Perl extension for generating Globally/Universally Unique Identifiers (GUIDs/UUIDs)"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

RDEPEND="virtual/perl-Digest-MD5"
DEPEND="${RDEPEND}"

SRC_TEST="do"
