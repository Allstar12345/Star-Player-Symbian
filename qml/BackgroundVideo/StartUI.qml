import QtQuick 1.1
Flickable{
    id: startui
    visible: true
    contentHeight: parent.height
    contentWidth: 1274
    boundsBehavior: Flickable.StopAtBounds
    flickableDirection: Flickable.HorizontalFlick
    Component.onCompleted: {if(firstRun===true){
            text.opacity=1; timer.start();
        }
    }
    anchors{
        top: parent.top
        bottom: bar.top
        left: parent.left
        right: parent.right
    }
    Timer{id: timer; interval: 1000; onTriggered: {text.opacity=0; firstRun=false;appsettings.saveSystemSetting("firstRun", "true") }}
    QtObject { id: create; property Component com: null;function createComponent (qmlfile){com = Qt.createComponent(qmlfile);com.createObject(startui)} }

    property Component __playmenu: null
    function openplaymenu() {if (!__playmenu) __playmenu = Qt.createComponent("PlayMenu.qml")
        __playmenu.createObject(startui)}

    StartUIItem{
        opacity: firstRun? 0: 1
        id: rect
        Behavior on opacity{NumberAnimation{}}
        onClicked:{ openplaymenu() }
        image:"img/filmstrip.svg"
        anchors{ left: parent.left;leftMargin: 30}}
    StartUIItem{
        id: rect2
        Behavior on opacity{NumberAnimation{}}
        opacity: firstRun? 0: 1
        image:"img/favourite.svg"
        onClicked:{bar.hide();create.createComponent("Favourites.qml")}
        anchors{left: rect.right; leftMargin: 1}}


    StartUIItem{
        id: rect3
          opacity: firstRun? 0: 1
        onClicked:{ bar.hide();
            create.createComponent("Settings.qml")}
        image:"img/settings.svg"
        anchors{left: rect2.right; leftMargin: 1}}

    StartUIItem{
        id: rect4
        opacity: firstRun? 0: 1
        onClicked:{about();}
        image:"img/information_userguide.svg"
        anchors{left: rect3.right; leftMargin: 1; rightMargin: 30}}
    Text{
        id: text
        Behavior on opacity{NumberAnimation{duration: 1000}}
        font.pointSize: 11
        font.bold: true
        opacity:0
        anchors{left:parent.left;leftMargin: 50; verticalCenter:parent.verticalCenter  }
        text:"Slide for more options"
        color:"white"
}

}
