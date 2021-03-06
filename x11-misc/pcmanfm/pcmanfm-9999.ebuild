# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/pcmanfm/pcmanfm-9999.ebuild,v 1.13 2011/09/10 11:45:31 hwoarang Exp $

EAPI=3

EGIT_REPO_URI="git://pcmanfm.git.sourceforge.net/gitroot/pcmanfm/${PN}"

inherit autotools git-2 fdo-mime

DESCRIPTION="Fast lightweight tabbed filemanager"
HOMEPAGE="http://pcmanfm.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug"
KEYWORDS=""

COMMON_DEPEND=">=dev-libs/glib-2.18:2
	>=x11-libs/gtk+-2.22.1:2
	>=lxde-base/menu-cache-0.3.2
	>=x11-libs/libfm-0.1.15"
RDEPEND="${COMMON_DEPEND}
	virtual/eject
	virtual/freedesktop-icon-theme"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.40
	dev-util/pkgconfig
	sys-devel/gettext"

src_prepare() {
	intltoolize --force --copy --automake || die
	# drop -O0. Bug #382265
	sed -i -e "s:-O0::" "${S}"/configure.ac
	eautoreconf
}

src_configure() {
	econf \
		--sysconfdir="${EPREFIX}/etc" \
		$(use_enable debug)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS
}

pkg_postinst() {
	fdo-mime_desktop_database_update

	elog 'PCmanFM can optionally support the menu://applications/ location.'
	elog 'You should install lxde-base/lxmenu-data for that	functionality.'
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
