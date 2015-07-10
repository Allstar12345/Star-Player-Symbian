// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1

CommonDialog{

Component.onCompleted: {open();}
id: progressDio
privateCloseIcon: true
buttonTexts: ["Cancel Download"]
onButtonClicked: {downloadManager.cancel();}
titleText:"Downloading.."
content:
    Item{anchors.fill: parent
    Connections{target:window
        onDownloadFinished:{close(); }
    }
ProgressBar{value:downloadProgress; maximumValue: 1.0; minimumValue: 0; width: parent.width-5;anchors{centerIn:parent}}
}
}
