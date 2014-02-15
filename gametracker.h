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
		QString m_winningPlayer;

		QList<InnerBoard> m_boards;


	public:
		Q_INVOKABLE void boardClicked(int bigIndex, int smallIndex);

		void resetGame();
		void initBoards();

	signals:

	public slots:

};

#endif // GAMETRACKER_H
