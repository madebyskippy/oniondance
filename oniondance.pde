import processing.serial.*;
import processing.video.*;
import ddf.minim.*;

Serial myPort;  // Create object from Serial class
int val;      // Data received from the serial port

// ------------------------- make this true when the arduino is connected
boolean arduino = false;
// -------------------------

Capture cam;
PImage onionpic[] = new PImage[5];

boolean onPlatform;

boolean isPaused;
int timepause;
int timepausestart;

int timestart;
int timer;

int counter;

String mode = "start"; //start, play, end

//sprites
PImage onion[] = new PImage[4];
PImage dump[] = new PImage[3];
PImage bubble;

PImage oniononion[] = new PImage[3];
PImage onionguy[] = new PImage[8];

PFont fontk;
PFont fonts;

void setup(){
  if (arduino){
    println(Serial.list());
    String portName = Serial.list()[9];
    myPort = new Serial(this, portName, 9600);
  }
  
  if (true){
    String[] cameras = Capture.list();
    
    if (cameras.length == 0) {
      println("There are no cameras available for capture.");
      exit();
    } else {
      //println("Available cameras:");
      //for (int i = 0; i < cameras.length; i++) {
      //  println(cameras[i]);
      //}
      cam = new Capture(this, cameras[0]); 
      cam.start();     
    } 
  }
  
  frameRate(60);
  
  fontk = loadFont("Kiddish-100.vlw");
  fonts = loadFont("DKSnippitySnap-150.vlw");
  textFont(fonts, 115);
  textAlign(LEFT,CENTER);
  
  for (int i=0; i<3; i++){
    onion[i] = loadImage("onion"+str(i)+".png");
  }
  onion[3] = loadImage("onion1.png");
  for (int i=0; i<oniononion.length; i++){
    oniononion[i] = loadImage("oniononion"+str(i)+".png");
  }
  for (int i=0; i<onionguy.length; i++){
    onionguy[i] = loadImage("onionguy"+str(i)+".png");
  }
  
  for (int i=0; i<onionpic.length; i++){
    onionpic[i] = loadImage("onionpic.png");
  }
  
  dump[0] = loadImage("dump3.png");
  dump[1] = loadImage("dump1.png");
  dump[2] = loadImage("dump4.png");
  bubble = loadImage("bubble.png");
  //onionpic = loadImage("onionpic.png"); //temporary
  
  //size (1600,900);
  fullScreen();
  reset();
}

void reset(){
  mode = "start";
  timer = 0;
  timestart = millis();
  counter = 1;
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
  } if (key == 'r'){
   //reset
   reset();
   }
}
void keyReleased(){
}

void platformon(){
  onPlatform = true;
  if (mode == "play"){
    isPaused = false;
    timepause += millis()-timepausestart;
    println("unpausing "+str(timepause));
  }
  if (mode == "start"){
    reset();
    mode = "play";
  }
  if (mode == "end"){
    mode = "start";
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
