
import QtQuick 1.1
import com.nokia.symbian 1.1

Item {
    property bool removeMode: false
    property alias header: listview.header

    Component {
        id: playlistDelegate

        Item {
            height: 75
            width: listview.width

            Rectangle {
                height: parent.height
                width: 4
                color: "#2d2875"
                visible: index % 2
            }

            Row {
                anchors { top: parent.top; bottom: parent.bottom; margins: 10 }
                width: parent.width

                Item {
                    id: numText

                    width: 50
                    height: parent.height
                    anchors.top: parent.top

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        visible: index != player.index
                        font.pixelSize: 22
                        font.letterSpacing: -1
                        color: "white"
                        text: index + 1 + "."
                        horizontalAlignment: Text.AlignHCenter
                    }

                    Image {
                        anchors.top: parent.top
                        anchors.topMargin: 4
                        anchors.horizontalCenter: parent.horizontalCenter
                        visible: index == player.index
                        source: player.playing ? "img/play.svg" : "img/pause.svg"
                    }
                }

                Column {
                    width: (listview.width > 300) ? (parent.width - timeText.width - numText.width) : (parent.width - timeText.width)
                    spacing: 3

                    Text {
                        id: titleText
                        width: parent.width
                        elide: Text.ElideRight
                        font.pixelSize: 22
                        font.letterSpacing: -1
                        color: "white"
                        text: title
                    }

                    Text {
                        id: artistText
                        width: parent.width
                        elide: Text.ElideRight
                        text: artist
                        font.pixelSize: 18
                        color: "white"
                    }
                }

                Item {
                    width: 60
                    height: parent.height

                    Text {
                        id: timeText
                        width: parent.width
                        visible: !removeMode && listview.width > 300
                        anchors.top: parent.top
                        horizontalAlignment: Text.AlignHCenter
                        elide: Text.ElideRight
                        font.pixelSize: 22
                        font.letterSpacing: -1
                        color: "white"
                        text: time
                    }

                    CheckBox {
                        visible: removeMode
                        anchors.centerIn: parent
                        checked: selected
                    }
                }
            }

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    if (removeMode) {
                        var selected = player.playlistModel.get(index).selected
                        player.playlistModel.setProperty(index, "selected", !selected)
                        if (selected)
                            numOfSelectedItems--
                        else
                            numOfSelectedItems++

                    } else {
                        if (player.index == index) {
                            if (player.playing)
                                player.pause()
                            else
                                QMLUtils.minimizeApp();QMLUtils.showPopup("Star Player", "CPU Will Be Under High Load!"); backgroundplayPlaylist.start();


                        } else {
                            player.index = index
                            player.refreshSong()
                        }
                    }
                }
            }
        }
    }

    ListView {
        id: listview

        anchors.fill: parent
        model: player.playlistModel
        delegate: playlistDelegate
        currentIndex: player.index
        cacheBuffer: height
        clip: true
        highlightMoveDuration: 500

        ScrollDecorator {
            flickableItem: parent
        }
    }
}
