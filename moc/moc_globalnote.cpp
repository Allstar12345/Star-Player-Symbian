/****************************************************************************
** Meta object code from reading C++ file 'globalnote.h'
**
** Created: Fri 1. May 12:03:14 2015
**      by: The Qt Meta Object Compiler version 62 (Qt 4.7.4)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../globalnote.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'globalnote.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.7.4. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_globalnote[] = {

 // content:
       5,       // revision
       0,       // classname
       0,    0, // classinfo
       1,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // methods: signature, parameters, type, tag, flags
      20,   12,   11,   11, 0x02,

       0        // eod
};

static const char qt_meta_stringdata_globalnote[] = {
    "globalnote\0\0message\0displayGlobalNote(QString)\0"
};

const QMetaObject globalnote::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_globalnote,
      qt_meta_data_globalnote, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &globalnote::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *globalnote::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *globalnote::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_globalnote))
        return static_cast<void*>(const_cast< globalnote*>(this));
    return QObject::qt_metacast(_clname);
}

int globalnote::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: displayGlobalNote((*reinterpret_cast< QString(*)>(_a[1]))); break;
        default: ;
        }
        _id -= 1;
    }
    return _id;
}
QT_END_MOC_NAMESPACE