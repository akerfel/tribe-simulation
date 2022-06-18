void keyPressed() {
    if (key == ' ') {
        paused = !paused;    
    }
    
    if (key == 'x') {
        boolean wasPaused = paused;
        paused = false;
        killAll();  
        draw();
        paused = wasPaused;
    }
}

void mousePressed() {
    for (int y = 0; y < buttons.size(); y++) {
        Button button = buttons.get(y);
        
        if (mouseY >= y * buttonHeight && mouseY <= (y + 1) * buttonHeight) {
            if (mouseX >= 0 && mouseX <= buttonHeight) {
                if (mouseButton == LEFT) button.isDecreasing = true;
                if (mouseButton == RIGHT) button.isDecreasingFast = true;
            }
            if (mouseX >= buttonHeight && mouseX <= 2 * buttonHeight) {
                if (mouseButton == LEFT) button.isIncreasing = true;
                if (mouseButton == RIGHT) button.isIncreasingFast = true;
            }
        }
        if (button.value < 0) button.value = 0;
        if (button.value > 100) button.value = 100;
        button.updateValue();
    }
    drawButtons();
}

void mouseReleased() {
    for (Button button : buttons) {
        button.isDecreasing = false;
        button.isDecreasingFast = false;
        button.isIncreasing = false;
        button.isIncreasingFast = false;
    }
    drawButtons();
}
