#include "motafile.h"

QObject* MotaFile::qmlSingleton(QQmlEngine *engine, QJSEngine *scriptEngine){
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);
    static MotaFile* _singleton=nullptr;
    if(!_singleton)
        _singleton=new MotaFile;
    return _singleton;
}
MotaFile* MotaFile::singleton(){
    return qobject_cast<MotaFile*>(qmlSingleton(nullptr,nullptr));
}

QString MotaFile::dataPath(QString file){
    QString path=QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    QDir dir(path);
    if(!dir.exists())
        dir.mkpath(path);
    return path+'/'+file;
}
bool MotaFile::exist(QString path){
    return QFile(path).exists();
}
QString MotaFile::resourcePath(QString file){
    return QString(":/")+file;
}

QStringList MotaFile::lines(QString path){
    QFile f(path);
    if(!f.exists()) return QStringList();
    if(!f.open(QIODevice::ReadOnly)) return QStringList();
    QStringList lines;
    while(!f.atEnd())
        lines.push_back(f.readLine());
    f.close();
    return lines;
}
QString MotaFile::read(QString path){
    QFile f(path);
    if(!f.exists()) return "";
    if(!f.open(QIODevice::ReadOnly)) return "";
    QByteArray byteArray(f.readAll());
    f.close();
    return QString(byteArray);  // maybe empty
}
bool MotaFile::remove(QString path){
    QFile f(path);
    return f.remove();
}
bool MotaFile::write(QString path, QString data){
    QFile f(path);
    if(!f.open(QIODevice::WriteOnly)) return false;
    if(f.write(data.toUtf8())==-1){     // writing failed
        f.close();
        return false;
    }else{
        f.close();
        return true;
    }
}
