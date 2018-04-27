int timeend = 5*1000; // in milliseconds

int timedown;
int timeheld;

void startscreen(){
  textFont(fonts,130);
  textAlign(LEFT,CENTER);
  fill(255);
  text("Onion Dance",500,height*4/5);
  fill(100,50,0);
  text("Onion Dance",500,height*4/5);
  image(dump[0],width/2-800,10);
  image(bubble[0],width/2-800+dump[0].width,75);
  textFont(fontk,50);
  text("You have one minute to be the biggest onion you can be!\nAdd lots of onion layers! Put the skin on last!",width/2-800+dump[0].width+100,175);
  image(onionpic[0],50,height/2-200,400,533);
  for (int i=0; i<4; i++){
    image(onionpic[i+1],500+325*i,height/2-200,300,400);
  }
  oniondraw();
  borderdraw();
}

void gamescreen(){
  
  if (!isPaused){
    timer = millis()-timestart-timepause;
  }else{
    text("paused",width/2,height/2);
  }
  
  int h;
  int w;
  PImage c;
  if (camon){
    if (cam.available() == true) {
      cam.read();
    }
    h = cam.height;
    w = (int)cam.height/4*3;
    c = cam.get(cam.width/2-w/2,0,w,h);
  }else{
    h = 800;
    w = 600;
    c = loadImage("onionpic.png");
  }
  
  //image(c,0,0);
  pushMatrix();
  scale(-1.0, 1.0);
  image(c,-c.width-(width/2-c.width/2),height/2-c.height/2);
  popMatrix();
  
  textAlign(CENTER,CENTER);
  textFont(fonts,40);
  fill(100,50,0);
  image(onionguy[1],width/2-c.width/2-onionguy[1].width*6/7,height-c.height-onionguy[1].height/3);
  image(onionguy[0],width/2+c.width/2-onionguy[0].width*1/7,height-onionguy[0].height-50);
  image(dump[2],-1*dump[2].width*1/4,height-dump[2].height*3/4);
  image(bubble[2],dump[2].width*3/5,height-dump[2].height*3/4);
  text("Be a",dump[2].width*3/5+bubble[2].width/2,height-dump[2].height*3/4+bubble[2].height/2-65);
  textSize(60);
  text("BIG",dump[2].width*3/5+bubble[2].width/2,height-dump[2].height*3/4+bubble[2].height/2-27);
  textSize(40);
  text("onion!",dump[2].width*3/5+bubble[2].width/2,height-dump[2].height*3/4+bubble[2].height/2+10);
  image(dump[1],width-dump[1].width*3/4,dump[1].height*1/7);
  image(bubble[3],width-dump[1].width*3/4-bubble[3].width,dump[1].height*1/7);
  textLeading(40);
  text("put the\nskin on\nlast!",width-dump[1].width*3/4-bubble[3].width*4/7,dump[1].height*1/7+bubble[3].height/2);
  
  if (timer > timeend){
    onionpic[4]=onionpic[3];
    onionpic[3]=onionpic[2];
    onionpic[2]=onionpic[1];
    onionpic[1]=onionpic[0];
    onionpic[0] = c;
    saveFrame("data/"+str(year())+str(month())+str(day())+"-"+str(hour())+str(minute())+".jpg"); 
    mode = "end";
  }
  borderdraw();
  timerdraw((float)timeend);
  fill(0);
}

void endscreen(){
  textFont(fonts,75);
  fill(100,50,0);
  textAlign(CENTER,CENTER);
  text("Hm...",width/5,height/5);
  text("yea...",width/5,height/5+75);
  text("nice...",width/5,height/5+200);
  text("Nice onion.",width*5/6,height/3);
  image(onionpic[0],width/2-onionpic[0].width/2,height/2-onionpic[0].height/2);
  
  int cwidth = onionpic[0].width;
  image(onionguy[2],width/2-cwidth/2-onionguy[2].width*2,height-onionguy[2].height-100);
  image(onionguy[3],width/2-cwidth/2-onionguy[3].width*1.5,height-onionguy[3].height-100);
  image(onionguy[4],width/2-cwidth/2-onionguy[4].width*0.75,height-onionguy[4].height-100);
  image(onionguy[5],width/2+cwidth/2+onionguy[5].width*-.25,height-onionguy[5].height-100);
  image(onionguy[6],width/2+cwidth/2+onionguy[6].width*0.5,height-onionguy[6].height-100);
  image(onionguy[7],width/2+cwidth/2+onionguy[7].width*1.25,height-onionguy[7].height-100);
  borderdraw();
}
