import QtQuick
import LingmoUI.CompatibleModule 3.0 as LingmoUI

// Lingmo window controls: one soft capsule holding close / minimize / zoom as
// coloured buttons with always-visible white glyphs (zoom follows the accent colour).
Rectangle {
    id: control

    property bool windowActive: true
    property bool maximized: false
    property bool minimizeVisible: true
    property bool zoomVisible: true

    signal closeClicked()
    signal minimizeClicked()
    signal zoomClicked()

    implicitWidth: _row.implicitWidth + 6
    implicitHeight: 22
    radius: height / 2
    color: LingmoUI.Theme.darkMode ? Qt.rgba(1, 1, 1, 0.07) : Qt.rgba(0, 0, 0, 0.045)
    border.width: 0.5
    border.color: LingmoUI.Theme.darkMode ? Qt.rgba(1, 1, 1, 0.08) : Qt.rgba(0, 0, 0, 0.06)

    Row {
        id: _row
        anchors.centerIn: parent
        spacing: 2

        WindowControlButton {
            kind: "close"
            accent: "#F2555A"
            windowActive: control.windowActive
            onClicked: control.closeClicked()
        }

        WindowControlButton {
            kind: "minimize"
            accent: "#F5A524"
            windowActive: control.windowActive
            visible: control.minimizeVisible
            onClicked: control.minimizeClicked()
        }

        WindowControlButton {
            kind: control.maximized ? "restore" : "zoom"
            accent: LingmoUI.Theme.highlightColor
            windowActive: control.windowActive
            visible: control.zoomVisible
            onClicked: control.zoomClicked()
        }
    }
}
