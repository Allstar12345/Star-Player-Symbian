// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1

Rectangle{
    opacity:0
    z: 1
    id: root
    anchors.fill: parent;color:"Transparent"
    property bool open
    function hide(){open=false;topInfo.opacity=0; controls.opacity=0}
    function show(){open=true;root.opacity=1;topInfo.opacity=0.7; controls.opacity= carMode? 0.9:0.7
        controlstimer.start(); open=true;}
    Timer{
        id: controlstimer
        interval: 6000
        repeat: false
        running: false
        onTriggered: {hide()}
    }
    function getTimeFromMSec(msec) {
        if (msec <= 0 || msec == undefined) {
            return "0:00"

        } else {
            var sec = "" + Math.floor(msec / 1000) % 60
            if (sec.length == 1)
                sec = "0" + sec

            var hour = Math.floor(msec / 3600000)
            if (hour < 1) {
                return Math.floor(msec / 60000) + ":" + sec
            } else {
                var min = "" + Math.floor(msec / 60000) % 60
                if (min.length == 1)
                    min = "0" + min

                return hour + ":" + min + ":" + sec
            }
        }
    }


    Rectangle{Behavior on opacity{NumberAnimation{}}  id:topInfo; height: carMode? 70:50;opacity:0;color:"black" ; anchors{top:parent.top} width:parent.width
        Text {
            visible: video.hasAudio?false:true;
            id: currentTrack
            anchors{verticalCenter: parent.verticalCenter;left:parent.left; leftMargin:5}
            color: "lightgray"
            font.pixelSize: carMode? 25:20
            text: "File Has No Audio"
            wrapMode: Text.Wrap
            maximumLineCount: 1
            width: root.width-100
            elide: Text.ElideRight
        }
        MenuButton{id: favBut;visible:currentTitle===""?false:true; imgSource: "img/favourite.svg"; anchors{right:parent.right; verticalCenter: parent.verticalCenter; rightMargin:2} onClicked:creator.createComponent("AddFavouriteDialog.qml")}
        MenuButton{id: repeatBut;visible:true; imgSource: "img/repeat.svg"; buttonPressed: video.repeat;anchors{right:favBut.left;rightMargin:2; verticalCenter: parent.verticalCenter;} onClicked:{if(video.repeat===true){video.repeat=false} else{video.repeat=true}}}
        MenuButton{visible:streaming===true? true:false; imgSource: "img/download.svg";anchors{right:repeatBut.left;rightMargin:2; verticalCenter: parent.verticalCenter;} onClicked:{creator.createComponent("DownloadDialog.qml")}}


    }
Rectangle{
    id: controls
    Behavior on opacity{NumberAnimation{}}
    visible: true
    height: carMode?190:150
    opacity: 0
    color: "black"
    anchors{
        right: parent.right
        left: parent.left
        bottom: parent.bottom
    }
    onWidthChanged: {
        if (controls.width=== 640){
            fastfoward.visible= true
            rewind.visible= true
        }

        else if (controls.width=== 360){
        fastfoward.visible=false
              rewind.visible= false
        }

    }

    Timer {
        id: longpressff
        interval: 100
        repeat: true
        onTriggered:{
         video.position += 2000
     }
    }

    Timer {
        id: longpressrw
        interval: 100
        repeat: true
        onTriggered:{
         video.position -= 2000
     }
    }

    Text {
        id: currentTime
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -41
        color:carMode?"white": "lightgray"
        font.pixelSize: carMode?25:18
        text: getTimeFromMSec(slider.value)
    }
    Slider {
         id: slider
         anchors.top: parent.top
         anchors.left: parent.left
         anchors.right: parent.right
         anchors.rightMargin: carMode?60:50
         anchors.leftMargin: carMode?60:50
         width: parent.width
         maximumValue: video.duration
         stepSize: 1000
         onPressedChanged: {if (!pressed)  video.position = value
         }

         Binding {
             target: slider
             property: "value"
             value: video.position
             when: !slider.pressed
       }
    }
    Text {
        id: durationTime
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -41
       color:carMode?"white": "lightgray"
        font.pixelSize:carMode?25: 18
        text: getTimeFromMSec(video.duration)
    }
    MenuButton{
        id: fastfoward
        anchors{right:playpause.right;rightMargin:160;verticalCenter: parent.verticalCenter;verticalCenterOffset: 20}
        height:carMode?90: 60
        width: carMode?90: 60
        customIconSize: true
        customIconWidth: carMode? "65" :"45"
        imgSource: "img/rewind.svg"
        onClicked: video.position -= 5000;
        onHold:{ longpressrw.start();controlstimer.stop()}
        onReleased: {   longpressrw.stop();controlstimer.start();}
    }

    MenuButton{
        id: playpause
        anchors{centerIn: parent;verticalCenterOffset: 20}
        height:carMode? 120: 90
        width: carMode? 120: 90
        customIconSize: true
        customIconWidth: carMode? "85": "65"
        imgSource: (video.paused == true || video.playing == false) ? "img/play.svg" : "img/pause.svg"
        onClicked:  if (video.playing == true) {
                        if (video.paused == true) {
                        playvideo()
                      }
              else {
                   pause()
         } }
    }
    MenuButton{
        id: rewind
        anchors{left:playpause.left;leftMargin:160;verticalCenter: parent.verticalCenter;verticalCenterOffset: 20}
        height:carMode?90: 60
        width: carMode?90: 60
        customIconSize: true
        customIconWidth: carMode? "65" :"45"
        imgSource: "img/fast_forward.svg"
        onClicked: video.position += 5000;
        onHold:{longpressff.start();controlstimer.stop()}
        onReleased: {longpressff.stop();controlstimer.start();}
    }

    MenuButton{
        id: volumer
        buttonEnabled:video.hasAudio?true: false
        buttonPressed: vol===0?true: false
        anchors{right:parent.right; rightMargin: 20; verticalCenter: parent.verticalCenter;verticalCenterOffset: 18}
        height: carMode? 95:65
        width:  carMode? 95:65
        customIconSize: true
        customIconWidth:carMode? "62": "42"
        imgSource: vol===0? "img/mute.svg": "img/volume.svg"
        onClicked:volumechanger.open()
        onHold: mute();

    }
    MenuButton{
        id:stoper
        anchors{left:parent.left; leftMargin: 20; verticalCenter: parent.verticalCenter;verticalCenterOffset: 18}
        height: carMode? 95:65
        width: carMode? 95:65
        customIconSize: true
        customIconWidth: carMode? "62": "42"
        imgSource:"img/stop.svg"
        onClicked: stopPlayBack()
    }

}

}
