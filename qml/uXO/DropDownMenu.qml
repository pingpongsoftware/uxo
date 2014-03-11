import QtQuick 2.0

Rectangle
{
	id: main;

	signal itemClicked(var buttonString);

	property int listContentHeight;
	property int listContentItemHeight: Vals.getBasicUnit()*12;
	property int listContentWidth: Vals.getBasicUnit()*50;

	clip: true;

	color:
	{
		if (Vals.getTheme() === "dark")
			"black";
		else
			"white";
	}

	border.width: 1;
	border.color:
	{
		if (Vals.getTheme() === "dark")
			"lightgray";
		else
			"#444444";
	}

	function addToList(name)
	{
		listModel.append( { "text": name } );
		listContentHeight += listContentItemHeight;
	}

	function clearList()
	{
		listModel.clear();
		listContentHeight = 0;
	}

	ListView
	{
		id: listView;
		anchors.fill: parent;
		model: listModel;
		delegate: listDelegate;
		spacing: 1;

		interactive: false;
	}

	Component
	{
		id: listDelegate;

		MyButton
		{
			width: main.listContentWidth;
			height:
			{
				height = main.listContentItemHeight;
				setClickableSize(width, height);
			}

			buttonColor:
			{
				if (Vals.getTheme() === "dark")
					"white";
				else
					"gray";
			}

			textColor:
			{
				if (Vals.getTheme() === "dark")
					"black";
				else
					"white";
			}

			buttonText: text;

			fontSize: Vals.getMediumSmallFontSize();

			onClick:
			{
				main.itemClicked(buttonText);
			}
		}
	}

	ListModel
	{
		id: listModel;
	}
}
