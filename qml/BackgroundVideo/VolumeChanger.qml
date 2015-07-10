// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
Rectangle{
signal clickedOutside
    onClickedOutside: {lose();}

    function open(){
        appear.start()
        if (vol=== 1.0){ voltext.text= "100%"}
        volchangertimer.start()
    }
    function close(){disappear.start(); volchangertimer.stop();}
    MouseArea{
        anchors.fill: parent
        onClicked: { close();}
   }
    id: volumechanger
    visible: true
    opacity: 0
    anchors{centerIn: parent}
    height: 140
    width:screen.width-3
    color: "black"
    radius: 20
    smooth: true

    PropertyAnimation{
        id: appear
        to: 0.800
        property: "opacity"
        target: volumechanger
    }
    PropertyAnimation{
        id: disappear
        to: 0
        property: "opacity"
        target: volumechanger
    }

    Text{
        id: voltext
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        color: "white"
        font.pixelSize: 39
        text: Math.round(vol*100) + "%"
        style: Text.Raised
    }

    ProgressBarMod{
        value: vol
        mediaVolumeHigh: vol > 0.7? true:false
        id: pbar
        minimumValue: 0.0
        maximumValue: 1.0
        height: 35
        anchors.right: parent.right
        anchors.rightMargin: 60
        anchors.left: parent.left
        anchors.leftMargin: 60
        anchors.verticalCenter: parent.verticalCenter
    }
    MenuButton{
        anchors{verticalCenter: parent.verticalCenter; right: pbar.left; rightMargin: 1}
        imgSource: "img/volume_decrease.svg"
        onClicked: {
            if (vol > 0.05) {
                vol -= 0.05
            }}
    }
    MenuButton{
        anchors{verticalCenter: parent.verticalCenter; left: pbar.right; leftMargin:1}
        imgSource: "img/volume_increase.svg"
        onClicked:{
            if (vol < 1.0) {
                vol += 0.05
            }}
    }


    Timer{
        id: volchangertimer
        interval: 8000; repeat: false; running: false
        onTriggered: {
            volumechanger.close()
        }
    }
}
