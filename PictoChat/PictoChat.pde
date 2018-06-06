public enum State{
  EXIT_PROGRAM,
  LOAD_MENU,
  MENU,
  PICTO
}

public enum Animation{
  NONE,
  FADE_IN,
  BEGIN_UI,
  LOAD_PICTO,
  START_PICTO
}

static class Program{ //default states
  static State state=State.LOAD_MENU; //if nonvalid state program will exit.
  static Animation animation=Animation.FADE_IN;
  static int animationCounter=24;
  static Display display;
  static String name = "Todd Howard's DS";
  static int MenuPictoState=0;
  static boolean LClick=false;
  static private boolean lastFrame=false;
  static boolean mEvent(){
    if(!lastFrame&&LClick){
      lastFrame=true;
      return lastFrame;
    }
    else{
      return false;
    }
  }
  static void mReset(){
    lastFrame=false;
  }
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
              fill(255);
              text(Program.name, 4,12-Program.animationCounter);
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
          if(Program.animation!=Animation.LOAD_PICTO){
            switch(Program.MenuPictoState){
              case 0:
                image(getImage(ASSET_CODE.PICTO_DEFAULT),33,265);
                break;
              case 1:
                image(getImage(ASSET_CODE.PICTO_CLICKED),33,265);
                break;
              case 2:
                image(getImage(ASSET_CODE.PICTO_INVALIDATE),33,265);
                break;
              case 3:
                Program.animation=Animation.LOAD_PICTO;
                Program.animationCounter=35;
                break;
              default:
                break;
            }
          }
          image(getImage(ASSET_CODE.DSD_DEFAULT),129,265);
          image(getImage(ASSET_CODE.BRIGHTNESS_ON),10,367);
          image(getImage(ASSET_CODE.OPTIONS),117,362);
          image(getImage(ASSET_CODE.ALARM_OFF),237,367);
          image(getImage(ASSET_CODE.STATUSBAR),0,0); //drags in statusbar
          image(getImage(small_letter_a_code(Time.hour/10)),148,4);//h
          image(getImage(small_letter_a_code(Time.hour%10)),153,4);//h
          image(getImage(small_letter_a_code(Time.minute/10)),162,4);//m
          image(getImage(small_letter_a_code(Time.minute%10)),167,4);//m
          image(getImage(small_letter_a_code(Date.month/10)),178,4);
          image(getImage(small_letter_a_code(Date.month%10)),183,4);
          image(getImage(small_letter_a_code(Date.day/10)),194,4);
          image(getImage(small_letter_a_code(Date.day%10)),199,4);
          fill(255);
          text(Program.name, 4,12);
          displayTime();
          if(Program.animation==Animation.LOAD_PICTO){
            Buffer=get();
            image(getImage(ASSET_CODE.PICTO_DEFAULT),33,265);
            Program.state=State.PICTO;
          }
          break;
        case PICTO:
          switch(Program.animation){
            case LOAD_PICTO:
              image(getImage(ASSET_CODE.DSBACKGROUND),0,0);
              tint(255,(float(Program.animationCounter)/35)*255);
              image(Buffer,0,0);
              noTint();
              image(getImage(ASSET_CODE.PICTO_DEFAULT),33,265-((35-Program.animationCounter)*10));
              if(Program.animationCounter==0){
                Program.animation=Animation.START_PICTO;
                Program.animationCounter=30;
              }
              break;
            case START_PICTO:
              tint(255,(float(30-Program.animationCounter)/30)*255);
              image(getImage(ASSET_CODE.PICTOBACKGROUND),0,0);
              noTint();
              if(Program.animationCounter==0){
                Program.animation=Animation.NONE;
              }
              break;
            case NONE:
              
              break;
            default:
              break;
          }
          break;
        default:
          exit();
          break;
      }
    }
  }
}

void mousePressed(){
  Program.LClick=true;
}

void mouseReleased(){
  Program.LClick=false;
  Program.mReset();
  switch(Program.MenuPictoState){
    case 1:
      Program.MenuPictoState=3;
      playAudio(AUDIO_CODE.START);
      Program.display.invalidate();
      break;
    case 2:
      Program.MenuPictoState=0;
      Program.display.invalidate();
      break;
    default:
      break;
  }
  
}

void setup(){
  size(256,384);
  background(255);
  minim= new Minim(this);
  load();
  Program.display = new Display();
  Program.display.invalidate();
  cal=new Cal();
  tint(255,0);
  noSmooth();
}

boolean getCollision(int xmin, int xmax, int ymin, int ymax){
  if((mouseX>xmin&&mouseX<xmax)&&(mouseY>ymin)&&(mouseY<ymax)){
    return true;
  }
  else{
    return false;
  }
}

void draw(){
  if(Program.mEvent()){
    switch(Program.state){
      case LOAD_MENU:
        break;
      case MENU:
        if(getCollision(32,126,264,310)){
          Program.MenuPictoState=1;
          Program.display.invalidate();
        }
        break;
      case PICTO:
        break;
    }
  }
  if(Program.LClick){
    switch(Program.state){
      case LOAD_MENU:
        break;
      case MENU:
        switch(Program.MenuPictoState){
          case 0:
            break;
          case 1:
            if(!getCollision(32,126,264,310)){
              Program.MenuPictoState=2;
              Program.display.invalidate();
            }
            break;
          case 2:
            if(getCollision(32,126,264,310)){
              Program.MenuPictoState=1;
              Program.display.invalidate();
            }
            break;
        }
        break;
      case PICTO:
        break;
    }
  }
  
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
  //Program.display.invalidate(); //debug always render
}
