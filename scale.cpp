#include "scale.h"
#include <QtCore/qmath.h>
//#include <iostream>
//#include <fstream>
using namespace std;


Scale::Scale(QObject *parent) :
    QObject(parent)
{
    m_isZoomedIn = false; //game is not zoomed in at startup.
}

void Scale::setScreenSize(int screenWidth, int screenHeight)
{
    //qreal basicUnit;

    //basicUnit = screenHeight * .01;
    m_buttonWidth = screenHeight/4; //= qCeil(basicUnit * 10);
    m_buttonHeight = m_buttonWidth/4;
    m_smallButtonHeight = m_buttonHeight/1.5;
    m_smallButtonWidth = m_buttonWidth/2;
    m_backButtonWidth = m_buttonWidth/3;
    m_backButtonHeight = m_backButtonWidth;

    m_screenHeight = screenHeight;
    m_screenWidth = screenWidth;

    if (m_screenWidth > m_screenHeight*.75)
        m_screenWidth = m_screenHeight*.7;

    m_rows = 3;

    m_largeFontSize = m_screenWidth/7;
    m_mediumFontSize = m_screenWidth/14;
    m_smallFontSize = m_screenWidth/21;

    m_topMargin = m_screenHeight/16;
    m_menuSpacing = m_topMargin/1.65;
    m_menuTitleHeight = m_screenHeight/7;

    m_outerGridSize = m_screenWidth;// - (m_bigGridSpacing * m_rows); //- m_bigGridSpacing;

    m_transitionTime = 150;

    this->setGameSize();  //sets all of the other variables based on m_outerGridSize;
    //this->zoomIn(); //temporary,  remove

    //--------------------------------------------------------------------------------------------


    // sets the initial theme-------------------
    ifstream readTheme;
    string theme;
    readTheme.open("theme.txt");
    readTheme >> theme;
    readTheme.close();

    if (theme != "light" && theme != "dark")  //If the theme has not been set yet, it will automatically go to light
        theme = "light";

    m_gameTheme = QString::fromStdString(theme);
    //--------------------------------------------

}

void Scale::setGameSize() //Sets all of the size and spacing for the items in the grid based on m_outerGridSize
{
    m_bigGridSpacing = m_outerGridSize/100;
    m_smallGridSpacing = m_outerGridSize/120;

    m_innerRectSize = m_outerGridSize/m_rows;

    m_innerGridSize = m_innerRectSize - (m_smallGridSpacing * m_rows) - m_smallGridSpacing;

    m_squareSize = m_innerGridSize / m_rows - 7;

}

void Scale::setTheme(QString s)
{
    this->m_gameTheme = s;
    ofstream writeTheme;
    writeTheme.open ("theme.txt");
    writeTheme << s.toStdString();
    writeTheme.close();

}

void Scale::zoomIn()
{
    if (!m_isZoomedIn)
    {
        m_outerGridSize *= 2;
        this->setGameSize();
        m_isZoomedIn = true;
    }
}

void Scale::zoomOut()
{
    if (m_isZoomedIn)
    {
        m_outerGridSize /= 2;
        this->setGameSize();
        m_isZoomedIn = false;
    }
}
