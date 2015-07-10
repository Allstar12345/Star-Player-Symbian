#ifndef QMLUTILS_H
#define QMLUTILS_H

#include <QtCore/QObject>
#include <CAknFileSelectionDialog.h>
#include <AknCommonDialogs.h>
#include <aknglobalmsgquery.h>
#include <AknCommonDialogs.h>
#include <akndiscreetpopup.h>
#include <AknCommonDialogs.h>
#include <AknCommonDialogsDynMem.h>
#include <aknmessagequerydialog.h>
#include <apgcli.h>
#include <e32svr.h>
#include <eikmenup.h>
#include <coemain.h>



class QClipboard;
class QDeclarativeItem;
class QDeclarativeView;

class QMLUtils : public QObject
{
    Q_OBJECT
public:
    explicit QMLUtils(QDeclarativeView *view, QObject *parent = 0);
     Q_INVOKABLE void copyToClipboard(const QString &text);


    Q_INVOKABLE void minimizeApp() const;
    Q_INVOKABLE QString openFileSelectionDlg();
    Q_INVOKABLE void snapScreen();
     Q_INVOKABLE void showPopup(QString title,QString message);
    TPtrC16 convertToSymbianString(QString string);
   void showStartDevice();


private:
     CAknGlobalMsgQuery* pDlg;
    QDeclarativeView *m_view;
        QClipboard *clipboard;

};

#endif // QMLUTILS_H
