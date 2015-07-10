import QtQuick 1.1
import com.nokia.symbian 1.1


CommonDialog {
        id: root
        Component.onCompleted: {open()}
         property bool __isClosing: false
        titleText: "Download"
        height: 200
        buttonTexts: ["Cancel", qsTr("Download")]
        content: Label {  wrapMode: Text.Wrap
            maximumLineCount: 3
            width: parent.width-1
            anchors.centerIn: parent; text: "Download File?\n"+ video.source;}
        onButtonClicked: {
            if (index === 0) close();
            else if (index === 1)video.pause(); downloadManager.download(video.source)

    }
        onStatusChanged: {
            if (status === DialogStatus.Closing) __isClosing = true
            else if (status === DialogStatus.Closed && __isClosing) root.destroy()
        }

}
