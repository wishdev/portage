# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-publicfile/selinux-publicfile-2.20101213.ebuild,v 1.2 2011/06/02 12:48:28 blueness Exp $

MODS="publicfile"
IUSE=""

inherit selinux-policy-2

RDEPEND="sec-policy/selinux-ucspi-tcp"

DESCRIPTION="SELinux policy for publicfile"

KEYWORDS="amd64 x86"
