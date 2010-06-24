# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkexiv2/libkexiv2-4.4.4.ebuild,v 1.4 2010/06/24 10:04:08 angelos Exp $

EAPI="3"

KMNAME="kdegraphics"
KMMODULE="libs/libkexiv2"
inherit kde4-meta

DESCRIPTION="KDE Image Plugin Interface: an exiv2 library wrapper"
HOMEPAGE="http://www.kipi-plugins.org"

LICENSE="GPL-2"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	>=media-gfx/exiv2-0.18
	media-libs/jpeg
	=media-libs/lcms-1*
"
RDEPEND="${DEPEND}"
