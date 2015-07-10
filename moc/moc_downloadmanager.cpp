/****************************************************************************
** Meta object code from reading C++ file 'downloadmanager.h'
**
** Created: Mon 15. Jun 22:55:30 2015
**      by: The Qt Meta Object Compiler version 62 (Qt 4.7.4)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../downloadmanager.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'downloadmanager.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.7.4. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_DownloadManager[] = {

 // content:
       5,       // revision
       0,       // classname
       0,    0, // classinfo
      12,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       4,       // signalCount

 // signals: signature, parameters, type, tag, flags
      17,   16,   16,   16, 0x05,
      47,   36,   16,   16, 0x05,
      75,   61,   16,   16, 0x05,
      97,   16,   16,   16, 0x05,

 // slots: signature, parameters, type, tag, flags
     115,   16,   16,   16, 0x0a,
     128,  124,   16,   16, 0x0a,
     143,   16,   16,   16, 0x0a,
     151,   16,   16,   16, 0x0a,
     168,  160,   16,   16, 0x08,
     195,   16,   16,   16, 0x08,
     231,  206,   16,   16, 0x08,
     268,  263,   16,   16, 0x08,

       0        // eod
};

static const char qt_meta_stringdata_DownloadManager[] = {
    "DownloadManager\0\0downloadComplete()\0"
    "percentage\0progress(int)\0currentStatus\0"
    "downloadStatus(float)\0downloadStarted()\0"
    "cancel()\0url\0download(QUrl)\0pause()\0"
    "resume()\0request\0download(QNetworkRequest&)\0"
    "finished()\0bytesReceived,bytesTotal\0"
    "downloadProgress(qint64,qint64)\0code\0"
    "error(QNetworkReply::NetworkError)\0"
};

const QMetaObject DownloadManager::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_DownloadManager,
      qt_meta_data_DownloadManager, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &DownloadManager::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *DownloadManager::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *DownloadManager::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_DownloadManager))
        return static_cast<void*>(const_cast< DownloadManager*>(this));
    return QObject::qt_metacast(_clname);
}

int DownloadManager::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: downloadComplete(); break;
        case 1: progress((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 2: downloadStatus((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 3: downloadStarted(); break;
        case 4: cancel(); break;
        case 5: download((*reinterpret_cast< QUrl(*)>(_a[1]))); break;
        case 6: pause(); break;
        case 7: resume(); break;
        case 8: download((*reinterpret_cast< QNetworkRequest(*)>(_a[1]))); break;
        case 9: finished(); break;
        case 10: downloadProgress((*reinterpret_cast< qint64(*)>(_a[1])),(*reinterpret_cast< qint64(*)>(_a[2]))); break;
        case 11: error((*reinterpret_cast< QNetworkReply::NetworkError(*)>(_a[1]))); break;
        default: ;
        }
        _id -= 12;
    }
    return _id;
}

// SIGNAL 0
void DownloadManager::downloadComplete()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}

// SIGNAL 1
void DownloadManager::progress(int _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void DownloadManager::downloadStatus(float _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}

// SIGNAL 3
void DownloadManager::downloadStarted()
{
    QMetaObject::activate(this, &staticMetaObject, 3, 0);
}
QT_END_MOC_NAMESPACE
