# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gst-plugins-base/gst-plugins-base-0.10.31.ebuild,v 1.1 2011/01/12 17:33:30 ford_prefect Exp $

EAPI=1

# order is important, gnome2 after gst-plugins
inherit gst-plugins-base gst-plugins10 gnome2 flag-o-matic eutils
# libtool

DESCRIPTION="Basepack of plugins for gstreamer"
HOMEPAGE="http://gstreamer.sourceforge.net"
SRC_URI="http://gstreamer.freedesktop.org/src/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="+introspection nls +orc"

RDEPEND=">=dev-libs/glib-2.20
	>=media-libs/gstreamer-0.10.31
	dev-libs/libxml2
	app-text/iso-codes
	orc? ( >=dev-lang/orc-0.4.11 )
	!<media-libs/gst-plugins-bad-0.10.10"
DEPEND="${RDEPEND}
	nls? ( >=sys-devel/gettext-0.11.5 )
	dev-util/pkgconfig
	dev-util/gtk-doc-am"

GST_PLUGINS_BUILD=""

DOCS="AUTHORS NEWS README RELEASE"

src_compile() {
	# gst doesnt handle opts well, last tested with 0.10.15
	strip-flags
	replace-flags "-O3" "-O2"

	gst-plugins-base_src_configure \
		$(use_enable introspection) \
		$(use_enable nls) \
		$(use_enable orc)
	emake || die "emake failed."
}

src_install() {
	gnome2_src_install
}
