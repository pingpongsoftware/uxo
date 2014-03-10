import QtQuick 2.0

Rectangle
{
    id: main;

	width: Vals.getScreenWidth();
	height: Vals.getScreenHeight();

	focus: true;

	Connections
	{
		target: Tracker;

		onGameDeleted:
		{
			main.backButtonPressed();
		}
	}

	Image
	{
		id: lightBackground;
		anchors.fill: parent;
		source: "Images/light/background.png";
	}

	Image
	{
		id: darkBackground;
		anchors.fill: parent;
		source: "Images/dark/background.png";

		Component.onCompleted: updateOpacity();

		function updateOpacity()
		{
			if (Vals.getTheme() === "light")
				opacity = 0;
			else if (Vals.getTheme() === "dark")
				opacity = 1;
		}

		Connections
		{
			target: Vals;

			onThemeSwitched: darkBackground.updateOpacity();

			onTopToolbarTextChanged: topToolbar.titleString = newText;
		}

		Behavior on opacity { NumberAnimation { duration: 200; } }
	}

	Loader
	{
		id: loader;

		Timer
		{
			interval: 1;
			running: true;

			onTriggered:
			{
				loader.loadApp();
			}
		}

		source: "Splash.qml";

		function loadApp()
		{
			Vals.initLoaderSource("Menu.qml");
			source = Vals.getLoaderSource();

			main.width = Vals.getScreenWidth();  //resets the screen size
			main.height = Vals.getScreenHeight();

			topToolbar.setVisibility();

			Vals.resizeWindowCorrectly();
		}
	}

	Connections
	{
		target: loader.item;
		ignoreUnknownSignals: true;

		onNewGameButtonClicked:
		{
			Vals.setTopToolbarText("Create Game");
			main.newLoaderSource("CreateGame.qml");
		}

		onPlayButtonClicked:
		{
			main.newLoaderSource("Game.qml");
		}

		onBackButtonPressed:
		{
			Vals.setTopToolbarText("uXO: Ultimate Tic-Tac-Toe");
			main.backButtonPressed();
		}

		onSettingsButtonClicked:
		{
			Vals.setTopToolbarText("Options");
			main.newLoaderSource("Settings.qml");
		}

		onCancelButtonClicked:
		{
			topToolbar.titleStringToNormal();
			main.newLoaderSource("Menu.qml");
		}

		onCreateGameButtonClicked:
		{
			Vals.setTopToolbarText(gameName);
			Tracker.newGame(gameName);  //gameName passed in through the signal
			main.newLoaderSource("Menu.qml");  //this is just here so the previous source will be Menu.qml instead of CreateGame.qml
			main.newLoaderSource("Game.qml");
		}
	}

	function newLoaderSource(source)
	{
		Vals.setLoaderSource(source);
		loader.setSource(Vals.getLoaderSource());
		topToolbar.setVisibility();
	}

	Keys.onReleased:
	{
		console.log("KEY_PRESSED: " + event.key)
		if (event.key === Qt.Key_Back)
		{
			event.accepted = true;
			console.log("ANDROID BACK BUTTON CLICKED");
			backButtonPressed();  //--TODO: implement function that will exit app if back button is pressed in the menu.  Have a pop up that asks if they really want to exit.
		}
	}

	function backButtonPressed()
	{
		topToolbar.titleStringToNormal();

		Vals.setLoaderSource(Vals.getPreviousLoaderSource());

		if(Vals.getLoaderSource() === "Menu.qml")   // So you can't push the back button from the menu and have it go back to the previous screen
			Vals.initLoaderSource("Menu.qml");
		else
			Vals.setLoaderSource(Vals.getLoaderSource())

		loader.setSource(Vals.getLoaderSource());

		topToolbar.setVisibility();
	}

	TopToolbar
	{
		id: topToolbar;

		visible: false;

		function setVisibility()
		{
			if (Vals.getLoaderSource() === "Menu.qml")
				visible = false;
			else
				visible = true;
		}

		function titleStringToNormal()
		{
			titleString = "uXO: Ultimate Tic-Tac-Toe"
		}

		onBackButtonPressed: main.backButtonPressed();
	}
}
