public enum State{
  LOAD_MENU,
  MENU
}

public enum Animation{
  NONE,
  FADE_IN,
  BEGIN_UI
}

static class Program{ //default states
  static State state=State.LOAD_MENU; //if nonvalid state program will exit.
  static Animation animation=Animation.FADE_IN;
  static int animationCounter=24;
  static Display display;
}

class Display{
  boolean queueRender=false;
  public void invalidate(){
    queueRender=true;
  }
  public void update(){
    if(queueRender){
      queueRender=false;
      switch(Program.state){
        case LOAD_MENU:
          background(255);
          image(getImage(ASSET_CODE.DSBACKGROUND),0,0);
          noStroke();
          fill(255,128);
          rect(14,46,99,99); //draw transparent white behind clock
          image(getImage(ASSET_CODE.CLOCKBASE),14,46);
          image(getImage(ASSET_CODE.CALENDARBASE),126,31);
          switch(Program.animation){
            case FADE_IN:
              tint(255,map(Program.animationCounter,24,0,0,255)); //fade in upper screen ui
              if(Program.animationCounter==0){
                Program.animation=Animation.BEGIN_UI;
                Program.animationCounter=16;
              }
              break;
            case BEGIN_UI:
              tint(255,map(Program.animationCounter,24,0,0,255)); //animation fades in following elements
              image(getImage(ASSET_CODE.DSCARD),33,217);
              image(getImage(ASSET_CODE.GBAPAK),33,313);
              image(getImage(ASSET_CODE.PICTO_DEFAULT),33,265);
              image(getImage(ASSET_CODE.DSD_DEFAULT),129,265);
              image(getImage(ASSET_CODE.BRIGHTNESS_ON),10,367);
              image(getImage(ASSET_CODE.OPTIONS),117,362);
              image(getImage(ASSET_CODE.ALARM_OFF),237,367);
              noTint();
              image(getImage(ASSET_CODE.STATUSBAR),0,-Program.animationCounter); //drags in statusbar
              if(Program.animationCounter==0){ //when animation ends move to menu state
                Program.animation=Animation.NONE;
                Program.state=State.MENU;
              }
              break;
            case NONE:
              break;
            default:
              break;
          }
          displayTime();
          break;
        case MENU:
          image(getImage(ASSET_CODE.DSBACKGROUND),0,0);
          noStroke();
          fill(255,128);
          rect(14,46,99,99); //draw transparent white behind clock
          image(getImage(ASSET_CODE.CLOCKBASE),14,46);
          image(getImage(ASSET_CODE.CALENDARBASE),126,31);
          image(getImage(ASSET_CODE.DSCARD),33,217);
          image(getImage(ASSET_CODE.GBAPAK),33,313);
          image(getImage(ASSET_CODE.PICTO_DEFAULT),33,265);
          image(getImage(ASSET_CODE.DSD_DEFAULT),129,265);
          image(getImage(ASSET_CODE.BRIGHTNESS_ON),10,367);
          image(getImage(ASSET_CODE.OPTIONS),117,362);
          image(getImage(ASSET_CODE.ALARM_OFF),237,367);
          image(getImage(ASSET_CODE.STATUSBAR),0,0); //drags in statusbar
          displayTime();
          break;
        default:
          exit();
          break;
      }
    }
  }
}

void setup(){
  size(256,384);
  minim= new Minim(this);
  load();
  Program.display = new Display();
  Program.display.invalidate();
  tint(255,0);
  noSmooth();
}



void draw(){
  if(Time.updateTime()){
    Program.display.invalidate();
    if(Program.state==State.MENU){
      playAudio(AUDIO_CODE.TICK);
    }
  }
  Program.display.update();
  if(Program.animationCounter!=0){
    Program.animationCounter--;
    Program.display.invalidate();
  }
}
