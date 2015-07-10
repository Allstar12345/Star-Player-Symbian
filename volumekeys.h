/**
 * Copyright (c) 2012 Nokia Corporation.
 * All rights reserved.
 *
 * Part of the VideoPlayer.
 * Based on volumekeys.h from Qt GameEnabler.
 *
 * For the applicable distribution terms see the license text file included in
 * the distribution.
 */


#ifndef VOLUMEKEYS_H
#define VOLUMEKEYS_H

#include <QObject>
#include <remconcoreapitargetobserver.h>
#include <remconcoreapitarget.h>
#include <remconinterfaceselector.h>

/*!
  \class VolumeKeys
  \brief Symbian specific utility for reacting to hardware volume buttons.
*/
class VolumeKeys : public QObject, 
                   public MRemConCoreApiTargetObserver
{
    Q_OBJECT

public:
    explicit VolumeKeys(QObject *parent);
    ~VolumeKeys();

signals:
    void volumeKeyUp();
    void volumeKeyDown();

private: // from MRemConCoreApiTargetObserver

    void MrccatoCommand(TRemConCoreApiOperationId operationId,
                        TRemConCoreApiButtonAction buttonAct);

private:
    CRemConInterfaceSelector *m_interfaceSelector;  // Owned
    CRemConCoreApiTarget *m_coreTarget;             // Not owned
};

#endif // VOLUMEKEYS_H
