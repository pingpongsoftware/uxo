#include "loadsave.h"

LoadSave::LoadSave(QString filename)
{
	this->m_filename = filename;
}

void LoadSave::saveGame(QString allSquares)
{
	QFile file(this->m_filename);

	if (file.open(QIODevice::WriteOnly))
	{
		QTextStream fileOut(&file);

		fileOut << allSquares;

		file.close();
	}
}

QString LoadSave::loadGame()
{
	QString allSquares = "";

	QFile file(this->m_filename);

	if (file.open(QIODevice::ReadOnly))
	{
		QTextStream fileIn(&file);

		allSquares = fileIn.readLine(81);

		file.close();
	}

	return allSquares;
}

void LoadSave::saveTurn(bool xTurn)
{
	QFile file("turn_" + this->m_filename);

	if (file.open(QIODevice::WriteOnly))
	{
		QTextStream fileOut(&file);

		fileOut << xTurn;

		file.close();
	}
}

bool LoadSave::loadTurn()
{
	QFile file ("turn_" + this->m_filename);

	QString xTurn;

	if (file.open(QIODevice::ReadOnly))
	{
		QTextStream fileIn(&file);

		xTurn = fileIn.readAll();

		file.close();
	}

	qDebug() << xTurn;

	if (xTurn == "1")
		return true;

	return false;
}


void LoadSave::saveValidBoards(QList<int> list)
{
	QString qstr;

	for (int i = 0; i < list.length(); i++)
		qstr += QString::number(list[i]);

	QFile file("valid_" + this->m_filename);

	if (file.open(QIODevice::WriteOnly))
	{
		QTextStream fileOut(&file);

		fileOut << qstr;

		file.close();
	}
}

QList<int> LoadSave::loadValidBoards()
{
	QFile file("valid_" + this->m_filename);

	qDebug() << file.fileName();

	QString qstr;

	if (file.open(QIODevice::ReadOnly))
	{
		QTextStream fileIn(&file);

		qstr = fileIn.readAll();

		file.close();
	}

	QList<int> list;

	for (int i = 0; i < qstr.length(); i++)
		if (i < 9)
			list.push_back(qstr.at(i).digitValue());

	return list;
}
