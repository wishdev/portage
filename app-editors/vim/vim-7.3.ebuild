# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/vim/vim-7.3.ebuild,v 1.3 2010/10/21 14:53:52 mduft Exp $

EAPI=3
VIM_VERSION="7.3"
inherit vim

#VIM_ORG_PATCHES="vim-patches-${PV}.tar.gz"

SRC_URI="ftp://ftp.vim.org/pub/vim/unix/vim-${VIM_VERSION}.tar.bz2"

# New release: No patches yet
#	mirror://gentoo/${VIM_ORG_PATCHES}

S="${WORKDIR}/vim${VIM_VERSION/.}"
DESCRIPTION="Vim, an improved vi-style text editor"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~sparc-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~ia64-hpux ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

src_prepare() {
	vim_src_prepare

	if [[ ${CHOST} == *-interix* ]]; then
		epatch "${FILESDIR}"/${PN}-7.3-interix-link.patch
	fi
	epatch "${FILESDIR}"/${PN}-7.1.285-darwin-x11link.patch
}
