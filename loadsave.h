#ifndef LOADSAVE_H
#define LOADSAVE_H

#include <QString>
#include <QDebug>
#include <QFile>

class LoadSave
{
	public:
		LoadSave(QString filename = "");

        void loadGame();
        void saveGame(QString allSquares, bool xTurn, QList<int> validBoards);

        QString getSquareVals();
        bool getXTurn();
        QList<int> getValidBoards();

		void deleteGame();

	private:
		QString m_filename;

        bool m_xTurn;
        QList<int> m_validBoards;
        QString m_squareVals;

        void setSquareVals(QString str);
        void setXTurn(QString str);
        void setValidBoards(QString str);

        QString getStringInsideTag(QString fileString, QString closeTag);

};

#endif // LOADSAVE_H
