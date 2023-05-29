void updateBoard() {
    for (int y = 0; y < w; y++) {
        for (int x = 0; x < w; x++) {
            maybeNewTribe(x, y);
            maybeBirth(x, y);
            maybeDeath(x, y);
            maybeVirus(x, y);
        }
    }
}

void updateButtonValues() {
    for (Button button : buttons) {
        button.updateValue();
    }
}

void createInitialBoard() {
    for (int i = 0; i < numStartTribes; i++) {
        int rand_x = int(random(0, w));
        int rand_y = int(random(0, w));
        createNewTribe(rand_x, rand_y);
    }
}

// Maybe creates new tribe (each tribe has a specific color)
void maybeNewTribe(int x, int y) {
    double chanceNewTribe = getValue("chanceNewTribe");

    if (spawnNewTribes) {
        if (random(0, 1) < chanceNewTribe) {
            if (onlyOneTribe) {
                tribeToColor.put(1, color(0, 0, 255));
                board[x][y] = 1;
            } else {
                createNewTribe(x, y);
            }
        }
    }
}

// Creates new tribe at (x, y)
void createNewTribe(int x, int y) {
    color randomColor = color(random(0, 255), random(0, 255), random(0, 255));
    tribeToColor.put(newTribeNum, randomColor);
    board[x][y] = newTribeNum;
    newTribeNum++;
}

// Maybe gives birth next to cell (x, y), if that cell is alive.
void maybeBirth(int x, int y) {
    int tribeNum = board[x][y];
    if (tribeNum != 0) {
        double chanceBirth = getValue("chanceBirth");
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

// Chance of death
void maybeDeath(int x, int y) {
    double chanceDeath = getValue("chanceDeath");
    if (useRandomDeaths) {
        if (board[x][y] != 0 && random(0, 1) < chanceDeath) {
            board[x][y] = 0;
        }
    }
}

void maybeVirus(int x, int y) {
    double chanceVirus = getValue("chanceVirus");
    int tribeNum = board[x][y];
    if (tribeNum != 0 && random(0, 1) < chanceVirus) {
        recursiveSpread(x, y, tribeNum);
    }
}

void recursiveSpread(int x, int y, int tribeNum) {
    if (x < 0 || x > w - 1 || y < 0 || y > w - 1 || board[x][y] != tribeNum) {
        return;
    } else if (random(0, 1) < chanceVirusDeath) {
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

void killAll() {
    for (int y = 0; y < w; y++) {
        for (int x = 0; x < w; x++) {
            board[x][y] = 0;
        }
    }
}

public double getValue(String name) {
    for (Button button : buttons) {
        if (button.name.equals(name)) {
            return button.value;
        }
    }
    return -1;
}
