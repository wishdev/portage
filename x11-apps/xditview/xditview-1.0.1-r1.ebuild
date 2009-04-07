# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xditview/xditview-1.0.1-r1.ebuild,v 1.3 2009/04/06 16:20:06 bluebird Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="display ditroff output"
KEYWORDS="~arm ~mips ~ppc ~ppc64 ~s390 ~sh sparc x86"
IUSE=""
RDEPEND="x11-libs/libXaw"
DEPEND="${RDEPEND}"

CONFIGURE_OPTIONS="--disable-xprint"
