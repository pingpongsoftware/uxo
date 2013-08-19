//#include "gametracker.h"

//GameTracker::GameTracker(QObject *parent) :
//    QObject(parent)
//{
//    this->init();
//}

//void GameTracker::init()
//{
//    for (int i = 0; i < 9; i++) //Squares won
//    {
//        for (int j = 0; j < 9; j++)
//        {
//            m_SQUARES_WON[i][j] = 0;
//        }
//    }

//    for (int i = 0; i < 9; i++) //Boards won
//    {
//        m_BOARDS_WON[i] = 0;
//    }

//    for (int i = 0; i < 9; i++) // X & O small & big tiles won
//    {
//        m_X_SMALL_TILES_WON[i] = 0;
//        m_X_BIG_TILES_WON[i] = 0;
//        m_O_SMALL_TILES_WON[i] = 0;
//        m_O_BIG_TILES_WON[i] = 0;
//    }

//    //Winning combinations.

//    m_WINNING_COMBINATIONS[0] = {0,1,2};
//    m_WINNING_COMBINATIONS[1] = {3,4,5};
//    m_WINNING_COMBINATIONS[2] = {6,7,8};
//    m_WINNING_COMBINATIONS[3] = {0,3,6};
//    m_WINNING_COMBINATIONS[4] = {1,4,7};
//    m_WINNING_COMBINATIONS[5] = {2,5,8};
//    m_WINNING_COMBINATIONS[6] = {2,4,6};
//    m_WINNING_COMBINATIONS[7] = {0,4,8};
//}

//bool GameTracker::checkForWinningCombinations(int *tilesWon)
//{
//    bool gameWon = false;
//    bool matchCount = 0;

//    for (int i = 0; i < sizeof(m_WINNING_COMBINATIONS); i++)
//    {
//        for (int j = 0; j < sizeof(m_WINNING_COMBINATIONS[i]); j++)
//        {
//            for (int k = 0; k < sizeof(tilesWon); k++)
//            {
//                if (m_WINNING_COMBINATIONS[i][k] == tilesWon[m])
//                {
//                    matchCount++;
//                    break;
//                }
//            }
//        }

//        if (matchCount >= 3)
//        {
//            gameWon = true;
//            break;
//        }
//        matchCount = 0;
//    }

//    return gameWon;
//}

////Changes the player turn, add the played tile to their winnings, and checks to see if they've won
//void GameTracker::makeMove(int smallIndex, int largeIndex)
//{
//    m_LITTLE_INDEX = smallIndex;
//    m_BIG_INDEX = largeIndex;

//    if (m_X_TURN)
//    {
//        //adds the chosen tile to the array of tiles won
//        m_X_SMALL_TILES_WON[largeIndex] = smallIndex;
//        m_SQUARES_WON[largeIndex][smallIndex] = 1;

//        //checks to see if the board has been won.  If it has, it adds
//        //the board to the array of boards won, and sets the corresponding
//        //boardWon variable as true(1 or -1.  If the board has previously
//        //been won it doesn't do anything

//        if (checkForWinningCombinations(m_X_SMALL_TILES_WON[largeIndex]) && m_BOARDS_WON[largeIndex] == 0)
//        {
//            m_X_SMALL_TILES_WON.push_back(largeIndex);
//            m_BOARDS_WON[largeIndex] = 1;
//        }

//        //Check to see if the big game has been won
//        if ( checkForWinningCombinations((m_X_BIG_TILES_WON)))
//        {
//            m_WINNING_PLAYER = 'X';
//            m_GAME_WON = true;
//        }
//    }

//    else //does the same as above but for O's
//    {
//        m_O_SMALL_TILES_WON[largeIndex] = smallIndex;
//        m_SQUARES_WON[largeIndex][smallIndex] = 1;

//        if (checkForWinningCombinations(m_O_SMALL_TILES_WON[largeIndex]) && m_BOARDS_WON[largeIndex] == 0)
//        {
//            m_O_SMALL_TILES_WON.push_back(largeIndex);
//            m_BOARDS_WON[largeIndex] = 1;
//        }

//        //Check to see if the big game has been won
//        if ( checkForWinningCombinations((m_O_BIG_TILES_WON)))
//        {
//            m_WINNING_PLAYER = 'O';
//            m_GAME_WON = true;
//        }
//    }

//    m_X_TURN = !m_X_TURN;
//    return m_BOARDS_WON[m_BIG_INDEX];
//}

//bool GameTracker::checkForDeadSquare()
//{
//    if (sizeof(m_X_SMALL_TILES_WON[m_LITTLE_INDEX]) + sizeof (m_O_SMALL_TILES_WON[m_LITTLE_INDEX]) < 9)
//        return false;

//    return true;
//}

//void GameTracker::resetGame()
//{
//    m_X_TURN = true;
//    m_GAME_WON = true;
//    m_WINNING_PLAYER = ' ';
//    m_BIG_INDEX = 0;
//    m_LITTLE_INDEX = 0;

//    this->init();
//}
