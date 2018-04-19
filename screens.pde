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
  
  text("step on this color!!!",width/2,height*5/6);
  
  noStroke();
  fill(colors[colornow*3],colors[colornow*3+1],colors[colornow*3+2]);
  ellipse(width/2,height/2,200,200); //x,y,w,h
  fill(255);
  ellipse(width/2,height/2,inputsize,inputsize); //x,y,w,h
  
  fill(0);
  for (int i=0; i<counter; i++){
    ellipse(25*2*i+15,height-50,25,25);
  }
  
  if (paddown==colornow){
    timeheld = millis()-timedown;
  }
  inputsize = (int)(200 * ((float)(timeheld)/(float)timeinput));
  
  timer = millis()-timestart;
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