int timeend = 5*1000; // in milliseconds

int timedown;
int timeheld;

void startscreen(){
  background(255,240,215);
  backgroundpattern();
  textFont(fonts,130);
  fill(255);
  text("Onion Dance",500,height*4/5);
  fill(100,50,0);
  text("Onion Dance",500,height*4/5);
  image(dump[0],width/2-800,10);
  image(bubble,width/2-800+dump[0].width,50);
  textFont(fontk,50);
  text("asdflkajflkfngslk yea yea whatever onions",width/2-800+dump[0].width+100,150);
  image(onionpic[0],50,height/2-200,400,533);
  for (int i=0; i<4; i++){
    image(onionpic[i+1],500+325*i,height/2-200,300,400);
  }
  oniondraw();
}

void gamescreen(){
  background(255,240,215);
  backgroundpattern();
  
  if (!isPaused){
    timer = millis()-timestart-timepause;
  }else{
    text("paused",width/2,height/2);
  }
  
 if (cam.available() == true) {
    cam.read();
  }
  
  int h = cam.height;
  int w = (int)cam.height/4*3;
  PImage c = cam.get(cam.width/2-w/2,0,w,h);
  //image(c,0,0);
  pushMatrix();
  scale(-1.0, 1.0);
  image(c,-c.width-(width/2-c.width/2),height/2-c.height/2);
  popMatrix();
  
  image(onionguy[1],width/2-c.width/2-onionguy[1].width*6/7,height-c.height-onionguy[1].height/2);
  image(onionguy[0],width/2+c.width/2-onionguy[0].width*1/7,height-onionguy[0].height-50);
  image(dump[2],-1*dump[2].width*1/4,height-dump[2].height*3/4);
  image(dump[1],width-dump[1].width*3/4,dump[1].height*1/7);
  
  if (timer > timeend){
    onionpic[4]=onionpic[3];
    onionpic[3]=onionpic[2];
    onionpic[2]=onionpic[1];
    onionpic[1]=onionpic[0];
    onionpic[0] = c;
    saveFrame("data/"+str(year())+str(month())+str(day())+"-"+str(hour())+str(minute())+".jpg"); 
    mode = "end";
  }
  timerdraw((float)timeend);
  fill(0);
}

void endscreen(){
  background(255,240,215);
  backgroundpattern();
  text("nice onion",width/2,height/2);
  image(onionpic[0],width/2-onionpic[0].width/2,height/2-onionpic[0].height/2);
  
  int cwidth = onionpic[0].width;
  image(onionguy[2],width/2-cwidth/2-onionguy[2].width*2,height-onionguy[2].height-50);
  image(onionguy[3],width/2-cwidth/2-onionguy[3].width*1.5,height-onionguy[3].height-50);
  image(onionguy[4],width/2-cwidth/2-onionguy[4].width*0.75,height-onionguy[4].height-50);
  image(onionguy[5],width/2+cwidth/2+onionguy[5].width*-.25,height-onionguy[5].height-50);
  image(onionguy[6],width/2+cwidth/2+onionguy[6].width*0.5,height-onionguy[6].height-50);
  image(onionguy[7],width/2+cwidth/2+onionguy[7].width*1.25,height-onionguy[7].height-50);
}
