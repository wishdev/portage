# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-SPF/Mail-SPF-2.007.ebuild,v 1.1 2009/11/10 10:16:06 robbat2 Exp $

EAPI=2

MODULE_AUTHOR="JMEHNLE"
MODULE_SECTION="mail-spf"
MY_P="${PN}-v${PV}"
S="${WORKDIR}/${MY_P}"

inherit perl-module

DESCRIPTION="Sender Permitted From - Object Oriented"

IUSE=""

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-perl/Error
	dev-perl/URI
	>=dev-perl/Net-DNS-0.65
	>=dev-perl/NetAddr-IP-4.026
	>=dev-perl/Net-DNS-Resolver-Programmable-0.003
	virtual/perl-version"
DEPEND="${RDEPEND}
		>=virtual/perl-Module-Build-0.33"

mydoc="TODO"

SRC_TEST="do"