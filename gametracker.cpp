#include "gametracker.h"
#include "QList"

GameTracker::GameTracker(QObject *parent) :
    QObject(parent)
{
	m_xTurn = true;
	m_gameWon = false;
	m_winningPlayer = "-";
}

void GameTracker::initBoards()
{
	for (int i = 0; i < 9; i++)
	{
		m_boards.push_back(InnerBoard(i));
		m_boards[i].initBoard();
	}
}

void GameTracker::boardClicked(int bigIndex, int smallIndex)
{
	if (m_xTurn)
		m_boards[bigIndex].squareClicked(smallIndex, "x");
	else
		m_boards[bigIndex].squareClicked(smallIndex, "o");

	m_xTurn = !m_xTurn;
}


void GameTracker::resetGame()
{
	m_xTurn = true;
	m_gameWon = false;
	m_winningPlayer = "-";

	for (int i = 8; i >= 0; i++)
		m_boards.removeAt(i);

	this->initBoards();
}
