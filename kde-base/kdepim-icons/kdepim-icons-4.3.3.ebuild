# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim-icons/kdepim-icons-4.3.3.ebuild,v 1.5 2009/12/10 15:12:08 fauli Exp $

EAPI="2"

KMNAME="kdepim"
KMMODULE="icons"
inherit kde4-meta

DESCRIPTION="KDE PIM icons"
IUSE=""
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ppc64 ~sparc x86"

src_install() {
	kde4-meta_src_install
	# colliding with oxygen icons
	rm -rf "${D}"/${KDEDIR}/share/icons/oxygen/16x16/status/meeting-organizer.png
}
