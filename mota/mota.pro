TEMPLATE = app

QT += qml quick widgets multimedia
CONFIG += c++11 resources_big

SOURCES += main.cpp \
    motafile.cpp \
    motaconfig.cpp

RESOURCES += qml.qrc \
    resources.qrc \
    resources.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    motafile.h \
    motaconfig.h
