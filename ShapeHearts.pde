

class ShapeHearts extends Shapes{

  
  ShapeHearts(){
    pos.y=height/2;
    pos.x=(int)random(0,width);
  }
  
  
  public void setDrawnShape(){
   
    p_shape.noFill();
    p_shape.beginDraw();
    p_shape.background(0,0);
    p_shape.beginShape();
    p_shape.strokeWeight(3);
    p_shape.stroke(255,0,0);
    p_shape.translate(width/2,height/2);

    
    for (float t=0; t<=2*PI; t+=0.01){
      vPos.x=(fft.getFreq(100)*.3+.2)*18*((3*sin(t)-sin(3*t))/4);  //sin cubed identity
      vPos.y=(fft.getFreq(100)*.3+.2)*15*cos(t)-5*cos(2*t)-2*cos(3*t)-cos(4*t);
      p_shape.vertex(vPos.x,-vPos.y);
    }
    
    p_shape.endShape();
    p_shape.endDraw();
    
    if (pos.y<-height/2){
      pos.x=(int)random(width*1/8,width*7/8);
      pos.y=height/2;
    }else pos.y-=3;
  
  }
};