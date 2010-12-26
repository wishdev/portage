# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libfontenc/libfontenc-1.1.0.ebuild,v 1.5 2010/12/25 20:35:32 fauli Exp $

EAPI=3
inherit xorg-2

DESCRIPTION="X.Org fontenc library"

KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="sys-libs/zlib
	x11-proto/xproto"
DEPEND="${RDEPEND}"
