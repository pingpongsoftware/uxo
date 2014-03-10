import QtQuick 2.0
import Qt.labs.folderlistmodel 2.0

Item
{
	id: main;
	clip: true;

	signal itemButtonClicked(var gameName);

	function getHeaderHeight()
	{
		return headerRect.height;
	}


	Rectangle
	{
		id: fillRect;
		anchors.fill: parent;

		color:
		{
			if (Vals.getTheme() === "dark")
				"#444444";
			else
				"lightgray";
		}

		opacity: 1;
	}

    Rectangle
    {
        id: headerRect;
		width: parent.width;
		height: Vals.getBasicUnit()*10;
        color: "firebrick"

        z: 1000; // so it is in front of everything else

        TrenchFontText
        {
			fontSize: Vals.getMediumSmallFontSize();
            text: "Saved Games";

			lightThemeColor: "white";
			darkThemeColor: "white";

			Component.onCompleted: updateColor();

            fontBold: true;
            anchors.centerIn: parent;
        }
    }

    Component
    {
        id: listDelegate

		Item
		{
			width: main.width;
			height: Vals.getBasicUnit()*15;

			GameListItem
			{
				width: parent.width - Vals.getBasicUnit()*4;
				height: parent.height;
				anchors.centerIn: parent;

				property string fName: fileName;

				name: fName.substring(0, fName.length - 5);

				rectOpacity: 1;

				onButtonClicked: itemButtonClicked(gameName);
			}
		}
    }

	FolderListModel
    {
         id: listModel

		 nameFilters: "*.game";
     }

    ListView
    {
          id: listView
          width: main.width;
          height: main.height - headerRect.height;
		  y: headerRect.height + spacing;
          anchors.horizontalCenter: main.horizontalCenter;
          model: listModel
          delegate: listDelegate
          focus: true
		  spacing: Vals.getBasicUnit()*2;
          pressDelay: 50;
    }

	TrenchFontText
	{
		id: noGamesText;

		anchors.top: headerRect.bottom;
		anchors.topMargin: Vals.getBasicUnit()*6;
		anchors.horizontalCenter: main.horizontalCenter;
		fontSize: Vals.getMediumFontSize();

		darkThemeColor: "lightgray";
		lightThemeColor: "#444444";

		text:
		{
			if (listView.contentHeight < Vals.getBasicUnit()) // if there are no items;
				"No Saved Games"
			else
				"";
		}
	}
}
