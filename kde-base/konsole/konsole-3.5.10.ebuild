# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/konsole/konsole-3.5.10.ebuild,v 1.1 2008/09/13 23:59:18 carlo Exp $

KMNAME=kdebase
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="X terminal for use with KDE."
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

RDEPEND="x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXrender
		x11-libs/libXtst"

DEPEND="${RDEPEND}
		x11-apps/bdftopcf"

# For kcm_konsole module
RDEPEND="${RDEPEND}
	>=kde-base/kcontrol-${PV}:${SLOT}"
