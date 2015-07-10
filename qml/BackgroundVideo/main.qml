import QtQuick 1.1
import com.nokia.symbian 1.1
import QtMultimediaKit 1.1
import QtMobility.systeminfo 1.1
import MediaKeysObserver 1.0
import AppSettings 1.0
import DownloadManager 1.0
Window {

    id: window
    signal downloadFinished
    property real downloadProgress
    property string currentTitle
    property bool carMode:appsettings.getSystemSetting("carMode", "")===""? false:true
    property bool popupNextTrackPlaylist:appsettings.getSystemSetting("popupNextTrackPlaylist", "")===""? true:false
    property bool streaming:false
    property bool firstRun: appsettings.getSystemSetting("firstRun", "")===""? true:false
    signal backgroundUIClose
    property real vol :appsettings.getSystemSetting("appvolume", "") != ''? appsettings.getSystemSetting("appvolume", ""): 0.3
    property bool applicationActive: Qt.application.active
    property string videosource: ""
    property Component __about: null
    QtObject { id: creator; property Component com: null;function createComponent (qmlfile){com = Qt.createComponent(qmlfile);com.createObject(window)} }
    AppSettings{id:appsettings}
    ScreenSaver { id: screenSaver ; Component.onCompleted: {screenSaver.setScreenSaverDelayed(true) }}
    PlaylistPlayer{id:player}
    DownloadManager{id: downloadManager}
    function playAudio(){audio.play()}
    function playvideo() {
        video.play()
        if(video.playing){console.log("playing")}else{console.debug("Not Playing")}
    }
    function stopPlayBack(){
        video.repeat=false;
        controls.hide();
        video.stop();
        audio.stop();
        audio.source="";
        video.source= "";
    }
    function stopAudio(){audio.stop();audio.source=""}
    function pauseAudio(){audio.pause();}
    function pause(){video.pause();}
    function close(){appsettings.saveSystemSetting("appvolume", vol)
        stopPlayBack();
        Qt.quit();
    }
    function mute(){vol=0;}
    function about(){QMLUtils.showPopup("Star Player by Allstar Software", "v1.01 ALPHA")}
    function openChooser(){var file= QMLUtils.openFileSelectionDlg();if(file==""){}else  {startui.visible=false; video.source= "file:///"+file; video.play();}}

    function openChooserBackground(){
         var file= QMLUtils.openFileSelectionDlg();if(file==""){}else  {audio.source= "file:///"+ file;QMLUtils.minimizeApp();startui.visible= false;creator.createComponent("BackgroundPlayerUI.qml"); backgroundplay.start();QMLUtils.showPopup("Star Player", "CPU Will Be Under High Load!")}}
    Timer{id: backgroundplay; interval: 1000;onTriggered:audio.play();}
    Timer{id: backgroundplayPlaylist; interval: 1000;onTriggered:player.play();}
    Controls{
        z:1
        id: controls
        anchors{
           fill:parent
        }
    }

VolumeChanger{
 z:2
 id: volumechanger
 anchors.centerIn: parent
}

Audio{
    id: audio
    volume: vol
    onStopped: {backgroundUIClose();appsettings.saveSystemSetting("appvolume", vol); startui.visible= true}
    onError: {console.log(audio.errorString)}
}
    Video{
        property bool repeat:false
        id: video
        focus: true
        visible: true
        anchors.fill: parent
        volume: vol
        autoLoad: false
        source: ""
        fillMode: Video.PreserveAspectFit
       // Timer{id: snapTimer;interval: 600; onTriggered: {QMLUtils.snapScreen(); controls.show();} }
        BusyIndicator{visible: video.status===Video.NoMedia?false:true;anchors.centerIn: parent;height:carMode? 120: 100; width: carMode? 120: 100; z:10; running: video.bufferProgress? false: true; opacity: video.bufferProgress?0: 1}
         MouseArea{
             anchors.fill: parent
             enabled: video.playing? true: false
             onClicked:{
                 if (controls.open===true){controls.hide();}
                 else {controls.show();}
             }
     //        onPressAndHold: {video.pause();controls.hide();snapTimer.start();}
         }
         onStopped: {
             if(repeat==true){
                 if(status===Video.EndOfMedia){
                     video.play();
                 }
             }
             else{
                 bar.show();
                 streaming=false;
                 startui.visible= true;
                 video.visible=false;
                 video.source= "";
                 controls.hide();
                 currentTitle="";
                 appsettings.saveSystemSetting("appvolume", vol)
             }
         }

         onStarted: {video.visible=true}

    }
    Bar{
        id: bar
        visible: video.playing? false: true
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
    }
    StartUI{
        id: startui
        z: 1
        visible: video.playing? false: true
        anchors{
            top: parent.top
            bottom: bar.top
            left: parent.left
            right: parent.right
        }
    }
MediaKeysObserver {
    id: mediakeysobserver
    property int key

    onMediaKeyClicked: {
            volumechanger.open()

        if (key == MediaKeysObserver.EVolIncKey) {
            if (vol < 1.0) {
                vol += 0.05

            }
        }

        else if (key == MediaKeysObserver.EVolDecKey) {
            if (vol > 0.05) {
                vol -= 0.05
            }
        }
     }

    onMediaKeyPressed: {
        volumechanger.open()
        volumelongpress.start()
        mediakeysobserver.key = key
    }
    onMediaKeyReleased: {
        volumechanger.close()
        volumelongpress.stop()
    }
}

Timer {
    id: volumelongpress
    interval: 100
    repeat: true
    onTriggered: {
        if (mediakeysobserver.key == MediaKeysObserver.EVolIncKey) {
            if (vol < 1.0) {
                vol += 0.05
            }
        }
        else if (mediakeysobserver.key == MediaKeysObserver.EVolDecKey) {
            if (vol > 0.05) {
                vol -= 0.05
            }
        }
    }
}

Connections {
       target: QApp
       onRedPressed:{close();}
}
Connections{
    target: downloadManager
    onDownloadStarted:{console.log("Started");creator.createComponent("DownloadManagerProgress.qml")}
    onDownloadStatus:{downloadProgress=currentStatus;}
    onDownloadComplete:{downloadFinished();QMLUtils.showPopup("Star Player", "Download Completed")}
}
}
