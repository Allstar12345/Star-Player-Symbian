#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"
#include <QtGui/QPixmap>
#include <QDeclarativeProperty>
#include <QSettings>
#include <QDir>
#include <QDebug>
#include <QObject>
#include <QtGui/QSplashScreen>
#include <QtGui/QPixmap>
#include <QtNetwork/QNetworkAccessManager>
#include <QtNetwork/QNetworkCookieJar>
#include <QtNetwork/QNetworkDiskCache>
#include <QtDeclarative/QDeclarativeContext>
#include <QtDeclarative/QDeclarativeNetworkAccessManagerFactory>
#include <QtDeclarative/QDeclarativeEngine>
#include <QMutex>
#include <QMutexLocker>
#include "qmlutils.h"
#include <QtDeclarative>
#include "mediakeysobserver.h"
#include "qsymbianapplication.h"
#include<QMessageBox>
#include<QSymbianEvent>

#include <QKeyEvent>
#include <HAL.h>
#include <hal_data.h>
#include "akndiscreetpopup.h"
#include "settings.h"
#include "downloadmanager.h"
#define C6 0x2002376a
#define C7 0x2002bf92
#define E7 0x2002bf96
#define N8 0x20029a73
#define X7 0x20029a6f
#define X7B 0x20035563
#define E6 0x20023767
#define Oro 0x20035560
#define N500 0x20035566
#define VERTU 0x20029A72

bool checkDevice()
{
    TInt uid = 0;
    HAL::Get(HAL::EMachineUid, uid);
    if( uid == C6 || uid == C7 || uid == E7 || uid == N8 || uid == X7 || uid ==E6 || uid == Oro || uid == E7 || uid == N500 || uid == VERTU || uid == X7B)
        {
            return true;
        }
    else
        {
            return false;
        }
}


int main(int argc, char **argv)

{
QCoreApplication::setAttribute(Qt::AA_S60DisablePartialScreenInputMode, false);
QScopedPointer<QSymbianApplication> app(new QSymbianApplication(argc, argv));
    QDeclarativeView view;
    view.rootContext()->setContextProperty("QApp", app->instance());
    qmlRegisterType<Setting> ("AppSettings", 1, 0, "AppSettings");
    qmlRegisterType<DownloadManager> ("DownloadManager", 1, 0, "DownloadManager");
   qmlRegisterType<MediaKeysObserver>("MediaKeysObserver", 1, 0, "MediaKeysObserver");
    QMLUtils qmlUtils(&view);
    view.rootContext()->setContextProperty("QMLUtils", &qmlUtils);
    if(checkDevice())
    {
       qmlUtils.showStartDevice();
    }
    view.setProperty("orientationMethod", 1);
    view.setSource(QUrl("qrc:/qml/BackgroundVideo/main.qml"));
    view.showFullScreen();
     return app->exec();
}





