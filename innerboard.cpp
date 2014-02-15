#include "innerboard.h"
#include <QDebug>
#include <QString>
#include "winningcombo.h"

InnerBoard::InnerBoard(int index)
{
	winningCombos.push_back(WinningCombo(1,2,3));
	winningCombos.push_back(WinningCombo(4,5,6));
	winningCombos.push_back(WinningCombo(7,8,9));
	winningCombos.push_back(WinningCombo(1,4,7));
	winningCombos.push_back(WinningCombo(2,5,8));
	winningCombos.push_back(WinningCombo(3,6,9));
	winningCombos.push_back(WinningCombo(1,5,9));
	winningCombos.push_back(WinningCombo(3,5,7));
}

void InnerBoard::initBoard()
{
	m_winningPlayer = "-";

	for (int i = 0; i < 9; i ++)
		this->m_squares.push_back("-");

	for (int i = 0; i < m_xSquares.length(); i++)
		this->m_xSquares.removeFirst();

	for (int i = 0; i < m_oSquares.length(); i++)
		this->m_oSquares.removeFirst();
}

void InnerBoard::squareClicked(int index, QString letter)
{
	this->m_squares.replace(index, letter);

	if (letter == "x")
	{
		this->m_xSquares.push_back(index);
		if (checkForWinningCombos(this->m_xSquares))
			this->m_winningPlayer = "x";
	}
	else if (letter == "o")
	{
		this->m_xSquares.push_back(index);
		if (checkForWinningCombos(this->m_oSquares))
			this->m_winningPlayer = "o";
	}
	else
		qDebug() << "invalid letter given";
}

bool InnerBoard::checkForWinningCombos(QList<int> squaresWon)
{
	bool boardWon = false;
	int matchCount = 0;

	for (int i = 0; i < this->winningCombos.length(); i++)
	{
		for (int j = 0; j < this->winningCombos[i].getCombo().length(); j++)
		{
			for (int k = 0; k < squaresWon.length(); i++)
			{
				if (winningCombos[i].getCombo() == squaresWon)
				{
					matchCount++;
					break;
				}
			}
		}

		if (matchCount >= 3)
		{
			boardWon = true;
			break;
		}

		matchCount = 0;
	}

	return boardWon;
}

bool InnerBoard::isBoardDead()
{
	if (this->m_winningPlayer == "-")
		return true;

	return false;
}
