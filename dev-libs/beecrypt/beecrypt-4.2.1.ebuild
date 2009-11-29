# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/beecrypt/beecrypt-4.2.1.ebuild,v 1.1 2009/11/15 12:23:28 swegener Exp $

EAPI="2"

inherit eutils multilib autotools java-pkg-opt-2

DESCRIPTION="general-purpose cryptography library"
HOMEPAGE="http://sourceforge.net/projects/beecrypt/"
SRC_URI="mirror://sourceforge/beecrypt/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="java nocxx python threads doc"

COMMONDEPEND="python? ( >=dev-lang/python-2.2 )
	!<app-arch/rpm-4.2.1
	!nocxx? ( threads? ( >=dev-libs/icu-2.8 ) )"

DEPEND="${COMMONDEPEND}
	java? ( >=virtual/jdk-1.4 )
	doc? ( app-doc/doxygen
		virtual/latex-base
		|| ( dev-texlive/texlive-fontsextra app-text/ptex )
	)"
RDEPEND="${COMMONDEPEND}
	java? ( >=virtual/jre-1.4 )"

src_prepare() {
	java-pkg-opt-2_src_prepare

	epatch "${FILESDIR}"/${P}-build-system.patch
	eautoreconf
}

src_configure() {
	# cpluscplus needs threads support
	econf \
		--disable-expert-mode \
		$(use_enable threads) \
		$(use_with python python /usr/bin/python) \
		$(use threads && use_with !nocxx cplusplus || echo --without-cplusplus) \
		$(use_with java) \
		|| die
}

src_compile() {
	default

	if use doc
	then
		cd include/beecrypt
		doxygen || die "doxygen failed"
	fi
}

src_test() {
	make check || die "self test failed"
	make bench || die "self benchmark test failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	rm -f "${D}"/usr/$(get_libdir)/python*/site-packages/_bc.*a

	dodoc BUGS README BENCHMARKS NEWS || die "dodoc failed"
	if use doc
	then
		dohtml -r docs/html/. || die "dohtml failed"
	fi
}