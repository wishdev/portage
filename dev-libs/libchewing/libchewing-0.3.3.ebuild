# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libchewing/libchewing-0.3.3.ebuild,v 1.1 2011/04/02 02:03:39 matsuu Exp $

EAPI=3

inherit multilib toolchain-funcs

DESCRIPTION="Library for Chinese Phonetic input method"
HOMEPAGE="http://chewing.csie.net/"
SRC_URI="http://chewing.csie.net/download/libchewing/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug test static-libs"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	test? (
		sys-libs/ncurses[unicode]
		>=dev-libs/check-0.9.4
	)"

src_configure() {
	export CC_FOR_BUILD="$(tc-getBUILD_CC)"
	econf $(use_enable debug) \
		$(use_enable static-libs static) || die
}

src_test() {
	# test subdirectory is not enabled by default; this means that we
	# have to make it explicit.
	emake -C test check || die "emake check failed"
}

src_install() {
	emake DESTDIR="${D}" install || die

	find "${ED}"usr/$(get_libdir)/ -name '*.la' -delete || die

	dodoc AUTHORS ChangeLog NEWS README TODO || die
}
