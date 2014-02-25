#ifndef TRACKER_H
#define TRACKER_H

#include <QObject>
#include "game.h"
#include "loadsave.h"

#include <QQmlEngine>
#include <QtQml>

class Tracker : public QObject
{
		Q_OBJECT
	public:
		explicit Tracker(QObject *parent = 0);

		Q_INVOKABLE void newGame(QString gameName);
		Q_INVOKABLE void loadGame(QString gameName);

		Q_INVOKABLE Game* getGame();
		Q_PROPERTY(Game* currentGame READ getGame)

		void registerTypes();

	private:
		Game *m_game;

	signals:

	public slots:

};

#endif // TRACKER_H
