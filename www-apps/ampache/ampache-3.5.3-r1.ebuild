# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/ampache/ampache-3.5.3-r1.ebuild,v 1.3 2010/10/20 14:19:43 hwoarang Exp $

EAPI="2"

inherit webapp depend.php

DESCRIPTION="Ampache is a PHP-based tool for managing, updating and playing your audio files via a web interface."
HOMEPAGE="http://www.ampache.org/"
SRC_URI="http://www.ampache.org/downloads/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE=""

RDEPEND="dev-lang/php[gd,hash,iconv,mysql,session,unicode,xml,zlib]
		 || ( <dev-lang/php-5.3[pcre] >=dev-lang/php-5.3 )"
DEPEND=""

need_httpd_cgi

src_install() {
	webapp_src_preinst

	dodoc docs/*
	rm -rf docs/

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	webapp_postinst_txt en "${FILESDIR}"/installdoc.txt
	webapp_src_install
}

pkg_postinst() {
	elog "Install and upgrade instructions can be found here:"
	elog "  /usr/share/doc/${P}/INSTALL.gz"
	elog "  /usr/share/doc/${P}/MIGRATION.gz"
	webapp_pkg_postinst
}
