# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/knemo/knemo-0.6.0.ebuild,v 1.1 2009/12/04 10:51:11 ssuominen Exp $

EAPI=2
KDE_LINGUAS="ar bg br cs cy da de el en_GB eo es et fr ga gl hu is it ja ka lt
ms nb nds nl pl pt pt_BR ru rw sk sv tr uk zh_TW"
inherit kde4-base

DESCRIPTION="KNemo - the KDE Network Monitor"
HOMEPAGE="http://kde-apps.org/content/show.php?content=12956"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/12956-${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

DEPEND=">=kde-base/systemsettings-${KDE_MINIMAL}
	net-wireless/wireless-tools
	sys-apps/net-tools
	dev-libs/libnl"

DOCS="AUTHORS ChangeLog README TODO"