#include <QObject>

class QString;
class QQuickView;

class screenCapture : public QObject
{
    Q_OBJECT
public:
    explicit screenCapture(QQuickView *parent = 0);

public slots:
    void capture(QString const &path) const;

private:
    QQuickView *currentView_;
};
