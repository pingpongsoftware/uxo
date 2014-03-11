#ifndef INNERBOARD_H
#define INNERBOARD_H

#include <QObject>
#include "square.h"
#include <QString>
#include <QList>
#include <QDebug>


class InnerBoard : public QObject
{
		Q_OBJECT
	public:
		explicit InnerBoard(QObject *parent = 0, QString squaresString = "---------");

		Q_INVOKABLE QString getState(); //returns the state, see innerboard.cpp
		QString getSquaresString();  //returns a string of all the squares states
		bool click(int index, QString s);  // runs method then returns true if its a valid click

		Q_INVOKABLE Square* getSquareAt(int index);  //returns the square at the given index		

		QList<int> squaresWonByX(); //returns a list of the indeces of the squares won by x
		QList<int> squaresWonByO();  //return a list of the indeces of the squres won by o


		void setValidity(bool b);
		void setWinner(QString winner);

		Q_INVOKABLE bool isValid();
		Q_INVOKABLE bool isWon();

		void popUpImage();

	private:
		QList<Square*> m_squares;
		QString m_state; // "x" if won by x, "o" if won by o, "-" if won by neither
		bool m_isValid;

	signals:
		void clicked();
		void stateChanged();
		void imagePoppedUp();

	public slots:

};

#endif // INNERBOARD_H
