#ifndef SCALE_H
#define SCALE_H

#include <QObject>

class Scale : public QObject
{
    Q_OBJECT

public:
    explicit Scale(QObject *parent = 0);

private:
       int m_BUTTON_SIZE;

private:
       int m_SCREEN_WIDTH;

private:
       int m_SCREEN_HEIGHT;

private:
       int m_ROWS;

private:
       int m_LARGE_FONT_SIZE;

private:
       int m_MEDIUM_FONT_SIZE;

private:
       int m_SMALL_FONT_SIZE;

private:
       int m_BIG_GRID_SPACING;

private:
       int m_OUTER_GRID_SIZE;

private:
       int m_SMALL_GRID_SPACING;

private:
       int m_INNER_RECT_SIZE;

private:
       int m_INNER_GRID_SIZE;

private:
       int m_SQUARE_SIZE;



public:
       int BUTTON_SIZE() {return m_BUTTON_SIZE;}

public:
       int SCREEN_WIDTH() {return m_SCREEN_WIDTH;}

public:
       int SCREEN_HEIGHT() {return m_SCREEN_HEIGHT;}

public:
       int ROWS() {return m_ROWS;}

public:
       int LARGE_FONT_SIZE() {return m_LARGE_FONT_SIZE;}

public:
       int MEDIUM_FONT_SIZE() {return m_MEDIUM_FONT_SIZE;}

public:
       int SMALL_FONT_SIZE() {return m_SMALL_FONT_SIZE;}

public:
       int BIG_GRID_SPACING() {return m_BIG_GRID_SPACING;}

public:
       int OUTER_GRID_SIZE() {return m_OUTER_GRID_SIZE;}

public:
       int SMALL_GRID_SPACING() {return m_SMALL_GRID_SPACING;}

public:
       int INNER_RECT_SIZE() {return m_INNER_RECT_SIZE;}

public:
       int INNER_GRID_SIZE() {return m_INNER_GRID_SIZE;}

public:
       int SQUARE_SIZE() {return m_SQUARE_SIZE;}


//------------------------------------------------------------------------------------------
       Q_PROPERTY(int BUTTON_SIZE READ BUTTON_SIZE())
       Q_PROPERTY(int SCREEN_HEIGHT READ SCREEN_HEIGHT())
       Q_PROPERTY(int SCREEN_WIDTH READ SCREEN_WIDTH())
       Q_PROPERTY(int ROWS READ ROWS())
       Q_PROPERTY(int LARGE_FONT_SIZE READ LARGE_FONT_SIZE())
       Q_PROPERTY(int MEDIUM_FONT_SIZE READ MEDIUM_FONT_SIZE())
       Q_PROPERTY(int SMALL_FONT_SIZE READ SMALL_FONT_SIZE())
       Q_PROPERTY(int BIG_GRID_SPACING READ BIG_GRID_SPACING())
       Q_PROPERTY(int OUTER_GRID_SIZE READ OUTER_GRID_SIZE())
       Q_PROPERTY(int SMALL_GRID_SPACING READ SMALL_GRID_SPACING())
       Q_PROPERTY(int INNER_RECT_SIZE READ INNER_RECT_SIZE())
       Q_PROPERTY(int INNER_GRID_SIZE READ INNER_GRID_SIZE())
       Q_PROPERTY(int SQUARE_SIZE READ SQUARE_SIZE())
//------------------------------------------------------------------------------------------------

public:
       void setScreenSize(int screenWidth, int screenHeight);
    
signals:
    
public slots:
    
};

#endif // SCALE_H
