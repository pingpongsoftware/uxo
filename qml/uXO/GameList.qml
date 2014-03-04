import QtQuick 2.0
import Qt.labs.folderlistmodel 2.0

Item
{
	id: main;
	clip: true;

	width: Vals.getScreenWidth();
	height: headerRect.height;  // will be added onto as items are added

	signal itemButtonClicked(var gameName);

	function getHeaderHeight()
	{
		return headerRect.height;
	}

    Rectangle
    {
        id: headerRect;
        width: parent.width;
		height: Vals.getBasicUnit()*10
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

        GameListItem
        {
            width: main.width
			height: Vals.getBasicUnit()*15;

			property string fName: fileName;

			name: fName.substring(0, fName.length - 5);

            rectOpacity: .5;


			onButtonClicked: itemButtonClicked(gameName);

            Rectangle  //this is the thin line in between buttons
            {
                color:
                {
                    if (Vals.theme === "light")
                        "black";
                    else
                        "gray";
                }
                width: main.width;
                height: listView.spacing;
                anchors.top: parent.bottom;
            }

			Component.onCompleted:
			{
				main.height += height;
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
          y: headerRect.height
          anchors.horizontalCenter: main.horizontalCenter;
          model: listModel
          delegate: listDelegate
          focus: true
          spacing: 1
		  boundsBehavior: Flickable.StopAtBounds;
          pressDelay: 50;

		  Component.onCompleted: console.log(height);
    }
}
