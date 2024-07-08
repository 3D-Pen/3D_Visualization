/**
* game.pde
*/

import processing.serial.*;
Serial serial;
String serialPort = "COM3";
int serialData = 0; 

boolean isSerialDisabled = true;

class Player {
    PImage image;
    final int Size = 30;
    final int PositionX = 30;
    
    int positionY = 0;
    
    void draw() {
        if (isSerialDisabled) {
            positionY = mouseY;
        } else {
            positionY = 370 - (int)serialData;
        }
        image(image, PositionX, positionY, Size, Size);
    };
}

class Enemy {
    final int Width = 30;
    final int Gap = 75;
    
    int positionX;
    int positionY;
    
    void draw() {
        fill(255, 255, 0);
        noStroke();
        rect(positionX, 0, Width, positionY);
        rect(positionX, positionY + Gap, Width, 200);
    };
    
    void updatePosition() {
        positionX -= 10;
        if (positionX < 0) {
            positionX = 600;
            positionY = int(150 + 25 * random(8));
        }
    };
}

class Graphic {
    PImage background;
    final int WindowWidth = 600;
    final int WindowHeight = 400;
    
    final int MessageColor = color(255, 0, 0);
    final int MessageSize = 24;
    
    void message(String str) {
        textAlign(CENTER);
        fill(MessageColor);
        textSize(MessageSize);
        
        text(str, WindowWidth / 2, 200);
    };
    
    void message(String str, int value) {
        textAlign(CENTER);
        fill(MessageColor);
        textSize(MessageSize);
        
        text(str, WindowWidth / 2, 200);
        text(value, WindowWidth / 2 , 230);
    };
}

class Game {
    int score = 0;
    final int MaxScore = 99;
    
    int startTime = 0;
    
    boolean onPlaying = false;
    boolean isFirstPlay = true;
    
    Player player = new Player();
    Enemy enemy = new Enemy();
    
    boolean isPlayerHit() {
        if (player.PositionX < enemy.positionX + enemy.Width && player.PositionX + player.Size > enemy.positionX) {
            if (player.positionY < enemy.positionY) {
                return true;  
            }

            if (player.positionY + player.Size > enemy.positionY + enemy.Gap) {
                return true;  
            }
        }
        
        return false;
    };
    
    void waitForNewGame() {
        onPlaying = false;
        enemy.positionX = 600;
        enemy.positionY = 325;
        
        if (!isSerialDisabled) {
            serial.write(game.score);
        }
    };
    
    void updateScore() {
        score = ((millis() - startTime) / 1000);
    }
}

Game game = new Game();
Graphic graphic = new Graphic();

public void serialEvent(Serial p) {
    if (!isSerialDisabled) {
        serialData = p.read();
        
        if (serialData == 255) {
            game.isFirstPlay = false;
            game.onPlaying = true;
            game.startTime = millis();
        }
    }
}

public void mousePressed() {
    if (isSerialDisabled) {
        game.isFirstPlay = false;
        game.onPlaying = true;
        game.startTime = millis();
    }
}

public void settings() {
    size(graphic.WindowWidth, graphic.WindowHeight);
    
    game.player.image = loadImage("data/cat.jpg");
    game.player.image.resize(game.player.Size,game.player.Size);
    
    graphic.background = loadImage("data/home.jpg");
    graphic.background.resize(graphic.WindowWidth, graphic.WindowHeight);
    
    if (!isSerialDisabled) {
        serial = new Serial(this, serialPort, 9600); // シリアルポートの設定
    }
    
    game.waitForNewGame();
}

public void draw() {
    if (game.isFirstPlay) {
        background(graphic.background);
        graphic.message("Press the button to start!");
        return;
    }
    
    if (!game.onPlaying) {
        return;
    }
    
    background(graphic.background);
    
    game.player.draw();
    
    game.enemy.updatePosition();
    game.enemy.draw();
    
    game.updateScore();
    
    if (game.isPlayerHit()) {
        graphic.message("Game Over!", game.score);
        game.waitForNewGame();
    }
    
    if (game.score >= game.MaxScore) {
        graphic.message("Game Finished!", game.score);
        game.waitForNewGame();
    }
}