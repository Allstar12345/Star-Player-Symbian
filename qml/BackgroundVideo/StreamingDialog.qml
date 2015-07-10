// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1

CommonDialog{
id: streaminger
privateCloseIcon: true
buttonTexts: ["Ok"]
titleText:"Internet Stream"
content: TextField{
    id: url
    placeholderText: "Enter URL Here"
    anchors{
       fill: parent
    }
}
onButtonClicked: {video.source= url.text
    video.play();
    streaminger.destroy();streaming=true; startui.visible=false;bar.hide();currentTitle="Internet Stream"}
Component.onCompleted: {
    open()
}
}
