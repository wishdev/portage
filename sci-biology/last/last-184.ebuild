# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/last/last-184.ebuild,v 1.1 2011/09/25 22:45:35 weaver Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="Genome-scale comparison of biological sequences"
HOMEPAGE="http://last.cbrc.jp/"
SRC_URI="http://last.cbrc.jp/archive/${P}.zip"

LICENSE="GPL-3"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/unzip"
RDEPEND=""

src_compile() {
	emake -e -C src CXX="$(tc-getCXX)" \
		STRICT="${LDFLAGS}" || die
}

src_install() {
	dobin src/last{al,db,ex} || die
	exeinto /usr/share/${PN}/scripts
	doexe scripts/* || die
	dodoc doc/*.txt ChangeLog.txt README.txt || die
}
