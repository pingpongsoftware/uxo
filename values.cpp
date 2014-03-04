#include "values.h"

Values::Values(QObject *parent) :
	QObject(parent)
{
}

void Values::setViewer(QtQuick2ApplicationViewer *v)
{
	m_viewer = v;
}

void Values::resizeWindowCorrectly()
{
	m_viewer->setGeometry(0, 0, m_screenWidth, m_screenHeight);
	m_viewer->showNormal();
}

void Values::setScreenSize(int width, int height)
{
	m_screenWidth = width;
	m_screenHeight = height;

	if (m_screenWidth > m_screenHeight*.75)
		m_screenWidth = m_screenHeight*.75;

	m_basicUnit = m_screenWidth*0.01;

	m_outerGridSpacing = m_basicUnit*3;
	m_innerGridSpacing = m_outerGridSpacing/4;

	m_boardSize = m_screenWidth - m_innerGridSpacing;
	m_innerBoardSize = (m_boardSize/3) - m_outerGridSpacing;
	m_squareSize = (m_innerBoardSize/3) - m_innerGridSpacing;

	m_topToolbarHeight = m_basicUnit*10;

	m_theme = this->loadTheme();

	this->setFontSizes();
}


void Values::switchTheme()
{
	if (m_theme == "light")
		m_theme = "dark";
	else
		m_theme = "light";

	this->saveTheme();
	emit this->themeSwitched();
}

void Values::saveTheme()
{
	QFile file("game_theme.txt");

	if(file.open(QIODevice::WriteOnly))
	{
		QTextStream fileOut(&file);
		fileOut << this->getTheme();

		file.close();
	}
}

QString Values::loadTheme()
{
	QFile file("game_theme.txt");
	QString temp;
	if(file.open(QIODevice::ReadOnly))
	{
		QTextStream fileIn(&file);

		temp = fileIn.readAll();
		qDebug() << temp;

		file.close();
	}

	if (temp != "light" && temp != "dark")
		temp = "dark";

	return temp;
}

void Values::initLoaderSource(QString source)
{
	m_previousLoaderSource = source;
	m_currentLoaderSource = source;
}

void Values::setLoaderSource(QString source)
{
	m_previousLoaderSource = m_currentLoaderSource;
	m_currentLoaderSource = source;
}

void Values::setFontSizes()
{
	m_extraSmallFontSize = m_basicUnit*2;
	m_smallFontSize = m_basicUnit*4;
	m_mediumSmallFontSize = m_basicUnit*6;
	m_mediumFontSize = m_basicUnit*8;
	m_mediumLargeFontSize = m_basicUnit*10;
	m_largeFontSize = m_basicUnit*15;
	m_extraLargeFontSize = m_basicUnit*20;
}

int Values::getScreenWidth() { return m_screenWidth; }
int Values::getScreenHeight() { return m_screenHeight; }

int Values::getBasicUnit() { return m_basicUnit; }

int Values::getOuterGridSpacing() { return m_outerGridSpacing; }
int Values::getInnerGridSpacing() { return m_innerGridSpacing; }

int Values::getBoardSize() { return m_boardSize; }
int Values::getInnerBoardSize() { return m_innerBoardSize; }
int Values::getSquareSize() { return m_squareSize; }

int Values::getTopToolbarHeight() { return m_topToolbarHeight; }

QString Values::getTheme() { return m_theme; }

QString Values::getLoaderSource() { return m_currentLoaderSource; }
QString Values::getPreviousLoaderSource() { return m_previousLoaderSource; }


//------FONT SIZES--------------------------------------------------------------------
int Values::getExtraSmallFontSize() { return m_extraSmallFontSize; }
int Values::getSmallFontSize() { return m_smallFontSize; }
int Values::getMediumSmallFontSize() { return m_mediumSmallFontSize; }
int Values::getMediumFontSize() { return m_mediumFontSize; }
int Values::getMediumLargeFontSize() { return m_mediumLargeFontSize; }
int Values::getLargeFontSize() { return m_largeFontSize; }
int Values::getExtraLargeFontSize() { return m_extraLargeFontSize; }
//------------------------------------------------------------------------------------
