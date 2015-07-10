#include "warningnote.h"

WarningNote::WarningNote(QObject *parent) :
    QObject(parent)
{
}
void WarningNote::displayWarningNote(QString message)
{
   TPtrC16 aMessage(reinterpret_cast<const TUint16*>(message.utf16()));
   ShowNoteL(aMessage);
}
void WarningNote::ShowNoteL(const TDesC16& aMessage)
{
    ShowGlobalNoteL(EAknGlobalErrorNote, aMessage);
    User::After(8000000);
    StopGlobalNoteL();
}
void WarningNote::ShowGlobalNoteL(TAknGlobalNoteType aNoteType, const TDesC16& aMessage)
{
    iNote = CAknGlobalNote::NewL();
    iNoteId = iNote->ShowNoteL(aNoteType,aMessage);
}
void WarningNote::StopGlobalNoteL(void)
{
    if(iNote && iNoteId >= 0)
    {
        iNote->CancelNoteL(iNoteId);
    }

    iNoteId = -1;
}
