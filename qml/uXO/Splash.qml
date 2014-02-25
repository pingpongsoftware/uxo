import QtQuick 2.0

Rectangle
{
	width: Vals.getScreenWidth();
	height: Vals.getScreenHeight();
	color: "black";

	Text
	{
		text: "loading";
		color: "white";
		anchors.centerIn: parent;
	}
}
