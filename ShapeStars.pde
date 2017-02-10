

class ShapeStars extends Shapes{

  
  ShapeStars(){
    pos.y=height/2;
    pos.x=width/2;
  }
  
  
  public void setDrawnShape(){
   
    p_shape.noFill();
    p_shape.beginDraw();
    p_shape.background(0,0);
    p_shape.beginShape();
    p_shape.strokeWeight(3);
    p_shape.stroke(255,255,255);
    p_shape.translate(width/2,height/2);
    p_shape.rotateX(PI/4);
    p_shape.rotateY(PI/4);
    p_shape.vertex(0,0,6);
    p_shape.vertex(0,0,15);
    p_shape.vertex(0,0,25);
    
    p_shape.endShape();
    p_shape.endDraw();
    

  
  }
};