class FireSound{
  SamplePlayer sp;

  void soundPeew(){
    AudioContext ac = new AudioContext();
    Glide gainGlide = new Glide(ac, 1, 50);
    try {
      sp = new SamplePlayer(ac, new Sample(sketchPath("")+"Peew_sound.wav"));
    }
    catch(Exception e)
    {
      println("Exception while attempting to load sample!");
      e.printStackTrace(); 
      exit(); 
    }
    finally{
      sp.setKillOnEnd(true);
      Gain g = new Gain(ac, 1, gainGlide);
      g.addInput(sp);
      ac.out.addInput(g);
      ac.start();
    }
  }

  void soundPop(){
    AudioContext ac = new AudioContext();
    Glide gainGlide = new Glide(ac, 1, 50);
    try {
      sp = new SamplePlayer(ac, new Sample(sketchPath("")+"Pop_Sound.wav"));
    }
    catch(Exception e)
    {
      println("Exception while attempting to load sample!");
      e.printStackTrace(); 
      exit(); 
    }
    finally{
      sp.setKillOnEnd(true);
      Gain g = new Gain(ac, 1, gainGlide);
      g.addInput(sp);
      ac.out.addInput(g);
      ac.start();
    }
  }
  
}
