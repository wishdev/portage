# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepasswd/kdepasswd-4.3.3.ebuild,v 1.5 2009/12/10 15:11:23 fauli Exp $

EAPI="2"

KMNAME="kdebase-apps"
inherit kde4-meta

DESCRIPTION="KDE GUI for passwd"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ppc64 ~sparc x86"
IUSE="debug +handbook"

DEPEND="
	$(add_kdebase_dep libkonq)
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kdesu)
"

KMLOADLIBS="libkonq"
