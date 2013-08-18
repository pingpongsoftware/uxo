#include "scale.h"
#include <QtCore/qmath.h>


Scale::Scale(QObject *parent) :
    QObject(parent)
{
}

void Scale::setScreenSize(int screenWidth, int screenHeight)
{
    qreal basicUnit;

    basicUnit = screenHeight * .01;
    m_BUTTON_SIZE = qCeil(basicUnit * 10);

    m_SCREEN_HEIGHT = screenHeight;
    m_SCREEN_WIDTH = screenWidth;

    if (m_SCREEN_WIDTH > m_SCREEN_HEIGHT*.75)
        m_SCREEN_WIDTH = m_SCREEN_HEIGHT*.75;

    m_ROWS = 3;

    m_LARGE_FONT_SIZE = m_SCREEN_WIDTH/10;
    m_MEDIUM_FONT_SIZE = m_SCREEN_WIDTH/20;
    m_SMALL_FONT_SIZE = m_SCREEN_WIDTH/35;

    m_BIG_GRID_SPACING = m_SCREEN_WIDTH/100;
    m_OUTER_GRID_SIZE = m_SCREEN_WIDTH - (m_BIG_GRID_SPACING * m_ROWS) - m_BIG_GRID_SPACING;

    m_SMALL_GRID_SPACING = m_SCREEN_WIDTH/120;
    m_INNER_RECT_SIZE = m_OUTER_GRID_SIZE/m_ROWS;

    m_INNER_GRID_SIZE = m_INNER_RECT_SIZE - (m_SMALL_GRID_SPACING * m_ROWS) - m_SMALL_GRID_SPACING;

    m_SQUARE_SIZE = m_INNER_GRID_SIZE / m_ROWS - 7;
}
