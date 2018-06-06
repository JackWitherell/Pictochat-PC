import ddf.minim.*;
Minim minim;

AudioPlayer [] Audio;

PImage [] Assets;

PFont nds;

PImage Buffer;

//startup
void load(){
  Assets=new PImage[33];
  loadAssets();
  Audio=new AudioPlayer[2];
  loadSounds();
  nds= createFont("Data/font/Nintendo-DS-BIOS.ttf",16);
  textFont(nds);
}

//image asset initialization
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
  ALARM_OFF,
  SMALLF_0,
  SMALLF_1,
  SMALLF_2,
  SMALLF_3,
  SMALLF_4,
  SMALLF_5,
  SMALLF_6,
  SMALLF_7,
  SMALLF_8,
  SMALLF_9,
  DATE_SELECTION,
  PICTOBACKGROUND,
  PICTO_MENU_BARS,
  CHAT_ROOM,
  PICTO_FIRST_MESSAGE,
  SCROLLBAR
}
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
  PImage SmallNumbers=loadImage("image/Template-Numbers.png");
  for(int i=0; i<10;i++){
    Assets[17+i]=SmallNumbers.get(4*i,0,4,7);
  }
  Assets[27] = loadImage("image/Date_Selection.png");
  Assets[28] = loadImage("image/PictoChatBackground.png");
  Assets[29] = loadImage("image/Picto-Menu-Bars.png");
  Assets[30] = loadImage("image/Chat-Room.png");
  Assets[31] = loadImage("image/Picto-First-Message.png");
  Assets[32] = loadImage("image/ScrollBar.png");
}

//audio asset initialization
public enum AUDIO_CODE{
  TICK,
  START
}
void loadSounds(){
  Audio[0]=minim.loadFile("audio/tick.wav");
  Audio[1]=minim.loadFile("audio/start.wav");
}

//interact with assets
void playAudio(AudioPlayer sound){
  sound.cue(0);
  sound.play();
}

void playAudio(AUDIO_CODE code){
  playAudio(Audio[code.ordinal()]);
}

PImage getImage(ASSET_CODE code){
  return Assets[code.ordinal()];
}

private ASSET_CODE small_letter_a_code(int in){
  switch(in){
    case 0:
      return ASSET_CODE.SMALLF_0;
    case 1:
      return ASSET_CODE.SMALLF_1;
    case 2:
      return ASSET_CODE.SMALLF_2;
    case 3:
      return ASSET_CODE.SMALLF_3;
    case 4:
      return ASSET_CODE.SMALLF_4;
    case 5:
      return ASSET_CODE.SMALLF_5;
    case 6:
      return ASSET_CODE.SMALLF_6;
    case 7:
      return ASSET_CODE.SMALLF_7;
    case 8:
      return ASSET_CODE.SMALLF_8;
    case 9:
      return ASSET_CODE.SMALLF_9;
    default:
      return ASSET_CODE.ALARM_OFF;
  }
}
