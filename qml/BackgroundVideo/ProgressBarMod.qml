import QtQuick 1.1
import com.nokia.symbian 1.1
import Qt.labs.components 1.1
//import "." 1.1

Item {
    id: root

    // Common Public API
    property bool mediaVolumeHigh:false
    property alias minimumValue: model.minimumValue
    property alias maximumValue: model.maximumValue
    property alias value: model.value
    property bool indeterminate: false

    // Symbian specific API
    property bool platformInverted: false

    implicitWidth: Math.max(50, screen.width / 2) // TODO: use screen.displayWidth
    implicitHeight: privateStyle.sliderThickness

    BorderImage {
        id: background

        source: privateStyle.imagePath("qtg_fr_progressbar_track", root.platformInverted)
        border { left: platformStyle.borderSizeMedium; top: 0; right: platformStyle.borderSizeMedium; bottom: 0 }
        anchors.fill: parent
    }

    Loader {
        id: progressBarContent

        LayoutMirroring.enabled: false
        LayoutMirroring.childrenInherit: true

        states: [
            State {
                name: "indeterminate"
                when: root.indeterminate
                PropertyChanges { target: progressBarContent; sourceComponent: indeterminateContent; anchors.fill: parent }
            },
            State {
                name: "determinate"
                when: !root.indeterminate
                PropertyChanges { target: progressBarContent; sourceComponent: determinateContent }
                AnchorChanges {
                    target: progressBarContent
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                }
            }
        ]
    }


    Component {
        id: indeterminateContent

        Item {
            anchors.fill: parent

            Item {
                id: indeterminateImageMask

                // Mask margins prevent indeterminateImage to appear outside the rounded
                // frame corners, hardcoded 3 has been instructed by UX
                anchors { fill: parent; leftMargin: 3; rightMargin: 3 }
                clip: true

                Image {
                    id: indeterminateImage

                    x: parent.x
                    height: parent.height
                    width: parent.width + height // height is the amount of horizontal movement
                    fillMode: Image.TileHorizontally
                    source: privateStyle.imagePath(root.platformInverted ? "qtg_graf_progressbar_wait_inverse"
                                                                         : "qtg_graf_progressbar_wait")

                    NumberAnimation on x {
                        loops: Animation.Infinite
                        running: true
                        from: 0
                        to: -indeterminateImage.height // see indeterminateImage.width
                        easing.type: Easing.Linear
                        duration: privateStyle.sliderThickness * 30
                    }
                }
            }

            BorderImage {
                id: indeterminateOverlay

                anchors.fill: parent
                source: privateStyle.imagePath("qtg_fr_progressbar_overlay", root.platformInverted)
                border {
                    left: platformStyle.borderSizeMedium
                    right: platformStyle.borderSizeMedium
                    top: 0
                    bottom: 0
                }
            }
        }
    }

    Component {
        id: determinateContent

        Item {
            id: progressMask

            width: model.position
            clip: true

            BorderImage {
                id: progress

                source: mediaVolumeHigh? "img/qtg_fr_progressbar_fill_red.svg": "img/qtg_fr_progressbar_fill.svg"

                border {
                    left: platformStyle.borderSizeMedium
                    right: platformStyle.borderSizeMedium
                    top: 0
                    bottom: 0
                }
                height: parent.height
                width: root.width
            }
        }
    }

    RangeModel {
        id: model
        minimumValue: 0.0
        maximumValue: 1.0
        positionAtMinimum: 0.0
        positionAtMaximum: background.width
    }
}

