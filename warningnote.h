#ifndef WARNINGNOTE_H
#define WARNINGNOTE_H

#include <QObject>
#include <aknglobalnote.h>

class WarningNote : public QObject
{
    Q_OBJECT
private:
    TInt iNoteId;
    CAknGlobalNote* iNote;
    void StopGlobalNoteL(void);
    void ShowGlobalNoteL(TAknGlobalNoteType aNoteType, const TDesC16& aMessage);
    void ShowNoteL(const TDesC& aMessage);
public:
    explicit WarningNote(QObject *parent = 0);
    Q_INVOKABLE void displayWarningNote(QString message);
signals:

public slots:

};

#endif // WARNINGNOTE_H
