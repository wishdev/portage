# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-bdb/ruby-bdb-0.6.5-r1.ebuild,v 1.4 2010/08/28 17:09:06 armin76 Exp $

EAPI=2

USE_RUBY="ruby18"

inherit db-use ruby-ng

MY_P=${P/ruby-/}

DESCRIPTION="Ruby interface to Berkeley DB"
HOMEPAGE="http://moulon.inra.fr/ruby/bdb.html"
SRC_URI="ftp://moulon.inra.fr/pub/ruby/${MY_P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="amd64 ia64 ~ppc sparc x86 ~x86-fbsd"
IUSE="doc"

S=${WORKDIR}/${MY_P}

RDEPEND=">=sys-libs/db-3.2.9"
DEPEND="${RDEPEND}"

each_ruby_configure() {
	${RUBY} extconf.rb --with-db-include=$(db_includedir) \
		--with-db-version=$(db_libname | sed -e 's:db::') \
		|| die "extconf failed"
}

each_ruby_compile() {
	emake || die "emake failed"

	if use doc; then
		emake rdoc || die "rdoc failed"
	fi
}

each_ruby_test() {
	emake test || die "tests failed"
}

each_ruby_install() {
	doruby src/bdb.so

	dodoc README.en Changes || die
	dohtml bdb.html || die

	if use doc; then
		pushd docs &>/dev/null
		docinto api
		dohtml -r doc || die
		popd &>/dev/null
	fi

	insinto /usr/share/doc/${PF}/examples
	doins -r examples/* || die
}
