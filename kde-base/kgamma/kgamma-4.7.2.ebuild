# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kgamma/kgamma-4.7.2.ebuild,v 1.1 2011/10/06 18:11:02 alexxy Exp $

EAPI=4

KDE_HANDBOOK="optional"
KDE_SCM="git"

inherit kde4-base

DESCRIPTION="KDE screen gamma values kcontrol module"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	x11-libs/libXxf86vm
"
DEPEND="${RDEPEND}
	x11-proto/xf86vidmodeproto
"
