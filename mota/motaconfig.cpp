#include <QJsonDocument>
#include "motaconfig.h"
#include "motafile.h"

static MotaConfig* _singleton=nullptr;

// ------------------- Private Func ---------------------------
QVariantMap parseJsonTable(const QString& json){
    QJsonDocument jsonDoc=QJsonDocument::fromJson(json.toUtf8());
    QJsonObject jsonObj=jsonDoc.object();
    return jsonObj.toVariantMap();
}

// ------------------ Singleton Func -----------------------
QObject* MotaConfig::qmlSingleton(QQmlEngine *engine, QJSEngine *scriptEngine){
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);
    if(!_singleton){
        _singleton=new MotaConfig;

        // load default config from resources :/data.json.json
        QString defaultData=MotaFile::singleton()->read(":/data.json.json");
        _singleton->data=parseJsonTable(defaultData);
        //  default config should NOT be empty!!
        Q_ASSERT(!_singleton->data.isEmpty());

        // load config from 'fromdata.mota'
        QString path(MotaFile::singleton()->dataPath("fromdata.mota"));
        QString data=MotaFile::singleton()->read(path);
        _singleton->fromData=parseJsonTable(data);
        //  if no fromdata.mota, I will create one via copying data.json.json
        if(_singleton->fromData.isEmpty()){
            qDebug()<<"[fromData]: fromdata.mota NOT found or invalid. I will use data.json";
            _singleton->fromData=_singleton->data;
            _singleton->sync();
        }
        qDebug()<<"[fromData]: fromData data loaded.";

    }
    return _singleton;
}
MotaConfig* MotaConfig::singleton(){
    return qobject_cast<MotaConfig*>(qmlSingleton(nullptr,nullptr));
}

// ------------------- QML Func ---------------------------
bool validateMap(const QVariantMap& map1, const QVariantMap& map2);
bool validateList(const QVariantList& list1, const QVariantList& list2){
    if(list1.count()!=list2.count())
        return false;
    for(int i=0;i<list1.count();i++){
        if(list1[i].type()!=list2[i].type())
            return false;
        if(list1[i].type()==QVariant::Map){
            if(!validateMap(list1[i].toMap(),list2[i].toMap()))
                return false;
        }else if(list1[i].type()==QVariant::List){
            if(!validateList(list1[i].toList(),list2[i].toList()))
                return false;
        }
    }
    return true;
}
bool validateMap(const QVariantMap& map1, const QVariantMap& map2){
    if(map1.count()!=map2.count()){
        qDebug()<<"*** count wrong!"<<map1<<map2;
        return false;
    }
    if(map1.keys()!=map2.keys()){
        qDebug()<<"*** keys wrong!"<<map1.keys()<<map2.keys();
        return false;
    }
    for(auto key:map1.keys()){
        auto t1=map1[key].type();
        auto t2=map2[key].type();
        // sometimes we should allow t1==<double> and t2==<int>
        if(t1!=t2){
            if(t1==QVariant::Map || t1==QVariant::List || t1==QVariant::String
                    || t2==QVariant::Map || t2==QVariant::List || t2==QVariant::String){
                qDebug()<<"*** type wrong:"<<key<<"="<<map1[key]<<","<<map2[key]<<" "<<t1<<t2;
                return false;
            }
        }
        if(t1==QVariant::Map){
            if(!validateMap(map1[key].toMap(),map2[key].toMap()))
                return false;
        }else if(t1==QVariant::List){
            if(!validateList(map1[key].toList(),map2[key].toList()))
                return false;
        }
    }
    return true;
}

QVariantMap MotaConfig::get(){
    return fromData;
}

bool MotaConfig::set(QVariantMap value){
    if(validateMap(value,data)){
        fromData=value;
        return true;
    }else{
        qDebug()<<"***[fromData] set(): wrong format!";
        return false;
    }
}

bool MotaConfig::sync(){
    QJsonObject jsonObj=QJsonObject::fromVariantMap(fromData);
    QJsonDocument jsonDoc(jsonObj);
    QString jsonData(jsonDoc.toJson());
    QString path(MotaFile::singleton()->dataPath("fromdata.mota"));
    bool result=MotaFile::singleton()->write(path,jsonData);
    if(result)
        qDebug()<<"[Config] sync(): OK.";
    else
        qDebug()<<"***[Config] sync(): error!";
    return result;
}

bool MotaConfig::restoreDefault(QString key){
    if(key.length()==0){
        fromData=data;
        return true;
    }
    if(!fromData.contains(key)){
        qDebug()<<"***[fromData] restoreDefault(): can NOT find key:"<<key;
        return false;
    }
    fromData[key]=data[key];
    return true;
}
