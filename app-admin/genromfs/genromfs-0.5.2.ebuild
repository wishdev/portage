# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/genromfs/genromfs-0.5.2.ebuild,v 1.2 2008/09/22 19:14:37 vapier Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Create space-efficient, small, read-only romfs filesystems"
HOMEPAGE="http://romfs.sourceforge.net/"
SRC_URI="mirror://sourceforge/romfs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
	tc-export CC
}

src_install() {
	dobin genromfs || die
	doman genromfs.8
	dodoc ChangeLog NEWS genromfs.lsm genrommkdev readme-kernel-patch romfs.txt
}
