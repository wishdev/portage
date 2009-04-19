# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/amarok/amarok-1.4.10-r3.ebuild,v 1.1 2009/04/14 03:05:15 jmbsvicetto Exp $

ARTS_REQUIRED="never"

LANGS="af ar az be bg bn br ca cs cy da de el en_GB eo es et eu fa fi
fr ga gl he hi hu id is it ja km ko ku lo lt mk ms nb nds ne nl nn pa
pl pt pt_BR ro ru rw se sk sl sq sr sr@Latn ss sv ta tg th tr uk uz
zh_CN zh_TW"

LANGS_DOC="da de es et fr it nl pl pt pt_BR ru sv"

USE_KEG_PACKAGING=1

inherit kde

PKG_SUFFIX=""

if [[ ${P/_pre} == ${P} ]]; then
	MY_P="${P/_/-}"

	if [[ ${P/_rc} == ${P} ]]; then
		SRC_URI="mirror://kde/stable/amarok/${PV}/src/${MY_P}.tar.bz2"
		S="${WORKDIR}/${P/_/-}"
	else
		SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"
		S="${WORKDIR}/${P/_rc*}"
	fi
else
	SRC_URI="mirror://gentoo/${P}.tar.bz2"
fi

DESCRIPTION="Advanced audio player based on KDE framework."
HOMEPAGE="http://amarok.kde.org/"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="mp4 kde mysql amazon opengl postgres
visualization ipod ifp real njb mtp musicbrainz daap
python"
# kde: enables compilation of the konqueror sidebar plugin

# Blocking amarok:2 until the KDE3 eclasses are updated
# to move misc apps to /usr/kde/3.5
RDEPEND="
	!>=media-sound/amarok-2.0.0
	=dev-lang/ruby-1.8*
	>=media-libs/taglib-1.4
	>=media-libs/xine-lib-1.1.2_pre20060328-r8
	kde? (
		|| (
			=kde-base/kdebase-3.5*
			=kde-base/konqueror-3.5*
		)
	)
	ifp? ( media-libs/libifp )
	ipod? ( >=media-libs/libgpod-0.5.2 )
	mp4? ( media-libs/libmp4v2 )
	mtp? ( >=media-libs/libmtp-0.3.0 )
	musicbrainz? ( media-libs/tunepimp )
	mysql? ( >=virtual/mysql-4.0 )
	njb? ( >=media-libs/libnjb-2.2.4 )
	opengl? ( virtual/opengl )
	postgres? ( virtual/postgresql-base )
	real? (
		media-libs/alsa-lib
		media-video/realplayer
	)
	visualization? (
		media-libs/libsdl
		=media-plugins/libvisual-plugins-0.4*
	)
"

DEPEND="${RDEPEND}"

RDEPEND="${RDEPEND}
	app-arch/unzip
	daap? ( www-servers/mongrel )
	python? ( dev-python/PyQt )
"

PATCHES=( "${FILESDIR}/amarok-1.4.9.1-libmtp-0.3.0-API.patch"
	"${FILESDIR}/${P}-gcc-4.3.patch"
	"${FILESDIR}/${P}-audibletag.patch" )

need-kde 3.5

src_compile() {
	# Extra, unsupported engines are forcefully disabled.
	local myconf="
		$(use_enable amazon)
		$(use_enable mysql)
		$(use_enable postgres postgresql)
		$(use_with daap)
		$(use_with ifp)
		$(use_with ipod libgpod)
		$(use_with mp4 mp4v2)
		$(use_with mtp libmtp)
		$(use_with musicbrainz)
		$(use_with njb libnjb)
		$(use_with opengl)
		$(use_with real helix)
		$(use_with visualization libvisual)
		--with-xine
		--without-nm
	"

	kde_src_compile
}

src_install() {
	kde_src_install

	# As much as I respect Ian, I'd rather leave Amarok to use mongrel
	# from Portage, for security and policy reasons.
	rm -rf "${D}"/usr/share/apps/amarok/ruby_lib/rbconfig \
		"${D}"/usr/share/apps/amarok/ruby_lib/mongrel* \
		"${D}"/usr/share/apps/amarok/ruby_lib/rubygems* \
		"${D}"/usr/share/apps/amarok/ruby_lib/gem* \
		"${D}"/usr/$(get_libdir)/ruby_lib

	if ! use python; then
		rm -r "${D}"/usr/share/apps/amarok/scripts/webcontrol \
			|| die "Unable to remove webcontrol."
	fi
}