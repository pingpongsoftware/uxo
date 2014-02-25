#ifndef VALUES_H
#define VALUES_H

#include "qtquick2applicationviewer.h"

#include <QObject>
#include <QDebug>

class Values : public QObject
{
		Q_OBJECT
	public:
		explicit Values(QObject *parent = 0);

		void setViewer(QtQuick2ApplicationViewer *v);
		Q_INVOKABLE void resizeWindowCorrectly();
		void setScreenSize(int width, int height);

	private:
		int m_screenHeight;
		int m_screenWidth;

		int m_basicUnit;

		int m_outerGridSpacing;
		int m_innerGridSpacing;

		int m_boardSize;
		int m_innerBoardSize;
		int m_squareSize;

		int m_topToolbarHeight;

		QString m_theme;

		QString m_currentLoaderSource;
		QString m_previousLoaderSource;

		int m_extraSmallFontSize;
		int m_smallFontSize;
		int m_mediumSmallFontSize;
		int m_mediumFontSize;
		int m_mediumLargeFontSize;
		int m_largeFontSize;
		int m_extraLargeFontSize;
		void setFontSizes();

		QtQuick2ApplicationViewer *m_viewer;

	public:
		Q_INVOKABLE int getScreenWidth();
		Q_INVOKABLE int getScreenHeight();

		Q_INVOKABLE int getBasicUnit();

		Q_INVOKABLE int getOuterGridSpacing();
		Q_INVOKABLE int getInnerGridSpacing();

		Q_INVOKABLE int getBoardSize();
		Q_INVOKABLE int getInnerBoardSize();
		Q_INVOKABLE int getSquareSize();

		Q_INVOKABLE int getTopToolbarHeight();

		Q_INVOKABLE void switchTheme();
		Q_INVOKABLE QString getTheme();

		Q_INVOKABLE void setLoaderSource(QString source);
		Q_INVOKABLE void initLoaderSource(QString source);
		Q_INVOKABLE QString getLoaderSource();
		Q_INVOKABLE QString getPreviousLoaderSource();

		Q_INVOKABLE int getExtraSmallFontSize();
		Q_INVOKABLE int getSmallFontSize();
		Q_INVOKABLE int getMediumSmallFontSize();
		Q_INVOKABLE int getMediumFontSize();
		Q_INVOKABLE int getMediumLargeFontSize();
		Q_INVOKABLE int getLargeFontSize();
		Q_INVOKABLE int getExtraLargeFontSize();

	signals:
		void themeSwitched();


	public slots:

};

#endif // VALUES_H
