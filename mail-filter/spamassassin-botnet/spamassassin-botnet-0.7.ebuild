# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/spamassassin-botnet/spamassassin-botnet-0.7.ebuild,v 1.2 2007/02/24 18:22:01 armin76 Exp $

inherit perl-module

MY_PN="${PN/b/B}"
MY_PN="${MY_PN/spamassassin-/}"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="SpamAssassin plugin that attempts to detect messages sent by a botnet"
HOMEPAGE="http://people.ucsc.edu/~jrudd/spamassassin/"
SRC_URI="http://people.ucsc.edu/~jrudd/spamassassin/${MY_P}.tar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/perl
	>=mail-filter/spamassassin-3.0.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_compile() {
	# make sure it doesn't try to look for the .pm in the same dir as the .cf
	sed -rie 's/^(loadplugin.+)[ ]+Botnet.pm/\1/' Botnet.cf
}

src_install() {
	perlinfo

	local plugin_dir=${VENDOR_LIB}/Mail/SpamAssassin/Plugin

	insinto ${plugin_dir}
	doins ${MY_PN}.pm

	insinto /etc/mail/spamassassin/
	doins ${MY_PN}.cf

	dodoc ${MY_PN}{{.{api,credits,variants},}.txt,.pl}
}

pkg_postinst() {
	echo
	elog "You need to restart spamassassin (as root) before this plugin will work:"
	elog "/etc/init.d/spamd restart"
	echo
}
