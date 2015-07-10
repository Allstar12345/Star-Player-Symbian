#include "qsymbianapplication.h"
#include <coemain.h>    // for CCoeEnv, LIBS += -lcone
#include <w32std.h>
#include <QDebug>
#include <Qfile>
#include <QKeyEvent>


QSymbianApplication::QSymbianApplication(int argc, char** argv) :
    QApplication(argc, argv), iForeground(false)
{
}



bool QSymbianApplication::foreground()
{
    return iForeground;
}


bool QSymbianApplication::symbianEventFilter(const QSymbianEvent *event)
{
    if (event->type() == QSymbianEvent::WindowServerEvent) {
        switch (event->windowServerEvent()->Type()) {
        // fire when press red key
        case KAknUidValueEndKeyCloseEvent: {
            emit redPressed();
            return true;

        }

        // fire when app is focus or in foreground
        case EEventFocusGained: {
            iForeground = true;
            emit foregroundChanged(iForeground);
            emit inFocus();
        }
            break;


        case EEventFocusLost: {
            iForeground = false;
            emit foregroundChanged(iForeground);
            emit inBackground();
        }
            break;



        }
    }
    else if (event->type() == QSymbianEvent::CommandEvent) {
        if (event->command() == EEikCmdExit) {
                 emit redPressed();
            return true;

        }
    }

    return QApplication::symbianEventFilter(event);


}





