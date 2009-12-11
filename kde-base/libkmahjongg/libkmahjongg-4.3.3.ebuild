# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkmahjongg/libkmahjongg-4.3.3.ebuild,v 1.5 2009/12/10 17:24:41 fauli Exp $

EAPI="2"

KMNAME="kdegames"
inherit kde4-meta

DESCRIPTION="LibKMahjongg for KDE"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ppc64 ~sparc x86"
IUSE="debug"

KMLOADLIBS="libkdegames"
