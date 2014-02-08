#ifndef SCALE_H
#define SCALE_H

#include <QObject>
#include <iostream>
#include <fstream>
using namespace std;

class Scale : public QObject
{
    Q_OBJECT

public:
    explicit Scale(QObject *parent = 0);

//----------------------------------------------------------------------------------------------------

private:
       int m_buttonHeight;
       int m_buttonWidth;
       int m_smallButtonHeight;
       int m_smallButtonWidth;
       int m_backButtonWidth;
       int m_backButtonHeight;
       int m_screenWidth;
       int m_screenHeight;
       int m_rows;
       int m_largeFontSize;
       int m_mediumFontSize;
       int m_smallFontSize;
       int m_bigGridSpacing;
       int m_outerGridSize;
       int m_originalOuterGridSize; //--- m_outerGridSize will change depending on whether or not the game is zoomed in, so this will store the original
       int m_smallGridSpacing;
       int m_innerRectSize;
       int m_innerGridSize;
       int m_squareSize;
       int m_topMargin;
       int m_menuSpacing;
       int m_menuTitleHeight;
       bool m_isZoomedIn;
       QString m_gameTheme;


public:
       int buttonWidth() {return m_buttonWidth;}
       int buttonHeight() {return m_buttonHeight;}
       int smallButtonWidth() {return m_smallButtonWidth;}
       int smallButtonHeight() {return m_smallButtonHeight;}
       int backButtonWidth() {return m_backButtonWidth;}
       int backButtonHeight() {return m_backButtonHeight;}
       int screenWidth() {return m_screenWidth;}
       int screenHeight() {return m_screenHeight;}
       int rows() {return m_rows;}
       int largeFontSize() {return m_largeFontSize;}
       int mediumFontSize() {return m_mediumFontSize;}
       int smallFontSize() {return m_smallFontSize;}
       int bigGridSpacing() {return m_bigGridSpacing;}
       int outerGridSize() {return m_outerGridSize;}
       int originalOuterGridSize() {return m_originalOuterGridSize;}
       int smallGridSpacing() {return m_smallGridSpacing;}
       int innerRectSize() {return m_innerRectSize;}
       int innerGridSize() {return m_innerGridSize;}
       int squareSize() {return m_squareSize;}
       int topMargin() {return m_topMargin;}
       int menuSpacing() {return m_menuSpacing;}
       int menuTitleHeight() {return m_menuTitleHeight;}
       bool isGameZoomedIn() {return m_isZoomedIn;}
       QString gameTheme() {return m_gameTheme;}


//------------------------------------------------------------------------------------------
       Q_PROPERTY(int buttonWidth READ buttonWidth() NOTIFY buttonWidthChanged)
       Q_PROPERTY(int buttonHeight READ buttonHeight() NOTIFY buttonHeightChanged)
       Q_PROPERTY(int smallButtonWidth READ smallButtonWidth() NOTIFY smallButtonWidthChanged)
       Q_PROPERTY(int smallButtonHeight READ smallButtonHeight() NOTIFY smallButtonHeightChanged)
       Q_PROPERTY(int backButtonWidth READ backButtonWidth() NOTIFY backButtonWidthChanged)
       Q_PROPERTY(int backButtonHeight READ backButtonHeight() NOTIFY backButtonHeightChanged)
       Q_PROPERTY(int screenHeight READ screenHeight() NOTIFY screenHeightChanged)
       Q_PROPERTY(int screenWidth READ screenWidth() NOTIFY screenWidthChanged)
       Q_PROPERTY(int rows READ rows() NOTIFY rowsChanged)
       Q_PROPERTY(int largeFontSize READ largeFontSize() NOTIFY largeFontSizeChanged)
       Q_PROPERTY(int mediumFontSize READ mediumFontSize() NOTIFY mediumFontSizeChanged)
       Q_PROPERTY(int smallFontSize READ smallFontSize() NOTIFY smallFontSizeChanged)
       Q_PROPERTY(int bigGridSpacing READ bigGridSpacing() NOTIFY bigGridSpacingChanged)
       Q_PROPERTY(int outerGridSize READ outerGridSize() NOTIFY outerGridSizeChanged)
       Q_PROPERTY(int originalOuterGridSize READ originalOuterGridSize() NOTIFY originalOuterGridSizeChanged)
       Q_PROPERTY(int smallGridSpacing READ smallGridSpacing() NOTIFY smallGridSpacingChanged)
       Q_PROPERTY(int innerRectSize READ innerRectSize() NOTIFY innerRectSizeChanged)
       Q_PROPERTY(int innerGridSize READ innerGridSize() NOTIFY innerGridSizeChanged)
       Q_PROPERTY(int squareSize READ squareSize() NOTIFY squareSizeChanged)
       Q_PROPERTY(int topMargin READ topMargin() NOTIFY topMarginChanged)
       Q_PROPERTY(int menuSpacing READ menuSpacing() NOTIFY menuSpacingChanged)
       Q_PROPERTY(int menuTitleHeight READ menuTitleHeight() NOTIFY menuTitleHeightChanged)
       Q_PROPERTY(int isGameZoomedIn READ isGameZoomedIn() NOTIFY isGameZoomedInChanged)
       Q_PROPERTY(QString theme READ gameTheme() NOTIFY themeChanged)

       Q_INVOKABLE void setTheme(QString s);
       Q_INVOKABLE void zoomIn();
       Q_INVOKABLE void zoomOut();
//------------------------------------------------------------------------------------------------


signals:
       void buttonWidthChanged();
       void buttonHeightChanged();
       void smallButtonWidthChanged();
       void smallButtonHeightChanged();
       void backButtonWidthChanged();
       void backButtonHeightChanged();
       void screenHeightChanged();
       void screenWidthChanged();
       void rowsChanged();
       void largeFontSizeChanged();
       void mediumFontSizeChanged();
       void smallFontSizeChanged();
       void bigGridSpacingChanged();
       void outerGridSizeChanged();
       void originalOuterGridSizeChanged();
       void smallGridSpacingChanged();
       void innerRectSizeChanged();
       void innerGridSizeChanged();
       void squareSizeChanged();
       void topMarginChanged();
       void themeChanged();
       void menuSpacingChanged();
       void menuTitleHeightChanged();
       void isGameZoomedInChanged();
//----------------------------------------------------------------------------------------------------


public:
       void setScreenSize(int screenWidth, int screenHeight);
       void setGameSize();
    
signals:
    
public slots:
    
};

#endif // SCALE_H
