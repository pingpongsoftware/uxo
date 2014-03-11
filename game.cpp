#include "game.h"

Game::Game(QObject *parent, QString name) :
	QObject(parent)
{
	this->m_name = name;
	this->m_loadSave = new LoadSave(name);

	this->setPlayerNames();

	this->initWinningCombos();
}

void Game::initWinningCombos()
{
	this->winningCombos.push_back(WinningCombo(0,1,2));
	this->winningCombos.push_back(WinningCombo(3,4,5));
	this->winningCombos.push_back(WinningCombo(6,7,8));
	this->winningCombos.push_back(WinningCombo(0,3,6));
	this->winningCombos.push_back(WinningCombo(1,4,7));
	this->winningCombos.push_back(WinningCombo(2,5,8));
	this->winningCombos.push_back(WinningCombo(0,4,8));
	this->winningCombos.push_back(WinningCombo(2,4,6));
}

void Game::createNew()
{
	QString emptySquares = "";

	for (int i = 0; i < 81; i++)
		emptySquares += "-";

	this->m_board = new Board(this, emptySquares);

	this->m_xTurn = true;

	for (int i = 0; i < 9; i++)  //sets all the boards to be valid for the start
		this->m_board->getInnerBoardAt(i)->setValidity(true);

    this->m_loadSave->saveGame(emptySquares, m_xTurn, m_board->getValidBoards());
}

void Game::loadExisting()
{
	QString allSquares = "";

    m_loadSave->loadGame();
    allSquares = m_loadSave->getSquareVals();

	if (allSquares.length() == 0)  //if the requested game to load is empty, creates new game and exits this method.
	{
		qDebug() << "LOADING ERROR";
		this->createNew();
		return;
	}

	this->m_board = new Board(this, allSquares);

	this->checkAllCombos();

    this->m_xTurn = this->m_loadSave->getXTurn();

    QList<int> validIBs = this->m_loadSave->getValidBoards();

    if (validIBs.length() > 0)
        for (int i = 0; i < validIBs.length(); i++)
            this->m_board->getInnerBoardAt(validIBs[i])->setValidity(true);
    else
		for (int i = 0; i < 9; i++)
			this->m_board->getInnerBoardAt(i)->setValidity(true);
}

void Game::checkAllCombos()  //checks for winning combos for all of the boards
{
	for (int i = 0; i < 9; i++)
		for (int j = 0; j < 9; j++)
			this->checkForWinningCombos(i, j);
}

void Game::click(int gridIndex, int squareIndex)
{
	QString s;

	if (this->m_xTurn)
		s = "x";
	else
		s = "o";

	if (this->m_board->click(gridIndex, squareIndex, s))
	{		
		this->checkForWinningCombos(gridIndex, squareIndex);

		this->switchTurn();

        m_loadSave->saveGame(m_board->getAllSquaresString(), m_xTurn, m_board->getValidBoards());

		emit this->clicked();
	}

	this->checkIfGameIsWon();
}

void Game::checkForWinningCombos(int gridIndex, int squareIndex)  //checks for winning combos for the inner boards and the board
{
	if (this->getWinningCombo(this->m_board->getInnerBoardAt(gridIndex)->squaresWonByX()).length() == 3)  //checks to see if there is a three in a row for x in the inner board
		this->m_board->getInnerBoardAt(gridIndex)->setWinner("x");
	else if (this->getWinningCombo(this->m_board->getInnerBoardAt(gridIndex)->squaresWonByO()).length() == 3)   //checks to see if there is a three in a row for o in the inner board
		this->m_board->getInnerBoardAt(gridIndex)->setWinner("o");
}

void Game::checkIfGameIsWon()
{
	//First Checks for X
	QList<int> list = this->getWinningCombo(m_board->innerBoardsWonByX());

	if(list.length() == 3)
	{
		m_board->setWinner("x");
		m_board->setValidBoards(-1);
		emit this->gameWon("x", list[0], list[1], list[2]);
		return;
	}


	//Then checks for O
	list = this->getWinningCombo(m_board->innerBoardsWonByO());

	if(list.length() == 3)
	{
		m_board->setWinner("o");
		m_board->setValidBoards(-1);
		emit this->gameWon("o", list[0], list[1], list[2]);
	}
}

void Game::switchTurn()
{
	this->m_xTurn = !this->m_xTurn;
}

bool Game::getXTurn()
{
	return this->m_xTurn;
}

Board* Game::getBoard()
{
	return this->m_board;
}

QList<int> Game::getWinningCombo(QList<int> squaresWon)
{
	bool boardWon = false;
	int matchCount = 0;

	QList<int> list;
	int currentIndex;

	for (int i = 0; i < this->winningCombos.length(); i++)
	{
		for (int j = 0; j < this->winningCombos[i].getCombo().length(); j++)
		{
			for (int k = 0; k < squaresWon.length(); k++)
			{
				if (winningCombos[i].getCombo()[j] == squaresWon[k])
				{
					matchCount++;
					currentIndex = i;
					break;
				}
			}
		}

		if (matchCount == 3)
		{
			boardWon = true;
			list = winningCombos[i].getCombo();
			break;
		}

		matchCount = 0;
		list = QList<int>();
	}

	return list;
}


void Game::deleteGame()
{
	m_loadSave->deleteGame();
}

void Game::callGameWonDelayed(QString winner, int index1, int index2, int index3)
{
	qDebug() << winner << index1 << index2 << index3;
	emit this->gameWonDelayed(winner, index1, index2, index3);
}

void Game::setPlayerNames()
{
	QString qstr = " vs ";

	QString xStr;
	QString oStr;

	for (int i = 0; i < m_name.length() - qstr.length(); i++)
	{
		if (m_name.mid(i, qstr.length()) == qstr)
		{
			xStr = m_name.mid(0, i);
			oStr = m_name.mid(i + qstr.length(), m_name.length());

			qDebug() << xStr << "   " << oStr;

			break;
		}
	}

	m_xPlayerName = xStr;
	m_oPlayerName = oStr;
}

QString Game::getPlayerXName() { return m_xPlayerName; }
QString Game::getPlayerOName() { return m_oPlayerName; }
