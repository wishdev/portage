# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libwmf/libwmf-0.2.8.4-r3.ebuild,v 1.13 2011/05/23 17:18:32 scarabeus Exp $

EAPI=4

inherit eutils autotools

#The configure script finds the 5.50 ghostscript Fontmap file while run.
#This will probably work, especially since the real one (6.50) in this case
#is empty. However beware in case there is any trouble

DESCRIPTION="library for converting WMF files"
HOMEPAGE="http://wvware.sourceforge.net/"
SRC_URI="mirror://sourceforge/wvware/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-solaris"
IUSE="X expat xml debug doc gtk"

RDEPEND="app-text/ghostscript-gpl
	xml? (  dev-libs/libxml2 )
	expat? ( dev-libs/expat )
	>=media-libs/freetype-2.0.1
	sys-libs/zlib
	>=media-libs/libpng-1.4
	virtual/jpeg
	X? (
		x11-libs/libICE
		x11-libs/libSM
		x11-libs/libX11
	)
	gtk? ( x11-libs/gtk+:2 ) "
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	X? (
		x11-libs/libXt
		x11-libs/libXpm
	)"
# plotutils are not really supported yet, so looks like that's it

REQUIRED_USE="xml? ( !expat ) expat? ( !xml )"

src_prepare() {
	if ! use doc ; then
		sed -e 's:doc::' -i Makefile.am || die
	fi
	epatch \
		"${FILESDIR}"/${P}-intoverflow.patch \
		"${FILESDIR}"/${P}-build.patch \
		"${FILESDIR}"/${P}-pngfix.patch \
		"${FILESDIR}"/${P}-libpng-1.5.patch

	eautoreconf
}

src_configure() {
	# NOTE: The gd that is included is gd-2.0.0. Even with --with-sys-gd, that gd is built
	# and included in libwmf. Since nothing in-tree seems to use media-libs/libwmf[gd],
	# we're explicitly disabling gd use w.r.t. bug 268161
	econf \
		--disable-static \
		$(use_enable debug) \
		$(use_with X x) \
		$(use_with expat) \
		$(use_with xml libxml2) \
		--disable-gd \
		--with-sys-gd \
		--with-gsfontdir="${EPREFIX}"/usr/share/ghostscript/fonts \
		--with-fontdir="${EPREFIX}"/usr/share/libwmf/fonts/ \
		--with-docdir="${EPREFIX}"/usr/share/doc/${PF}
}

src_install() {
	# bug #298596
	emake -j1 install DESTDIR="${D}"
	dodoc README AUTHORS CREDITS ChangeLog NEWS TODO

	find "${ED}" -name '*.la' -exec rm -f '{}' +
}

set_gtk_confdir() {
	# An arch specific config directory is used on multilib systems
	has_multilib_profile && GTK2_CONFDIR="${EROOT}etc/gtk-2.0/${CHOST}"
	GTK2_CONFDIR="${GTK2_CONFDIR:-${EROOT}etc/gtk-2.0}"
}

pkg_postinst() {
	if use gtk; then
		set_gtk_confdir
		gdk-pixbuf-query-loaders > "${GTK2_CONFDIR}/gdk-pixbuf.loaders"
	fi
}

pkg_postrm() {
	if use gtk; then
		set_gtk_confdir
		gdk-pixbuf-query-loaders > "${GTK2_CONFDIR}/gdk-pixbuf.loaders"
	fi
}
