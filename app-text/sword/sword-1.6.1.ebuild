# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/sword/sword-1.6.1.ebuild,v 1.2 2010/05/14 08:14:39 grobian Exp $

EAPI="3"

inherit flag-o-matic

DESCRIPTION="Library for Bible reading software."
HOMEPAGE="http://www.crosswire.org/sword/"
SRC_URI="http://www.crosswire.org/ftpmirror/pub/sword/source/v1.6/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd ~ppc-macos"
IUSE="curl debug doc icu lucene"

RDEPEND="sys-libs/zlib
	curl? ( net-misc/curl )
	icu? ( dev-libs/icu )
	lucene? ( dev-cpp/clucene )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	cat > "${T}"/sword.conf <<- _EOF
		[Install]
		DataPath=${EPREFIX}/usr/share/sword/
	_EOF
}

src_configure() {
	strip-flags
	econf --with-zlib \
		--with-conf \
		$(use_with curl) \
		$(use_enable debug) \
		$(use_with icu) \
		$(use_with lucene) || die "configure failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS CODINGSTYLE ChangeLog README
	if use doc ;then
		rm -rf examples/.cvsignore
		rm -rf examples/cmdline/.cvsignore
		rm -rf examples/cmdline/.deps
		cp -R samples examples "${ED}/usr/share/doc/${PF}/"
	fi
	# global configuration file
	insinto /etc
	doins "${T}/sword.conf"
}

pkg_postinst() {
	echo
	elog "Check out http://www.crosswire.org/sword/modules/"
	elog "to download modules that you would like to use with SWORD."
	elog "Follow module installation instructions found on"
	elog "the web or in ${EPREFIX}/usr/share/doc/${PF}/"
	echo
}
