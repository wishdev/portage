# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-lore/twisted-lore-10.1.0.ebuild,v 1.3 2010/12/23 23:45:09 tomka Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
MY_PACKAGE="Lore"

inherit twisted versionator

DESCRIPTION="Twisted documentation system"

KEYWORDS="~alpha amd64 ~ia64 ~ppc ~ppc64 ~sparc x86"
IUSE=""

DEPEND="=dev-python/twisted-$(get_version_component_range 1-2)*
	dev-python/twisted-web"
RDEPEND="${DEPEND}"

PYTHON_MODNAME="twisted/lore twisted/plugins"
