#include "tracker.h"

Tracker::Tracker(QObject *parent) :
	QObject(parent)
{
	this->registerTypes();
}

void Tracker::newGame(QString gameName)
{
	this->m_game = new Game(this, gameName);
	this->m_game->createNew();
}

void Tracker::loadGame(QString gameName)
{
	this->m_game = new Game(this, gameName);
	this->m_game->loadExisting();
}

Game* Tracker::getGame()
{
	return this->m_game;
}

void Tracker::registerTypes()
{
	qmlRegisterType<Game>("uxo.game", 1, 0, "Game");
	qmlRegisterType<Board>("uxo.board", 1, 0, "Board");
	qmlRegisterType<InnerBoard>("uxo.innerboard", 1, 0, "InnerBoard");
	qmlRegisterType<Square>("uxo.square", 1, 0, "Square");
}

void Tracker::deleteGame()
{
	this->m_game->deleteGame();
	emit this->gameDeleted();
}

void Tracker::clickDropDownButton()
{
	emit this->dropDownButtonClicked();
}

void Tracker::goBack()
{
	emit this->backButtonClicked();
}

void Tracker::goToOptions()
{
	emit this->optionsButtonClicked();
}

void Tracker::goToHelp()
{
	emit this->helpButtonClicked();
}
