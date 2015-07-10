#ifndef SCRENCLASS_H
#define SCRENCLASS_H

#include <QDebug>
#include <QPixmap>
#include <qmlapplicationviewer.h>
#include <QDir>

class ScreenClass : public QObject
{

public:
    ScreenClass(QmlApplicationViewer* currentView);

    Q_OBJECT public: Q_INVOKABLE void capture();

private:
    QmlApplicationViewer* currentView;
};

#endif // SCRENCLASS_H
