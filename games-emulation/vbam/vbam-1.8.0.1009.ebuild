# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/vbam/vbam-1.8.0.1009.ebuild,v 1.2 2011/05/04 13:29:22 nyhm Exp $

EAPI=2

inherit confutils cmake-utils games

DESCRIPTION="Game Boy, GBC, and GBA emulator forked from VisualBoyAdvance"
HOMEPAGE="http://vba-m.ngemu.com"
SRC_URI="http://dev.gentoo.org/~radhermit/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk link lirc nls +sdl"

RDEPEND=">=media-libs/libpng-1.4
	media-libs/libsdl[joystick]
	link? ( media-libs/libsfml )
	sys-libs/zlib
	virtual/opengl
	gtk? ( >=dev-cpp/glibmm-2.4.0:2
		>=dev-cpp/gtkmm-2.4.0:2.4
		>=dev-cpp/gtkglextmm-1.2.0 )
	lirc? ( app-misc/lirc )
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	x86? ( || ( dev-lang/nasm dev-lang/yasm ) )
	nls? ( sys-devel/gettext )
	dev-util/pkgconfig"

pkg_setup() {
	confutils_require_any sdl gtk
	games_pkg_setup
}

src_configure() {
	local myconf
	use x86 && myconf="-DENABLE_ASM_SCALERS=ON -DENABLE_ASM_CORE=ON"

	mycmakeargs=(
		$(cmake-utils_use_enable gtk GTK)
		$(cmake-utils_use_enable link LINK)
		$(cmake-utils_use_enable lirc LIRC)
		$(cmake-utils_use_enable nls NLS)
		$(cmake-utils_use_enable sdl SDL)
		${myconf}
		"-DCMAKE_INSTALL_PREFIX=${GAMES_PREFIX}"
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	if use sdl ; then
		dodoc doc/ReadMe.SDL.txt
		doman debian/vbam.1
	fi
	prepgamesdirs
}
