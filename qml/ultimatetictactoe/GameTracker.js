.pragma library

var xTurn = true;
var gameWon = false;
var winningPlayer = "";

var bigIndex = 0;
var littleIndex = 0;

/* Three-way boolean.  If square or board is still in play, it's variable is set
at 0. If x has won its variable is set at 1. If o has won its
variable is set at -1. Initialized at 0 */
var squareWon = new Array(9);
for(var i=0; i<squareWon.length; i++)
{
    squareWon[i] = new Array(9);
    for(var k=0; k<squareWon[i].length; k++)
    {
        squareWon[i][k] = 0;
    }
}

var boardWon = new Array(9);
for(var i=0; i<boardWon.length; i++)
{
    boardWon[i] = 0;
}

var xBigTilesWon = new Array(0);
var oBigTilesWon = new Array(0);
var xSmallTilesWon = new Array(9);
var oSmallTilesWon = new Array(9);

for(var i=0; i<xSmallTilesWon.length; i++){
    xSmallTilesWon[i] = new Array(0);
    oSmallTilesWon[i] = new Array(0);
}

var winningCombinations = new Array(8);
winningCombinations[0] = [0,1,2];
winningCombinations[1] = [3,4,5];
winningCombinations[2] = [6,7,8];
winningCombinations[3] = [0,3,6];
winningCombinations[4] = [1,4,7];
winningCombinations[5] = [2,5,8];
winningCombinations[6] = [2,4,6];
winningCombinations[7] = [0,4,8];

function checkForWinningCombination(tilesWonArray)
{
    var tempGameWon = false;
    var matchCount = 0;

    for(var i=0; i<winningCombinations.length; i++)
    {
        for(var k=0; k<winningCombinations[i].length; k++)
        {
            for(var m=0; m<tilesWonArray.length; m++)
            {
                if(winningCombinations[i][k] === tilesWonArray[m])
                {
                    matchCount++;
                    break;
                }
            }
        }

        if(matchCount >= 3)
        {
            tempGameWon = true;
            break;
        }
        else matchCount = 0;
    }

    return tempGameWon;
}

//Changes the player turn, add the played tile to their winnings, and checks to see if they've won
function makeMove(smallIndex, largeIndex)
{
    littleIndex = smallIndex;
    bigIndex = largeIndex;

    if(xTurn)
    {
        //adds the chosen tile to the array of tiles won
        xSmallTilesWon[bigIndex].push(littleIndex);
        squareWon[bigIndex][littleIndex] = 1;

        /* checks to see if the board has been won.  If it has, it adds
        the board to the array of boards won, and sets the corresponding
        boardWon variable as true(1 or -1.  If the board has previously
        been won it doesn't do anything*/
        if( checkForWinningCombination(xSmallTilesWon[bigIndex]) && boardWon[bigIndex] === 0 )
        {
            xBigTilesWon.push(bigIndex);
            boardWon[bigIndex] = 1

            //Check to see if the big game has been won
            if( checkForWinningCombination(xBigTilesWon) )
            {
                winningPlayer = "X"
                gameWon = true;
            }
        }
    }

    else
    {
        oSmallTilesWon[bigIndex].push(littleIndex);
        squareWon[bigIndex][littleIndex] = -1;

        if( checkForWinningCombination(oSmallTilesWon[bigIndex]) && boardWon[bigIndex] === 0 )
        {
            oBigTilesWon.push(bigIndex);
            boardWon[bigIndex] = -1

            if( checkForWinningCombination(oBigTilesWon) )
            {
                winningPlayer = "O";
                gameWon = true;
            }
        }
    }
    xTurn = !xTurn;
    return boardWon[bigIndex];
}

function checkForDeadSquare()
{
    if(xSmallTilesWon[littleIndex].length + oSmallTilesWon[littleIndex].length < 9)
    {
        return false;
    }

    else
    {
        return true;
    }
}

function resetGame()
{
    xTurn = true;
    gameWon = false;
    winningPlayer = "";
    bigIndex = 0;
    littleIndex = 0;

    squareWon = new Array(9);
    for(var i=0; i<squareWon.length; i++)
    {
        squareWon[i] = new Array(9);
        for(var k=0; k<squareWon[i].length; k++)
        {
            squareWon[i][k] = 0;
        }
    }

    boardWon = new Array(9);
    for(i=0; i<boardWon.length; i++)
    {
        boardWon[i] = 0;
    }

    xBigTilesWon = new Array(0);
    oBigTilesWon = new Array(0);
    xSmallTilesWon = new Array(9);
    oSmallTilesWon = new Array(9);

    for(i=0; i<xSmallTilesWon.length; i++){
        xSmallTilesWon[i] = new Array(0);
        oSmallTilesWon[i] = new Array(0);
    }
}
