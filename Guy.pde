
class Guy {
  
  private PImage basic;
  private PImage speaking;
  private PImage basicBlinking;
  private PImage speakingBlinking;
  
  private boolean blinking;
  private int blinkTime;
  
  private int silentTime;
  private int silentOffset;
  
  private int xOffset;
  private int yOffset;
  
  private State currentState;
  
  public Guy() {
    basic = loadImage("default.png");
    speaking = loadImage("speaking.png");
    basicBlinking = loadImage("default_blinking.png");
    speakingBlinking = loadImage("speaking_blinking.png");
    
    currentState = State.SPEAKING;
    
    blinking = false;
    blinkTime = 0;
    
    silentTime = 0;
    silentOffset = 0;
    
    xOffset = 0;
    yOffset = 0;
  }
  
  public void setState(State newState) {
    currentState = newState;
  }
  
  public State getState() {
    return currentState; 
  }
  
  public void blink() {
    if (blinking) {
      return;
    } else {
      blinking = true;
      blinkTime = 20;
      return;
    }
  }
  
  
  public boolean isBlinking() {
    return blinking;
  }
  
  public void resetSilentTime() {
    silentTime = 0;
    silentOffset += 5;
    silentOffset = min(30, silentOffset);
  }
  
  public void updateSilentTime() {
    silentTime++;
    silentOffset -= 5;
    silentOffset = max(0, silentOffset);
  }
  
  public void show() {
    PImage toShow = basic;
    switch (currentState) {
      case BASIC:
        toShow = basic;
        break;
      case SPEAKING:
        toShow = speaking;
        break;
      case BASIC_BLINKING:
        toShow = basicBlinking;
        break;
      case SPEAKING_BLINKING:
        toShow = speakingBlinking;
        break;
    }
    
    xOffset = (int) ((noise(frameCount*0.005) - 0.5) * 40);
    yOffset = (int) ((noise((frameCount + 3000)*0.005) - 0.5) * 40);
    
    yOffset -= silentOffset;
    
    image(toShow, 50 + xOffset, 100 + yOffset);
    
    if (blinking) {
      blinkTime--;
      if (blinkTime == 0) {
        blinking = false;
      }
    }
    
  }
}
