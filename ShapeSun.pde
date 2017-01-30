
 
 
class ShapeSun extends Shapes{
  
  ShapeSun(){

  }
  
  
  public void setDrawnShape(){
    p_shape.noFill(); 
    p_shape.beginDraw();
    p_shape.background(0,255);
    p_shape.beginShape();
    
    p_shape.stroke(255, 255, 0);
    p_shape.strokeWeight(3);
    p_shape.translate(width*3/4,height*1/8); //center to drawable
    p_shape.rotateY(-PI/6);
    p_shape.rotateX(PI/1.4);
    fft.forward(in.mix);
    
   /*for (int i=0; i<fft.specSize(); i+=1)
      p_sun.line(i-width/2+5,height/2,i-width/2+5,height/2-fft.getFreq(i)*2);*/
    
    
    float rad; 
    float x; //convert to cartesian coordinates
    float y;
    /*super formula paramters: 
      m=number of corners,
      a=b=radius of shape & form of shape,
      n1=softness
      n2= corner protrusion
      n3= corner protrusion
      symetric if n3==n2 && a==b
    */
    float a,b,m,n1,n2,n3;    
    //add some vertices..
    for (float theta =0; theta<=2*PI; theta+=.01){
      a=volLeft*2+1; b=volRight*2+1; m=fft.getFreq(500); n1=1; n2=fft.getFreq(20)/50+2; n3=fft.getFreq(20)/50+2;
      rad=r(theta,a,b,m,n1,n2,n3); 
      x = rad*cos(theta) * 50; //convert to cartesian coordinates
      y= rad*sin(theta) * 50;
      
      p_shape.vertex(x,y);
  
    }
    
    p_shape.endShape();
    p_shape.endDraw();
  
  }
  
   private float r(float theta, float a, float b, float m, float n1, float n2, float n3){    //radius
   float first = pow(abs(cos(m*theta/4.0)/ a),n2);
   float second = pow(abs(sin(m*theta/4.0)/b),n3);
   
   return pow((first + second),-1.0/n1);
}
};