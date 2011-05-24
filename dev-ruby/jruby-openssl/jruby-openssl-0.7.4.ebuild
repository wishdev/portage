# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/jruby-openssl/jruby-openssl-0.7.4.ebuild,v 1.2 2011/05/23 20:44:18 tomka Exp $

EAPI=2

USE_RUBY=jruby

RUBY_FAKEGEM_TASK_DOC="redocs"
RUBY_FAKEGEM_DOCDIR="doc"

inherit ruby-fakegem

DESCRIPTION="A Ruby SSL library that works with JRuby"
HOMEPAGE="http://rubyforge.org/projects/jruby-extras"

LICENSE="MIT || ( CPL-1.0 GPL-2	LGPL-2.1 )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

ruby_add_bdepend "doc? ( dev-ruby/hoe )"
ruby_add_bdepend "test? ( dev-ruby/hoe dev-ruby/mocha )"

ruby_add_rdepend ">=dev-ruby/bouncy-castle-java-1.5.0146.1"

all_ruby_prepare() {
	# Remove a test that only works with JCE installed.
	sed -i -e 's/OpenSSL::OPENSSL_VERSION_NUMBER > 0x00907000/false/' test/openssl/test_cipher.rb || die
}
