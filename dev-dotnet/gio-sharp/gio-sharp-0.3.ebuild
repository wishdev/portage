# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gio-sharp/gio-sharp-0.3.ebuild,v 1.3 2011/06/30 14:14:10 angelos Exp $

EAPI=4
inherit autotools mono

DESCRIPTION="GIO API C# binding"
HOMEPAGE="http://github.com/mono/gio-sharp"
SRC_URI="http://github.com/mono/${PN}/tarball/${PV} -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=dev-dotnet/glib-sharp-2.12
	>=dev-dotnet/gtk-sharp-gapi-2.12
	>=dev-libs/glib-2.22:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	DOCS="AUTHORS NEWS README"
}

src_unpack() {
	unpack ${A}
	mv *-${PN}-* "${S}"
}

src_prepare() {
	sed -i -e '/autoreconf/d' autogen-generic.sh || die
	NOCONFIGURE=1 ./autogen-2.22.sh || die

	eautoreconf
}

src_compile() {
	emake -j1
}

src_install() {
	default
	mono_multilib_comply
}
