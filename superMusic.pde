/* Javier Gonzalez
 * A different take on the music visualizer
 * Walk through an adventures created by your musci
 /////////////README///////////////////
 Make sure your soundcard is set as your microphone
*/




import ddf.minim.*;  //import audio library
import ddf.minim.analysis.*;  //includes FFT library

Minim minim;
AudioInput in;
FFT fft;
BeatDetect beat;

  
ShapeHearts hearts = new ShapeHearts();
ShapeFloor floor=new ShapeFloor();
ShapeSun sun= new ShapeSun();

float time=0;
float vol;  //volume level of audio
float volLeft;
float volRight;
float avgBPM=1;    //average beats per minute
int beatCount=1;
int prevBeatCount=1;
int secondChecked=0;  //the second() the beat was previously averaged on. Avoid averaging on same second
float kickSize, snareSize, hatSize;


void setup(){
  size(700,700,P3D);
  PGraphics p_graphics = createGraphics(width,height,P3D);
  hearts.InitGraphics(p_graphics);
  floor.InitGraphics(p_graphics);
  sun.InitGraphics(p_graphics);
  
  minim = new Minim(this);
  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn();
  beat = new BeatDetect();
  fft= new FFT(in.bufferSize(),in.sampleRate());
  textFont(createFont("Helvetica", 16));
}

void draw(){
  
  vol=in.mix.level();  //volume level of audio
  volLeft=in.left.level();
  volRight=in.right.level();
  drawSun();
  drawHearts();
  drawFloor();

  text(averageBPM(),14,14);
  
  if (time>5.0) 
    time=0;
  time+=.01f;
  delay(10);
}

void drawFloor(){
  floor.setDrawnShape();
  image(floor.getDrawnShape(),floor.getPos().x, floor.getPos().y);;}


void drawHearts(){
  hearts.setDrawnShape();
  image(hearts.getDrawnShape(),hearts.getPos().x,hearts.getPos().y);
}


void drawSun(){
  sun.setDrawnShape();
  image(sun.getDrawnShape(), sun.getPos().x,sun.getPos().y);
}

float averageBPM(){

  beat.detect(in.mix);
  if ( beat.isOnset() || beat.isKick() || beat.isHat()){
    beatCount++;
    text(second(),4*beatCount,40);
  }
    
  if (second()%2==0&&secondChecked!=second()){ //every five seconds take average
    secondChecked=second();
    avgBPM=(beatCount+prevBeatCount)/2;
    prevBeatCount=beatCount;
    beatCount=0; //reset number of beats
  }
    
  return avgBPM;
}