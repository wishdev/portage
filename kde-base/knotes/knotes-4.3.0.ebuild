# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/knotes/knotes-4.3.0.ebuild,v 1.1 2009/08/04 00:48:11 wired Exp $

EAPI="2"

KMNAME="kdepim"

inherit kde4-meta

DESCRIPTION="KDE Notes application"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug +handbook"

DEPEND=">=kde-base/libkdepim-${PV}:${SLOT}[kdeprefix=]"
RDEPEND="${DEPEND}"

KMLOADLIBS="libkdepim"
