#ifndef SCALE_H
#define SCALE_H

#include <QObject>

class Scale : public QObject
{
    Q_OBJECT

public:
    explicit Scale(QObject *parent = 0);

private:
       int m_buttonSize;

private:
       int m_screenWidth;

private:
       int m_screenHeight;

private:
       int m_rows;

private:
       int m_largeFontSize;

private:
       int m_mediumFontSize;

private:
       int m_smallFontSize;

private:
       int m_bigGridSpacing;

private:
       int m_outerGridSize;

private:
       int m_smallGridSpacing;

private:
       int m_innerRectSize;

private:
       int m_innerGridSize;

private:
       int m_squareSize;

private:
       QString m_gameTheme;



public:
       int buttonSize() {return m_buttonSize;}

public:
       int screenWidth() {return m_screenWidth;}

public:
       int screenHeight() {return m_screenHeight;}

public:
       int rows() {return m_rows;}

public:
       int largeFontSize() {return m_largeFontSize;}

public:
       int mediumFontSize() {return m_mediumFontSize;}

public:
       int smallFontSize() {return m_smallFontSize;}

public:
       int bigGridSpacing() {return m_bigGridSpacing;}

public:
       int outerGridSize() {return m_outerGridSize;}

public:
       int smallGridSpacing() {return m_smallGridSpacing;}

public:
       int innerRectSize() {return m_innerRectSize;}

public:
       int innerGridSize() {return m_innerGridSize;}

public:
       int squareSize() {return m_squareSize;}

public:
       QString gameTheme() {return m_gameTheme;}


//------------------------------------------------------------------------------------------
       Q_PROPERTY(int BUTTON_SIZE READ buttonSize())
       Q_PROPERTY(int SCREEN_HEIGHT READ screenHeight())
       Q_PROPERTY(int SCREEN_WIDTH READ screenWidth())
       Q_PROPERTY(int ROWS READ rows())
       Q_PROPERTY(int LARGE_FONT_SIZE READ largeFontSize())
       Q_PROPERTY(int MEDIUM_FONT_SIZE READ mediumFontSize())
       Q_PROPERTY(int SMALL_FONT_SIZE READ smallFontSize())
       Q_PROPERTY(int BIG_GRID_SPACING READ bigGridSpacing())
       Q_PROPERTY(int OUTER_GRID_SIZE READ outerGridSize())
       Q_PROPERTY(int SMALL_GRID_SPACING READ smallGridSpacing())
       Q_PROPERTY(int INNER_RECT_SIZE READ innerRectSize())
       Q_PROPERTY(int INNER_GRID_SIZE READ innerGridSize())
       Q_PROPERTY(int SQUARE_SIZE READ squareSize())
       Q_PROPERTY(QString THEME READ gameTheme())
//------------------------------------------------------------------------------------------------

public:
       void setScreenSize(int screenWidth, int screenHeight);
    
signals:
    
public slots:
    
};

#endif // SCALE_H
