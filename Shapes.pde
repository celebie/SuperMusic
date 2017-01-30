
private class VertexPos{    //position of vertex that will draw shape
  float x;
  float y;
  float z;
}
private class Pos{    //position of overall shape in screen
  float x; 
  float y; 
  float z; 
}
class Shapes{
  
  protected VertexPos vPos = new VertexPos();
  protected Pos pos = new Pos();
  protected PGraphics p_shape;

  Shapes(){
    pos.x=0;
    pos.y=0;
    pos.z=0;
    
  }
  
  public Pos getPos(){
   return pos; 
  }
  public void InitGraphics(PGraphics p){
    p_shape= p;
  }

  public PGraphics getDrawnShape(){
    return p_shape; 
  }
  
  
};