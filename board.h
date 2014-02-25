#ifndef BOARD_H
#define BOARD_H

#include <QObject>
#include "innerboard.h"
#include <QString>
#include <QList>

class Board : public QObject
{
		Q_OBJECT
	public:
		explicit Board(QObject *parent = 0, QString allSquaresString = "");

		QString getAllSquaresString();
		bool click(int gridIndex, int squareIndex, QString s);

		Q_INVOKABLE void setValidBoards(int index);  // pass in the index of the small square clicked, and it will set the corresponding large square as clickable.

		Q_INVOKABLE InnerBoard* getInnerBoardAt(int index);

		QList<int> innerBoardsWonByX(); //returns a list of the indeces of the squares won by x
		QList<int> innerBoardsWonByO();  //return a list of the indeces of the squres won by o

		void setWinner(QString winner);
		Q_INVOKABLE QString getWinner();

		Q_INVOKABLE void zoomIn(int gridIndex);
		Q_INVOKABLE void zoomOut(int gridIndex);
		Q_INVOKABLE bool isZoomed();

		QList<int> getValidBoards();

	private:
		QList<InnerBoard*> m_innerBoards;
		QString m_winner;

		bool m_isZoomed;

	signals:
		void clicked();
		void stateChanged();
		void zoomedIn(int gridIndex);
		void zoomedOut(int gridIndex);

	public slots:

};

#endif // BOARD_H
