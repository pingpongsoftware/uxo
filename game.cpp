#include "game.h"

Game::Game(QObject *parent, QString name) :
	QObject(parent)
{
	this->m_name = name;
	this->m_loadSave = new LoadSave(name);

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

	this->m_loadSave->saveTurn(this->m_xTurn);
	this->m_loadSave->saveGame(emptySquares);
	this->m_loadSave->saveValidBoards(this->m_board->getValidBoards());
}

void Game::loadExisting()
{
	QString allSquares = "";

	allSquares = this->m_loadSave->loadGame();

	if (allSquares.length() == 0)  //if the requested game to load is empty, creates new game and exits this method.
	{
		qDebug() << "LOADING ERROR";
		this->createNew();
		return;
	}

	this->m_board = new Board(this, allSquares);

	this->checkAllCombos();

	this->m_xTurn = this->m_loadSave->loadTurn();	

	QList<int> validIBs = this->m_loadSave->loadValidBoards();

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
		this->m_loadSave->saveGame(this->m_board->getAllSquaresString());
		this->m_loadSave->saveTurn(this->getXTurn());
		this->m_loadSave->saveValidBoards(this->m_board->getValidBoards());

		emit this->clicked();
	}
}

void Game::checkForWinningCombos(int gridIndex, int squareIndex)  //checks for winning combos for the inner boards and the board
{
	if (this->isWinningCombo(this->m_board->getInnerBoardAt(gridIndex)->squaresWonByX()))  //checks to see if there is a three in a row for x in the inner board
		this->m_board->getInnerBoardAt(gridIndex)->setWinner("x");
	else if (this->isWinningCombo(this->m_board->getInnerBoardAt(gridIndex)->squaresWonByO()))   //checks to see if there is a three in a row for o in the inner board
		this->m_board->getInnerBoardAt(gridIndex)->setWinner("o");

	if (this->isWinningCombo(this->m_board->innerBoardsWonByX()))  //checks to see if there is a three in a row for x in the outer board
		this->m_board->setWinner("x");
	else if (this->isWinningCombo(this->m_board->innerBoardsWonByO()))
		this->m_board->setWinner("o");
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

bool Game::isWinningCombo(QList<int> squaresWon)
{
	bool boardWon = false;
	int matchCount = 0;

	for (int i = 0; i < this->winningCombos.length(); i++)
	{
		for (int j = 0; j < this->winningCombos[i].getCombo().length(); j++)
		{
			for (int k = 0; k < squaresWon.length(); k++)
			{
				if (winningCombos[i].getCombo()[j] == squaresWon[k])
				{
					matchCount++;
					break;
				}
			}
		}

		if (matchCount >= 3)
		{
			boardWon = true;
			break;
		}

		matchCount = 0;
	}

	return boardWon;
}


void Game::deleteGame()
{
	m_loadSave->deleteGame();
}
