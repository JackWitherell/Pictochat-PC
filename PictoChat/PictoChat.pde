static class Program{ //default states
  static State state=State.LOAD_MENU; //if nonvalid state program will exit.
  static Animation animation=Animation.FADE_IN;
  static int animationCounter=24;
  static Display display;
  static String name = "Todd Howard's DS";
  static int [] ButtonState=new int[10];
  static boolean LClick=false;
  static private boolean lastFrame=false;
  Program(){
    for(int i=0; i<10; i++){
      ButtonState[0]=0;
    }
  }
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
        case PICTO_MENU: //todo: finish and move to drawconstructs
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
              image(getImage(ASSET_CODE.PICTO_MENU_BARS),0,192);
              image(getImage(ASSET_CODE.SCROLLBAR),0,0);
              image(getImage(ASSET_CODE.CHAT_ROOM_DEFAULT),31,224);
              image(getImage(ASSET_CODE.CHAT_ROOM_DEFAULT),31,256);
              image(getImage(ASSET_CODE.CHAT_ROOM_DEFAULT),31,288);
              image(getImage(ASSET_CODE.CHAT_ROOM_DEFAULT),31,320);
              image(getImage(ASSET_CODE.PICTO_FIRST_MESSAGE),21,169);
              image(getImage(ASSET_CODE.PICTO_QUIT),31,364);
              image(getImage(ASSET_CODE.PICTO_JOIN),144,364);
              noTint();
              if(Program.animationCounter==0){
                Program.animation=Animation.NONE;
              }
              break;
            case NONE:
              image(getImage(ASSET_CODE.PICTOBACKGROUND),0,0);
              image(getImage(ASSET_CODE.PICTO_MENU_BARS),0,192);
              image(getImage(ASSET_CODE.SCROLLBAR),0,0);
              image(getImage(ASSET_CODE.CHAT_ROOM_DEFAULT),31,224);
              image(getImage(ASSET_CODE.CHAT_ROOM_DEFAULT),31,256);
              image(getImage(ASSET_CODE.CHAT_ROOM_DEFAULT),31,288);
              image(getImage(ASSET_CODE.CHAT_ROOM_DEFAULT),31,320);
              image(getImage(ASSET_CODE.PICTO_FIRST_MESSAGE),21,169);
              image(getImage(ASSET_CODE.PICTO_JOIN),144,364);
              switch(Program.ButtonState[0]) {
              case 0:
                image(getImage(ASSET_CODE.PICTO_QUIT),31,364);
                break;
              case 1:
                image(getImage(ASSET_CODE.PICTO_CLICKED), 33, 265); //TODO START HERE
                break;
              case 2:
                image(getImage(ASSET_CODE.PICTO_INVALIDATE), 33, 265);
                break;
              case 3:
                Program.animation=Animation.NONE;//todo
                Program.ButtonState[0]=0;
                playAudio(AUDIO_CODE.START);
                break;
              default:
                break;
              }
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
    switch(Program.state){ //use state true in buttonHandle for preliminary state
      case MENU:
        buttonHandle(0,true,33,265,93,45); //pictostart
        break;
      case PICTO_MENU:
        buttonHandle(0,true,31,364,80,18); //quit
        buttonHandle(1,true,144,364,80,18); //join
        buttonHandle(2,true,31,224,192,32); //chat room a
        buttonHandle(3,true,31,256,192,32); //chat room b
        buttonHandle(4,true,31,288,192,32); //chat room c
        buttonHandle(5,true,31,320,192,32); //chat room d
        break;
      default:
        break;
    }
  }
  if(Program.LClick){
    switch(Program.state){ //use state false for case 1, state true for case 2
      case MENU:
        buttonStateUpdate(0,33,265,93,45);
        break;
      case PICTO_MENU:
        buttonStateUpdate(0,31,364,80,18); //quit
        buttonStateUpdate(1,144,364,80,18); //join
        buttonStateUpdate(2,31,224,192,32); //chat room a
        buttonStateUpdate(3,31,256,192,32); //chat room b
        buttonStateUpdate(4,31,288,192,32); //chat room c
        buttonStateUpdate(5,31,320,192,32); //chat room d
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
