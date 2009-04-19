# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdf/kdf-4.2.2.ebuild,v 1.2 2009/04/17 06:47:27 alexxy Exp $

EAPI="2"

KMNAME="kdeutils"
inherit kde4-meta

DESCRIPTION="KDE free disk space utility"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug doc"

src_unpack() {
	if use doc; then
		KMEXTRA="doc/kcontrol/blockdevices"
	fi

	kde4-meta_src_unpack
}