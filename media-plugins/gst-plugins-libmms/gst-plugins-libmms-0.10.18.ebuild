# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-libmms/gst-plugins-libmms-0.10.18.ebuild,v 1.4 2010/06/27 13:36:41 nixnut Exp $

inherit gst-plugins-bad

KEYWORDS="~alpha amd64 ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.27
	>=media-libs/libmms-0.4"
DEPEND="${RDEPEND}"
