# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/grip/grip-3.3.1-r2.ebuild,v 1.1 2009/03/05 03:19:23 beandog Exp $

inherit eutils flag-o-matic toolchain-funcs libtool

DESCRIPTION="GTK+ based Audio CD Player/Ripper."
HOMEPAGE="http://www.nostatic.org/grip"
SRC_URI="mirror://sourceforge/grip/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="nls vorbis"

RDEPEND=">=x11-libs/gtk+-2.2
	x11-libs/vte
	media-sound/lame
	media-sound/cdparanoia
	>=media-libs/id3lib-3.8.3
	>=gnome-base/libgnomeui-2.2.0
	>=gnome-base/orbit-2
	net-misc/curl
	gnome-extra/yelp
	vorbis? ( media-sound/vorbis-tools )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Fix for incompatible implicit declaration of built-in function ‘strlen’.
	epatch "${FILESDIR}"/${P}-implicit-declaration.patch

	# Required for FreeBSD (do not remove)
	elibtoolize
}

src_compile() {
	# Bug #69536
	[[ $(tc-arch) == "x86" ]] && append-flags "-mno-sse"

	strip-linguas be bg ca de en en_CA en_GB en_US es fi fr hu it ja nl pl_PL pt_BR ru zh_CN zh_HK zh_TW

	econf \
		--disable-dependency-tracking \
		$(use_enable nls) || die "./configure failed"
	emake || die "emake failed."
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS CREDITS ChangeLog README TODO
}