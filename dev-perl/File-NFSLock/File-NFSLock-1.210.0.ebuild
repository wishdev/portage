# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-NFSLock/File-NFSLock-1.210.0.ebuild,v 1.1 2011/07/14 13:53:45 tove Exp $

EAPI=4

MODULE_AUTHOR=BBB
MODULE_VERSION=1.21
inherit perl-module

DESCRIPTION="NFS compatible (safe) locking utility"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SRC_TEST="do"
