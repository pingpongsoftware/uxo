#include "scale.h"
#include <QtCore/qmath.h>
#include <iostream>
#include <fstream>
using namespace std;


Scale::Scale(QObject *parent) :
    QObject(parent)
{

}

void Scale::setScreenSize(int screenWidth, int screenHeight)
{
    qreal basicUnit;

    basicUnit = screenHeight * .01;
    m_buttonSize = qCeil(basicUnit * 10);

    m_screenHeight = screenHeight;
    m_screenWidth = screenWidth;

    if (m_screenWidth > m_screenHeight*.75)
        m_screenWidth = m_screenHeight*.7;

    m_rows = 3;

    m_largeFontSize = m_screenWidth/7;
    m_mediumFontSize = m_screenWidth/14;
    m_smallFontSize = m_screenWidth/21;

    m_bigGridSpacing = m_screenWidth/100;
    m_outerGridSize = m_screenWidth;// - (m_bigGridSpacing * m_rows); //- m_bigGridSpacing;

    m_smallGridSpacing = m_screenWidth/120;
    m_innerRectSize = m_outerGridSize/m_rows;

    m_innerGridSize = m_innerRectSize - (m_smallGridSpacing * m_rows) - m_smallGridSpacing;    

    m_squareSize = m_innerGridSize / m_rows - 7;

    m_topMargin = m_screenHeight/16;
    m_menuSpacing = m_topMargin/1.40;
    m_menuTitleHeight = m_screenHeight/7;

    //--------------------------------------------------------------------------------------------

    ifstream readTheme;
    string theme;
    readTheme.open("theme.txt");
    readTheme >> theme;
    readTheme.close();

    if (theme != "light" && theme != "dark")
        theme = "light";

    m_gameTheme = QString::fromStdString(theme);

}

void Scale::setTheme(QString s)
{
    this->m_gameTheme = s;
    ofstream writeTheme;
    writeTheme.open ("theme.txt");
    writeTheme << s.toStdString();
    writeTheme.close();

}
