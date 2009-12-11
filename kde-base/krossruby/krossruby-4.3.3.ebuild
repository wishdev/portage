# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/krossruby/krossruby-4.3.3.ebuild,v 1.4 2009/12/10 16:34:41 fauli Exp $

EAPI="2"

KMNAME="kdebindings"
KMMODULE="ruby/krossruby"
inherit kde4-meta

DESCRIPTION="Ruby plugin for the kdelibs/kross scripting framework."
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ppc64 x86"
IUSE="debug"

DEPEND="
	dev-lang/ruby
"
RDEPEND="${DEPEND}"
