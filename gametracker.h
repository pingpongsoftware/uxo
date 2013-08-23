#ifndef GAMETRACKER_H
#define GAMETRACKER_H

#include <QObject>

class GameTracker : public QObject
{
    Q_OBJECT
public:
    explicit GameTracker(QObject *parent = 0);

private:
    bool m_xTurn = true;
    bool m_gameWon= false;
    char m_winningPlayer = ' ';
    int m_bigIndex = 0;
    int m_littleIndex = 0;

    // -1 means O won that square, 0 means nobody has won that square, 1 means X won that square-----------
    QList<QList<int>* > m_squaresWon;
    QList<int> m_boardsWon;
    QList<int> m_xBigTilesWon;
    QList<int> m_oBigTilesWon;
    QList<QList<int>* > m_xSmallTilesWon;
    QList<QList<int>* > m_oSmallTilesWon;
    QList<QList<int>* > m_winningCombinations;


//--------------------------------------------------------------------------------------

public:
    bool xTurn() {return m_xTurn;}
    bool gameWon() {return m_gameWon;}

    char winningPlayer() {return m_winningPlayer;}

    int bigIndex() {return m_bigIndex;}
    int littleIndex() {return m_littleIndex;}

    QList<QList<int>* > squaresWon() {return m_squaresWon;}
    QList<int> boardsWon() {return m_boardsWon;}
    QList<int> xBigTilesWon() {return m_xBigTilesWon;}
    QList<int> oBigTilesWon() {return m_oBigTilesWon;}
    QList<QList<int>* > xSmallTilesWon() {return m_xSmallTilesWon;}
    QList<QList<int>* > oSmallTilesWon() {return m_oSmallTilesWon;}
    QList<QList<int>* > winningCombinations() {return m_winningCombinations;}


//------------------------------------------------------------------------------------
    Q_PROPERTY(int xTurn READ xTurn())
    Q_PROPERTY(int gameWon READ gameWon())
    Q_PROPERTY(int winningPlayer READ winningPlayer())
    Q_PROPERTY(int bigIndex READ bigIndex())
    Q_PROPERTY(int littleIndex READ littleIndex())
    Q_PROPERTY(QList<QList<int>* > squaresWon READ squaresWon())
    Q_PROPERTY(QList<int> boardsWon READ boardsWon())
    Q_PROPERTY(QList<int> xBigTilesWon READ xBigTilesWon())
    Q_PROPERTY(QList<int> oBigTilesWon READ oBigTilesWon())
    Q_PROPERTY(QList<QList<int>* > xSmallTilesWon READ xSmallTilesWon())
    Q_PROPERTY(QList<QList<int>* > oSmallTilesWon READ oSmallTilesWon())
    Q_PROPERTY(QList<QList<int>* > winningCombinations READ winningCombinations())
//---------------------------------------------------------------------------------------
    Q_INVOKABLE int getVal(QList<int> list, int index);
    Q_INVOKABLE int getVal(QList<QList<int>* > list, int indexA, int indexB);
    Q_INVOKABLE bool checkForWinningCombinations(QList<int>* tilesWon);
    Q_INVOKABLE void makeMove(int smallIndex, int largeIndex);
    Q_INVOKABLE bool checkForDeadSquare();
    Q_INVOKABLE void resetGame();

private:
    void init();
    void addToWinningCombos(int index, int a, int b, int c);

signals:
    
public slots:
    
};

#endif // GAMETRACKER_H
