#include "square.h"

Square::Square(QObject *parent, QString state) :
	QObject(parent)
{
	this->setState(state);

	if (state == "-")
		this->m_isValid = true;
	else
		this->m_isValid = false;
}

QString Square::getState()
{
	return this->m_state;
}

void Square::setState(QString s)
{
	this->m_state = s;
}

bool Square::click(QString s)
{
	if (this->m_isValid)
	{
		this->setState(s);
		this->m_isValid = false;
		return true;
	}

	return false;
}
