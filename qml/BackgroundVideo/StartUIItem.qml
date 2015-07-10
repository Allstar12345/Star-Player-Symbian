// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle{
    color: "black"
    smooth: true
    border.width: 1
    signal clicked
    id: root
    property alias image: img.source
    border.color: mouse.pressed? "white" : "black"
    radius: 20
    width: 300
    anchors{
        top: parent.top
        topMargin: carMode?60:85
        bottom: parent.bottom
        bottomMargin: carMode?63:85
    }

    Image{
        id:img
        sourceSize.width:carMode? 240:200
        sourceSize.height: carMode? 240:200
        anchors.centerIn: parent
        MouseArea{
            anchors.fill: parent
            id: mouse
            onClicked:{root.clicked()}
        }
}
}
