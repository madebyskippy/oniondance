int timeend = 30*1000; // in milliseconds
int timeinput = 3*1000;

int colorinterval = 5*1000;

int colornow;
int inputsize;
int paddown;

int timedown;
int timeheld;

void startscreen(){
  background(255);
  text("onion dance",width/2,height/2);
}

void gamescreen(){
  background(255);
  
  if (!isPaused){
    timer = millis()-timestart-timepause;
  }else{
    text("paused",width/2,height/2);
  }
  if (timer > colorinterval * counter || inputsize == 200){
    counter ++;
    colornow = int(random(3));
    inputsize = 0;
    timeheld = 0;
  }
  if (timer > timeend){
    mode = "end";
  }
  timerdraw((float)timeend);
  fill(0);
}

void endscreen(){
  background(255);
  text("the end",width/2,height/2);
}
