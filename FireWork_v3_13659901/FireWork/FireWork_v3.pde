//Refined algorithm from; https://www.youtube.com/watch?v=CKeyIbT3vXI

import beads.*;

ArrayList<Firework> fireworks;
PVector gravity = new PVector(0, 0.2);
boolean flagFire = false;
boolean flagStart = false;
FireSound fs = new FireSound();
FireLight fl;
PImage img;
ReplayFire rf = new ReplayFire();
int replay_count = 1;
int mode = 0;
float hue = 100;

void setup() {
  img = loadImage("home.jpg");
  fl = new FireLight(img);
  size(478, 359, P2D);
  fireworks = new ArrayList<Firework>();
  colorMode(HSB);
  background(img);
  textSize(15);
}

void draw() {
  if(mode == 2){
    if(rf.isReplayedAll()){
      rf.startReplay();
      replay_count++;
    }
    // start bia memory
    if(rf.isTimeToFire()){
      FireLocTime replay_flt= rf.getNextFireLocTime();
      hue = replay_flt.hu;
      fireworks.add(new Firework(fl, replay_flt.x, replay_flt.y, replay_flt.hu));
      fs.soundPeew();
    }
  }
  else{
    // start bia mouse click
    if(flagFire){
      fireworks.add(new Firework(fl, mouseX, mouseY, hue));
      flagFire = false;
    }
  }
  
  fill(1, 20);
  noStroke();
  rect(0,0,width,height);
  //background(255, 20);

  
  for (int i = fireworks.size()-1; i >= 0; i--) {
    Firework f = fireworks.get(i);
    f.run();
    if (f.done()) {
      fireworks.remove(i);
    }
  }
  
  
  if(mode == 1) text("Recording", 30, 30);
  else if(mode == 2) text("Replaying"+replay_count, 30, 30);
  else text("Idle", 30, 30);
  text("Hue: "+hue, 30, 50);
  //fl.drawLight(mouseX, mouseY, 100);
}

void mouseClicked()
{
  if(mode == 1){
    rf.addFireLocTime(hue);
  }
  flagFire = true;
  fs.soundPeew();
  flagStart = !flagStart;
}

void keyPressed(){
  if(key == '1' && mode == 0){
    mode = 1;
    rf.startRecord();
  }
  if(key == '2' && mode == 1){
    mode = 2;
    rf.startReplay();;
  }
  if(key == '3') mode = 0;
  if(key == '0'){
    hue +=5;
    if(hue>255) hue = 255;
  }
  if(key == '9'){
    hue -=5;
    if(hue<0) hue = 0;
  }
}
