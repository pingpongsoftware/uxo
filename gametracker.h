#ifndef GAMETRACKER_H
#define GAMETRACKER_H

#include <QObject>
#include <QList>
#include <innerboard.h>

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

		QList<InnerBoard> m_boards;


	public:
		Q_INVOKABLE void boardClicked(int bigIndex, int smallIndex);
		Q_INVOKABLE bool checkForDeadSquare(int index);
		Q_INVOKABLE QString boardWon(int index);
		Q_INVOKABLE QString squareWon(int bigIndex, int smallIndex);

		void resetGame();
		void initBoards();

		QList<InnerBoard>* boards() { return &m_boards; }

		int bigIndex() { return m_bigIndex; }
		int smallIndex() { return m_smallIndex; }

		bool xTurn() { return m_xTurn; }
		bool gameWon() { return m_gameWon; }

		//---------------------------------------------------------------------------

		Q_PROPERTY(QList<InnerBoard>* boards READ boards())
		Q_PROPERTY(int bigIndex READ bigIndex())
		Q_PROPERTY(int smallIndex READ smallIndex())
		Q_PROPERTY(bool xTurn READ xTurn())
		Q_PROPERTY(bool gameWon READ gameWon())

	signals:

	public slots:

};

#endif // GAMETRACKER_H
