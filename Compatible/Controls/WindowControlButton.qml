import QtQuick
import LingmoUI.CompatibleModule 3.0 as LingmoUI

// A single button of WindowControls; glyphs are drawn with rectangles so they
// stay crisp at any scale factor
Item {
    id: control

    property string kind: "close"      // close | minimize | zoom | restore
    property color accent
    property bool windowActive: true
    readonly property bool lit: _mouse.containsMouse
    signal clicked()

    width: 16
    height: 16

    // Always coloured with a white glyph; grey when the window is inactive
    readonly property color fill: !windowActive && !lit
                                  ? (LingmoUI.Theme.darkMode ? "#4A4B57" : "#CFD0D6")
                                  : _mouse.pressed ? Qt.darker(accent, 1.2)
                                  : lit ? Qt.lighter(accent, 1.1) : accent
    readonly property color ink: !windowActive && !lit
                                 ? (LingmoUI.Theme.darkMode ? Qt.rgba(1, 1, 1, 0.45) : Qt.rgba(1, 1, 1, 0.9))
                                 : "white"

    Rectangle {
        anchors.fill: parent
        radius: width / 2
        color: control.fill
        scale: control.lit ? 1.08 : 1.0

        Behavior on color { ColorAnimation { duration: 140 } }
        Behavior on scale { NumberAnimation { duration: 160; easing.type: Easing.OutBack } }
    }

    Item {
        anchors.centerIn: parent
        width: 8
        height: 8

        // close: ×
        Repeater {
            model: control.kind === "close" ? [45, -45] : []
            Rectangle {
                anchors.centerIn: parent
                width: 9; height: 1.5; radius: 0.75
                rotation: modelData
                color: control.ink
                antialiasing: true
            }
        }

        // minimize: −
        Rectangle {
            visible: control.kind === "minimize"
            anchors.centerIn: parent
            width: 8; height: 1.5; radius: 0.75
            color: control.ink
        }

        // zoom: rounded square outline
        Rectangle {
            visible: control.kind === "zoom"
            anchors.centerIn: parent
            width: 7.5; height: 7.5; radius: 2
            color: "transparent"
            border.width: 1.4
            border.color: control.ink
        }

        // restore: two overlapping rounded squares
        Item {
            visible: control.kind === "restore"
            anchors.fill: parent
            Rectangle {
                x: 2; y: 0; width: 6; height: 6; radius: 1.5
                color: "transparent"; border.width: 1.3; border.color: control.ink
            }
            Rectangle {
                x: 0; y: 2; width: 6; height: 6; radius: 1.5
                color: control.fill
                border.width: 1.3; border.color: control.ink
            }
        }
    }

    MouseArea {
        id: _mouse
        anchors.fill: parent
        anchors.margins: -2
        hoverEnabled: true
        onClicked: control.clicked()
    }
}
