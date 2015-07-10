// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
import "Settings.js" as Setting

AppPage{
    id: settings
    Component.onCompleted: {show();}

    ToolBar{
        id: toolbar
        anchors.bottom: parent.bottom
        ToolButton{anchors.left: parent.left; iconSource: "toolbar-back";onClicked: {close();bar.showDelayed(300);}}
    }

    Flickable {
        id: flickable1
        anchors{top:parent.top; bottom:toolbar.top;left:parent.left; right:parent.right}
        contentHeight: list.height
        contentWidth: list.width
        ScrollDecorator{
            flickableItem: flickable1

        }
    Column {
       spacing: 1
       id: list
       ListHeading {
           id: sectionHeading

           ListItemText {
              id: headingText
              anchors.centerIn: parent
               role: "Heading"
               text: "Settings"
           }
       }

       ListItem {
            id: c
            enabled: false
            ListItemText {
                role: "Title"
                text: "Car Mode"
                anchors.fill: c.paddingItem
            }
           Switch {
                anchors.right: parent.right
                anchors.rightMargin: 1
                height:parent.height
                checked: carMode
                onClicked: {
                    if(appsettings.getSystemSetting("carMode", "")===""){appsettings.saveSystemSetting("carMode", "enabled"); carMode=true;}
                    else{appsettings.saveSystemSetting("carMode", ""); carMode=false;}
                }
            }
       }
       ListItem {
            id: f
              height: 88
            enabled: false
            Column { anchors.fill: parent.paddingItem
                ListItemText {
                     role: "Title"
                     text: "Playlist Track Banner"
                    anchors.fill: parent.paddingItem
                 }
                 ListItemText {
                     role: "SubTitle"
                     mode:f.mode
                     text: screen.width===360? "Show Banner When Playlist Track\nChanges": "Show Banner When Playlist Track Changes"
                 }
           }
           Switch {
                anchors.right: parent.right
                anchors.rightMargin: 1
                height:parent.height
                checked: popupNextTrackPlaylist
                onClicked: {
                    if(appsettings.getSystemSetting("popupNextTrackPlaylist", "false")===""){appsettings.saveSystemSetting("popupNextTrackPlaylist", "");  popupNextTrackPlaylist=true;}
                    else{appsettings.saveSystemSetting("popupNextTrackPlaylist", "false");  popupNextTrackPlaylist=false;}
                }
            }
       }
       ListItem {
            id: startm
              height: 88
            enabled: false
            Column { anchors.fill: parent.paddingItem
                ListItemText {
                     role: "Title"
                     text: "Stop Warning Message"
                    anchors.fill: parent.paddingItem
                 }
                 ListItemText {
                     role: "SubTitle"
                     mode:f.mode
                     text: screen.width===360? "Stop Warning Message on startup\nfor first gens": "Stop Warning Message on startup for first gens"
                 }
           }
           Switch {
                anchors.right: parent.right
                anchors.rightMargin: 1
                height:parent.height
                checked: appsettings.getSystemSetting("firstGenStartupWarning", "")? true: false
                onClicked: {
                    if(appsettings.getSystemSetting("firstGenStartupWarning", "")===""){appsettings.saveSystemSetting("firstGenStartupWarning", "false"); }
                    else{appsettings.saveSystemSetting("firstGenStartupWarning", "");;}
                }
            }
       }

       ListItem {
            id: re
            enabled: true
            subItemIndicator: true
            onClicked: creator.createComponent("ResetDialog.qml")
            ListItemText {
                role: "Title"
                text: "Reset Star Player"
                anchors.fill: re.paddingItem
            }
       }

    }
    }

}
