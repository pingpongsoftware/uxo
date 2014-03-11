#include "innerboard.h"

InnerBoard::InnerBoard(QObject *parent, QString squaresString) :
	QObject(parent)
{
	for (int i = 0; i < 9; i++)
		this->m_squares.push_back(new Square(this, squaresString.at(i)));

	this->setValidity(false);
}

QString InnerBoard::getState()
{
	return this->m_state;
}

QString InnerBoard::getSquaresString()
{
	QString temp = "";

	for (int i = 0; i < this->m_squares.length(); i++)
		temp += this->m_squares[i]->getState();

	return temp;
}

QList<int> InnerBoard::squaresWonByX()
{
	QList<int> temp;

	for (int i = 0; i < 9; i++)
		if (this->m_squares[i]->getState() == "x")
			temp.push_back(i);

	return temp;
}

QList<int> InnerBoard::squaresWonByO()
{
	QList<int> temp;

	for (int i = 0; i < 9; i++)
		if (this->m_squares[i]->getState() == "o")
			temp.push_back(i);

	return temp;
}

bool InnerBoard::click(int index, QString s)
{
	if (this->isValid())
	{
		if (m_squares[index]->click(s))
		{
			emit this->clicked();
			return true;
		}
	}

	return false;
}

Square* InnerBoard::getSquareAt(int index)
{
	return this->m_squares[index];
}

void InnerBoard::setValidity(bool b)
{
	this->m_isValid = b;
}

bool InnerBoard::isValid()
{
	return this->m_isValid;
}

bool InnerBoard::isWon()
{
	if (this->m_state == "x" || this->m_state == "o")
		return true;

	this->m_state = "-";  //if for some reason the state is neither "x", "o", or "-", this changes it to "-"

	return false;
}

void InnerBoard::setWinner(QString winner)
{
	this->m_state = winner;
	this->stateChanged();
}

void InnerBoard::popUpImage()
{
	emit this->imagePoppedUp();
}
