# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/jpeginfo/jpeginfo-1.6.1.ebuild,v 1.2 2011/04/27 18:22:28 ssuominen Exp $

EAPI=4
inherit eutils toolchain-funcs

DESCRIPTION="Prints information and tests integrity of JPEG/JFIF files."
HOMEPAGE="http://www.kokkonen.net/tjko/projects.html"
SRC_URI="http://www.kokkonen.net/tjko/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

RDEPEND="virtual/jpeg"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.6.0-parallel_install.patch
}

src_configure() {
	tc-export CC
	econf
}

src_install() {
	emake INSTALL_ROOT="${D}" install
	dodoc README
}
