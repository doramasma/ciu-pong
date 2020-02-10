//import gifAnimation.*;
import processing.sound.*;

SoundFile player1, player2, rebote;
PFont font1;
PImage imageW, imageS, imageUp, imageDown;
//int counter = 0;
//GifMaker ficherogif;
int lastWinner =0;
Raqueta jugador1;
Raqueta jugador2;
int px, py;
int vx, vy;
int scoreJ1, scoreJ2;
int aux;
boolean game;
boolean [] keys = new boolean[4];
int [] speed = new int[]{-6, -4, 0, 4, 6};



void setup() {

  size(800, 400);
  font1 = loadFont("OCRAExtended-48.vlw");
  player1 = new SoundFile(this, "pong1.wav");
  player2 = new SoundFile(this, "pong2.wav");
  rebote = new SoundFile(this, "pongRebote.wav");
  imageW = loadImage("./image/w.png");
  imageS = loadImage("./image/s.png");
  imageUp = loadImage("./image/up.png");
  imageDown = loadImage("./image/down.png");
  game = false;
  //ficherogif = new GifMaker( this , "animacion.gif") ;
  //ficherogif.setRepeat(0);
  fill(128);
  stroke(255, 255, 255);
  jugador1 = new Raqueta((int)(width*0.05), height/2, 20, 40);
  jugador2 = new Raqueta((int)(width*0.92), height/2, 20, 40);
  scoreJ1 = 0;
  scoreJ2 = 0;
  setupBall();
}

void draw() {
  if (!game) {
    background(0);
    textFont(font1, 20);
    text("Jugador 1: ", width/2 - 60, 50 );
    image(imageW, width/2 - 100 , 70, 80, 50);
    image(imageS, width/2 , 70, 80, 50);
    textFont(font1, 20);
    text("Jugador 2: ", width/2 - 60, 160 );
    image(imageUp, width/2 - 100, 180, 80, 50);
    image(imageDown, width/2, 180, 80, 50);
    textFont(font1, 20);
    text("Pulsa Enter para jugar", 280, 300 );
    move();
    jugador1.drawRaqueta();
    jugador2.drawRaqueta();
  } else {

    background(0);
    printText();
    ellipse(px, py, 20, 20);
    move();
    jugador1.drawRaqueta();
    jugador2.drawRaqueta();

    processBall();
  }

}

void setupBall() {
  px = 400;
  py = 200;
  vx = 0;
  vy = 0;
  while (vx == 0) {
    aux =round(random(0, 4));
    vx = speed[aux];
    aux =round(random(0, 4));
    vy = speed[aux];
  }
}

void processBall() {
  px=px+vx;
  py = py+vy;
  if (px > 800 || px < 0) {
    if (px > 800) {
      scoreJ1++;
      lastWinner = 1;
    }
    if (px < 0) {
      scoreJ2++;
      lastWinner = 2;
    }
    ellipse(400, 200, 20, 20);
    px = 400;
    py = 200;
    if (lastWinner == 1) {
      vx = 0;
      vy = 0;
      while (vx == 0) {
        aux =round(random(0, 1));
        vx = speed[aux];
        aux =round(random(0, 4));
        vy = speed[aux];
      }
    } else if (lastWinner == 2) {
      vx = 0;
      vy = 0;
      while (vx == 0) {
        aux =round(random(3, 4));
        vx = speed[aux];
        aux =round(random(0, 4));
        vy = speed[aux];
      }
    }
    delay(500);
  }

  if (py > 400 || py < 0) {
    vy = vy*-1;
    rebote.play();
  }

  if (jugador1.jx + 20 >= px && jugador1.jx + 5 < px ) {
    if (jugador1.jy - 5 <= py && jugador1.jy + 5 >= py) {
      vx = vx*-1;
      vy = (int)random(-7, -3);
      player1.play();
    } else if (jugador1.jy + 5 < py && jugador1.jy + 35 >= py) {
      vx = vx*-1;
      player1.play();
    } else if (jugador1.jy + 35 < py && jugador1.jy + 45 >= py) {
      vx = vx*-1;
      vy = (int)random(3, 7);
      player1.play();
    }
  }

  if (jugador2.jx <= px && jugador2.jx + 10 > px) {
    if (jugador2.jy -5 <= py && jugador2.jy + 5 >= py ) {
      vx = vx*-1;
      vy = (int)random(-7, -3);
      player2.play();
    } else if (jugador2.jy + 5 < py && jugador2.jy + 35 >= py) {
      vx = vx*-1;
      player2.play();
    } else if (jugador2.jy + 35 < py && jugador2.jy + 45 >= py) {
      vx = vx*-1;
      vy = (int)random(3, 7);
      player2.play();
    }
  }
}

void printText() {
  if (scoreJ1 < 10) {
    String aux = scoreJ1 + "-" +  scoreJ2;
    textFont(font1, 40);
    text( aux, 365, 65);
  } else {
    String aux = scoreJ1 + "-" +  scoreJ2;
    textFont(font1, 40);
    text( aux, 340, 65);
  }

  // Lineas que dividen el campo
  for (int i = 0; i < height; i = i + 30) {
    strokeWeight(2);
    line(400, i, 400, i+15);
  }
}

// Tratamiento del teclado
void move() {
  if (keys[0] == true) {
    jugador1.jyUp();
  }
  if (keys[1] == true) {
    jugador1.jyDown();
  }

  if (keys[2] == true) {
    jugador2.jyUp();
  }
  if (keys[3] == true) {
    jugador2.jyDown();
  }
}

void keyPressed() {
  if (game == false) {
      if (keyCode == ENTER) {
        game = true;
        jugador1.setJy(200);
        jugador2.setJy(200);
      }
  }
    if (key == 'w' || key == 'W') keys[0] =true;
    if (key == 's' || key == 'S') keys[1] =true;
    if (key == CODED) {
      if (keyCode == UP)  keys[2] =true;
      if (keyCode == DOWN)  keys[3] =true;
    }
  
}

void keyReleased() {
  if (key == 'w' || key == 'W') keys[0] =false;
  if (key == 's' || key == 'S') keys[1] =false;
  if (key == CODED) {
    if (keyCode == UP)  keys[2] =false;
    if (keyCode == DOWN)  keys[3] =false;
  }
}
