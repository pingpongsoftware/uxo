#ifndef SQUARE_H
#define SQUARE_H

#include <QObject>
#include <QList>
#include <QString>
#include <QDebug>

class Square : public QObject
{
		Q_OBJECT
	public:
		explicit Square(QObject *parent = 0, QString state = "-");

		Q_INVOKABLE QString getState();  //returns m_state, see square.cpp
		void setState(QString s);
		bool click(QString s); //returns true if it is a valid click

	private:
		QString m_state;  //starts as "-", changes to "x" if won by x player, "o" if won by o player
		bool m_isValid;

	signals:


	public slots:

};

#endif // SQUARE_H
