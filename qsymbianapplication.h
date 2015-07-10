
#ifndef QSYMBIANAPPLICATION_H
#define QSYMBIANAPPLICATION_H

#include <QObject>
#include <QtGui/QApplication>
#include <QSymbianEvent>
#include <w32std.h>
#include <eikenv.h>
#include <aknappui.h>
#include <QDebug>
#include <QValueSpaceSubscriber>
#include <QDeclarativeView>


QTM_USE_NAMESPACE

class QSymbianApplication : public QApplication
{
    Q_OBJECT
public:
    QSymbianApplication(int argc, char** argv);

    Q_INVOKABLE bool foreground();


signals:
    void foregroundChanged(bool status);
    void redPressed();
    void inFocus();
    void inBackground();
    void reloadKey();


protected:
    bool symbianEventFilter(const QSymbianEvent* event);

    public slots:
private:
    bool iForeground;
     QDeclarativeView* currentView;

};



#endif // QSYMBIANAPPLICATION_H
