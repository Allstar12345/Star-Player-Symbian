#include "qmlutils.h"
#include <QtCore/QDateTime>
#include <QtGui/QApplication>
#include <QtGui/QClipboard>
#include <QtGui/QImage>
#include <QtGui/QStyleOptionGraphicsItem>
#include <QtGui/QPainter>
#include <QtGui/QDesktopServices>
#include <QtDeclarative/QDeclarativeItem>
#include <QtDeclarative/QDeclarativeView>
#include <QtDeclarative/QDeclarativeEngine>
#include <QtNetwork/QNetworkAccessManager>
#include <AknCommonDialogs.h>
#include <akndiscreetpopup.h>
#include <AknCommonDialogs.h>
#include <AknCommonDialogsDynMem.h>
#include <aknmessagequerydialog.h>
#include <apgcli.h>
#include <e32svr.h>
#include <eikmenup.h>
#include <coemain.h>
#include "settings.h"


QMLUtils::QMLUtils(QDeclarativeView *view, QObject *parent) :
    QObject(parent), m_view(view), clipboard(QApplication::clipboard())
{
}

void QMLUtils::copyToClipboard(const QString &text)
{
#ifdef Q_WS_SIMULATOR
    qDebug("Text copied to clipboard: %s", qPrintable(text));
#endif
    clipboard->setText(text, QClipboard::Clipboard);
    clipboard->setText(text, QClipboard::Selection);
}



void QMLUtils::minimizeApp() const
{
    m_view->lower();

}

QString QMLUtils::openFileSelectionDlg()
{
    TBuf16<255> filename;
    if (!AknCommonDialogs::RunSelectDlgLD(filename, 0))
            return NULL;
    QString qString = QString::fromUtf16(filename.Ptr(), filename.Length());
    return qString;
}

void QMLUtils::showPopup(QString title, QString message) {
    TPtrC16 sTitle(reinterpret_cast<const TUint16*>(title.utf16()));
    TPtrC16 sMessage(reinterpret_cast<const TUint16*>(message.utf16()));
    TRAP_IGNORE(CAknDiscreetPopup::ShowGlobalPopupL(sTitle, sMessage, KAknsIIDNone, KNullDesC, 0, 0, 180, 0, NULL,  {0xE0327334}));
}

void QMLUtils::snapScreen(){
QPixmap::grabWidget(m_view).save("E:/Images/" + QDateTime::currentDateTime().toString("yy-M-dd_h-m-s") + ".png");
qDebug("Screen Captured");}


void QMLUtils::showStartDevice(){
    Setting* set;
    if(set->getSystemSetting("firstGenStartupWarning", "")== ""){

    QString title= "Warning";
    QString urle= "This Application is not designed for your device\nAllstar Software accepts no responsibility for any problems caused\nContinue?";
    CAknGlobalMsgQuery* pDlg = CAknGlobalMsgQuery::NewL();
    CleanupStack::PushL(pDlg);
     TRequestStatus iStatus;
   pDlg->ShowMsgQueryL(iStatus, convertToSymbianString(urle), R_AVKON_SOFTKEYS_YES_NO, convertToSymbianString(title), KNullDesC,0,-1,CAknQueryDialog::ENoTone);
   User::WaitForRequest(iStatus);

 CleanupStack::PopAndDestroy(pDlg);
    if (iStatus.Int() == EAknSoftkeyYes)
    {}
   else if(iStatus.Int() == EAknSoftkeyNo)
    {exit(0);}
    }
    set->deleteLater();

}

TPtrC16 QMLUtils::convertToSymbianString(QString string) {
return reinterpret_cast<const TUint16*>(string.utf16());
}
