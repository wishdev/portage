# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/akregator/akregator-4.4.5.ebuild,v 1.4 2010/08/09 06:08:44 fauli Exp $

EAPI="3"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="KDE news feed aggregator."
KEYWORDS="~alpha amd64 ~ia64 ppc ~ppc64 ~sparc x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook"

DEPEND="
	$(add_kdebase_dep kdepimlibs)
	$(add_kdebase_dep libkdepim)
"
RDEPEND="${DEPEND}"

KMLOADLIBS="libkdepim"
