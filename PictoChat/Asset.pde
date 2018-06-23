import ddf.minim.*;
Minim minim;

AudioPlayer [] Audio;

PImage [] Assets;

PFont nds;

PImage Buffer;

//startup
void load(){
  Assets=new PImage[61];
  loadAssets();
  Audio=new AudioPlayer[2];
  loadSounds();
  nds= createFont("Data/font/Nintendo-DS-BIOS.ttf",16);
  textSize(16);
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
  CHAT_ROOM_DEFAULT,
  CHAT_ROOM_CLICKED,
  CHAT_ROOM_INVALIDATE,
  PICTO_FIRST_MESSAGE,
  SCROLLBAR,
  PICTO_QUIT_DEFAULT,
  PICTO_QUIT_CLICKED,
  PICTO_QUIT_INVALIDATE,
  PICTO_JOIN_DEFAULT,
  PICTO_JOIN_CLICKED,
  PICTO_JOIN_INVALIDATE,
  TOOL_PANEL,
  KEYBOARD,
  SEND,
  COPY,
  CLEAR,
  PICTO_X,
  SCROLL_UP,
  SCROLL_DOWN,
  TAB_PENCIL_DEFAULT,
  TAB_PENCIL_SELECTED,
  TAB_ERASER_DEFAULT,
  TAB_ERASER_SELECTED,
  TAB_SIZE_LARGE,
  TAB_SIZE_SMALL,
  TAB_ENGLISH,
  TAB_ACCENTS,
  TAB_JAPAN,
  TAB_SYMBOLS,
  TAB_EMOTES,
  BLANK_MESSAGE
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
  Assets[30] = loadImage("image/ChatRoom-default.png");
  Assets[31] = loadImage("image/ChatRoom-clicked.png");
  Assets[32] = loadImage("image/ChatRoom-invalidate.png");
  Assets[33] = loadImage("image/Picto-First-Message.png");
  Assets[34] = loadImage("image/ScrollBar.png");
  Assets[35] = loadImage("image/Picto-Quit-default.png");
  Assets[36] = loadImage("image/Picto-Quit-clicked.png");
  Assets[37] = loadImage("image/Picto-Quit-invalidate.png");
  Assets[38] = loadImage("image/Picto-Join-default.png");
  Assets[39] = loadImage("image/Picto-Join-clicked.png");
  Assets[40] = loadImage("image/Picto-Join-invalidate.png");
  Assets[41] = loadImage("image/Tool-Panel.png");
  Assets[42] = loadImage("image/KeyBoard.png");
  Assets[43] = loadImage("image/Send-Button.png");
  Assets[44] = loadImage("image/Copy-Button.png");
  Assets[45] = loadImage("image/Clear-Button.png");
  Assets[46] = loadImage("image/Quit-Picto.png");
  Assets[47] = loadImage("image/Scroll-Up.png");
  Assets[48] = loadImage("image/Scroll-Down.png");
  Assets[49] = loadImage("image/Tab-Pencil-default.png");
  Assets[50] = loadImage("image/Tab-Pencil-selected.png");
  Assets[51] = loadImage("image/Tab-Eraser-default.png");
  Assets[52] = loadImage("image/Tab-Eraser-selected.png");
  Assets[53] = loadImage("image/Tab-Size-Large.png");
  Assets[54] = loadImage("image/Tab-Size-Small.png");
  Assets[55] = loadImage("image/Tab-English.png");
  Assets[56] = loadImage("image/Tab-Accents.png");
  Assets[57] = loadImage("image/Tab-Japan.png");
  Assets[58] = loadImage("image/Tab-Symbols.png");
  Assets[59] = loadImage("image/Tab-Emotes.png");
  Assets[60] = loadImage("image/Blank-Message.png");
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

//state and animation definitions
public enum State{
  EXIT_PROGRAM,
  LOAD_MENU,
  MENU,
  PICTO_MENU,
  PICTO_CHAT
}
public enum Animation{
  NONE,
  FADE_IN,
  BEGIN_UI,
  LOAD_PICTO,
  START_PICTO,
  PICTO_UI,
  LOAD_ROOM,
  START_CHAT
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