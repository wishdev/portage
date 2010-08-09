# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kstreamripper/kstreamripper-0.7.0.ebuild,v 1.2 2010/08/09 16:11:10 reavertm Exp $

EAPI=2

inherit kde4-base

DESCRIPTION="A program for ripping internet radios"
HOMEPAGE="http://kstreamripper.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2 GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	>=net-libs/libproxy-0.3.1
"
RDEPEND="${DEPEND}
	media-sound/streamripper
"

S=${WORKDIR}/${PN}

DOCS=(TODO.odt)
