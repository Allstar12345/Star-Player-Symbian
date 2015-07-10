import QtQuick 1.1
import com.nokia.symbian 1.1

AppPage {
    Component.onCompleted: {show();}
    property int numOfSelectedItems: 0
    property alias removeMode: playlist.removeMode
    function clearSelection(remove) {
        var currentSongRemoved = false
        for (var i = 0; i < player.playlistModel.count; i++) {
            if (player.playlistModel.get(i).selected) {
                if (remove) {
                    if (i == player.index)
                        currentSongRemoved = true

                    player.remove(i)
                    i--
                } else {
                    player.playlistModel.setProperty(i, "selected", false)
                }
            }
        }
        if (currentSongRemoved)
            player.refreshSong()

        numOfSelectedItems = 0
    }


       ListHeading {
           id: headerr
           z: 1
            width: parent.width
            ListItemText {
               id: headingText
               anchors.centerIn: parent
                role: "Heading"
                text: "Playlist"
            }
        }


    Playlist {
        id: playlist
        width:parent.width
        anchors{bottom:playlistTools.top; top:headerr.bottom}
    }

    ToolBar {
        id: playlistTools
        z: 1

        visible: true
        anchors.bottom: parent.bottom

        ToolButton {
            flat: true
            visible: removeMode?false:true
            iconSource:"toolbar-back"
            onClicked:{ close(); bar.showDelayed(400)}
        }

       Row{
           spacing: 50
           anchors.centerIn: parent

           ToolButton {
            flat: true
            visible: removeMode?false:true
            iconSource: "toolbar-add"
          //  anchors.centerIn: parent
            onClicked: creator.createComponent("FilePickerPage.qml")
        }
        ToolButton {
            flat: true
            opacity:  player.playlistModel.count? 1: 0
            visible: removeMode?false:true
            iconSource: "img/shuffle.svg"
            checkable: true
            checked: player.shuffle
          //  anchors.right: removee.left
            onClicked:{if(player.shuffle===true){player.shuffle=false}
                else{player.shuffle=true;}}
        }
       }

        ToolButton {
            id: removee
            flat: true
            visible: removeMode?false:true
            anchors.right: parent.right
           iconSource: "toolbar-delete"
            enabled: player.playlistModel.count
            onClicked: {removeMode = true}
        }

        ToolButton {
            text: qsTr("Cancel")
          anchors.left:parent.left
             visible: removeMode?true:false
            onClicked: {
                clearSelection(false)
                removeMode = false
            }
        }
        ToolButton {
            text: qsTr("Remove")
            anchors.right:menuBut.left
            visible: removeMode?true:false
            enabled: numOfSelectedItems > 0
            onClicked: {
                clearSelection(true)
                removeMode = false
            }
        }

        ToolButton {
            id: menuBut
            flat: true
            anchors.right: parent.right
            visible: removeMode?true:false
            iconSource: "toolbar-menu"
           onClicked: viewMenu.open()
        }
    }


   Menu {
        id: viewMenu

        content:
            Column {
                width: viewMenu.width

                MenuItem {
                    text: qsTr("Select All")

                    onClicked: {
                        viewMenu.close()
                        for (var i = 0; i < player.playlistModel.count; i++)
                            player.playlistModel.setProperty(i, "selected", true)

                        numOfSelectedItems = player.playlistModel.count
                    }
                }

                MenuItem {
                    text: qsTr("Unselect All")

                    onClicked: {
                        viewMenu.close()
                        for (var i = 0; i < player.playlistModel.count; i++)
                            player.playlistModel.setProperty(i, "selected", false)

                        numOfSelectedItems = 0
                    }
                }
            }
    }
}
