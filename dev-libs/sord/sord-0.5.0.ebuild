# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/sord/sord-0.5.0.ebuild,v 1.1 2011/10/11 20:35:13 aballier Exp $

EAPI=3

inherit base multilib toolchain-funcs

DESCRIPTION="Library for storing RDF data in memory"
HOMEPAGE="http://drobilla.net/software/sord/"
SRC_URI="http://download.drobilla.net/${P}.tar.bz2"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc static-libs test"

RDEPEND=">=dev-libs/serd-0.5.0"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	dev-util/pkgconfig"

PATCHES=( "${FILESDIR}/ldconfig.patch" )

src_configure() {
	tc-export CC CXX CPP AR RANLIB
	./waf configure \
		--prefix=/usr \
		--libdir="/usr/$(get_libdir)" \
		--mandir=/usr/share/man \
		--docdir=/usr/share/doc/${PF} \
		$(use test && echo "--test") \
		$(use doc && echo "--docs") \
		$(use static-libs && echo "--static") \
		|| die
}

src_compile() {
	./waf || die
}

src_test() {
	./waf test || die
}

src_install() {
	./waf install --destdir="${D}" || die
	dodoc AUTHORS README ChangeLog || die
}
