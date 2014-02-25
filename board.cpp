#include "board.h"

Board::Board(QObject *parent, QString allSquares) :
	QObject(parent)
{
	for (int i = 0; i < 81; i+=9)
	{
		QString temp = "";

		for (int j = 0; j < 9; j ++)
		{
			temp += allSquares.at(j+i);
		}

		m_innerBoards.push_back(new InnerBoard(this, temp));
	}

	m_isZoomed = true;
}

InnerBoard* Board::getInnerBoardAt(int index)
{
	return this->m_innerBoards[index];
}


QString Board::getAllSquaresString()
{
	QString temp = "";

	for (int i = 0; i < this->m_innerBoards.length(); i++)
	{
		temp += this->m_innerBoards[i]->getSquaresString();
	}

	return temp;
}

bool Board::click(int gridIndex, int squareIndex, QString s)
{
	if (m_innerBoards[gridIndex]->click(squareIndex, s))
	{
		if (this->m_innerBoards[squareIndex]->isWon()) //if the square you are going into is won, all squares will be valid
		{
			for (int i = 0; i < 9; i++)
				this->m_innerBoards[i]->setValidity(true);
		}
		else
		{
			for (int i = 0; i < 9; i++)
				this->m_innerBoards[i]->setValidity(false);  //sets all inner boards to be invalid

			this->m_innerBoards[squareIndex]->setValidity(true);  //sets the correct inner board to be valid
		}

		emit this->clicked();

		return true;
	}

	return false;
}

QList<int> Board::innerBoardsWonByX()
{
	QList<int> temp;

	for (int i = 0; i < 9; i++)
		if (this->m_innerBoards[i]->getState() == "x")
			temp.push_back(i);

	return temp;
}

QList<int> Board::innerBoardsWonByO()
{
	QList<int> temp;

	for (int i = 0; i < 9; i++)
		if (this->m_innerBoards[i]->getState() == "o")
			temp.push_back(i);

	return temp;
}

void Board::setValidBoards(int index)
{

}

void Board::setWinner(QString winner)
{
	this->m_winner = winner;
	emit this->stateChanged();
}

QString Board::getWinner()
{
	return this->m_winner;
}

QList<int> Board::getValidBoards()
{
	QList<int> temp;

	for (int i = 0; i < 9; i++)
		if (this->m_innerBoards[i]->isValid())
			temp.push_back(i);

	return temp;
}

void Board::zoomIn(int gridIndex)
{
	emit this->zoomedIn(gridIndex);
	m_isZoomed = true;
}

void Board::zoomOut(int gridIndex)
{
	emit this->zoomedOut(gridIndex);
	m_isZoomed = false;
}

bool Board::isZoomed()
{
	return m_isZoomed;
}
