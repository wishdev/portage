# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/eix/eix-0.22.11.ebuild,v 1.9 2011/09/06 08:33:45 chainsaw Exp $

EAPI="4"

inherit multilib

DESCRIPTION="Search and query ebuilds, portage incl. local settings, ext. overlays, version changes, and more"
HOMEPAGE="http://eix.berlios.de"
SRC_URI="mirror://berlios/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ~ppc64 s390 sh sparc x86 ~ppc-aix ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~ia64-hpux ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x86-solaris"
IUSE="bzip2 debug doc hardened nls optimization strong-optimization sqlite tools zsh-completion"

RDEPEND="sqlite? ( >=dev-db/sqlite-3 )
	nls? ( virtual/libintl )
	bzip2? ( app-arch/bzip2 )
	zsh-completion? ( !!<app-shells/zsh-completion-20091203-r1 )"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	nls? ( sys-devel/gettext )"

src_configure() {
	econf $(use_with bzip2) $(use_with sqlite) $(use_with doc extra-doc) \
		$(use_with zsh-completion) \
		$(use_enable nls) $(use_enable tools separate-tools) \
		$(use_enable hardened security) $(use_enable optimization) \
		$(use_enable strong-optimization) $(use_enable debug debugging) \
		$(use_with prefix always-accept-keywords) \
		--with-ebuild-sh-default="/usr/$(get_libdir)/portage/bin/ebuild.sh" \
		--with-portage-rootpath="${ROOTPATH}" \
		--with-eprefix-default="${EPREFIX}" \
		--docdir="${EPREFIX}/usr/share/doc/${PF}" \
		--htmldir="${EPREFIX}/usr/share/doc/${PF}/html"
}
