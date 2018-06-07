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
          loadMenu();
          break;
        case MENU:
          drawMenu();
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
                Program.animation=Animation.PICTO_UI;
                Program.animationCounter=30;
              }
              break;
            case PICTO_UI:
              image(getImage(ASSET_CODE.PICTOBACKGROUND),0,0);
              tint(255,(float(30-Program.animationCounter)/30)*255);
  //PICTO_MENU_BARS,
  //CHAT_ROOM,
  //PICTO_FIRST_MESSAGE,
  //SCROLLBAR
              image(getImage(ASSET_CODE.PICTO_MENU_BARS),0,192);
              image(getImage(ASSET_CODE.SCROLLBAR),0,0);
              image(getImage(ASSET_CODE.CHAT_ROOM),31,224);
              image(getImage(ASSET_CODE.CHAT_ROOM),31,256);
              image(getImage(ASSET_CODE.CHAT_ROOM),31,288);
              image(getImage(ASSET_CODE.CHAT_ROOM),31,320);
              image(getImage(ASSET_CODE.PICTO_FIRST_MESSAGE),21,169);
              image(getImage(ASSET_CODE.PICTO_QUIT),31,364);
              image(getImage(ASSET_CODE.PICTO_JOIN),144,364);
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

void draw(){
  if(Program.mEvent()){
    switch(Program.state){
      case MENU:
        if(getCollision(32,126,264,310)){
          Program.MenuPictoState=1;
          Program.display.invalidate();
        }
        break;
      default:
        break;
    }
  }
  if(Program.LClick){
    switch(Program.state){
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
      default:
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
