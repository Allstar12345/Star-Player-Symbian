/****************************************************************************
** Meta object code from reading C++ file 'warningnote.h'
**
** Created: Mon 26. Aug 09:14:15 2013
**      by: The Qt Meta Object Compiler version 62 (Qt 4.7.4)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../warningnote.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'warningnote.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 62
#error "This file was generated using the moc from 4.7.4. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_WarningNote[] = {

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
      21,   13,   12,   12, 0x02,

       0        // eod
};

static const char qt_meta_stringdata_WarningNote[] = {
    "WarningNote\0\0message\0displayWarningNote(QString)\0"
};

const QMetaObject WarningNote::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_WarningNote,
      qt_meta_data_WarningNote, 0 }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &WarningNote::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *WarningNote::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *WarningNote::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_WarningNote))
        return static_cast<void*>(const_cast< WarningNote*>(this));
    return QObject::qt_metacast(_clname);
}

int WarningNote::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: displayWarningNote((*reinterpret_cast< QString(*)>(_a[1]))); break;
        default: ;
        }
        _id -= 1;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
