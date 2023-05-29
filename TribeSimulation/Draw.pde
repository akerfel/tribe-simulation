void drawEverything() {
    drawBoard();
    drawButtons();
}

void drawBoard() {
    for (int y = 0; y < w; y++) {
        for (int x = 0; x < w; x++) {
            if (board[x][y] == 0) { // empty
                fill(220);
            } else {
                fill(tribeToColor.get(board[x][y]));
            }
            square(x * squareWidth, y * squareWidth, squareWidth);
        }
    }
}

void drawButtons() {
    textSize(buttonHeight - 8);
    textAlign(LEFT, TOP);

    // Draw background to buttons
    fill(200);
    rect(0, 0, 300, buttonHeight * buttons.size());

    // Draw buttons
    for (int y = 0; y < buttons.size(); y++) {
        Button button = buttons.get(y);
        int ypixel = y * buttonHeight;

        // Minus button
        fill(255, 0, 0);
        rect(0, ypixel, buttonHeight, buttonHeight);
        fill(0);
        text("-", 0, ypixel);

        // Plus button
        fill(0, 255, 0);
        rect(buttonHeight, ypixel, buttonHeight, buttonHeight);
        fill(0);
        text("+", buttonHeight, ypixel);

        // Probability value
        fill(0);
        double prcntValue = button.value * 100;
        String buttonValue = String.format("%,.7f", prcntValue);
        String toPrint = String.format(button.name + ": " + buttonValue);
        text(toPrint + "%", buttonHeight * 2 + 5, ypixel);
    }
}
