# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/purple-plugin_pack/purple-plugin_pack-2.6.3.ebuild,v 1.6 2011/10/11 19:35:10 jer Exp $

EAPI="2"

inherit eutils python

DESCRIPTION="A package with many different plugins for pidgin and libpurple"
HOMEPAGE="http://plugins.guifications.org"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ~ppc x86"
IUSE="debug gtk ncurses spell talkfilters"

RDEPEND="net-im/pidgin[gtk?,ncurses?]
	talkfilters? ( app-text/talkfilters )
	spell? ( app-text/gtkspell )"
DEPEND="${RDEPEND}
	=dev-lang/python-2*"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	sed -e '/CFLAGS=/{s| -g3||}' -i configure || die
}

list_plugins_dep() {
	local dependency=${1}
	grep -EH "depends.*$dependency" */plugins.cfg | sed 's:/.*::'
}

src_configure() {
	local plugins=""

	# list all plugins, then pull DISABLED_PLUGINS with the ones we don't need
	plugins="$($(PYTHON) plugin_pack.py -d dist_dirs)"
	einfo "List of all possible plugins:"
	einfo "${plugins}"

	eval DISABLED_PLUGINS="\$${PN//[^a-z]/_}_DISABLED_PLUGINS"
	# disable known broken plugins
	DISABLED_PLUGINS+=" schedule findip"
	use gtk || DISABLED_PLUGINS+=" $(list_plugins_dep pidgin)"
	use ncurses || DISABLED_PLUGINS+=" $(list_plugins_dep finch)"
	use spell || DISABLED_PLUGINS+=" $(list_plugins_dep gtkspell)"
	use talkfilters || DISABLED_PLUGINS+=" $(list_plugins_dep talkfiltersbin)"

	for plug in ${DISABLED_PLUGINS}; do
		plugins="${plugins//${plug}}"
	done

	plugins="$(echo ${plugins} | sed 's:[ \t]\+:,:g;s:,$::;s:^,::')"

	econf \
		--with-plugins="${plugins}" \
		$(use_enable debug)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README VERSION || die
}

pkg_preinst() {
	elog "Note: if you want to disable some plugins in pack, define"
	elog "${PN//[^a-z]/_}_DISABLED_PLUGINS with a list of plugins to"
	elog "skip during install (for list see einfo in build output)."
}
