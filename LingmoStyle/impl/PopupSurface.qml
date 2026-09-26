import QtQuick
import QtQuick.Effects
import LingmoUI.CompatibleModule 3.0 as LUI

// Shared surface for menus, popups and dialogs: rounded panel, hairline border
// and a soft drop shadow
Item {
    id: surface

    property real radius: 10
    implicitWidth: 200
    implicitHeight: 40

    Rectangle {
        id: panel
        anchors.fill: parent
        radius: surface.radius
        color: LUI.Theme.darkMode ? "#2E3040" : "#FFFFFF"
        border.width: 1
        border.color: LUI.Theme.darkMode ? Qt.rgba(1, 1, 1, 0.10) : Qt.rgba(0, 0, 0, 0.08)
        visible: false
    }

    MultiEffect {
        source: panel
        anchors.fill: panel
        shadowEnabled: true
        shadowColor: Qt.rgba(0, 0, 0, LUI.Theme.darkMode ? 0.55 : 0.22)
        shadowBlur: 0.8
        shadowVerticalOffset: 4
        autoPaddingEnabled: true
    }
}
