Display View;

PImage [] Assets;

void loadAssets(){
  Assets[0] = loadImage("image/DSBackground.png");
  Assets[1] = loadImage("image/DSCard.png");
  Assets[2] = loadImage("image/GBAPak.png");
}

public enum ASSET_CODE{
  DSBACKGROUND,
  DSCARD,
  GBAPAK
}

public enum State{
  MAIN_MENU
}

static class Program{
  static State state=State.MAIN_MENU; //if nonvalid state program will exit.
}

class Display{
  boolean queueRender=false;
  public void invalidate(){
    queueRender=true;
  }
  public void update(){
    if(queueRender){
      switch(Program.state){
        case MAIN_MENU:
          image(Assets[ASSET_CODE.DSBACKGROUND.ordinal()],0,0);
          image(Assets[ASSET_CODE.DSCARD.ordinal()],33,217);
          image(Assets[ASSET_CODE.GBAPAK.ordinal()],33,313);
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
  Assets=new PImage[3];
  loadAssets();
  View = new Display();
  View.invalidate();
}

void draw(){
  View.update();
}