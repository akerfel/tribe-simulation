int squareWidth;
int w;
int board[][];
HashMap<Integer, Integer> tribeToColor;
int newtribeNum = 0;

// Settings
boolean spawnNewTribes;
int numStartTribes;
boolean useRandomDeaths;

// Debug
boolean onlyOneTribe;

void setup() {
    size(900, 900);    
    w = 100;
    squareWidth = width/w;
    board = new int[w][w];
    tribeToColor = new HashMap<Integer, Integer>();
    noStroke();
    
    // Settings
    spawnNewTribes = true;
    numStartTribes = 0;
    useRandomDeaths = true;
    
    // Debug
    onlyOneTribe = false;
    
    createInitialBoard();
}

void createInitialBoard() {
    for (int i = 0; i < numStartTribes; i++) {
        int rand_x = int(random(0, w));
        int rand_y = int(random(0, w));
        createNewTribe(rand_x, rand_y);
    }
}

void draw() {
    updateBoard();
    drawBoard();
}

void updateBoard() {
    if (spawnNewTribes) randomNewTribes();
    randomBirths();
    if (useRandomDeaths) randomDeaths();
    randomVirus();
}

// Create new tribe (each tribe has a specific color)
void randomNewTribes() {
    double chanceNewTribe = 0.00001;
    for (int y = 0; y < w; y++) {
        for (int x = 0; x < w; x++) {
            if (random(0, 1) < chanceNewTribe) {
                if (onlyOneTribe) {
                    tribeToColor.put(1, color(0, 0, 255));
                    board[x][y] = 1;
                }
                else {
                    createNewTribe(x, y);
                }
            }
        }
    }     
}

void createNewTribe(int x, int y) {
    color randomColor = color(random(0, 255), random(0, 255), random(0, 255));
    tribeToColor.put(newtribeNum, randomColor);
    board[x][y] = newtribeNum;
    newtribeNum++;
}

// Chance of a new birth within a tribe (only happens next to tribe member)
void randomBirths() {
    double chanceBirth = 0.05;
    for (int y = 0; y < w; y++) {
        for (int x = 0; x < w; x++) {
            int tribeNum = board[x][y];
            if (tribeNum != 0) {
                if (y > 0 && random(0, 1) < chanceBirth) {
                    board[x][y-1] = tribeNum;
                }
                if (y < w - 1 && random(0, 1) < chanceBirth) {
                    board[x][y+1] = tribeNum;
                }
                if (x > 0 && random(0, 1) < chanceBirth) {
                    board[x-1][y] = tribeNum;
                }
                if (x < w - 1 && random(0, 1) < chanceBirth) {
                    board[x+1][y] = tribeNum;
                }
            }
            
        }
    }    
}

// Chance of death for all non-dead cells
void randomDeaths() {
    double chanceDeath = 0.005;
    for (int y = 0; y < w; y++) {
        for (int x = 0; x < w; x++) {
            if (board[x][y] != 0 && random(0, 1) < chanceDeath) {
                board[x][y] = 0;
            }
        }
    } 
}

void randomVirus() {
    double chanceVirus = 0.0001;
    for (int y = 0; y < w; y++) {
        for (int x = 0; x < w; x++) {
            int tribeNum = board[x][y];
            if (tribeNum != 0 && random(0, 1) < chanceVirus) {
                recursiveSpread(x, y, tribeNum);
            }
        }
    }    
}

void recursiveSpread(int x, int y, int tribeNum) {
    println("x: " + x);
    double chanceVirusDeath = random(0.4, 0.8);
    double chanceVirusSpread = random(0.3, 0.8);
    if (x < 0 || x > w - 1 || y < 0 || y > w - 1 || board[x][y] != tribeNum) {
        return;    
    }
    else if (random(0, 1) < chanceVirusDeath) {
        board[x][y] = 0;
        if (random(0, 1) < chanceVirusSpread) recursiveSpread(x+1, y, tribeNum);
        if (random(0, 1) < chanceVirusSpread) recursiveSpread(x-1, y, tribeNum);
        if (random(0, 1) < chanceVirusSpread) recursiveSpread(x, y+1, tribeNum);
        if (random(0, 1) < chanceVirusSpread) recursiveSpread(x, y-1, tribeNum);
        
        if (random(0, 1) < chanceVirusSpread) recursiveSpread(x+1, y+1, tribeNum);
        if (random(0, 1) < chanceVirusSpread) recursiveSpread(x-1, y+1, tribeNum);
        if (random(0, 1) < chanceVirusSpread) recursiveSpread(x+1, y+1, tribeNum);
        if (random(0, 1) < chanceVirusSpread) recursiveSpread(x+1, y-1, tribeNum);
        
    }
}

void drawBoard() {
    for (int y = 0; y < w; y++) {
        for (int x = 0; x < w; x++) {
            if (board[x][y] == 0) { // empty
                fill(220);
            }
            else {
                fill(tribeToColor.get(board[x][y]));
            }
            
            square(x * squareWidth, y * squareWidth, squareWidth);    
        }
    }
}
