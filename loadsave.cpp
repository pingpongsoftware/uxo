#include "loadsave.h"

LoadSave::LoadSave(QString filename)
{
	this->m_filename = filename;
}

void LoadSave::saveGame(QString allSquares, bool xTurn, QList<int> validBoards)
{
	QFile file(this->m_filename + ".game");

	if (file.open(QIODevice::WriteOnly))
	{
		QTextStream fileOut(&file);

        fileOut << "<squares>" << allSquares << "</squares>\n";
        fileOut << "<turn>" << xTurn << "</turn>\n";

        QString boardsString;

        for (int i = 0; i < validBoards.length(); i++)
            boardsString += QString::number(validBoards[i]);

        fileOut << "<valid>" << boardsString << "</valid>\n";

		file.close();
	}
}

void LoadSave::loadGame()
{
    QString fileString;

    QFile file(this->m_filename + ".game");

    if (file.open(QIODevice::ReadOnly))
    {
        QTextStream fileIn(&file);
        fileString = fileIn.readAll();
        file.close();
    }

    QString tagSearch;

    for (int i = 0; i < fileString.length(); i++)
    {
        tagSearch += fileString[i];

        if (tagSearch == "<squares>")
        {
            this->setSquareVals(getStringInsideTag(fileString.mid(i+1, fileString.length() - (i+1)), "</squares>"));
            tagSearch = "";
        }

        else if (tagSearch == "<turn>")
        {
            this->setXTurn(getStringInsideTag(fileString.mid(i+1, fileString.length() - (i+1)), "</turn>"));
            tagSearch = "";
        }

        else if (tagSearch == "<valid>")
        {
            this->setValidBoards(getStringInsideTag(fileString.mid(i+1, fileString.length() - (i+1)), "</valid>"));
            tagSearch = "";
        }

        if (fileString[i] == '\n')
        {
            tagSearch = "";
        }
    }
}

QString LoadSave::getStringInsideTag(QString fileString, QString closeTag)
{
    QString dataStr;
    for (int i = 0; i < fileString.length() - closeTag.length(); i++)
    {
        if(fileString.mid(i, closeTag.length()) == closeTag)
        {
            return dataStr;
        }

        dataStr += fileString[i];
    }

    qDebug() << "ERROR: LoadSave::getStringInsideTag()";
    return "";
}

//------------------------------------------------------------------------------------------------

void LoadSave::setSquareVals(QString str)
{
    m_squareVals = str;
}

void LoadSave::setXTurn(QString str)
{
    if (str == "1")
        m_xTurn = true;
    else
        m_xTurn = false;
}


void LoadSave::setValidBoards(QString str)
{
    QList<int> list;

    for (int i = 0; i < str.length(); i++)
        if (i < 9)
            list.push_back(str.at(i).digitValue());

    m_validBoards = list;
}


//----------------------------------------------------------------------------------------------

void LoadSave::deleteGame()
{
	QFile gameFile(this->m_filename + ".game");

	gameFile.open(QIODevice::ReadWrite);

	if (gameFile.remove())
        qDebug() << m_filename + ".game deleted successfully";

    gameFile.close();

}

//----------------------------------------------------------------------------------------------

QString LoadSave::getSquareVals()
{
    return m_squareVals;
}

QList<int> LoadSave::getValidBoards()
{
    return m_validBoards;
}

bool LoadSave::getXTurn()
{
    return m_xTurn;
}
