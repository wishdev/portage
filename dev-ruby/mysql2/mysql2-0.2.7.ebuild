# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mysql2/mysql2-0.2.7.ebuild,v 1.4 2011/08/07 14:51:58 armin76 Exp $

EAPI="3"
USE_RUBY="ruby18 ree18"

# Tests require a live MySQL database.
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="README.rdoc CHANGELOG.md"

inherit multilib ruby-fakegem

DESCRIPTION="A modern, simple and very fast Mysql library for Ruby - binding to libmysql."
HOMEPAGE="https://github.com/brianmario/mysql2"

LICENSE="MIT"
SLOT="0.2"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="${DEPEND} virtual/mysql[-static]"
RDEPEND="${RDEPEND} virtual/mysql[-static]"

each_ruby_configure() {
	${RUBY} -Cext/mysql2 extconf.rb --with-mysql-config "${EPREFIX}/usr/bin/mysqlconfig" || die
}

each_ruby_compile() {
	emake -Cext/mysql2 || die
	cp ext/mysql2/mysql2$(get_modname) lib/mysql2/ || die
}
