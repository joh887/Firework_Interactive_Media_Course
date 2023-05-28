

class Firework {

  ArrayList<Particle> particles;    // An arraylist for all the particles
  Particle firework;
  float hu;
  FireSound fs = new FireSound();
  FireLight fl=null;

  // x,y : explosion position(mouse position)
  // setfl : make possible to access the background image 
  Firework(FireLight setfl, int x, int y, float hue) {
    //hu = random(255);
    hu = hue;
    float t = sqrt((height - y) * 2 * 0.2);   // time = sqrt(2*distance/acc)
    float vel = t * -0.2 * 5;    // velocity = time * acc
    print("dist:" + (height - y) + " time:" + t + " vel:" + vel + "\r\n");
    firework = new Particle(x, height, hu, vel);
    particles = new ArrayList<Particle>();   // Initialize the arraylist
    fl = setfl;
  }
  
  boolean done() {
    if (firework == null && particles.isEmpty()) {
      return true;
    } else {
      return false;
    }
  }

  void run() {

    // apply light first
    if(firework != null){
      int x = (int)firework.location.x;
      int y = (int)firework.location.y;
      fl.drawLight(x, y, 50);
    }
    
    if(particles.size() > 1){
      float minx = img.width;
      float maxx = 0;
      float miny = img.height;
      float maxy = 0;
      for(int i=0; i<particles.size(); i++)
      {
        float x = particles.get(i).location.x;
        float y = particles.get(i).location.y;
        if(x < minx) minx = x;
        if(x > maxx) maxx = x;
        if(y < miny) miny = y;
        if(y > maxy) maxy = y;
      }
      float dia = abs(maxx-minx);
      if(dia < abs(maxy-miny)) dia = abs(maxy-miny);
      fl.drawLight((int)((maxx+minx)/2), (int)((maxy+miny)/2), (int)(dia/2));
    }

    if (firework != null) {
      fill(hu,255,255);
      firework.applyForce(gravity);
      firework.update();
      firework.display();

      if (firework.explode()) {
        //pop sound
        fs.soundPop();
        for (int i = 0; i < 100; i++) {
          particles.add(new Particle(firework.location, hu));    // Add "num" amount of particles to the arraylist
          
        }
        firework = null;
      }
    }

    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.applyForce(gravity);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
    
  }


  // A method to test if the particle system still has particles
  boolean dead() {
    if (particles.isEmpty()) {
      return true;
    } else {
      return false;
    }
  }
}
