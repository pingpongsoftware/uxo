#include "gametracker.h"
#include <QList>
#include <QDebug>
GameTracker::GameTracker(QObject *parent) :
    QObject(parent)
{
	m_xTurn = true;
	m_gameWon = false;
	m_winningPlayer = "-";

	this->initBoards();
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

	this->m_bigIndex = bigIndex;
	this->m_smallIndex = smallIndex;

//	for (int i = 0; i < m_boards.length(); i++)
//		qDebug() << m_boards[i].winningPlayer();

//	for (int i = 0; i < 10; i++)
//		qDebug() << " ";

	m_xTurn = !m_xTurn;
}


void GameTracker::resetGame()
{
	m_xTurn = true;
	m_gameWon = false;
	m_winningPlayer = "-";

	for (int i = 8; i >= 0; i++)
		m_boards.removeAt(i);

	//this->initBoards();
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

