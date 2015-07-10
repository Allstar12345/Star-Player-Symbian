// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1

QueryDialog{
id: profiledialog
titleText: "Profile"
message: "Profile Changed, would you like to\n adjust the Apps volume to suite the profile?"
acceptButtonText: "Yes"
rejectButtonText: "No"
onAccepted: {currentVolume = deviceInfo.voiceRingtoneVolume / 100;
    profiledialog.destroy()}
onRejected: {profiledialog.destroy()}
Component.onCompleted: {
    open()
}
}
