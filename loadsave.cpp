#include "loadsave.h"

#include <QString>
#include <QFile>
#include <QTextStream>
#include <QDebug>
#include "innerboard.h"

LoadSave::LoadSave(QString name)
{
	this->m_name = name;
}

void LoadSave::saveBoards(QList<InnerBoard> boards)
{
	QFile file(this->m_name + ".txt");

	if (file.open(QIODevice::ReadWrite))
	{
		QTextStream stream(&file);

		for (int i = 0; i < 9; i++)
		{
			QString temp;

			for (int j = 0; j < 9; j ++)
			{
				temp += boards[i].squareWon(j);
			}

			stream << temp;
			qDebug() << temp;
			temp = "";
		}

		qDebug() << "\n\n\n\n\n";

	}

	file.close();
}

QList<InnerBoard> LoadSave::loadBoards()
{
	QFile file(this->m_name + ".txt");
	QTextStream stream(&file);

	QList<InnerBoard> boards;
	QString temp;

	if (file.open(QIODevice::ReadOnly))
	{
		for (int i = 0; i < 9; i++)
		{
			boards.push_back(InnerBoard(i));
			temp += stream.readLine(9);

			QList<QString> tempList;

			for (int j = 0; j < 9; j++)
			{
				tempList.push_back(temp.at(j));
			}

			boards[i].initBoard(tempList);

			temp = "";
		}
	}

	return boards;
}
