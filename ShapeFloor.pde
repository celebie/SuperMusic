class ShapeFloor extends Shapes{

  private float b_lerp=0;
  
  ShapeFloor(){

  }
  
  
  public void setDrawnShape(){
   
    float t_time=time*10;    //adjusted run time
    
    p_shape.noFill();
    p_shape.beginDraw();
    p_shape.background(0,255);
    p_shape.beginShape(TRIANGLE_STRIP);
    p_shape.translate(width/1.75,height/2,0); //translate to center of screen
    p_shape.stroke(0, 255, 0);
    p_shape.strokeWeight(3);
    p_shape.rotateZ(PI/2);
    p_shape.rotateY(-PI/2.1);
  
  
    b_lerp=lerp(b_lerp,avgBPM,.01); // beats value lerped/smoothed towards target beats value
  
      for (int i=-90; i<=70; i++)
        if (i%2==0)
          p_shape.vertex((i+t_time)*10,20,sin(i+t_time)*2+sin(i+b_lerp*10));
        else p_shape.vertex((i+t_time)*10,75,sin(i+t_time)*2+sin(i+b_lerp*10));
    p_shape.clear();
    p_shape.endShape();
    p_shape.endDraw();
  
  }
};