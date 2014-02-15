#include "winningcombo.h"
#include <QList>
#include <QDebug>
using namespace std;

WinningCombo::WinningCombo(int a, int b, int c)
{
	this->first = a;
	this->second = b;
	this->third = c;
}

QList<int> WinningCombo::getCombo()
{
	QList<int> ql;

	ql.push_back(this->first);
	ql.push_back(this->second);
	ql.push_back(this->third);

	return ql;
}
