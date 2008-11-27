# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkonq/libkonq-4.1.3.ebuild,v 1.2 2008/11/16 08:19:50 vapier Exp $

EAPI="2"

KMNAME=kdebase
KMMODULE=apps/lib/konq
CPPUNIT_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="The embeddable part of konqueror"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"
RESTRICT="test"
PATCHES=("${FILESDIR}/fix_includes_install.patch")
KMSAVELIBS="true"