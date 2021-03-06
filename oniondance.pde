import processing.serial.*;
import processing.video.*;
import ddf.minim.*;

Serial myPort;  // Create object from Serial class
int val;      // Data received from the serial port

// ------------------------- make this true when the arduino is connected
boolean arduino = false;
// ------------------------- for debugging cus opening webcam takes forever
boolean camon = false;
// -------------------------
boolean istweeting = false;
// -------------------------

Minim minim;
AudioPlayer ding_noise, beep_noise;
int beepPlayed;

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
PImage bubble[] = new PImage[5];

PImage oniononion[] = new PImage[3];
PImage onionguy[] = new PImage[8];

PImage pictureframe;

PFont fontk;
PFont fonts;

void setup(){
  if (arduino){
    println(Serial.list());
    String portName = Serial.list()[9];
    myPort = new Serial(this, portName, 9600);
  }
  
  if (camon){
    String[] cameras = Capture.list();
    
    if (cameras.length == 0) {
      println("There are no cameras available for capture.");
      exit();
    } else {
      println("Available cameras:");
      for (int i = 0; i < cameras.length; i++) {
        println(cameras[i]);
      }
      cam = new Capture(this, cameras[0]);//15]); 
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
  
  onionpic[0] = loadImage("pix/onionpic9.jpg");
  onionpic[1] = loadImage("pix/onionpic8.jpg");
  onionpic[2] = loadImage("pix/onionpic7.jpg");
  onionpic[3] = loadImage("pix/onionpic6.jpg");
  onionpic[4] = loadImage("pix/onionpic5.jpg");
 
  dump[0] = loadImage("dump3.png");
  dump[1] = loadImage("dump1.png");
  dump[2] = loadImage("dump4.png");
  
  for (int i=0; i<bubble.length; i++){
    bubble[i] = loadImage("bubble"+str(i)+".png");
  }
  
  pictureframe = loadImage("photoframe.png");
  
  if (istweeting){
    //setupTwitterer();
  }
  
  minim = new Minim(this);
  ding_noise = minim.loadFile("sound-beepclean-up.wav");
  beep_noise = minim.loadFile("sound-beepclean.wav");
  
  frameRate(30);
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
  beepPlayed = 0;
  fill(0);
  timejump = 0;
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
  
  background(255,240,215);
  backgroundpattern();
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
  
  if (istweeting){
    //checkTwitterer();
  }
}

void keyPressed() {
  if (key == ' ') {
    if (!onPlatform){
      platformon();
    }
  } if (key == 'r'){
   //reset
   reset();
   }
}
void keyReleased(){
  if (key == ' ') {
    if (onPlatform){
      platformoff();
    }
  }
}

void platformon(){
  onPlatform = true;
  //if (mode == "play"){
  //  isPaused = false;
  //  timepause += millis()-timepausestart;
  //  println("unpausing "+str(timepause));
  //}
  if (mode == "start"){
    reset();
    mode = "play";
  }
  if (mode == "play"){
    if (timer > (timeend/2)){
      timejump = timeend - timer -3500;
    }
  }
  if (mode == "end"){
    mode = "start";
  }
}

void platformoff(){
  onPlatform = false;
  //if (mode == "play"){
  //  println("pausing");
  //  isPaused = true;
  //  timepausestart = millis();
  //}
}
