#include "innerboard.h"
#include <QDebug>
#include <QString>
#include "winningcombo.h"

InnerBoard::InnerBoard(int index)
{
	winningCombos.push_back(WinningCombo(0,1,2));
	winningCombos.push_back(WinningCombo(3,4,5));
	winningCombos.push_back(WinningCombo(6,7,8));
	winningCombos.push_back(WinningCombo(0,3,6));
	winningCombos.push_back(WinningCombo(1,4,7));
	winningCombos.push_back(WinningCombo(2,5,8));
	winningCombos.push_back(WinningCombo(0,4,8));
	winningCombos.push_back(WinningCombo(2,4,6));
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

		if (m_xSquares.length() >= 3 && checkForWinningCombos(this->m_xSquares))
			this->m_winningPlayer = "x";
	}
	else if (letter == "o")
	{
		this->m_oSquares.push_back(index);
		if (m_oSquares.length() >= 3 && checkForWinningCombos(this->m_oSquares))
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
			for (int k = 0; k < squaresWon.length(); k++)
			{				
				if (winningCombos[i].getCombo()[j] == squaresWon[k])
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

bool InnerBoard::isBoardWon()
{
	if (this->m_winningPlayer == "-")
		return false;

	return true;
}


QString InnerBoard::squareWon(int index)
{
	return m_squares[index];
}
