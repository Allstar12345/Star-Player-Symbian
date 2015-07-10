import QtQuick 1.1
import com.nokia.symbian 1.1


ContextMenuer{
    id: root
    Component.onCompleted: {open();}
    property bool __isClosing: false

        onStatusChanged: {
            if (status === DialogStatus.Closing) __isClosing = true
            else if (status === DialogStatus.Closed && __isClosing) root.destroy()
        }

    MenuLayout{

        MenuItem{
            text: "Background Player (Playlist)"
            onClicked:{bar.hide();create.createComponent("PlaylistPage.qml")}
        }
        MenuItem{
            text: "Background Player (File Picker)"
            onClicked: {openChooserBackground();}
        }
        MenuItem{
            text: "Background Player (Video Picker)"
            onClicked:{bar.hide();create.createComponent("TileVideoLoaderBackground.qml")}
        }
        MenuItem{
            text: "Normal Player (File Picker)"
            onClicked: {openChooser();}
        }
        MenuItem{
            text: "Normal Player (Video Picker)"
            onClicked:{bar.hide();create.createComponent("TileVideoLoader.qml")}
        }
        MenuItem{
            text: "Internet Stream"
            onClicked:{create.createComponent("StreamingDialog.qml")}
        }
    }
}
