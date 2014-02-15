#ifndef INNERBOARD_H
#define INNERBOARD_H

#include <QList>
#include <QString>
#include "winningcombo.h"

class InnerBoard
{
	public:
		InnerBoard(int index = -1);

		void initBoard();
		void resetBoard();
		void squareClicked(int index, QString letter);

		bool checkForWinningCombos(QList<int> squaresWon);

		bool isBoardWon();

		QString winningPlayer() { return m_winningPlayer; }

		QString squareWon(int index);

		int squaresPlayedLength() { return m_oSquares.length() + m_xSquares.length(); }


	private:
		QList<WinningCombo> winningCombos;

		QList<QString> m_squares; //the total list of squares. "x" if won by x, "o" if won by o, and "-" if won by nobody
		QList<int> m_xSquares; // a list of the indeces of the tiles won by x
		QList<int> m_oSquares; // a list of the indeces of the tiles won by o

		QString m_winningPlayer;  // "x" if x won the board, "o" if o won the board
};

#endif // INNERBOARD_H
