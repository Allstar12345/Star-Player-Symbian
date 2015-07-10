#include "ScreenClass.h"


ScreenClass::ScreenClass(QmlApplicationViewer *currentView){
    this->currentView = currentView;
}

void ScreenClass::capture(){

    QPixmap::grabWidget(currentView).save("E:/Images/" + FILE_NAME + ".png");
    //QPixmap::grabWidget(currentView).save( QDir::currentPath() + "/screenShot/" + FILE_NAME+ ".png");

    qDebug() << "Captured on Symbian, here" + "E:/Images/";

#endif // Q_OS_SYMBIAN

}
