# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libgpg-error/libgpg-error-1.10-r1.ebuild,v 1.2 2011/09/26 18:33:32 vapier Exp $

EAPI="4"

inherit eutils libtool

DESCRIPTION="Contains error handling functions used by GnuPG software"
HOMEPAGE="http://www.gnupg.org/related_software/libgpg-error"
SRC_URI="mirror://gnupg/${PN}/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="common-lisp nls static-libs"

RDEPEND="nls? ( virtual/libintl )"
DEPEND="nls? ( sys-devel/gettext )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-multilib-syspaths.patch
	epunt_cxx
	elibtoolize
}

DOCS=( AUTHORS ChangeLog NEWS README )

src_configure() {
	econf \
		$(use_enable nls) \
		$(use_enable static-libs static) \
		$(use_enable common-lisp languages)
}

src_install() {
	default

	# library has no dependencies, so it does not need the .la file
	find "${D}" -name '*.la' -delete
}
