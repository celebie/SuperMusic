class ShapeFloor extends Shapes{

  private float b_lerp;
  private float t_time;
  private float beatIntensity;
  ShapeFloor(){
    b_lerp=t_time=0;
  }
  
  
  public void setDrawnShape(){
   
    t_time=lerp(t_time,time*(2*avgBPS+2),.1);    //adjusted run time

    beatIntensity=fft.getFreq(20)*(vol+adjVol)*10;
      
    b_lerp=lerp(b_lerp,beatIntensity*10,.2); // beats value lerped/smoothed towards target beats value
    beatIntensity=lerp(beatIntensity,0,.05);  //if no beats, lower intensity
    
    p_shape.noFill();
    p_shape.beginDraw();
    p_shape.background(0,255);
    p_shape.beginShape(TRIANGLE_STRIP);
    p_shape.translate(width/1.75,height/1.7,0); //translate to center of screen
    p_shape.stroke(0, 180, 230);
    p_shape.strokeWeight(3);
    p_shape.rotateZ(PI/2);
    p_shape.rotateY(-PI/2);
    

    
      for (int i=-90; i<=70; i++)
        if (i%2==0)
          p_shape.vertex((i)*10,20+5*sin(i+t_time)*(i+91)/2,b_lerp*sin(i+t_time));
        else p_shape.vertex((i)*10,75+5*sin(i+t_time)*(i+91)/2,b_lerp*cos(i+t_time));
    p_shape.clear();
    p_shape.endShape();
    p_shape.endDraw();
  
  }
};