# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/smartirc4net/smartirc4net-0.4.5.1.ebuild,v 1.3 2009/10/21 15:59:54 maekke Exp $

EAPI="2"

inherit mono

HOMEPAGE="http://www.smuxi.org/page/Download"
SRC_URI="http://smuxi.meebey.net/jaws/data/files/${P}.tar.gz"
DESCRIPTION="SmartIrc4net is a multi-threaded and thread-safe IRC library written in C#"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
LICENSE="|| ( LGPL-2.1 LGPL-3 )"

RDEPEND=">=dev-lang/mono-2.0"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.23"

src_install() {
	emake DESTDIR="${D}" install
	dodoc FEATURES TODO API_CHANGE CHANGELOG README || die "dodoc failed"
}
