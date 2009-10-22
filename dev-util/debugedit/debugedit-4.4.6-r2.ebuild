# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/debugedit/debugedit-4.4.6-r2.ebuild,v 1.1 2009/10/21 07:40:50 loki_val Exp $

inherit toolchain-funcs eutils

DESCRIPTION="Standalone debugedit taken from rpm"

HOMEPAGE="http://www.rpm.org/"
SRC_URI="http://dev.gentoo.org/~tester/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="dev-libs/popt
	dev-libs/elfutils"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/${P}-busted-paths-with-O0.patch"
	epatch "${FILESDIR}/${P}-update.patch"
}

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dobin debugedit
}
