# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvdread/libdvdread-4.1.3_p1168.ebuild,v 1.15 2011/10/10 22:57:36 beandog Exp $

EAPI=4
WANT_AUTOCONF=2.5

inherit autotools libtool multilib

DESCRIPTION="Library for DVD navigation tools"
HOMEPAGE="http://dvdnav.mplayerhq.hu/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="+css"

RDEPEND="!<=media-libs/libdvdnav-4.1.2
	css? ( media-libs/libdvdcss )"
DEPEND="${RDEPEND}"

DOCS=( AUTHORS DEVELOPMENT-POLICY.txt ChangeLog TODO README )

src_prepare() {
	elibtoolize
	eautoreconf
}

src_install() {
	default
	rm -f "${ED}"usr/lib*/${PN}.la
}
