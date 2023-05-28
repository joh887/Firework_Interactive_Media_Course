class FireLight{
  PImage img = null;
  
  FireLight(PImage setimg){
    img = setimg;
    img.loadPixels();
  }
  
  void drawLight(int cx, int cy, int radius){
    if(img==null) return;
    int minx = cx-radius;
    int maxx = cx+radius;
    int miny = cy-radius;
    int maxy = cy+radius;
    if(minx < 1) minx = 1;
    if(maxx >= img.width) maxx = img.width;
    if(miny < 1) miny = 1;
    if(maxy >= img.height) maxy = img.height;
    for(int y=miny; y<maxy; y++){
      for(int x=minx; x<maxx; x++){
        if(isInCircle(x, y, cx, cy, radius)){
          color c = img.pixels[x+y*img.width];
          float dist = dist(x,y,cx,cy);
          float bright = (radius-dist) / radius * 1.5;  
          float r = constrain(red(c) * bright, 0, 255);
          float g = constrain(green(c) * bright, 0, 255);
          float b = constrain(blue(c) * bright, 0, 255);
          set(x, y, color(r,g,b));
        }
      }
    }
  }
  
  boolean isInCircle(int x, int y, int cx, int cy, int radius){
    if((x-cx) * (x-cx) + (y-cy) * (y-cy)  < radius * radius) return true;
    return false;
  }
}

// for saving fire time and position
class FireLocTime{
  int x, y, fire_time;
  float hu;
  boolean flag;   
  FireLocTime(float hue){
    x = mouseX;
    y = mouseY;
    hu = hue;
    fire_time = millis();
    flag = false;
  }
}

// handling FireLocTime arrays for saving and replaying
class ReplayFire{
  int start_milli_time;
  int restart_milli_time;
  ArrayList<FireLocTime> fireloctime = new ArrayList<FireLocTime>();
  boolean flag_replay_end;
  void startRecord(){
    start_milli_time = millis();
    flag_replay_end = false;
    for(int i=0; i<fireloctime.size(); i++){
      fireloctime.remove(i);
    }
  }

  void addFireLocTime(float hue){
    fireloctime.add(new FireLocTime(hue));  
  }
 
  void startReplay(){
    restart_milli_time = millis();
    for(int i=0; i<fireloctime.size(); i++){
      fireloctime.get(i).flag = false;
    }
    flag_replay_end = false;
  }
  
  boolean isTimeToFire(){
    flag_replay_end = true;
    for(int i=0; i<fireloctime.size(); i++){
      if(fireloctime.get(i).flag==false){
        flag_replay_end = false;
        if(millis() - restart_milli_time > fireloctime.get(i).fire_time - start_milli_time){
          return true;
        }
      }
    }
    return false;
  }
  
  FireLocTime getNextFireLocTime(){
    for(int i=0; i<fireloctime.size(); i++){
      if(fireloctime.get(i).flag == false){
        fireloctime.get(i).flag = true;
        return fireloctime.get(i);
      }
    }
    return null;
  }
  
  boolean isReplayedAll(){
    return flag_replay_end;
  }
}
