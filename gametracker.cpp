#include "gametracker.h"
#include "QList"

GameTracker::GameTracker(QObject *parent) :
    QObject(parent)
{
    this->init();
}

void GameTracker::init()
{
    for (int i = 0; i < 8; i++)
    {
        m_winningCombinations.push_back(new QList<int>);
    }

    addToWinningCombos(0, 0,1,2);
    addToWinningCombos(1, 3,4,5);
    addToWinningCombos(2, 6,7,8);
    addToWinningCombos(3, 0,3,6);
    addToWinningCombos(4, 1,4,7);
    addToWinningCombos(5, 2,5,8);
    addToWinningCombos(6, 2,4,6);
    addToWinningCombos(7, 0,4,8);

    for (int i = 0; i < 9; i++) //Squares won
    {
        m_squaresWon.push_back(new QList<int>());

        for (int j = 0; j < 9; j++)
        {
            m_squaresWon[i]->push_back(0);
        }
    }

    for (int i = 0; i < 9; i++) //Boards won
    {
        m_boardsWon.push_back(0);
    }

    for (int i = 0; i < 9; i++) // X & O small & big tiles won
    {
        m_xBigTilesWon.push_back(0);
        m_oBigTilesWon.push_back(0);

        m_oSmallTilesWon.push_back(new QList<int>);
        m_xSmallTilesWon.push_back(new QList<int>);
    }

}

void GameTracker::addToWinningCombos(int index, int a, int b, int c)
{
    m_winningCombinations.at(index)->push_back(a);
    m_winningCombinations.at(index)->push_back(b);
    m_winningCombinations.at(index)->push_back(c);
}

bool GameTracker::checkForWinningCombinations(QList<int>* tilesWon)
{
    bool gameWon = false;
    bool matchCount = 0;

    for (int i = 0; i < m_winningCombinations.length(); i++)
    {
        for (int j = 0; j < m_winningCombinations.at(i)->length(); j++)
        {
            for (int k = 0; k < tilesWon->length(); k++)
            {
                if (m_winningCombinations.at(i)->at(j) == tilesWon->at(k))
                {
                    matchCount++;
                    break;
                }
            }
        }

        if (matchCount >= 3)
        {
            gameWon = true;
            break;
        }
        matchCount = 0;
    }

    return gameWon;
}

//Changes the player turn, add the played tile to their winnings, and checks to see if they've won
void GameTracker::makeMove(int smallIndex, int largeIndex)
{
    m_littleIndex = smallIndex;
    m_bigIndex = largeIndex;

    if (m_xTurn)
    {
        //adds the chosen tile to the array of tiles won
        m_xSmallTilesWon[m_bigIndex]->push_back(m_littleIndex);
        m_squaresWon[m_bigIndex]->replace(m_littleIndex, 1);

        //checks to see if the board has been won.  If it has, it adds
        //the board to the array of boards won, and sets the corresponding
        //boardWon variable as true(1 or -1.  If the board has previously
        //been won it doesn't do anything

        if (checkForWinningCombinations(m_xSmallTilesWon.at(m_bigIndex)) && m_boardsWon.at(m_bigIndex) == 0)
        {
            m_xBigTilesWon.push_back(m_bigIndex);
            m_boardsWon[m_bigIndex] = 1;
        }

        //Check to see if the big game has been won
        if ( checkForWinningCombinations((&m_xBigTilesWon)))
        {
            m_winningPlayer = 'X';
            m_gameWon= true;
        }
    }

    else //does the same as above but for O's
    {
        m_oSmallTilesWon[m_bigIndex]->push_back(m_littleIndex);
        m_squaresWon[m_bigIndex]->replace(m_littleIndex, 1);  //m_squaresWon[m_bigIndex][m_littleIndex] = 1;

        if (checkForWinningCombinations(m_oSmallTilesWon.at(m_bigIndex)) && m_boardsWon.at(m_bigIndex) == 0)
        {
            m_oBigTilesWon.push_back(m_bigIndex);
            m_boardsWon[m_bigIndex] = 1;
        }

        //Check to see if the big game has been won
        if ( checkForWinningCombinations((&m_oBigTilesWon)))
        {
            m_winningPlayer = 'O';
            m_gameWon= true;
        }
    }

    m_xTurn = !m_xTurn;

    //return m_boardsWon.at(m_bigIndex);  ---don't know why this was here, but it was.
}

bool GameTracker::checkForDeadSquare()
{
    if (m_xSmallTilesWon.at(m_littleIndex)->length() + m_oSmallTilesWon.at(m_littleIndex)->length() < 9)
        return false;

    return true;
}

void GameTracker::resetGame()
{
    m_xTurn = true;
    m_gameWon= true;
    m_winningPlayer = ' ';
    m_bigIndex = 0;
    m_littleIndex = 0;

    this->init();
}

int GameTracker::getVal(QList<int>* list, int index)
{
    return list->at(index);
}

int GameTracker::get2DVal(QList<QList<int>* >* list, int indexA, int indexB)
{
    return list->at(indexA)->at(indexB);
}
