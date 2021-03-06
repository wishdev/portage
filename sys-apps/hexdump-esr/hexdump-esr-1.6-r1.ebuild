# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hexdump-esr/hexdump-esr-1.6-r1.ebuild,v 1.1 2010/09/28 19:35:29 jer Exp $

EAPI="2"

inherit toolchain-funcs

MY_P=${P/-esr/}
DESCRIPTION="Eric Raymond's hex dumper"
HOMEPAGE="http://www.catb.org/~esr/hexdump/"
SRC_URI="http://www.catb.org/~esr/hexdump/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""
S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -i Makefile \
		-e 's|-O ||g' \
		|| die "sed Makefile"
}

src_compile() {
	emake CC="$(tc-getCC) ${CFLAGS} ${LDFLAGS}" || die
	mv hexdump hexdump-esr
	mv hexdump.1 hexdump-esr.1
}

src_install() {
	dobin hexdump-esr || die
	doman hexdump-esr.1
	dodoc README
	dosym hexdump-esr /usr/bin/hex
}
