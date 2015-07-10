import QtQuick 1.1
import QtMultimediaKit 1.1

Item {
    id: player

    property bool playing: false
    property int index: -1
    property alias playlistModel: playlist
    property alias count: playlist.count
    property string title: audioe.metaData.title != undefined && audioe.source != "" ? audioe.metaData.title : getFileFromPath(audioe.source.toString())
    property int duration: audioe.source != "" ? audioe.duration : 0
    property string durationTime: audioe.source != "" ? getTimeFromMSec(audioe.duration) : ""
    property string artist: audioe.metaData.albumArtist != undefined && audioe.source != "" ? audioe.metaData.albumArtist : ""
    property bool seekable: audioe.seekable
    property alias position: audioe.position
    property string positionTime: getTimeFromMSec(position)
    property alias volume: audioe.volume
    property bool repeat: false
    property bool shuffle: false
    property string error: audioe.errorString
    property alias playlist:  playlist

    signal playlistLoaded

    function play() {
        console.log("source: "+ audioe.source)

        playing = true
        console.log("playing:" + audioe.playing)
        console.log("error " + error)
           audioe.play()
    }

    function pause() {
        audioe.pause()
        playing = false
    }

    function stop() {
        audioe.stop()
        playing = false
    }

    function previous() {
        var i = shuffle ? (Math.random() * (count - 1)) : (index - 1)
        if (i < 0)
            i = repeat ? (count - 1) : 0

        index = i
        refreshSong()
    }

    function next() {
        var i = shuffle ? (Math.random() * (count - 1)) : (index + 1)
        if (i > count - 1) {
            if (repeat) {
                i = 0
            } else {
                i = count - 1
                playing = false
            }
        }

        index = i
        refreshSong()
    }

    function addSong(file, title, artist, duration) {
        playlist.append({"source": file,
                        "title": title,
                        "artist": artist,
                        "time": getTimeFromMSec(duration),
                        "selected": false})

        if (playlist.count == 1) {
            index = 0
            refreshSong()
          //  play()
        }
    }

    function remove(i) {
        playlist.remove(i)

        if (playlist.count == 0) {
                stop()

            audioe.source = ""
            return
        }

        if (i < index) {
            index--
        } else if (i == index) {
            if (index > count - 1)
                index = count - 1
        }
    }

    function refreshSong() {
        var wasPlaying = playing
            stop()

        if (index >= 0 && playlist.count > 0) {
            audioe.source = playlist.get(index).source
            console.log("SOURCE SET " + playlist.get(index).source )
            if (wasPlaying)
                play()
            if(playing===true){
                if(popupNextTrackPlaylist===true){
                QMLUtils.showPopup(playlist.get(index).title, "")}}
        }
    }

 function getFileFromPath(path) {
        return path.substring(path.lastIndexOf(path.charAt(path.indexOf(":") + 1)) + 1)
       // console.log(path.substring(path.lastIndexOf(path.charAt(path.indexOf(":") + 1)) + 1));
    }

    function getTimeFromMSec(msec) {
        if (msec <= 0 || msec == undefined) {
            return ""

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

    function updatePlaylistData() {
        playlist.setProperty(index, "time", durationTime)
        playlist.setProperty(index, "artist", artist)
        playlist.setProperty(index, "title", title)
    }

    onDurationTimeChanged: playlist.setProperty(index, "time", durationTime)
    onTitleChanged: playlist.setProperty(index, "title", title)
    onArtistChanged: playlist.setProperty(index, "artist", artist)

    ListModel {
        id: playlist
    }

    Audio {
        id: audioe
        volume: vol
        onStatusChanged: {
            if (status == Audio.EndOfMedia) {
                next()
            }
        }

        onPlayingChanged: updatePlaylistData()
    }
}
