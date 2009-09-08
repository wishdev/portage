# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-wavpack/gst-plugins-wavpack-0.10.15.ebuild,v 1.1 2009/09/08 02:19:02 leio Exp $

inherit gst-plugins-good

KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.23
	>=media-libs/gstreamer-0.10.23
	>=media-sound/wavpack-4.40"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
