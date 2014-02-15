#include "gametracker.h"
#include <QList>
#include <QDebug>
GameTracker::GameTracker(QObject *parent) :
    QObject(parent)
{
	this->initBoards();
}

void GameTracker::initBoards()
{
	m_xTurn = true;
	m_gameWon = false;
	m_winningPlayer = "-";

	for (int i = 0; i < 9; i++)
	{
		m_boards.push_back(InnerBoard(i));
		m_boards[i].initBoard();
	}
}

void GameTracker::boardClicked(int bigIndex, int smallIndex)
{
	if (m_xTurn)
	{
		m_boards[bigIndex].squareClicked(smallIndex, "x");
		if (m_boards[bigIndex].isBoardWon())
			m_xBigBoardsWon.push_back(bigIndex);

		this->m_winningPlayer = this->checkForTicTacToe();
	}
	else
	{
		m_boards[bigIndex].squareClicked(smallIndex, "o");
		if (m_boards[bigIndex].isBoardWon())
			m_oBigBoardsWon.push_back(bigIndex);

		this->m_winningPlayer = this->checkForTicTacToe();
	}

	this->m_bigIndex = bigIndex;
	this->m_smallIndex = smallIndex;

	if (this->m_winningPlayer != "-")
	{
		this->m_winningPlayer = this->m_winningPlayer.toUpper();
		this->m_gameWon = true;
	}

	m_xTurn = !m_xTurn;
}


void GameTracker::resetGame()
{
	for (int i = m_boards.length()-1; i >= 0; i--)
	{
		m_boards[i].resetBoard();
		m_boards.removeLast();
	}

	this->initBoards();
}

bool GameTracker::checkForDeadSquare(int index)
{
	if (m_boards[index].squaresPlayedLength() < 9)
		return false;

	return true;
}

QString GameTracker::boardWon(int index)
{
	return m_boards[index].winningPlayer();
}

QString GameTracker::squareWon(int bigIndex, int smallIndex)
{
	return m_boards[bigIndex].squareWon(smallIndex);
}

QString GameTracker::checkForTicTacToe()
{
	if (m_boards[0].checkForWinningCombos(m_xBigBoardsWon)) //Using inner boards method for checking for winning combos
		return "x";

	if (m_boards[0].checkForWinningCombos(m_oBigBoardsWon)) //Using inner boards method for checking for winning combos
		return "o";

	return "-";
}

