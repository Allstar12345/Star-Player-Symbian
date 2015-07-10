import QtQuick 1.1
import com.nokia.symbian 1.1

Menu{
    z: 6
    clip: true
    id: playmenu
    property int indexPlaying : -1 // index of file being played
    property string activeFolder // active folder with file being played
    property int indexFolder : -1 // index of previous folder clicked, to refocus list
    Component.onCompleted: {open()}
    MenuLayout{
        MenuItem{
            text: "Play"
            onClicked: {
                indexPlaying = index
                filePlaying = model.filePath
                activeFolder = folderModel.folder
                video.source= ""
                video.stop()
                video.visible= true
               video.source = model.filePath
                video.play()
                loader.source= ""
                loader.visible= false
            }
        }
        MenuItem{
            text: "Play In Background"
            onClicked:{
                indexPlaying = index
                filePlaying = model.filePath
                activeFolder = folderModel.folder
                Setting.set ("background", model.filePath)
                QMLUtils.minimizeApp()
                loader.source= "BackgroundPlayer.qml"
                videoloader.destroy();
            }
        }
        MenuItem{
            text: "Use Native Player"
            onClicked: {
                startui.visible= true
                Qt.openUrlExternally(model.filePath)
            }
        }

        MenuItem{
            text: "Back"
            onClicked:{
              loader.visible= true
            }
        }
    }
}
