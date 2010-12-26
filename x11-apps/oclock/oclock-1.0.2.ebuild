# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/oclock/oclock-1.0.2.ebuild,v 1.5 2010/12/25 19:53:36 fauli Exp $

EAPI=3

inherit xorg-2

DESCRIPTION="round X clock"

KEYWORDS="~alpha amd64 ~arm ~ia64 ~mips ~ppc ppc64 ~s390 ~sh ~sparc x86 ~amd64-linux ~ia64-linux ~x86-linux"
IUSE=""
RDEPEND="x11-libs/libX11
	x11-libs/libXmu
	x11-libs/libXext"
DEPEND="${RDEPEND}"
