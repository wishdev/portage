# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/skstream/skstream-0.3.8.ebuild,v 1.1 2011/09/26 14:24:41 tupone Exp $
EAPI=2

inherit base eutils

DESCRIPTION="FreeSockets - Portable C++ classes for IP (sockets) applications"
SRC_URI="mirror://sourceforge/worldforge/${P}.tar.bz2"
HOMEPAGE="http://www.worldforge.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="test"

DEPEND="test? ( dev-util/cppunit )"
RDEPEND=""

PATCHES=( "${FILESDIR}"/${P}-test.patch )
DOCS=( AUTHORS ChangeLog NEWS README README.FreeSockets TODO )
