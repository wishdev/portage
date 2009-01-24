# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-debug/ruby-debug-0.10.3.ebuild,v 1.1 2008/12/28 13:19:39 graaff Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="CLI interface to ruby-debug"
HOMEPAGE="http://rubyforge.org/projects/ruby-debug/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="ruby-debug"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="=dev-ruby/ruby-debug-base-0.10.3
	>=dev-ruby/columnize-0.1
	>=dev-lang/ruby-1.8.4"
RDEPEND="${DEPEND}"