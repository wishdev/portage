# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk-scripts/kdesdk-scripts-4.4.5.ebuild,v 1.4 2010/08/09 07:28:28 fauli Exp $

EAPI="3"

KMNAME="${PN/-*/}"
KMMODULE="${PN/*-/}"

inherit kde4-meta

DESCRIPTION="KDE SDK Scripts"
KEYWORDS="~alpha amd64 ~ia64 ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="+handbook debug"

src_prepare() {
	# bug 275069
	sed -ie 's:colorsvn::' scripts/CMakeLists.txt || die

	kde4-meta_src_prepare
}
