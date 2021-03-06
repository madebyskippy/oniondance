void timerdraw(float total){
  int size = 500;
  float x=width/2;
  float y=0;
  
  noStroke();
  fill(255);
  arc(x,y,size,size,0,PI,OPEN);
  
  float left = (float)timer/total;
  if (left > 0.9f){
    fill(255,150,150);
  }else if (left > 0.7f){
    fill(255,222,50);
  }else{
    fill(175);
  }
  arc (x,y, size,size,0,left*PI);
  
  noFill();
  stroke(0);
  strokeWeight(5);
  arc(x,y,size,size,0,PI,OPEN);
  
  float angle = TWO_PI/20;
  stroke(0);
  for (int i=0; i<11; i++){
    //circumference...
    line(size/2*sin(angle*i-PI/2)+x,size/2*cos(angle*i-PI/2)+y,
        size/2*0.9f*sin(angle*i-PI/2)+x,size/2*0.9f*cos(angle*i-PI/2)+y);
  }
}

int frametime = (int)(1000/6);
int frametimer=millis();
int frame=0;

void oniondraw(){
  if (millis()-frametimer > frametime){
    frametimer = millis();
    frame = (frame+1)%4;
  }
  
  image(onion[frame],width-onion[0].width*1.1,height-onion[0].height*1.15);
}

float bcounter = 0;
float change = 0.5;
void backgroundpattern(){
  int size = 30;
  color c = color(150,100,0,50);
  fill(c);
  noStroke();
  float x,y;
  
  if (bcounter > 10) bcounter = 0;
  bcounter += change;
  for (int i=0; i<21; i++){
    for (int j=0; j<21; j++){
      x = 5+size/2+(size*1.5*(j%2))+size*i*3 - size;
      y = height-size*1.5-size*j*3;
      ellipse(x+bcounter*(size*1.5)/10,y+bcounter*(size*3/10),size,size);
    }
  }
}

void borderdraw(){
  noStroke();
  int size = 100;
  scallopdraw(color(210,151,73),255,size*1.1);
  scallopdraw(color(255),255,size);
  scallopdraw(color(234,213,174),255,size*0.8);
  scallopdraw(color(255),255,size*0.7);
  scallopdraw(color(210,151,73),255,size*0.3);
  scallopdraw(color(255),255,size*0.2);
}

void scallopdraw(color c, int a, float s){
  for (int i=0; i<25; i++){
    fill(c,a);
    ellipse(width/24*i,0,s*0.75,s*0.75);
    ellipse(width/24*i,height,s,s);
    //ellipse(0,width/24*i,s,s);
    //ellipse(width,width/24*i,s,s);
  }
}
