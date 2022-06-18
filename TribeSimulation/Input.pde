void keyPressed() {
    if (key == ' ') {
        killAll();    
    }
}

void mousePressed() {
    for (int y = 0; y < buttons.size(); y++) {
        Button button = buttons.get(y);
        
        if (mouseY >= y * buttonHeight && mouseY <= (y + 1) * buttonHeight) {
            if (mouseX >= 0 && mouseX <= buttonHeight) {
                if (mouseButton == LEFT) button.value -= 0.01;
                if (mouseButton == RIGHT) button.value -= 0.05;
            }
            if (mouseX >= buttonHeight && mouseX <= 2 * buttonHeight) {
                if (mouseButton == LEFT) button.value += 0.01;
                if (mouseButton == RIGHT) button.value += 0.05;
            }
        }
        if (button.value < 0) button.value = 0;
        if (button.value > 100) button.value = 100;
    }
}
