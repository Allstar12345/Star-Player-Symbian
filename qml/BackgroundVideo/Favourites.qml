// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
import "Bookmarks.js" as Bookmarks
AppPage{
    Component.onCompleted: {show();Bookmarks.openDB();updateList();bmView.opacity=1; }
    id: col
    QtObject { id: favcreator; property Component com: null;function createComponent (qmlfile){com = Qt.createComponent(qmlfile);com.createObject(col)} }

    function updateList()
    {
        bmView.model = 0;
        Bookmarks.readBookmarkList(bmModel);
        bmView.model = bmModel;
        bmView.positionViewAtEnd()
        console.log(bmView.count)
        if(bmView.count===0){bmView.opacity=0; nocontent.opacity=1} else{nocontent.opacity=0}
    }
    function deleteAll(){Bookmarks.dropTable()
            Bookmarks.createTable()
        updateList()}
    function deleteFav(){Bookmarks.deleteBookmark(bmView.currentItem.myData.id)
        updateList();}
    ListHeading {
        id: sectionHeading

        ListItemText {
            id: headingText
            anchors.centerIn: parent
            role: "Heading"
            text: "Favourites"
        }
    }
    ToolBar{
        id:toolbar
        anchors.bottom: parent.bottom
        ToolButton{anchors.left: parent.left; iconSource: "toolbar-back"; onClicked: {close();bar.showDelayed(300);}}
        ToolButton{anchors.right:parent.right; iconSource: "toolbar-delete"; onClicked: {deleteAll();close();bar.showDelayed(300);}}
    }
    Text{id: nocontent; text:"No Favourites"; anchors.centerIn:parent;  font.pointSize: 11; color: "grey"}
       ListView {
           id: bmView
           opacity:1
           anchors.top: sectionHeading.bottom
           anchors.bottom: toolbar.top
           anchors.left: parent.left
           anchors.right: parent.right
           clip: true
           model: bmModel
           delegate: bmDelegate
           highlightFollowsCurrentItem: true
           currentIndex: count
           ScrollDecorator{flickableItem: bmView}
       }
       ListModel {id: bmModel}
       Component {
         id: bmDelegate
         ListItem {
             property bool selected: false
             property variant myData: model
             id: bmItem
             onPressAndHold: favcreator.createComponent("FavLongMenu.qml");
             onClicked: { startui.visible=false; close();video.source=model.url;video.play();console.debug("Stream model: "+ model.stream); if(model.stream==="true"){streaming=true;} console.log("stream: "+streaming)}
             Column { anchors.fill: bmItem.paddingItem
                 ListItemText {
                     id: titleTxt
                     role: "Title"
                      mode: bmItem.mode
                     text: model.title
                 }
                 ListItemText {
                     id: urlTxt
                     role: "SubTitle"
                     mode: bmItem.mode
                     text: model.url
                 }

             }
         }
       }
}
