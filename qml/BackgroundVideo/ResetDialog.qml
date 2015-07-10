import QtQuick 1.1
import com.nokia.symbian 1.1
import "Bookmarks.js" as Bookmarks


CommonDialog {
        id: root
        z:Infinity
        Component.onCompleted: {open(); Bookmarks.openDB();}
         property bool __isClosing: false
        titleText: "Reset Application"
        buttonTexts: ["Cancel", ("Reset")]
        content: Label {
            anchors.centerIn: parent; text: "Reset Star Player?"}
        onButtonClicked: {
           // if (index === 0){}
             if (index === 1){Bookmarks.dropTable();appsettings.dropSettings();window.close();}

    }
        onStatusChanged: {
            if (status === DialogStatus.Closing) __isClosing = true
            else if (status === DialogStatus.Closed && __isClosing) root.destroy()
        }

}
