#ifndef WINNINGCOMBO_H
#define WINNINGCOMBO_H

#include <QList>
using namespace std;

class WinningCombo
{
	public:
		WinningCombo(int a, int b, int c);

		QList<int> getCombo();

	private:
		int first;
		int second;
		int third;
};

#endif // WINNINGCOMBO_H
