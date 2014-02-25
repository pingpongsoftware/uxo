#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"
#include <QScreen>
#include <QQmlEngine>
#include <QQmlContext>
#include "values.h"
#include "tracker.h"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

	QtQuick2ApplicationViewer viewer;

	QRect screenRect = app.primaryScreen()->geometry();

	Tracker *gTracker;
	gTracker = new Tracker();

	viewer.engine()->rootContext()->setContextProperty("Tracker", gTracker);

	Values *vals;
	vals = new Values();
	vals->setScreenSize(screenRect.width(), screenRect.height());

	viewer.engine()->rootContext()->setContextProperty("Vals", vals);

	viewer.setMainQmlFile(QStringLiteral("qml/uXO/Main.qml"));
	viewer.showExpanded();

	screenRect = viewer.geometry();
	vals->setScreenSize(screenRect.width(), screenRect.height());
	vals->setViewer(&viewer);

    return app.exec();
}
