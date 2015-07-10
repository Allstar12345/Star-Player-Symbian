#ifndef SETTING_H
#define SETTING_H

#include <QtCore/QObject>
#include <QtGui/QApplication>


class Setting : public QObject
{
    Q_OBJECT
public:
    explicit Setting(QObject *parent = 0);
   Q_INVOKABLE QString getSystemSetting(QString name, QString defaultValue);
    Q_INVOKABLE void saveSystemSetting(QString name, QString data);

    Q_INVOKABLE void dropSettings();

};

#endif
