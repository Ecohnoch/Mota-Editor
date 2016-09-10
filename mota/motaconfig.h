#ifndef MotaCONFIG_H
#define MotaCONFIG_H

#include <QObject>
#include <QtCore>

class QQmlEngine;
class QJSEngine;
class MotaConfig : public QObject
{
    Q_OBJECT
public:
    // ------------------ Singleton Func -----------------------
    Q_DISABLE_COPY(MotaConfig)
    MotaConfig() {}
public:
    static QObject* qmlSingleton(QQmlEngine *engine, QJSEngine *scriptEngine);
    static MotaConfig* singleton();

    // ------------------- QML Props ---------------------------

    // ------------------- QML Func ---------------------------
    Q_INVOKABLE QVariantMap get();
    Q_INVOKABLE bool set(QVariantMap value);
    Q_INVOKABLE bool sync();
    Q_INVOKABLE bool restoreDefault(QString key="");

    // ------------------- C++ Func ---------------------------

private:
    QVariantMap fromData;
    QVariantMap data;
};

#endif // MotaCONFIG_H
