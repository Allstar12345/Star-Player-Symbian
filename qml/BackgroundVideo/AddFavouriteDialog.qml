// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
import "Bookmarks.js" as Bookmarks

CommonDialog{
id: fav
privateCloseIcon: true
buttonTexts: ["Add"]
height: 200
titleText: "Add Favourite"
onButtonClicked: {
    var itemnew = Bookmarks.defaultItem();
           itemnew.title = titlet.text;
           itemnew.url = video.source;
           itemnew.creationdate=""
    itemnew.stream= streaming;
     console.log( itemnew.stream)
          Bookmarks.createBookmark(itemnew);
     console.log(itemnew)}
onAccepted: {

}

content:
    Item {
     anchors.fill: parent
     TextField{
    id: titlet
    text:currentTitle
    width:parent.width
    anchors{top:parent.top}}

}
Component.onCompleted: {open();Bookmarks.openDB();}
}
