# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/xnoise/xnoise-9999.ebuild,v 1.4 2011/07/08 16:31:16 angelos Exp $

EAPI=4
inherit fdo-mime gnome2-utils mercurial

DESCRIPTION="A media player for Gtk+ with a slick GUI, great speed and lots of
features"
HOMEPAGE="http://www.xnoise-media-player.com/"
EHG_REPO_URI="https://xnoise.googlecode.com/hg/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+cover libnotify +lyrics"

RDEPEND="dev-db/sqlite:3
	>=dev-libs/glib-2.26:2
	dev-libs/libunique:1
	dev-libs/libxml2:2
	media-libs/gst-plugins-base:0.10
	media-libs/gstreamer:0.10
	media-libs/taglib
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:2
	cover? ( net-libs/libsoup:2.4 )
	libnotify? ( x11-libs/libnotify )
	lyrics? ( net-libs/libsoup:2.4 )"
DEPEND="${RDEPEND}
	dev-lang/vala:0.12
	dev-util/intltool
	dev-util/pkgconfig
	gnome-base/gnome-common:3
	>=sys-devel/autoconf-2.67:2.5
	sys-devel/gettext"

DOCS=( AUTHORS README )

src_prepare() {
	NOCONFIGURE=yes ./autogen.sh || die
}

src_configure() {
	VALAC=$(type -p valac-0.12) \
	econf \
		--disable-soundmenu \
		--enable-soundmenu2 \
		$(use_enable cover lastfm-covers) \
		$(use_enable libnotify notifications) \
		$(use_enable lyrics leoslyrics) \
		$(use_enable lyrics lyricsfly) \
		$(use_enable lyrics lyricwiki) \
		$(use_enable lyrics chartlyrics)
}

src_install() {
	default
	find "${ED}" -type f -name "*.la" -exec rm -rf {} + || die
	rm -rf "${ED}"/usr/share/${PN}/license || die
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
