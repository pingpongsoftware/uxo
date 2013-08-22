#include "gametracker.h"
#include "QList"

GameTracker::GameTracker(QObject *parent) :
    QObject(parent)
{
    this->init();
}

void GameTracker::init()
{
    m_WINNING_COMBINATIONS.push_back(addToWinningCombos(0,1,2));
    m_WINNING_COMBINATIONS.push_back(addToWinningCombos(3,4,5));
    m_WINNING_COMBINATIONS.push_back(addToWinningCombos(6,7,8));
    m_WINNING_COMBINATIONS.push_back(addToWinningCombos(0,3,6));
    m_WINNING_COMBINATIONS.push_back(addToWinningCombos(1,4,7));
    m_WINNING_COMBINATIONS.push_back(addToWinningCombos(2,5,8));
    m_WINNING_COMBINATIONS.push_back(addToWinningCombos(2,4,6));
    m_WINNING_COMBINATIONS.push_back(addToWinningCombos(0,4,8));

    for (int i = 0; i < 9; i++) //Squares won
    {
        for (int j = 0; j < 9; j++)
        {
            m_SQUARES_WON_INNER.push_back(0);
        }

        m_SQUARES_WON.push_back(m_SQUARES_WON_INNER);
    }

    for (int i = 0; i < 9; i++) //Boards won
    {
        m_BOARDS_WON.push_back(0);
    }

    for (int i = 0; i < 9; i++) // X & O small & big tiles won
    {
        m_X_BIG_TILES_WON.push_back(0);
        m_O_BIG_TILES_WON.push_back(0);

        QList<int> temp;
        m_O_SMALL_TILES_WON.push_back(temp);
        m_X_SMALL_TILES_WON.push_back(temp);
    }

}

QList<int> GameTracker::addToWinningCombos(int a, int b, int c)
{
    QList<int> temp;
    temp.push_back(a);
    temp.push_back(b);
    temp.push_back(c);
    return temp;
}

bool GameTracker::checkForWinningCombinations(QList<int> tilesWon)
{
    bool gameWon = false;
    bool matchCount = 0;

    for (int i = 0; i < m_WINNING_COMBINATIONS.length(); i++)
    {
        for (int j = 0; j < m_WINNING_COMBINATIONS.at(i).length(); j++)
        {
            for (int k = 0; k < tilesWon.length(); k++)
            {
                if (m_WINNING_COMBINATIONS.at(i).at(j) == tilesWon.at(k))
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
    m_LITTLE_INDEX = smallIndex;
    m_BIG_INDEX = largeIndex;

    if (m_X_TURN)
    {
        //adds the chosen tile to the array of tiles won
        m_X_SMALL_TILES_WON[largeIndex].push_back(smallIndex);
        m_SQUARES_WON[largeIndex][smallIndex] = 1;

        //checks to see if the board has been won.  If it has, it adds
        //the board to the array of boards won, and sets the corresponding
        //boardWon variable as true(1 or -1.  If the board has previously
        //been won it doesn't do anything

        if (checkForWinningCombinations(m_X_SMALL_TILES_WON.at(largeIndex)) && m_BOARDS_WON.at(largeIndex) == 0)
        {
            m_X_BIG_TILES_WON.push_back(largeIndex);
            m_BOARDS_WON[largeIndex] = 1;
        }

        //Check to see if the big game has been won
        if ( checkForWinningCombinations((m_X_BIG_TILES_WON)))
        {
            m_WINNING_PLAYER = 'X';
            m_GAME_WON = true;
        }
    }

    else //does the same as above but for O's
    {
        m_O_SMALL_TILES_WON[largeIndex].push_back(smallIndex);
        m_SQUARES_WON[largeIndex][smallIndex] = 1;

        if (checkForWinningCombinations(m_O_SMALL_TILES_WON.at(largeIndex)) && m_BOARDS_WON.at(largeIndex) == 0)
        {
            m_O_BIG_TILES_WON.push_back(largeIndex);
            m_BOARDS_WON[largeIndex] = 1;
        }

        //Check to see if the big game has been won
        if ( checkForWinningCombinations((m_O_BIG_TILES_WON)))
        {
            m_WINNING_PLAYER = 'O';
            m_GAME_WON = true;
        }
    }

    m_X_TURN = !m_X_TURN;

    //return m_BOARDS_WON.at(m_BIG_INDEX);  ---don't know why this was here, but it was.
}

bool GameTracker::checkForDeadSquare()
{
    if (m_X_SMALL_TILES_WON.at(m_LITTLE_INDEX).length() + m_O_SMALL_TILES_WON.at(m_LITTLE_INDEX).length() < 9)
        return false;

    return true;
}

void GameTracker::resetGame()
{
    m_X_TURN = true;
    m_GAME_WON = true;
    m_WINNING_PLAYER = ' ';
    m_BIG_INDEX = 0;
    m_LITTLE_INDEX = 0;

    this->init();
}

int GameTracker::getVal(QList<int> list, int index)
{
    return list.at(index);
}

int GameTracker::getVal(QList<QList<int> > list, int indexA, int indexB)
{
    if (indexA > list.length() || indexB > list.at(0).length())
        return 0;

    return list.at(indexA).at(indexB);
}
