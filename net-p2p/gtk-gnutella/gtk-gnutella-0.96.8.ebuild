# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gtk-gnutella/gtk-gnutella-0.96.8.ebuild,v 1.8 2011/03/01 18:35:39 graaff Exp $

EAPI="2"

inherit eutils

IUSE="nls dbus gnutls +gtk"

DESCRIPTION="A GTK+ Gnutella client"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://gtk-gnutella.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"

RDEPEND=">=dev-libs/libxml2-2.6.0
	gtk? ( >=x11-libs/gtk+-2.2.1:2 )
	dbus? ( >=sys-apps/dbus-0.35.2 )
	gnutls? ( >=net-libs/gnutls-1.0.16 )
	nls? ( >=sys-devel/gettext-0.11.5 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	# Our awk is new enough, so avoid a warning when trying nawk: #333833
	sed -i -e 's/${nawk:-$awk}/awk/' Configure || die
}

src_configure() {
	# The build script does not support the equivalent --enable
	# options so we must construct the configuration by hand.

	local myconf

	if ! use nls; then
		myconf="${myconf} --disable-nls"
	fi

	if ! use dbus; then
		myconf="${myconf} --disable-dbus"
	fi

	if ! use gnutls; then
		myconf="${myconf} --disable-gnutls"
	fi

	if use gtk; then
		myconf="${myconf} --gtk2"
	else
		myconf="${myconf} --topless"
	fi

	./build.sh --configure-only --prefix="/usr" ${myconf}
}

src_install() {
	dodir /usr/bin
	emake INSTALL_PREFIX="${D}" install || die "Install failed"
	dodoc AUTHORS ChangeLog README TODO
}
