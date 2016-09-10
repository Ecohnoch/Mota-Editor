#ifndef MOTAFILE_H
#define MOTAFILE_H

#include <QObject>
#include <QtCore>

class QQmlEngine;
class QJSEngine;
class MotaFile : public QObject
{
    Q_OBJECT
public:
    // ------------------ Singleton Func -----------------------
    Q_DISABLE_COPY(MotaFile)
    MotaFile() {}
public:
    static QObject* qmlSingleton(QQmlEngine *engine, QJSEngine *scriptEngine);
    static MotaFile* singleton();

    // ------------------ QML Property -----------------------


    // ------------------- QML Func ---------------------------
    //  File Path
    Q_INVOKABLE QString dataPath(QString file);
    Q_INVOKABLE bool exist(QString path);
    Q_INVOKABLE QString resourcePath(QString file);
    //  File IO
    Q_INVOKABLE QStringList lines(QString path);
    Q_INVOKABLE QString read(QString path);
    Q_INVOKABLE bool remove(QString path);
    Q_INVOKABLE bool write(QString path, QString data);

    // ------------------- C++ Func ---------------------------

    // ------------------- Private Func ---------------------------
private:
};

#endif // MOTAFILE_H
