#ifndef GAME_H
#define GAME_H

#include <QDebug>

#include <QObject>
#include <QString>
#include "loadsave.h"
#include "board.h"
#include "winningcombo.h"

class Game : public QObject
{
		Q_OBJECT
	public:
		explicit Game(QObject *parent = 0, QString name = "empty_name");

	private:
		QString m_name;
		LoadSave *m_loadSave;
		Board *m_board;
		bool m_xTurn;  // true if it is X's turn, false if its O's turn		

		void initWinningCombos();
		QList<WinningCombo> winningCombos;
		void checkAllCombos();

		QList<int> sortList(QList<int> list);

		QString m_xPlayerName;
		QString m_oPlayerName;


	public:
		bool getXTurn();

		void switchTurn();

		void loadExisting();
		void createNew();

		Q_INVOKABLE void click(int gridIndex, int squareIndex);
		Q_INVOKABLE Board* getBoard();
		void deleteGame();

		Q_INVOKABLE void callGameWonDelayed(QString winner, int index1, int index2, int index3);

		QList<int> getWinningCombo(QList<int> squaresWon);  // goes through the list of innerboard/squares won and looks combos of three in a row, returning true if that player has three in a row
		void checkForWinningCombos(int gridIndex, int squareIndex);
		void checkIfGameIsWon();

		Q_INVOKABLE void setPlayerNames();
		Q_INVOKABLE QString getPlayerXName();
		Q_INVOKABLE QString getPlayerOName();

		Q_INVOKABLE QString getGameName() { return m_name; }

		Q_PROPERTY(bool xTurn READ getXTurn)

	signals:
		void clicked();
		void gameWon(QString winner, int index1, int index2, int index3);
		void gameWonDelayed(QString winner, int index1, int index2, int index3);

	public slots:

};

#endif // GAME_H
