//#ifndef GAMETRACKER_H
//#define GAMETRACKER_H

//#include <QObject>
//#include <vector>

//class GameTracker : public QObject
//{
//    Q_OBJECT
//public:
//    explicit GameTracker(QObject *parent = 0);

//private:
//    bool m_X_TURN = true;

//private:
//    bool m_GAME_WON = false;

//private:
//    char m_WINNING_PLAYER = ' ';

//private:
//    int m_BIG_INDEX = 0;

//private:
//    int m_LITTLE_INDEX = 0;

//    // -1 means O won that square, 0 means nobody has won that square, 1 means X won that square-----------
//private:
//    int** m_SQUARES_WON;
    
//private:
//    int* m_BOARDS_WON = new int[9];
//    //-----------------------------------------------------------------------------------------------------

////private:
////    std::vector<int> m_X_BIG_TILES_WON = new vector<int>();

////private:
////    std::vector<int> m_O_BIG_TILES_WON = new vector<int>();

//private:
//    int* m_X_SMALL_TILES_WON = new int[9];

//private:
//    int* m_O_SMALL_TILES_WON = new int[9];

//private:
//    int** m_WINNING_COMBINATIONS;

////--------------------------------------------------------------------------------------

//public:
//    bool X_TURN() {return m_X_TURN;}

//public:
//    bool GAME_WON() {return m_GAME_WON;}

//public:
//    char WINNING_PLAYER() {return m_WINNING_PLAYER;}

//public:
//    int BIG_INDEX() {return m_BIG_INDEX;}

//public:
//    int LITTLE_INDEX() {return m_LITTLE_INDEX;}

//public:
//    int **SQUARES_WON() {return m_SQUARES_WON;}

//public:
//    int *BOARDS_WON() {return m_BOARDS_WON;}

//public:
//    int *X_BIG_TILES_WON()
//    {
//        int* temp = new int[m_X_BIG_TILES_WON.size()];

//        for (int i = 0; i < sizeof(temp); i++)
//        {
//            temp[i] = m_X_BIG_TILES_WON.at(i);
//        }

//        return temp;
//    }

//public:
//    int *O_BIG_TILES_WON()
//    {
//        int* temp = new int[m_O_BIG_TILES_WON.size()];

//        for (int i = 0; i < sizeof(temp); i++)
//        {
//            temp[i] = m_O_BIG_TILES_WON.at(i);
//        }

//        return temp;
//    }

//public:
//    int *X_SMALL_TILES_WON() {return m_X_SMALL_TILES_WON;}

//public:
//    int *O_SMALL_TILES_WON() {return m_O_SMALL_TILES_WON;}

//public:
//    int **WINNING_COMBINATIONS() {return m_WINNING_COMBINATIONS;}


////------------------------------------------------------------------------------------
//    Q_PROPERTY(int X_TURN READ X_TURN())
//    Q_PROPERTY(int GAME_WON READ GAME_WON())
//    Q_PROPERTY(int WINNING_PLAYER READ WINNING_PLAYER())
//    Q_PROPERTY(int BIG_INDEX READ BIG_INDEX())
//    Q_PROPERTY(int LITTLE_INDEX READ LITTLE_INDEX())
//    Q_PROPERTY(int** SQUARES_WON READ SQUARES_WON())
//    Q_PROPERTY(int* BOARDS_WON READ BOARDS_WON())
//    Q_PROPERTY(int* X_BIG_TILES_WON READ X_BIG_TILES_WON())
//    Q_PROPERTY(int* O_BIG_TILES_WON READ O_BIG_TILES_WON())
//    Q_PROPERTY(int* X_SMALL_TILES_WON READ X_SMALL_TILES_WON())
//    Q_PROPERTY(int* O_SMALL_TILES_WON READ O_SMALL_TILES_WON())
//    Q_PROPERTY(int** WINNING_COMBINATIONS READ WINNING_COMBINATIONS())
////---------------------------------------------------------------------------------------


//private:
//       bool checkForWinningCombinations(int* tilesWon);

//private:
//       bool checkForWinningCombinations(std::vector<int> tilesWon)
//       {
//           int* temp = new int[tilesWon.size()];

//           for (int i = 0; i < sizeof(temp); i++)
//           {
//               temp[i] = tilesWon.at(i);
//           }

//           return checkForWinningCombinations(temp);
//       }

//public:
//       void makeMove(int smallIndex, int largeIndex);

//public:
//       bool checkForDeadSquare();

//public:
//       void resetGame();

//private:
//       void init();

//signals:
    
//public slots:
    
//};

//#endif // GAMETRACKER_H
