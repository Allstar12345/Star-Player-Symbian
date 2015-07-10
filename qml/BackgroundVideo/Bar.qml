import QtQuick 1.1

    Image{
        property int delayInt
        function hide(){anchors.bottomMargin=-47; visible=false}
        function show(){anchors.bottomMargin=0; visible=true}
        function showDelayed(inter){delayInt=inter; delay.start();}
        Timer{id:delay; interval: delayInt; onTriggered:{show();}}
        visible: video.playing? false: true
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        fillMode: Image.PreserveAspectFit
        source: "img/close.svg"
        sourceSize.height: 45
        sourceSize.width: 45
        smooth: true

        scale: mouseArea.pressed ? 0.9 : 1.0

        Behavior on scale { NumberAnimation { duration: 100 } }

        MouseArea{
            id: mouseArea
            anchors.fill: parent
            onClicked: {
                close();
            }
        }
    }

