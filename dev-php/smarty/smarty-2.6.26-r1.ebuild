# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/smarty/smarty-2.6.26-r1.ebuild,v 1.1 2011/02/11 16:04:26 tomk Exp $

inherit php-lib-r1 eutils versionator

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"

MY_P="Smarty-${PV}"
MAJOR_PV=$(get_version_component_range 1-2)

DESCRIPTION="A template engine for PHP."
HOMEPAGE="http://www.smarty.net/"
SRC_URI="http://www.smarty.net/files/${MY_P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE="doc"

DEPEND=">=dev-lang/php-4.0.6"
RDEPEND="${DEPEND}"
PDEPEND="doc? ( =dev-php/smarty-docs-${MAJOR_PV} )"

S="${WORKDIR}/${MY_P}"

need_php_by_category

src_install() {
	dodoc-php BUGS ChangeLog FAQ NEWS QUICK_START README RELEASE_NOTES TODO

	php-lib-r1_src_install ./libs `find ./libs -type f -print | sed -e "s|./libs||g"`
}

pkg_postinst() {
	elog "${PHP_LIB_NAME} has been installed in /usr/share/php/${PHP_LIB_NAME}/."
	elog "To use it in your scripts, either"
	elog "1. define('SMARTY_DIR', \"/usr/share/php/${PHP_LIB_NAME}/\") in your scripts, or"
	elog "2. add '/usr/share/php/${PHP_LIB_NAME}/' to the 'include_path' variable in your"
	elog "php.ini file under /etc/php/SAPI (where SAPI is one of apache2-php5,"
	elog "cgi-php5 or cli-php5)."
	elog
	elog "If you're upgrading from a previous version make sure to clear out your"
	elog "templates_c and cache directories as some include paths have changed!"

	if use doc; then
		elog
		elog "The versioning scheme for the smarty documentation has changed so installing"
		elog "dev-php/smarty-docs-${MAJOR_PV} is not a downgrade despite what your package"
		elog "manager might say."
	fi
}
