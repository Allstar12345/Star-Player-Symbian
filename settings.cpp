#include "settings.h"
#include <QSettings>
#include <Qstring>
#include <QDebug>

Setting::Setting(QObject *parent):
 QObject(parent)
{
}
void Setting::dropSettings(){
    QSettings settings("C:/data/.config/AllstarSoftware/StarBrowserSystem.ini", QSettings::IniFormat);
    settings.remove("");
}


QString Setting::getSystemSetting(QString name, QString defaultValue){
    QSettings settings("C:/data/.config/AllstarSoftware/StarBrowserSystem.ini", QSettings::IniFormat);
    return settings.value(name, defaultValue).toString();
}
void Setting::saveSystemSetting(QString name,QString data){
     QSettings settings("C:/data/.config/AllstarSoftware/StarBrowserSystem.ini", QSettings::IniFormat);
     settings.setValue(name, data);}


