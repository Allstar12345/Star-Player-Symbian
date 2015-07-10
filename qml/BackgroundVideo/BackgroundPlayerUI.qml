import QtQuick 1.1
import com.nokia.symbian 1.1
Rectangle{
    color: "black"
    anchors.fill: parent
    z: 20
    visible: true
    id: audiopage
    Component.onCompleted:{}
    property int lastPosition
    property string lastSource
    Connections{
        target: window
        onBackgroundUIClose:{audiopage.destroy();}
    }

    MenuButton{
        height: 100
        customIconWidth: "50"
        customIconSize: true
        width: 100
        imgSource:(audio.paused == true || audio.playing == false) ? "img/play.svg" : "img/pause.svg"
        anchors{bottom: parent.bottom; bottomMargin: 5; horizontalCenter: parent.horizontalCenter}
        onClicked: { if (audio.playing == true) {
             if (audio.paused == true) {playAudio()}
   else { pauseAudio()
} }}
    }

    MenuButton{
        height: 80
        customIconWidth: "35"
        customIconSize: true
        width: 80
        imgSource:"img/stop.svg"
        anchors{bottom: parent.bottom; bottomMargin: 15; left:parent.left}
        onClicked: {stopAudio();}
    }
   /* MenuButton{
        height: 80
        customIconWidth: "35"
        customIconSize: true
        width: 80
        imgSource:"img/home.svg"
        anchors{bottom: parent.bottom; bottomMargin: 15; right:parent.right}
        onClicked: {console.log(audio.position);lastPosition=audio.position; lastSource=audio.source;audio.source=""; console.log(lastPosition);QMLUtils.minimizeApp();console.log("this far"); audio.source=lastSource; console.log("SOURCE "+audio.source);audio.position=lastPosition;console.log("s "+ audio.position); audio.play();}
    }*/
}
