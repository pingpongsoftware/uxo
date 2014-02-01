#ifndef SCALE_H
#define SCALE_H

#include <QObject>

class Scale : public QObject
{
    Q_OBJECT

public:
    explicit Scale(QObject *parent = 0);

//----------------------------------------------------------------------------------------------------

private:
       int m_buttonSize;
       int m_screenWidth;
       int m_screenHeight;
       int m_rows;
       int m_largeFontSize;
       int m_mediumFontSize;
       int m_smallFontSize;
       int m_bigGridSpacing;
       int m_outerGridSize;
       int m_smallGridSpacing;
       int m_innerRectSize;
       int m_innerGridSize;
       int m_squareSize;
       int m_topMargin;
       int m_menuSpacing;
       QString m_gameTheme;


public:
       int buttonSize() {return m_buttonSize;}
       int screenWidth() {return m_screenWidth;}
       int screenHeight() {return m_screenHeight;}
       int rows() {return m_rows;}
       int largeFontSize() {return m_largeFontSize;}
       int mediumFontSize() {return m_mediumFontSize;}
       int smallFontSize() {return m_smallFontSize;}
       int bigGridSpacing() {return m_bigGridSpacing;}
       int outerGridSize() {return m_outerGridSize;}
       int smallGridSpacing() {return m_smallGridSpacing;}
       int innerRectSize() {return m_innerRectSize;}
       int innerGridSize() {return m_innerGridSize;}
       int squareSize() {return m_squareSize;}
       int topMargin() {return m_topMargin;}
       int menuSpacing() {return m_menuSpacing;}
       QString gameTheme() {return m_gameTheme;}


//------------------------------------------------------------------------------------------
       Q_PROPERTY(int buttonSize READ buttonSize() NOTIFY buttonSizeChanged)
       Q_PROPERTY(int screenHeight READ screenHeight() NOTIFY screenHeightChanged)
       Q_PROPERTY(int screenWidth READ screenWidth() NOTIFY screenWidthChanged)
       Q_PROPERTY(int rows READ rows() NOTIFY rowsChanged)
       Q_PROPERTY(int largeFontSize READ largeFontSize() NOTIFY largeFontSizeChanged)
       Q_PROPERTY(int mediumFontSize READ mediumFontSize() NOTIFY mediumFontSizeChanged)
       Q_PROPERTY(int smallFontSize READ smallFontSize() NOTIFY smallFontSizeChanged)
       Q_PROPERTY(int bigGridSpacing READ bigGridSpacing() NOTIFY bigGridSpacingChanged)
       Q_PROPERTY(int outerGridSize READ outerGridSize() NOTIFY outerGridSizeChanged)
       Q_PROPERTY(int smallGridSpacing READ smallGridSpacing() NOTIFY smallGridSpacingChanged)
       Q_PROPERTY(int innerRectSize READ innerRectSize() NOTIFY innerRectSizeChanged)
       Q_PROPERTY(int innerGridSize READ innerGridSize() NOTIFY innerGridSizeChanged)
       Q_PROPERTY(int squareSize READ squareSize() NOTIFY squareSizeChanged)
       Q_PROPERTY(int topMargin READ topMargin() NOTIFY topMarginChanged)
       Q_PROPERTY(int menuSpacing READ menuSpacing() NOTIFY menuSpacingChanged)
       Q_PROPERTY(QString theme READ gameTheme() NOTIFY themeChanged)

       Q_INVOKABLE void setTheme(QString s);
//------------------------------------------------------------------------------------------------


signals:
       void buttonSizeChanged();
       void screenHeightChanged();
       void screenWidthChanged();
       void rowsChanged();
       void largeFontSizeChanged();
       void mediumFontSizeChanged();
       void smallFontSizeChanged();
       void bigGridSpacingChanged();
       void outerGridSizeChanged();
       void smallGridSpacingChanged();
       void innerRectSizeChanged();
       void innerGridSizeChanged();
       void squareSizeChanged();
       void topMarginChanged();
       void themeChanged();
       void menuSpacingChanged();
//----------------------------------------------------------------------------------------------------


public:
       void setScreenSize(int screenWidth, int screenHeight);
    
signals:
    
public slots:
    
};

#endif // SCALE_H
