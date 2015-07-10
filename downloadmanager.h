#ifndef DOWNLOADMANAGER_H
#define DOWNLOADMANAGER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QFile>

class DownloadManager : public QObject
{
    Q_OBJECT
public:
    explicit DownloadManager(QObject *parent = 0);

signals:
   Q_INVOKABLE void downloadComplete();

    void progress( int percentage);
    Q_INVOKABLE void downloadStatus(float currentStatus);
    Q_INVOKABLE void downloadStarted();


public slots:

    Q_INVOKABLE void cancel();
     Q_INVOKABLE void download(QUrl url);

     Q_INVOKABLE  void pause();

     Q_INVOKABLE  void resume();

private slots:

   void download( QNetworkRequest& request );

    Q_INVOKABLE   void finished();

    Q_INVOKABLE   void downloadProgress ( qint64 bytesReceived, qint64 bytesTotal );

     Q_INVOKABLE  void error ( QNetworkReply::NetworkError code );


private:

    QNetworkAccessManager* mManager;
    QNetworkRequest mCurrentRequest;
    QNetworkReply* mCurrentReply;
    QFile* mFile;
    int mDownloadSizeAtPause;
};

#endif // DOWNLOADMANAGER_H
