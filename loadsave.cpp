#include "loadsave.h"

LoadSave::LoadSave(QString filename)
{
	this->m_filename = filename;
}

void LoadSave::saveGame(QString allSquares)
{
	QFile file(this->m_filename + ".game");

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

	QFile file(this->m_filename + ".game");

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
	QFile file(this->m_filename + ".turn");

	if (file.open(QIODevice::WriteOnly))
	{
		QTextStream fileOut(&file);

		fileOut << xTurn;

		file.close();
	}
}

bool LoadSave::loadTurn()
{
	QFile file (this->m_filename + ".turn");

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

	QFile file(this->m_filename + ".valid");

	if (file.open(QIODevice::WriteOnly))
	{
		QTextStream fileOut(&file);

		fileOut << qstr;

		file.close();
	}
}

QList<int> LoadSave::loadValidBoards()
{
	QFile file(this->m_filename + ".valid");

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

void LoadSave::deleteGame()
{
	QFile gameFile(this->m_filename + ".game");
	gameFile.open(QIODevice::ReadWrite);
	if (gameFile.remove())
		qDebug() << m_filename << ".game deleted successfully";
	gameFile.close();

	QFile turnFile(this->m_filename + ".turn");
	turnFile.open(QIODevice::ReadWrite);
	if (turnFile.remove())
		qDebug() << m_filename << ".turn deleted successfully";
	gameFile.close();

	QFile validFile(this->m_filename + ".valid");
	validFile.open(QIODevice::ReadWrite);
	if (QFile::remove(validFile.fileName()))
		qDebug() << m_filename << ".valid deleted successfully";
	gameFile.close();

}
