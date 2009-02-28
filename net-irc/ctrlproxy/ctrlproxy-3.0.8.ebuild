# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ctrlproxy/ctrlproxy-3.0.8.ebuild,v 1.1 2009/01/25 11:02:25 armin76 Exp $

DESCRIPTION="IRC proxy with multiserver and multiclient support"
HOMEPAGE="http://www.ctrlproxy.org"
SRC_URI="http://www.ctrlproxy.org/releases/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~x86"
IUSE="ssl"
RESTRICT="test"

RDEPEND=">=dev-libs/glib-2
	ssl? ( net-libs/gnutls )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install install-doc || die "emake install failed"
}