import QtQuick 1.1
import com.nokia.symbian 1.1
import QtMobility.gallery 1.1
AppPage{
    z: 5
    id: tilevideoloader
    Component.onCompleted: show()

     ToolBar {
         id: toolbar
         anchors.bottom: parent.bottom
         z: 2
         ToolButton {
             iconSource: player.playlistModel.count? "img/ok.svg": "toolbar-back"
            onClicked: {close(); }
        }
         ToolButton{anchors.centerIn: parent; enabled:true; text:"Count: " + player.playlistModel.count}
    }
ListView {
    id: galleryGridView
    anchors{right: parent.right
    left: parent.left
    bottom: toolbar.top
    top: parent.top}
    delegate: videoDelegate
    model: galleryModel
    ScrollDecorator{flickableItem: galleryGridView; }
}

DocumentGalleryModel {
    id: galleryModel
    property bool ready: status === DocumentGalleryModel.Idle || status === DocumentGalleryModel.Finished
    autoUpdate: true
    properties: ["filePath", "url", "title", "lastModified"]
    sortProperties: ["-lastModified"]
    rootType: DocumentGallery.Video
}

Component {
    id: videoDelegate
    Item {
        property string mod: lastModified
          opacity: itemAdded? 0.5:1
          Behavior on opacity {NumberAnimation{}}
        property bool itemAdded
        MouseArea{anchors.fill: parent; onClicked:{console.log(filePath);
                var file = "file:///"+ filePath
                    player.addSong(file, title, "", 0)
                   itemAdded=true;
                    console.log("File : " +file)
                }
            }
        width:parent.width
        height: 100
                Image {
                    id: img
                    anchors{verticalCenter:parent.verticalCenter; left:parent.left; leftMargin:1}
                    sourceSize { width: 50; height: 50 }
                    source: "img/video.svg"
                }
                Text{
                    wrapMode: Text.Wrap
                    id: text1
                    maximumLineCount: 1
                    width: parent.width-60
                    elide: Text.ElideRight
                    anchors{verticalCenterOffset: -8;verticalCenter: parent.verticalCenter; left: img.right; leftMargin:5; } color:"white"; text:title}
                Text{
                    id: lastmod
                    opacity: 0.8
                    anchors{top:text1.bottom; topMargin: 2;left: img.right; leftMargin:5;verticalCenter: parent.verticalCenter}
                    color:"white"
                    text:"Last Modified: "+ mod.substring(0, 10)

                }
        }
}
}

