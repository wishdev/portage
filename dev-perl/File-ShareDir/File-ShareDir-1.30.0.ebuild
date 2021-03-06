# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-ShareDir/File-ShareDir-1.30.0.ebuild,v 1.1 2011/08/30 15:41:26 tove Exp $

EAPI=4

MODULE_AUTHOR=ADAMK
MODULE_VERSION=1.03
inherit perl-module

DESCRIPTION="Locate per-dist and per-module shared files"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-solaris"
IUSE=""

RDEPEND="dev-perl/Class-Inspector"
DEPEND="${RDEPEND}"

SRC_TEST="do"
