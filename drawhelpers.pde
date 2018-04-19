void timerdraw(float total){
  int size = 300;
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