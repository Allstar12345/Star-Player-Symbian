#folder_01.source = qml/BackgroundVideo
#folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

symbian:TARGET.UID3 = 0xE0327334
# 0x20070767

# Smart Installer package's UID
# This UID is from the protected range and therefore the package will
# fail to install if self-signed. By default qmake uses the unprotected
# range value if unprotected UID is defined for the application and
# 0x2002CCCF value if protected UID is given to the application
#symbian:DEPLOYMENT.installer_header = 0x2002CCCF

# Allow network access on Symbian
symbian {
VERSION = 1.01

    TARGET.CAPABILITY += NetworkServices

    my_deployment.pkg_prerules += vendorinfo

    DEPLOYMENT += my_deployment
 TARGET.EPOCHEAPSIZE = 0x90000 0x9999999

    vendorinfo += "%{\"Allstar Software\"}" ":\"Allstar Software\""
    LIBS += -L\epoc32\release\armv5\lib -lremconcoreapi\
    LIBS += -L\epoc32\release\armv5\lib -lremconinterfacebase\
    LIBS += -letel3rdparty \
               -lapgrfx \
               -lfeatdiscovery \
               -lws32 \
               -lsysutil \
               -lefsrv \
               -lavkon\
               -lhal \
               -lapparc\
               -lcommondialogs\
               -leiksrv \
               -lcone\
                 -leikcore\
-lapgrfx \-lswinstcli\
-leikcdlg \
-leikdlg\
-lcommonui\
 -leikctl \
-leikcdlg\
-lapmime\
-lws32\
-laknnotify

    DEPLOYMENT.display_name += Star Player


}

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
 CONFIG += mobility
 MOBILITY += multimedia
MOBILITY+= systeminfo
MOBILITY += feedback location gallery
MOBILITY += systeminfo feedback multimedia
DEFINES += DOCUMENT_GALLERY

# Speed up launching on MeeGo/Harmattan when using applauncherd daemon
# CONFIG += qdeclarative-boostable

# Add dependency to Symbian components
CONFIG += qt-components

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    qmlutils.cpp\
   mediakeysobserver.cpp \
    qsymbianapplication.cpp \
    settings.cpp \
    downloadmanager.cpp

#QT += xml

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

HEADERS += \
    qmlutils.h\
    mediakeysobserver.h \
    qsymbianapplication.h \
    settings.h \
    downloadmanager.h

RESOURCES += \
    res.qrc

gccOption = "OPTION gcce -fpermissive"
MMP_RULES += gccOption\
 "EPOCPROCESSPRIORITY high"

