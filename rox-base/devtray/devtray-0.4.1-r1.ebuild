# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/devtray/devtray-0.4.1-r1.ebuild,v 1.1 2008/09/14 20:13:51 lack Exp $

ROX_LIB_VER=1.9.6
inherit rox

MY_PN="DevTray"
DESCRIPTION="DevTray is a rox panel applet which shows HAL devices."
HOMEPAGE="http://rox4debian.berlios.de"
SRC_URI="ftp://ftp.berlios.de/pub/rox4debian/apps/${MY_PN}-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cddb alsa"

# TODO: When pycups is available, depend on it too (probably conditionally)

RDEPEND=">=rox-base/traylib-0.3.2.1
	dev-python/dbus-python
	sys-apps/hal
	dev-python/libwnck-python
	|| ( sys-apps/pmount gnome-base/gnome-mount )
	cddb? ( dev-python/cddb-py )
	alsa? ( dev-python/pyalsaaudio )"

APPNAME="${MY_PN}"
S="${WORKDIR}"
