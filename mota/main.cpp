#include <QApplication>
#include <QDesktopWidget>
#include <QQuickView>
#include <QStyle>
#include <QtCore>
#include <QTimer>


int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    // set using UTF-8
    QTextCodec::setCodecForLocale(QTextCodec::codecForName("UTF-8"));

    // read fullScreen & winSize here
    bool fullScreen=false;
    QSize winSize(700,600); // works when !fullScreen


    QSize screenSize=QApplication::desktop()->screenGeometry().size();  // works for fullScreen

    // setup viewer
    QQuickView viewer;
    viewer.setSource(QUrl(QStringLiteral("qrc:/main.qml")));
    // common settings
    viewer.setResizeMode(QQuickView::SizeRootObjectToView);
    viewer.setTitle(QObject::tr("Mota editor"));
    // geo settings
    if(!fullScreen){
        // set fixed size for viewer
        viewer.setMaximumSize(winSize);
        viewer.setMinimumSize(winSize);

        // show window
        QRect geo=QStyle::alignedRect(Qt::LeftToRight, Qt::AlignCenter, winSize,
                                      app.desktop()->availableGeometry());
        viewer.setGeometry(geo);
        viewer.show();
    }else{
        // disable all other things
        viewer.setFlags(viewer.flags()|Qt::FramelessWindowHint);
        // set full screen size
        viewer.setMaximumSize(screenSize);
        viewer.setMinimumSize(screenSize);
        viewer.showFullScreen();
    }
    return app.exec();
}
