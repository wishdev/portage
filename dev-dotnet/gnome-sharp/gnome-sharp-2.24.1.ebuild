# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gnome-sharp/gnome-sharp-2.24.1.ebuild,v 1.1 2009/03/10 15:13:40 loki_val Exp $

EAPI=2

GTK_SHARP_REQUIRED_VERSION="2.12"
GNOMECANVAS_REQUIRED_VERSION="2.20"
inherit gtk-sharp-module

SLOT="2"
KEYWORDS="~ppc ~x86-fbsd ~x86 ~amd64"
IUSE=""

RESTRICT="test"