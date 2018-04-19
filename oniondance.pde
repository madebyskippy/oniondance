import processing.serial.*;
import ddf.minim.*;

Serial myPort;  // Create object from Serial class
int val;      // Data received from the serial port

// ------------------------- make this true when the arduino is connected
boolean arduino = false;
// -------------------------

int timestart;
int timer;

int[] colors = {150,0,0,    0,150,0,    0,0,150};

int counter;

String mode = "start"; //start, play, end

void setup(){
  if (arduino){
    println(Serial.list());
    String portName = Serial.list()[9];
    myPort = new Serial(this, portName, 9600);
  }
  
  frameRate(60);
  
  PFont font;
  font = loadFont("Kiddish-48.vlw");
  textFont(font, 30);
  textAlign(CENTER,CENTER);
  
  size (900,600);
  reset();
}

void reset(){
  mode = "start";
  timer = 0;
  timestart = millis();
  counter = 1;
  colornow = int(random(3));
  inputsize = 0;
  paddown = -1;
  timeheld = 0;
  fill(0);
}

void draw(){
  if (arduino){
    if ( myPort.available() > 0) {  // If data is available,
      val = myPort.read();         // read it and store it in val
      switch(val){
        case 0:
          platformon();
          break;
        case 1:
          platformoff();
          break;
      }
      println(val);
    }
  }
  
  if (mode=="start"){
    //intro game and show instructions
    startscreen();
  }else if (mode == "play"){
    //gameplay!
    gamescreen();
  }else if (mode == "end"){
    //results
    endscreen();
  }
}

void keyPressed() {
  if (key == ' ') {
    if (onPlatform){
      platformoff();
    }else{
      platformon();
    }
  }
  } if (key == 'r'){
   //reset
   reset();
   }
}
void keyReleased(){
  if (key == 'a' || key == 'A'){
    offPad(0);
  }if (key == 'g' || key == 'G'){
    offPad(1);
  }if (key == 'l' || key == 'L'){
    offPad(2);
  }
}

void platformon(){
  onPlatform = true;
  if (mode == "play"){
    isPaused = false;
    timepause += millis()-timepausestart;
    println("unpausing "+str(timepause));
  }
  if (mode == "start" || mode == "end"){
    mode = "play";
  }
}

void platformoff(){
  onPlatform = false;
  if (mode == "play"){
    println("pausing");
    isPaused = true;
    timepausestart = millis();
  }
}
