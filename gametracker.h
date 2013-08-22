#ifndef GAMETRACKER_H
#define GAMETRACKER_H

#include <QObject>
#include <vector>
#include <QList>

class GameTracker : public QObject
{
    Q_OBJECT
public:
    explicit GameTracker(QObject *parent = 0);

private:
    bool m_X_TURN = true;

private:
    bool m_GAME_WON = false;

private:
    char m_WINNING_PLAYER = ' ';

private:
    int m_BIG_INDEX = 0;

private:
    int m_LITTLE_INDEX = 0;

    // -1 means O won that square, 0 means nobody has won that square, 1 means X won that square-----------
private:
    QList<QList<int> > m_SQUARES_WON;
    
private:
    QList<int> m_BOARDS_WON;
    //-----------------------------------------------------------------------------------------------------

private:
    QList<int> m_X_BIG_TILES_WON;

private:
    QList<int> m_O_BIG_TILES_WON;

private:
    QList<int> m_X_SMALL_TILES_WON;

private:
    QList<int> m_O_SMALL_TILES_WON;

private:
    QList<QList<int> > m_WINNING_COMBINATIONS;


//--------------------------------------------------------------------------------------

public:
    bool X_TURN() {return m_X_TURN;}

public:
    bool GAME_WON() {return m_GAME_WON;}

public:
    char WINNING_PLAYER() {return m_WINNING_PLAYER;}

public:
    int BIG_INDEX() {return m_BIG_INDEX;}

public:
    int LITTLE_INDEX() {return m_LITTLE_INDEX;}

public:
    QList<QList<int> > SQUARES_WON() {return m_SQUARES_WON;}

public:
    QList<int> BOARDS_WON() {return m_BOARDS_WON;}

public:
    QList<int> X_BIG_TILES_WON() {return m_X_BIG_TILES_WON;}

public:
    QList<int> O_BIG_TILES_WON() {return m_O_BIG_TILES_WON;}

public:
    QList<int> X_SMALL_TILES_WON() {return m_X_SMALL_TILES_WON;}

public:
    QList<int> O_SMALL_TILES_WON() {return m_O_SMALL_TILES_WON;}

public:
    QList<QList<int> > WINNING_COMBINATIONS() {return m_WINNING_COMBINATIONS;}


//------------------------------------------------------------------------------------
    Q_PROPERTY(int X_TURN READ X_TURN())
    Q_PROPERTY(int GAME_WON READ GAME_WON())
    Q_PROPERTY(int WINNING_PLAYER READ WINNING_PLAYER())
    Q_PROPERTY(int BIG_INDEX READ BIG_INDEX())
    Q_PROPERTY(int LITTLE_INDEX READ LITTLE_INDEX())
    Q_PROPERTY(QList<QList<int> > SQUARES_WON READ SQUARES_WON())
    Q_PROPERTY(QList<int> BOARDS_WON READ BOARDS_WON())
    Q_PROPERTY(QList<int> X_BIG_TILES_WON READ X_BIG_TILES_WON())
    Q_PROPERTY(QList<int> O_BIG_TILES_WON READ O_BIG_TILES_WON())
    Q_PROPERTY(QList<int> X_SMALL_TILES_WON READ X_SMALL_TILES_WON())
    Q_PROPERTY(QList<int> O_SMALL_TILES_WON READ O_SMALL_TILES_WON())
    Q_PROPERTY(QList<QList<int> > WINNING_COMBINATIONS READ WINNING_COMBINATIONS())
//---------------------------------------------------------------------------------------


public:
       bool checkForWinningCombinations(QList<int> tilesWon);

public:
       void makeMove(int smallIndex, int largeIndex);

public:
       bool checkForDeadSquare();

public:
       void resetGame();

private:
       void init();

signals:
    
public slots:
    
};

#endif // GAMETRACKER_H
