# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/arrayfields/arrayfields-4.7.4-r1.ebuild,v 1.1 2010/01/26 07:31:17 graaff Exp $

EAPI="2"
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_EXTRADOC="README"

inherit ruby-fakegem

DESCRIPTION="Allow keyword access to array instances."
HOMEPAGE="http://rubyforge.org/projects/codeforpeople/"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

each_ruby_test() {
	${RUBY} test/arrayfields.rb || die "Test failed."
}

all_ruby_install() {
	all_fakegem_install

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r sample || die "Installing examples failed."
	fi
}
