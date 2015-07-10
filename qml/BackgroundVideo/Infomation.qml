// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1

CommonDialog{
    id: infomation
    titleText: "Infomation"
    privateCloseIcon: true
    content:
        Flickable{
        anchors.fill: parent
        contentHeight: column.height
        contentWidth: column.width
         flickableDirection: Flickable.VerticalFlick
        Column{
            id: column
            ListItem {
                 id: title
                 enabled: false
                 ListItemText {
                     role: "Title"
                     text: "Title: "+ vtitle
                     anchors.fill: parent.paddingItem

                 }
             }
            ListItem {
                 id: author
                 enabled: false
                 ListItemText {
                     role: "Title"
                     text: "Author: "+video.metaData.author
                     anchors.fill: parent.paddingItem

                 }
             }
            ListItem {
                 id: res
                 enabled: false
                 ListItemText {
                     role: "Title"
                     text: "Resolution: "+ video.metaData.resolution
                     anchors.fill: parent.paddingItem

                 }
             }
        }
    }
}
