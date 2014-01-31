import QtQuick 2.2

Rectangle
{
    id: main;

    width: Vals.screenWidth;
    height: Vals.screenHeight;
    color: "transparent";

    //load fonts from a file
    FontLoader { id: prime_reg; source: "Fonts/Prime Regular.ttf" }

    Flickable
    {
        id: flowListFLickable;
        width: main.width/3;
        height: 250 + 100 + 100 + 20*2;  //this is the height of all the objects in the flow added together plus the spacing (20 is the spacing of the flow and the number multiplied by 20 is the number of objects in it)


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
                height: 250;

                text: "Settings";
                font.capitalization: Font.SmallCaps;
                font.bold: true;
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: Vals.largeFontSize;
                font.letterSpacing: 2;
                font.wordSpacing: 0;
                font.family: prime_reg.name;
                color: "firebrick";
                opacity: .7;

            }

            Text
            {
                id: setThemeText;

                width: parent.width;
                height: 60

                text: "Select Theme";
                font.capitalization: Font.SmallCaps;
                //font.bold: true;
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: Vals.mediumFontSize;
                font.family: prime_reg.name;
                color: "firebrick";
                opacity: .7;

            }

            Rectangle //This rectangle is merely for the purpose of fixing the spacing for the light and dark theme buttons
            {
                id: spacingRect;
                width: Vals.buttonSize*.3;
                height: Vals.buttonSize / 3;
                color: "transparent"
            }

            MyButton
            {
                id: darkThemeButton;

                width: Vals.buttonSize/1.2;
                height: Vals.buttonSize/3;
                buttonText: "Dark"

                fontSize: Vals.smallFontSize;
                textColor:
                {
                    if (Vals.theme === "light")
                        "#666666";
                    else if (Vals.theme === "dark")
                    {
                        textColor = "#33aadd"
                        opacity = .6;
                    }
                }

                onClick: switchTheme("dark");
            }

            MyButton
            {
                id: lightThemeButton;

                width: darkThemeButton.width;
                height: darkThemeButton.height;
                buttonText: "Light"

                fontSize: Vals.smallFontSize;
                textColor:
                {
                    if (Vals.theme === "light")
                        "#aaaaaa";
                    else if (Vals.theme === "dark")
                    {
                        textColor = "#33aadd"
                        opacity = .6;
                    }
                }

                onClick: switchTheme("light");
            }


        }


        Rectangle
        {
            id: themeRect;
            width: lightThemeButton.width;
            height: lightThemeButton.height*.8;
            radius: 15;
            color: "steelblue"
            opacity: .9;
            z: -5; //so it is behind the other objects

            y: darkThemeButton.y;
            x: lightThemeButton.x//switchTheme(Vals.theme); //gets initial theme and puts the rect at appropriate location
        }

    }


    function switchTheme(theme)
    {
        if (theme === "dark")
        {
            themeRect.x = darkThemeButton.x
            Vals.theme = "dark";
        }
        else if (theme === "light")
        {
            themeRect.x = lightThemeButton.x;
            Vals.theme = "light";
        }

    }


}
