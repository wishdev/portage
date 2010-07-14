# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-DB_File/perl-DB_File-1.820.ebuild,v 1.14 2010/07/14 06:25:14 tove Exp $

EAPI=2

DESCRIPTION="Virtual for DB_File"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

DEPEND=""
RDEPEND="|| ( ~dev-lang/perl-5.12.1[berkdb] ~dev-lang/perl-5.10.1[berkdb] ~perl-core/DB_File-${PV} )"
