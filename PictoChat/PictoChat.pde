import ddf.minim.*;

Display View;

Minim minim;

AudioPlayer [] Audio;

void loadSounds(){
  Audio[0]=minim.loadFile("audio/tick.wav");
}

public enum AUDIO_CODE{
  TICK
}

PImage [] Assets;

void loadAssets(){
  Assets[0] = loadImage("image/DSBackground.png");
  Assets[1] = loadImage("image/DSCard.png");
  Assets[2] = loadImage("image/GBAPak.png");
  Assets[3] = loadImage("image/ClockBase.png");
  Assets[4] = loadImage("image/CalendarBase.png");
  Assets[5] = loadImage("image/StatusBar.png");
  Assets[6] = loadImage("image/PictoChat-default.png");
  Assets[7] = loadImage("image/PictoChat-clicked.png");
  Assets[8] = loadImage("image/PictoChat-invalidate.png");
  Assets[9] = loadImage("image/DSDownloadPlay-default.png");
  Assets[10] = loadImage("image/DSDownloadPlay-clicked.png");
  Assets[11] = loadImage("image/DSDownloadPlay-invalidate.png");
  Assets[12] = loadImage("image/Brightness-on.png");
  Assets[13] = loadImage("image/Brightness-off.png");
  Assets[14] = loadImage("image/Options.png");
  Assets[15] = loadImage("image/Alarm-on.png");
  Assets[16] = loadImage("image/Alarm-off.png");
}

public enum ASSET_CODE{
  DSBACKGROUND,
  DSCARD,
  GBAPAK,
  CLOCKBASE,
  CALENDARBASE,
  STATUSBAR,
  PICTO_DEFAULT,
  PICTO_CLICKED,
  PICTO_INVALIDATE,
  DSD_DEFAULT,
  DSD_CLICKED,
  DSD_INVALIDATE,
  BRIGHTNESS_ON,
  BRIGHTNESS_OFF,
  OPTIONS,
  ALARM_ON,
  ALARM_OFF
}

static class Time{
  static int hour;
  static int minute;
  static int second;
  static boolean updateTime(){
    if(second!=second()){
      hour=hour();
      minute=minute();
      second=second();
      return true;
    }
    return false;
  }
}

void displayTime(){
  stroke(97,130,154);
  strokeWeight(2);
  float sw=63+cos(((float(Time.second)/60)*TWO_PI)-HALF_PI)*37;
  float sh=95+sin(((float(Time.second)/60)*TWO_PI)-HALF_PI)*37;
  line(63,95,sw,sh); //render seconds
  stroke(121);
  float mw=63+cos(((float(Time.minute)/60)*TWO_PI)-HALF_PI)*31;
  float mh=95+sin(((float(Time.minute)/60)*TWO_PI)-HALF_PI)*31;
  line(63,95,mw,mh);
  float hw=63+cos((((float(Time.hour)+(float(Time.minute)/60))/12)*TWO_PI)-HALF_PI)*24;
  float hh=95+sin((((float(Time.hour)+(float(Time.minute)/60))/12)*TWO_PI)-HALF_PI)*24;
  line(63,95,hw,hh);
  fill(73);
  noStroke();
  rect(61,93,5,5);
}

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
          image(Assets[ASSET_CODE.DSBACKGROUND.ordinal()],0,0);
          noStroke();
          fill(255,128);
          rect(14,46,99,99); //draw transparent white behind clock
          image(Assets[ASSET_CODE.CLOCKBASE.ordinal()],14,46);
          image(Assets[ASSET_CODE.CALENDARBASE.ordinal()],126,31);
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
              image(Assets[ASSET_CODE.DSCARD.ordinal()],33,217);
              image(Assets[ASSET_CODE.GBAPAK.ordinal()],33,313);
              image(Assets[ASSET_CODE.PICTO_DEFAULT.ordinal()],33,265);
              image(Assets[ASSET_CODE.DSD_DEFAULT.ordinal()],129,265);
              image(Assets[ASSET_CODE.BRIGHTNESS_ON.ordinal()],10,367);
              image(Assets[ASSET_CODE.OPTIONS.ordinal()],117,362);
              image(Assets[ASSET_CODE.ALARM_OFF.ordinal()],237,367);
              noTint();
              image(Assets[ASSET_CODE.STATUSBAR.ordinal()],0,-Program.animationCounter); //drags in statusbar
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
          image(Assets[ASSET_CODE.DSBACKGROUND.ordinal()],0,0);
          noStroke();
          fill(255,128);
          rect(14,46,99,99); //draw transparent white behind clock
          image(Assets[ASSET_CODE.CLOCKBASE.ordinal()],14,46);
          image(Assets[ASSET_CODE.CALENDARBASE.ordinal()],126,31);
          image(Assets[ASSET_CODE.DSCARD.ordinal()],33,217);
          image(Assets[ASSET_CODE.GBAPAK.ordinal()],33,313);
          image(Assets[ASSET_CODE.PICTO_DEFAULT.ordinal()],33,265);
          image(Assets[ASSET_CODE.DSD_DEFAULT.ordinal()],129,265);
          image(Assets[ASSET_CODE.BRIGHTNESS_ON.ordinal()],10,367);
          image(Assets[ASSET_CODE.OPTIONS.ordinal()],117,362);
          image(Assets[ASSET_CODE.ALARM_OFF.ordinal()],237,367);
          image(Assets[ASSET_CODE.STATUSBAR.ordinal()],0,0); //drags in statusbar
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
  Assets=new PImage[17];
  Audio=new AudioPlayer[1];
  loadAssets();
  loadSounds();
  View = new Display();
  View.invalidate();
  tint(255,0);
  noSmooth();
}

void draw(){
  if(Time.updateTime()){
    View.invalidate();
    if(Program.state==State.MENU){
      Audio[AUDIO_CODE.TICK.ordinal()].cue(0);
      Audio[AUDIO_CODE.TICK.ordinal()].play();
    }
  }
  View.update();
  if(Program.animationCounter!=0){
    Program.animationCounter--;
    View.invalidate();
  }
}