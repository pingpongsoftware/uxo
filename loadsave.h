#ifndef LOADSAVE_H
#define LOADSAVE_H

#include <QString>
#include <QDebug>
#include <QFile>

class LoadSave
{
	public:
		LoadSave(QString filename = "");

		QString loadGame();
		void saveGame(QString allSquares);

		bool loadTurn();
		void saveTurn(bool xTurn);

		QList<int> loadValidBoards();
		void saveValidBoards(QList<int> list);

		void deleteGame();

	private:
		QString m_filename;
};

#endif // LOADSAVE_H
