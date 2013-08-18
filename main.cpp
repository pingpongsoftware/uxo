#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"
#include <QScreen>
#include "scale.h"
#include <QQmlEngine>
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);


    QRect myScreenRect = app.primaryScreen()->geometry();

    Scale *pScale;
    pScale = new Scale();
    pScale->setScreenSize(myScreenRect.width(), myScreenRect.height());

    QtQuick2ApplicationViewer viewer;

    viewer.engine()->rootContext()->setContextProperty("Vals", pScale);


    viewer.setMainQmlFile(QStringLiteral("qml/ultimatetictactoe/Main.qml"));
    viewer.showExpanded();

    return app.exec();
}
