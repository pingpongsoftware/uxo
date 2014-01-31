import QtQuick 2.2

Rectangle
{
    id: main;

    width: Vals.screenWidth;
    height: Vals.screenHeight;
    color: "transparent";

    property int titleHeight: height/7;
    property int buttonHeight: Vals.buttonSize/2.5;
    property int smallButtonHeight: Vals.buttonSize/4;
    property int smallButtonWidth: Vals.buttonSize/1.2;

    signal topToolbarBackButtonClicked();
    signal switchThemeButtonClicked();

    //load fonts from a file
    FontLoader { id: prime_reg; source: "Fonts/Prime Regular.ttf" }

    TopToolbar
    {
        id: topToolbar;

        width: main.width;
        //makes the toolbar fill the space between the board and the top of the screen
        height: main.height / 12;
        color: "transparent";

        onBackButtonClicked:
        {
            topToolbarBackButtonClicked();
        }

        anchors.top: titleRect.bottom;
    }


    Flickable
    {
        id: flowListFLickable;
        width: main.width/3;
        height: titleHeight + buttonHeight + smallButtonHeight + 20*2;  //this is the height of all the objects in the flow added together plus the spacing (20 is the spacing of the flow and the number multiplied by 20 is the number of objects in it)


        anchors.top: main.top;
        anchors.topMargin: 50;
        anchors.horizontalCenter: main.horizontalCenter;

        interactive: true;

        contentWidth: width;
        contentHeight: main.height;


        Flow
        {
            id: flow;

            width: parent.width;
            height: parent.height;
            anchors.centerIn: parent;

            spacing: 10;

            Text
            {
                id: title;

                width: parent.width;
                height: main.titleHeight;

                text: "Settings";
                font.capitalization: Font.SmallCaps;
                font.bold: true;
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: Vals.largeFontSize;
                font.letterSpacing: 2;
                font.wordSpacing: 0;
                font.family: prime_reg.name;
                color: {changeColorsToMatchTheme();}
                opacity: .7;

            }

            Text
            {
                id: setThemeText;

                width: parent.width;
                height: main.buttonHeight;

                text: "Select Theme";
                font.capitalization: Font.SmallCaps;
                //font.bold: true;
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: Vals.mediumFontSize;
                font.family: prime_reg.name;
                color: {changeColorsToMatchTheme();}
                opacity: .7;

            }

            Rectangle //This rectangle is merely for the purpose of fixing the spacing for the light and dark theme buttons
            {
                id: spacingRect;
                width: Vals.buttonSize*.3;
                height: Vals.buttonSize*.3;
                color: "transparent"
            }

            MyButton
            {
                id: darkThemeButton;

                width: main.smallButtonWidth;
                height: main.smallButtonHeight;
                buttonText: "Dark"

                fontSize: Vals.smallFontSize;
                textColor: "#333333"

                onClick: switchTheme("dark");
            }

            MyButton
            {
                id: lightThemeButton;

                width: darkThemeButton.width;
                height: darkThemeButton.height;
                buttonText: "Light"

                fontSize: Vals.smallFontSize;
                textColor: "lightgray"

                onClick: switchTheme("light");
            }


        }


        Rectangle
        {
            id: themeRect;
            width: lightThemeButton.width;
            height: lightThemeButton.height;
            radius: height;
            color: "steelblue";
            opacity: .8;
            z: -5; //so it is behind the other objects


            y: lightThemeButton.y * .989;  //For some reason it wasn't quite centered on the text, so multiplying it by .989 fixes that problem
            x:
            {
                if (Vals.theme === "light")
                    lightThemeButton.x;  //switchTheme(Vals.theme); //gets initial theme and puts the rect at appropriate location
                else if (Vals.theme === "dark")
                    darkThemeButton.x;
            }

        }

    }


    function switchTheme(theme)
    {
        Vals.setTheme(theme)

        if (theme === "dark")
            themeRect.x = darkThemeButton.x

        else if (theme === "light")
            themeRect.x = lightThemeButton.x;

        switchThemeButtonClicked(); //sends signal to the main.qml file so the background image will change
        changeColorsToMatchTheme(); //calls the function that changes the colors of all the text and button, etc.

        console.log(Vals.theme);

    }

    function changeColorsToMatchTheme()
    {
        if (Vals.theme === "light")
        {
            title.color = "firebrick";
            setThemeText.color = "firebrick";
        }

        else if (Vals.theme === "dark")
        {
            title.color = "gray"
            setThemeText.color = "steelblue";
        }

    }


}
