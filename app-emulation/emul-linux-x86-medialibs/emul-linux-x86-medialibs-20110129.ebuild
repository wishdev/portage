# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-medialibs/emul-linux-x86-medialibs-20110129.ebuild,v 1.2 2011/02/12 20:19:41 hwoarang Exp $

inherit emul-linux-x86

LICENSE="GPL-2 GPL-3 LGPL-2 LGPL-2.1 BSD BSD-2 public-domain"
KEYWORDS="-* amd64"

DEPEND=""
RDEPEND="~app-emulation/emul-linux-x86-baselibs-${PV}
	~app-emulation/emul-linux-x86-xlibs-${PV}
	!<=app-emulation/emul-linux-x86-sdl-20081109"
PDEPEND="~app-emulation/emul-linux-x86-soundlibs-${PV}"

src_unpack() {
	# Include all libv4l libs, bug #348277
	ALLOWED="${S}/usr/lib32/libv4l/"
	emul-linux-x86_src_unpack
}
