# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xdg-utils/xdg-utils-1.1.0_rc1_p20111003.ebuild,v 1.4 2011/10/19 11:14:06 chainsaw Exp $

# See .spec in http://pkgs.fedoraproject.org/gitweb/?p=xdg-utils.git;a=summary
# The source tree MUST be cleaned before rolling a snapshot tarball:
# make scripts-clean -C scripts
# make man scripts -C scripts

EAPI=4

DESCRIPTION="Portland utils for cross-platform/cross-toolkit/cross-desktop interoperability"
HOMEPAGE="http://portland.freedesktop.org/"
SRC_URI="http://dev.gentoo.org/~ssuominen/${P}.tar.xz"
#SRC_URI="http://portland.freedesktop.org/download/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="doc"

RDEPEND="dev-util/desktop-file-utils
	dev-perl/File-MimeInfo
	x11-misc/shared-mime-info
	x11-apps/xprop
	x11-apps/xset"
DEPEND=""

DOCS=( ChangeLog README RELEASE_NOTES TODO )

src_test() { :; } # write access as root outside of sandbox required

src_install() {
	default

	newdoc scripts/README README.scripts
	use doc && dohtml -r scripts/html

	# Install default XDG_DATA_DIRS, bug #264647
	echo 'XDG_DATA_DIRS="/usr/local/share"' > 30xdg-data-local
	echo 'COLON_SEPARATED="XDG_DATA_DIRS XDG_CONFIG_DIRS"' >> 30xdg-data-local
	doenvd 30xdg-data-local

	echo 'XDG_DATA_DIRS="/usr/share"' > 90xdg-data-base
	echo 'XDG_CONFIG_DIRS="/etc/xdg"' >> 90xdg-data-base
	doenvd 90xdg-data-base
}

pkg_postinst() {
	[[ -x $(type -P gtk-update-icon-cache) ]] || elog "Install x11-libs/gtk+:2 for the gtk-update-icon-cache command."
}
