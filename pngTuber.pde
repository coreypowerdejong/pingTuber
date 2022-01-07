import processing.sound.*;
Amplitude amp;
AudioIn in;
LowPass lowPass;
Guy guy;

void setup() {
  size(500,500);
  background(50, 255, 50);
  
  guy = new Guy();
  
  amp = new Amplitude(this);
  in = new AudioIn(this, 0);
  lowPass = new LowPass(this);
  in.start();
  lowPass.process(in, 600);
  amp.input(in);
}

void draw() {
  if (amp.analyze() > 0.03) {
    guy.setState(State.SPEAKING);
    guy.resetSilentTime();
  } else {
    guy.setState(State.BASIC);
    guy.updateSilentTime();
  }
  
  if (random(1) > 0.9958) {
    guy.blink();
  }
  
  if (guy.isBlinking()) {
    if (guy.getState() == State.SPEAKING) {
      guy.setState(State.SPEAKING_BLINKING);
    } else {
      guy.setState(State.BASIC_BLINKING);
    }
  }
  background(50, 255, 50);
  guy.show();
}
