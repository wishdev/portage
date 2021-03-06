# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/php-tokenstream/php-tokenstream-1.0.1.ebuild,v 1.5 2011/06/28 07:34:43 olemarkus Exp $

PHP_PEAR_CHANNEL="${FILESDIR}/channel.xml"
PHP_PEAR_URI="pear.phpunit.de"
PHP_PEAR_PN="PHP_TokenStream"
inherit php-pear-lib-r1

DESCRIPTION="Wrapper around PHP's tokenizer extension"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RDEPEND="${RDEPEND}
	>=dev-php5/ezc-ConsoleTools-1.6"
HOMEPAGE="http://pear.phpunit.de"
