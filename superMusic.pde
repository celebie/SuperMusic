import ddf.minim.*;  //import audio library
import ddf.minim.analysis.*;  //includes FFT library

Minim minim;
AudioInput in;
FFT fft;
BeatDetect beat;
PGraphics p_sun;
PGraphics p_floor;


float time=0;
float vol;  //volume level of audio
float volLeft;
float volRight;
float avgBPM=1;    //average beats per minute
int beatCount=1;
int prevBeatCount=1;
int secondChecked=0;  //the second() the beat was previously averaged on. Avoid averaging on same second

void setup(){
  size(700,700,P3D);
  p_floor = createGraphics(width, height,P3D);
  p_sun = createGraphics(width, height,P3D);
  
  
  minim = new Minim(this);
  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn();
  beat = new BeatDetect();
  fft= new FFT(in.bufferSize(),in.sampleRate());

}

void draw(){
  
  vol=in.mix.level();  //volume level of audio
  volLeft=in.left.level();
  volRight=in.right.level();
  drawFloor();
  drawSun();
  
  text(averageBPM(),14,14);
  
  if (time>4.0) time=0;
  time+=.01f;

}

float b_lerp=0;
void drawFloor(){
  float t_time=time*10;    //adjusted run time
  
  p_floor.noFill();
  p_floor.beginDraw();
  p_floor.background(0,255);
  p_floor.beginShape(TRIANGLE_STRIP);
  p_floor.translate(width/1.75,height/2,0); //translate to center of screen
  p_floor.stroke(0, 255, 0);
  p_floor.strokeWeight(3);
  p_floor.rotateZ(PI/2);
  p_floor.rotateY(-PI/2.1);


  b_lerp=lerp(b_lerp,avgBPM,.01); // beats lerped

    for (int i=-90; i<=70; i++)
      if (i%2==0)
        p_floor.vertex((i+t_time)*10,20,sin(i+t_time*b_lerp/10)*2);
      else p_floor.vertex((i+t_time)*10,75,sin(i+t_time*b_lerp/10)*2);
  
  p_floor.endShape();
  p_floor.endDraw();
  image(p_floor,0, 0);
}


void drawSun(){
  p_sun.noFill(); 
  p_sun.beginDraw();
  p_sun.background(0,0);
  p_sun.beginShape();
  
  p_sun.stroke(255, 255, 0);
  p_sun.strokeWeight(3);
  p_sun.translate(width*3/4,height*1/8); //translate to top right side of screen
  p_sun.rotateY(-PI/4);
  p_sun.rotateX(PI/1.4);
  fft.forward(in.mix);
  
 /*for (int i=0; i<fft.specSize(); i+=1)
    line(i-width/2+5,height/2,i-width/2+5,height/2-fft.getFreq(i)*2);
  */
  
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
    
    p_sun.vertex(x,y);

  }
  
  p_sun.endShape();
  p_sun.endDraw();
  image(p_sun, 0, 0);
}

float averageBPM(){

  beat.detect(in.mix);
  if ( beat.isOnset() ){
    beatCount++;
    text(second(),4*beatCount,40);
  }
    
  if (second()%3==0&&secondChecked!=second()){ //every five seconds take average
    secondChecked=second();
    avgBPM=(beatCount+prevBeatCount)/2;
    prevBeatCount=beatCount;
    beatCount=0; //reset number of beats
  }
    
  return avgBPM;
}

float r(float theta, float a, float b, float m, float n1, float n2, float n3){    //radius
   float first = pow(abs(cos(m*theta/4.0)/ a),n2);
   float second = pow(abs(sin(m*theta/4.0)/b),n3);
   
   return pow((first + second),-1.0/n1);
}