.pragma library

//Generic
var screenWidth = 768;
var screenHeight = 1280;

//.......

var rows = 3;

//Outer Grid
var bigGridSpacing = screenWidth/100;

var outerGridSize = screenWidth - (bigGridSpacing*rows) - bigGridSpacing;

//Inner Grid
var smallGridSpacing = screenWidth/120;

var innerRectSize = outerGridSize/rows;

    //for the grid inside the rectangle
    var innerGridSize = innerRectSize - (smallGridSpacing*rows) - smallGridSpacing;

//Tic Tac Toe Square
var squareSize = innerGridSize/rows - 7;

//Toolbar
var toolbarWidth = screenWidth;
var toolbarHeight = 55;


//Game Title
var titleHeight = 50;
var titleWidth = screenWidth;

//makes the screen large enough to fit the toolbar and title
screenHeight += toolbarHeight + titleHeight;
