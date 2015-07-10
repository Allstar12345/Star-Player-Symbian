import QtQuick 1.1
import com.nokia.symbian 1.1

ContextMenuer{
    id: root
    Component.onCompleted: { open()}
property bool __isClosing: false
    onStatusChanged: {
        if (status === DialogStatus.Closing) __isClosing = true
        else if (status === DialogStatus.Closed && __isClosing) root.destroy()
    }
    MenuLayout{
      MenuItem{
          text: "Delete Favourite"
          onClicked:{deleteFav();}
      }

    }
}



