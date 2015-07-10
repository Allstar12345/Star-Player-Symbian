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
            iconSource: "toolbar-back"
            onClicked: {close(); bar.showDelayed(400)}
        }
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
        MouseArea{anchors.fill: parent; onClicked:{console.log(filePath);currentTitle=title; startui.visible=false; video.source= "file:///"+filePath;  tilevideoloader.destroy();video.play();}}
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
