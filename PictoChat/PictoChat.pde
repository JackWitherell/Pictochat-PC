color SelectedColor=color(0,0,0);

static class LastMouse{
  static int x, y;
  static public void upd(int mx,int my){
    x=mx;
    y=my;
  }
}

static class Program{ //default states
  static State state=State.LOAD_MENU; //if nonvalid state program will exit.
  static Animation animation=Animation.FADE_IN;
  static int animationCounter=24;
  static Display display;
  static String name = "Todd Howard";
  static int [] ButtonState=new int[10];
  static int currentButton=-1;
  static boolean LClick=false;
  static PGraphics drawingCanvas;
  static PGraphics nameTag;
  static boolean penState=true;
  static int penSize=2;
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
          drawPictoMenu();
          break;
        case PICTO_CHAT:
          switch(Program.animation) {
            case START_CHAT:
              tint(255,(float(35-Program.animationCounter)/35)*255);
              image(getImage(ASSET_CODE.TOOL_PANEL),0,192);
              image(getImage(ASSET_CODE.KEYBOARD),24,297);
              image(getImage(ASSET_CODE.SEND),226,297);
              image(getImage(ASSET_CODE.COPY),226,328);
              image(getImage(ASSET_CODE.CLEAR),226,352);
              image(getImage(ASSET_CODE.PICTO_X),245,193);
              image(getImage(ASSET_CODE.SCROLL_UP),2,194);
              image(getImage(ASSET_CODE.SCROLL_DOWN),2,209);
              if(Program.penState){
                image(getImage(ASSET_CODE.TAB_PENCIL_SELECTED),2,230);
                image(getImage(ASSET_CODE.TAB_ERASER_DEFAULT),2,244);
              }
              else{
                image(getImage(ASSET_CODE.TAB_PENCIL_DEFAULT),2,230);
                image(getImage(ASSET_CODE.TAB_ERASER_SELECTED),2,244);
              }
              image(getImage(ASSET_CODE.TAB_SIZE_LARGE),2,263);
              image(getImage(ASSET_CODE.TAB_SIZE_SMALL),2,278);
              image(getImage(ASSET_CODE.TAB_ENGLISH),2,299);
              image(getImage(ASSET_CODE.TAB_ACCENTS),2,316);
              image(getImage(ASSET_CODE.TAB_JAPAN),2,333);
              image(getImage(ASSET_CODE.TAB_SYMBOLS),2,350);
              image(getImage(ASSET_CODE.TAB_EMOTES),2,367);
              image(getImage(ASSET_CODE.BLANK_MESSAGE),21,207);
              image(Program.drawingCanvas,24,210);
              image(Program.nameTag,23,209);
              noTint();
              if(Program.animationCounter==0){
                Program.animation=Animation.NONE;
              }
              break;
            case COLOR_PICKER:
              tint(128,128,128);
              image(Buffer,0,0);
              noTint();
              colorMode(RGB, 3, 4, 3);
              stroke(3);
              strokeWeight(1);
              for(int x=0; x<4; x++){
                for(int y=0; y<5; y++){
                  for(int z=0; z<4; z++){
                    fill(x-1,y-1,z-1);
                    stroke(2);
                    rect((x*32)+(z>1?128:0)+5,(y*38)+((z>1?z-2:z)*190)+10,24,24);
                    fill(x,y,z);
                    stroke(3);
                    rect((x*32)+(z>1?128:0)+3,(y*38)+((z>1?z-2:z)*190)+8,24,24);
                  }
                }
              }
              colorMode(RGB,255,255,255);
              break;
            case NONE:
              image(getImage(ASSET_CODE.PICTOBACKGROUND), 0, 0);
              image(getImage(ASSET_CODE.PICTO_FIRST_MESSAGE), 21, 169);
              image(getImage(ASSET_CODE.SCROLLBAR), 0, 0);
              image(getImage(ASSET_CODE.TOOL_PANEL),0,192);
              image(getImage(ASSET_CODE.KEYBOARD),24,297);
              image(getImage(ASSET_CODE.SEND),226,297);
              image(getImage(ASSET_CODE.COPY),226,328);
              image(getImage(ASSET_CODE.CLEAR),226,352);
              image(getImage(ASSET_CODE.PICTO_X),245,193);
              image(getImage(ASSET_CODE.SCROLL_UP),2,194);
              image(getImage(ASSET_CODE.SCROLL_DOWN),2,209);
              if(Program.penState){
                image(getImage(ASSET_CODE.TAB_PENCIL_SELECTED),2,230);
                image(getImage(ASSET_CODE.TAB_ERASER_DEFAULT),2,244);
              }
              else{
                image(getImage(ASSET_CODE.TAB_PENCIL_DEFAULT),2,230);
                image(getImage(ASSET_CODE.TAB_ERASER_SELECTED),2,244);
              }
              image(getImage(ASSET_CODE.TAB_SIZE_LARGE),2,263);
              image(getImage(ASSET_CODE.TAB_SIZE_SMALL),2,278);
              image(getImage(ASSET_CODE.TAB_ENGLISH),2,299);
              image(getImage(ASSET_CODE.TAB_ACCENTS),2,316);
              image(getImage(ASSET_CODE.TAB_JAPAN),2,333);
              image(getImage(ASSET_CODE.TAB_SYMBOLS),2,350);
              image(getImage(ASSET_CODE.TAB_EMOTES),2,367);
              image(getImage(ASSET_CODE.BLANK_MESSAGE),21,207);
              image(Program.drawingCanvas,24,210);
              image(Program.nameTag,23,209);
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
  Program.drawingCanvas= createGraphics(228,80);
  Program.drawingCanvas.beginDraw();
  Program.drawingCanvas.strokeWeight(Program.penSize);
  Program.drawingCanvas.colorMode(RGB, 3, 4, 3);
  Program.drawingCanvas.endDraw();
  Program.nameTag=renderNametag(int(textWidth(Program.name))+7,18);
  cal=new Cal();
  tint(255,0);
  noSmooth();
}

void draw(){
  if(Program.mEvent()){
    switch(Program.state){ //use state true in buttonHandle for preliminary state
      case MENU:
        if(getCollision(33,265,93,45)){
          Program.ButtonState[0]=1;
          Program.currentButton=0;
          Program.display.invalidate();
        }
        break;
      case PICTO_MENU:
        switch(getCollision(31,364,80,18)==true?0:
               getCollision(144,364,80,18)==true?1:
               getCollision(31,224,192,32)==true?2:
               getCollision(31,256,192,32)==true?3:
               getCollision(31,288,192,32)==true?4:
               getCollision(31,320,192,32)==true?5:-1){
          case 0:
            Program.ButtonState[0]=1;
            Program.currentButton=0;
            Program.display.invalidate();
            break;
          case 1:
            Program.ButtonState[1]=1;
            Program.currentButton=1;
            Program.display.invalidate();
            break;
          case 2:
            Program.ButtonState[2]=1;
            Program.currentButton=2;
            Program.display.invalidate();
            break;
          case 3:
            Program.ButtonState[3]=1;
            Program.currentButton=3;
            Program.display.invalidate();
            break;
          case 4:
            Program.ButtonState[4]=1;
            Program.currentButton=4;
            Program.display.invalidate();
            break;
          case 5:
            Program.ButtonState[5]=1;
            Program.currentButton=5;
            Program.display.invalidate();
            break;
          default:
            break;
          }
        break;
      case PICTO_CHAT:
        switch(Program.animation){
          case NONE:
            switch(getCollision(24,210,228,80)==true?0:
                   getCollision(2,278,14,14)==true?1:
                   getCollision(2,230,14,13)==true?2:
                   getCollision(2,244,14,13)==true?3:-1){
              case 0:
                Program.ButtonState[0]=1;
                Program.currentButton=0;
                Program.display.invalidate();
                break;
              case 1:
                Buffer=get();
                Program.animation=Animation.COLOR_PICKER;
                Program.display.invalidate();
                break;
              case 2:
                Program.penState=true;
                Program.drawingCanvas.stroke(SelectedColor);
                Program.drawingCanvas.strokeWeight(Program.penSize);
                Program.display.invalidate();
                break;
              case 3:
                Program.penState=false;
                if(Program.penSize>1){
                  Program.drawingCanvas.strokeWeight(Program.penSize+2);
                }
                else{
                  Program.drawingCanvas.strokeWeight(Program.penSize);
                }
                Program.display.invalidate();
                break;
              default:
                break;
            }
            break;
          case COLOR_PICKER:
            Program.animation=Animation.NONE;
            if(((mouseX-3)%32<24&&mouseX>2)&&((mouseY-9)%38<24)&&mouseY>8){
              colorMode(RGB, 3, 4, 3);
              SelectedColor=color(((mouseX-3)/32)%4,((mouseY-8)/38)%5,((mouseY>height/2)?1:0)+((mouseX>width/2)?2:0));
              Program.drawingCanvas.stroke(SelectedColor);
              colorMode(RGB,255,255,255);
            }
            Program.display.invalidate();
            break;
          default:
            break;
          }
      default:
        break;
    }
  }
  
  else if(Program.LClick){
    switch(Program.state){ //use state false for case 1, state true for case 2
      case MENU:
        switch(Program.currentButton){
          case 0:
            buttonStateUpdate(0,33,265,93,45);
            break;
          default:
            break;
        }
        break;
      case PICTO_MENU:
        switch(Program.currentButton){
          case 0:
            buttonStateUpdate(0,31,364,80,18); //quit
            break;
          case 1:
            buttonStateUpdate(1,144,364,80,18); //join
            break;
          case 2:
            buttonStateUpdate(2,31,224,192,32); //chat room a
            break;
          case 3:
            buttonStateUpdate(3,31,256,192,32); //chat room b
            break;
          case 4:
            buttonStateUpdate(4,31,288,192,32); //chat room c
            break;
          case 5:
            buttonStateUpdate(5,31,320,192,32); //chat room d
            break;
          default:
            break;
        }
        break;
      case PICTO_CHAT:
        switch(Program.currentButton){
          case 0:
            Program.drawingCanvas.beginDraw();
            if(!Program.penState){
              Program.drawingCanvas.blendMode(REPLACE);
              Program.drawingCanvas.stroke(0,0,0,0);
            }
            Program.drawingCanvas.line(LastMouse.x-24,LastMouse.y-210,mouseX-24,mouseY-210);
            Program.drawingCanvas.endDraw();
            Program.display.invalidate();
            break;
          default:
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
  LastMouse.upd(mouseX,mouseY);
}