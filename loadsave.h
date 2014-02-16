#ifndef LOADSAVE_H
#define LOADSAVE_H

#include <QString>
#include <QFile>
#include <QTextStream>
#include <QDebug>
#include "innerboard.h"

class LoadSave
{
	public:
		LoadSave(QString name);

		QList<InnerBoard> loadBoards();
		void saveBoards(QList<InnerBoard> list);

	private:
		QString m_name;
};

#endif // LOADSAVE_H
