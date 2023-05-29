// In this file, all global variables and declared and initialized,
// and the draw() method is defined, which is called 60 times per second.

// Game board
int squareWidth;
int w;
int board[][];
HashMap<Integer, Integer> tribeToColor;
int newTribeNum = 0;

// General settings
boolean useRandomDeaths;
boolean spawnNewTribes;
int numStartTribes;
int buttonHeight;
boolean paused;

// Virus probabilities
double chanceVirusDeath;
double chanceVirusSpread;

// ChangeValueButton objects
ArrayList<Button> buttons;

// Debug
boolean onlyOneTribe;

void setup() {
    size(1600, 1200);
    w = 500;
    squareWidth = width/w;
    board = new int[w][w];
    tribeToColor = new HashMap<Integer, Integer>();
    noStroke();
    paused = false;

    // General settings
    useRandomDeaths = true;
    spawnNewTribes = true;
    numStartTribes = 8;
    buttonHeight = 25; // also decides font size

    // Virus probabilities
    chanceVirusDeath = random(0.4, 0.8);
    chanceVirusSpread = random(0.3, 0.8);

    // ChangeValueButton objects
    buttons = new ArrayList<Button>();
    buttons.add(new Button("chanceBirth", 0.25));
    buttons.add(new Button("chanceDeath", 0.005));
    buttons.add(new Button("chanceNewTribe", 0.00001));
    buttons.add(new Button("chanceVirus", 0.0001));

    // Debug
    onlyOneTribe = false;

    createInitialBoard();
}

// This function is called 60 times per second.
void draw() {
    updateButtonValues();
    if (!paused) {
        updateBoard();
    }
    drawEverything();
}
