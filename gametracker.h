#ifndef GAMETRACKER_H
#define GAMETRACKER_H

#include <QObject>
#include <QList>
#include <innerboard.h>
#include <loadsave.h>

using namespace std;

class GameTracker : public QObject
{
    Q_OBJECT

	public:
		explicit GameTracker(QObject *parent = 0);

	private:
		bool m_xTurn;
		bool m_gameWon;
		int m_bigIndex;
		int m_smallIndex;
		QString m_winningPlayer;

		QString m_gameName;

		QList<InnerBoard> m_boards;
		QList<int> m_xBigBoardsWon;  //list of the indeces of big boards won by x;
		QList<int> m_oBigBoardsWon;  //list of the indeces of big boards won by y;

		LoadSave *loadSave;


	public:
		Q_INVOKABLE void boardClicked(int bigIndex, int smallIndex);
		Q_INVOKABLE bool checkForDeadSquare(int index);
		Q_INVOKABLE QString boardWon(int index);
		Q_INVOKABLE QString squareWon(int bigIndex, int smallIndex);
		Q_INVOKABLE QString checkForTicTacToe();
		Q_INVOKABLE void resetGame();
		Q_INVOKABLE void startGame(QString name);
		Q_INVOKABLE void loadGame(QString name);

		void initBoards(QList<InnerBoard> boards);

		QList<InnerBoard>* boards() { return &m_boards; }

		int bigIndex() { return m_bigIndex; }
		int smallIndex() { return m_smallIndex; }

		bool xTurn() { return m_xTurn; }
		bool gameWon() { return m_gameWon; }

		QList<int>* xBigBoardsWon() { return &m_xBigBoardsWon; }
		QList<int>* oBigBoardsWon() { return &m_oBigBoardsWon; }
		QString winningPlayer() { return m_winningPlayer; }

		//---------------------------------------------------------------------------

		Q_PROPERTY(QList<InnerBoard>* boards READ boards())
		Q_PROPERTY(int bigIndex READ bigIndex())
		Q_PROPERTY(int smallIndex READ smallIndex())
		Q_PROPERTY(bool xTurn READ xTurn())
		Q_PROPERTY(bool gameWon READ gameWon())
		Q_PROPERTY(QList<int>* xBigBoardsWon READ oBigBoardsWon())
		Q_PROPERTY(QList<int>* oBigBoardsWon READ oBigBoardsWon())
		Q_PROPERTY(QString winningPlayer READ winningPlayer())

	signals:

	public slots:

};

#endif // GAMETRACKER_H
