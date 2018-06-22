void loadMenu() {
  image(getImage(ASSET_CODE.DSBACKGROUND), 0, 0);
  noStroke();
  fill(255, 128);
  rect(14, 46, 99, 99); //draw transparent white behind clock
  image(getImage(ASSET_CODE.CLOCKBASE), 14, 46);
  image(getImage(ASSET_CODE.CALENDARBASE), 126, 31);
  switch(Program.animation) {
  case FADE_IN:
    tint(255, map(Program.animationCounter, 24, 0, 0, 255)); //fade in upper screen ui
    if (Program.animationCounter==0) {
      Program.animation=Animation.BEGIN_UI;
      Program.animationCounter=16;
    }
    break;
  case BEGIN_UI:
    tint(255, map(Program.animationCounter, 24, 0, 0, 255)); //animation fades in following elements
    image(getImage(ASSET_CODE.DSCARD), 33, 217);
    image(getImage(ASSET_CODE.GBAPAK), 33, 313);
    image(getImage(ASSET_CODE.PICTO_DEFAULT), 33, 265);
    image(getImage(ASSET_CODE.DSD_DEFAULT), 129, 265);
    image(getImage(ASSET_CODE.BRIGHTNESS_ON), 10, 367);
    image(getImage(ASSET_CODE.OPTIONS), 117, 362);
    image(getImage(ASSET_CODE.ALARM_OFF), 237, 367);
    noTint();
    image(getImage(ASSET_CODE.STATUSBAR), 0, -Program.animationCounter); //drags in statusbar
    fill(255);
    text(Program.name, 4, 12-Program.animationCounter);
    if (Program.animationCounter==0) { //when animation ends move to menu state
      Program.animation=Animation.NONE;
      Program.state=State.MENU;
    }
    break;
  default:
    break;
  }
  displayTime();
}

void drawMenu() {
  image(getImage(ASSET_CODE.DSBACKGROUND), 0, 0);
  noStroke();
  fill(255, 128);
  rect(14, 46, 99, 99); //draw transparent white behind clock
  image(getImage(ASSET_CODE.CLOCKBASE), 14, 46);
  image(getImage(ASSET_CODE.CALENDARBASE), 126, 31);
  image(getImage(ASSET_CODE.DSCARD), 33, 217);
  image(getImage(ASSET_CODE.GBAPAK), 33, 313);
  switch(Program.ButtonState[0]) {
  case 0:
    image(getImage(ASSET_CODE.PICTO_DEFAULT), 33, 265);
    break;
  case 1:
    image(getImage(ASSET_CODE.PICTO_CLICKED), 33, 265);
    break;
  case 2:
    image(getImage(ASSET_CODE.PICTO_INVALIDATE), 33, 265);
    break;
  case 3:
    Program.animation=Animation.LOAD_PICTO;
    Program.ButtonState[0]=0;
    playAudio(AUDIO_CODE.START);
    Program.animationCounter=35;
    break;
  default:
    break;
  }
  image(getImage(ASSET_CODE.DSD_DEFAULT), 129, 265);
  image(getImage(ASSET_CODE.BRIGHTNESS_ON), 10, 367);
  image(getImage(ASSET_CODE.OPTIONS), 117, 362);
  image(getImage(ASSET_CODE.ALARM_OFF), 237, 367);
  image(getImage(ASSET_CODE.STATUSBAR), 0, 0); //drags in statusbar
  image(getImage(small_letter_a_code(Time.hour/10)), 148, 4);//h
  image(getImage(small_letter_a_code(Time.hour%10)), 153, 4);//h
  image(getImage(small_letter_a_code(Time.minute/10)), 162, 4);//m
  image(getImage(small_letter_a_code(Time.minute%10)), 167, 4);//m
  image(getImage(small_letter_a_code(Date.month/10)), 178, 4);
  image(getImage(small_letter_a_code(Date.month%10)), 183, 4);
  image(getImage(small_letter_a_code(Date.day/10)), 194, 4);
  image(getImage(small_letter_a_code(Date.day%10)), 199, 4);
  fill(255);
  text(Program.name, 4, 12);
  displayTime();
  if (Program.animation==Animation.LOAD_PICTO) {
    Buffer=get();
    image(getImage(ASSET_CODE.PICTO_DEFAULT), 33, 265);
    Program.state=State.PICTO_MENU;
  }
}

void drawPictoMenu() {
  switch(Program.animation) {
  case LOAD_PICTO:
    image(getImage(ASSET_CODE.DSBACKGROUND), 0, 0);
    tint(255, (float(Program.animationCounter)/35)*255);
    image(Buffer, 0, 0);
    noTint();
    image(getImage(ASSET_CODE.PICTO_DEFAULT), 33, 265-((35-Program.animationCounter)*10));
    if (Program.animationCounter==0) {
      Program.animation=Animation.START_PICTO;
      Program.animationCounter=30;
    }
    break;
  case START_PICTO:
    tint(255, (float(30-Program.animationCounter)/30)*255);
    image(getImage(ASSET_CODE.PICTOBACKGROUND), 0, 0);
    noTint();
    if (Program.animationCounter==0) {
      Program.animation=Animation.PICTO_UI;
      Program.animationCounter=30;
    }
    break;
  case PICTO_UI:
    image(getImage(ASSET_CODE.PICTOBACKGROUND), 0, 0);
    tint(255, (float(30-Program.animationCounter)/30)*255);
    image(getImage(ASSET_CODE.PICTO_MENU_BARS), 0, 192);
    image(getImage(ASSET_CODE.SCROLLBAR), 0, 0);
    image(getImage(ASSET_CODE.CHAT_ROOM_DEFAULT), 31, 224);
    image(getImage(ASSET_CODE.CHAT_ROOM_DEFAULT), 31, 256);
    image(getImage(ASSET_CODE.CHAT_ROOM_DEFAULT), 31, 288);
    image(getImage(ASSET_CODE.CHAT_ROOM_DEFAULT), 31, 320);
    image(getImage(ASSET_CODE.PICTO_FIRST_MESSAGE), 21, 169);
    image(getImage(ASSET_CODE.PICTO_QUIT_DEFAULT), 31, 364);
    image(getImage(ASSET_CODE.PICTO_JOIN_DEFAULT), 144, 364);
    noTint();
    if (Program.animationCounter==0) {
      Program.animation=Animation.NONE;
    }
    break;
  case NONE:
    image(getImage(ASSET_CODE.PICTOBACKGROUND), 0, 0);
    image(getImage(ASSET_CODE.SCROLLBAR), 0, 0);
    image(getImage(ASSET_CODE.PICTO_FIRST_MESSAGE), 21, 169);
    image(getImage(ASSET_CODE.PICTO_MENU_BARS), 0, 192);
    switch(Program.ButtonState[0]) {
    case 0:
      image(getImage(ASSET_CODE.PICTO_QUIT_DEFAULT), 31, 364);
      break;
    case 1:
      image(getImage(ASSET_CODE.PICTO_QUIT_CLICKED), 31, 364);
      break;
    case 2:
      image(getImage(ASSET_CODE.PICTO_QUIT_INVALIDATE), 31, 364);
      break;
    case 3:
      Program.state=State.EXIT_PROGRAM;//todo
      image(getImage(ASSET_CODE.PICTO_QUIT_DEFAULT), 31, 364);
      Program.ButtonState[0]=0;
      break;
    default:
      break;
    }
    switch(Program.ButtonState[1]) {
    case 0:
      image(getImage(ASSET_CODE.PICTO_JOIN_DEFAULT), 144, 364);
      break;
    case 1:
      image(getImage(ASSET_CODE.PICTO_JOIN_CLICKED), 144, 364);
      break;
    case 2:
      image(getImage(ASSET_CODE.PICTO_JOIN_INVALIDATE), 144, 364);
      break;
    case 3:
      Program.state=State.EXIT_PROGRAM;//todo
      image(getImage(ASSET_CODE.PICTO_JOIN_DEFAULT), 144, 364);
      Program.ButtonState[1]=0;
      break;
    default:
      break;
    }
    switch(Program.ButtonState[2]) {
    case 0:
      image(getImage(ASSET_CODE.CHAT_ROOM_DEFAULT), 31, 224);
      break;
    case 1:
      image(getImage(ASSET_CODE.CHAT_ROOM_CLICKED), 31, 224);
      break;
    case 2:
      image(getImage(ASSET_CODE.CHAT_ROOM_INVALIDATE), 31, 224);
      break;
    case 3:
      image(getImage(ASSET_CODE.CHAT_ROOM_DEFAULT), 31, 224);
      Program.ButtonState[2]=0;
      Program.animation=Animation.LOAD_ROOM;
      playAudio(AUDIO_CODE.START);
      Program.animationCounter=35;
      break;
    default:
      break;
    }
    switch(Program.ButtonState[3]) {
    case 0:
      image(getImage(ASSET_CODE.CHAT_ROOM_DEFAULT), 31, 256);
      break;
    case 1:
      image(getImage(ASSET_CODE.CHAT_ROOM_CLICKED), 31, 256);
      break;
    case 2:
      image(getImage(ASSET_CODE.CHAT_ROOM_INVALIDATE), 31, 256);
      break;
    case 3:
      Program.state=State.EXIT_PROGRAM;//todo
      image(getImage(ASSET_CODE.CHAT_ROOM_DEFAULT), 31, 256);
      Program.ButtonState[3]=0;
      break;
    default:
      break;
    }
    switch(Program.ButtonState[4]) {
    case 0:
      image(getImage(ASSET_CODE.CHAT_ROOM_DEFAULT), 31, 288);
      break;
    case 1:
      image(getImage(ASSET_CODE.CHAT_ROOM_CLICKED), 31, 288);
      break;
    case 2:
      image(getImage(ASSET_CODE.CHAT_ROOM_INVALIDATE), 31, 288);
      break;
    case 3:
      Program.state=State.EXIT_PROGRAM;//todo
      image(getImage(ASSET_CODE.CHAT_ROOM_DEFAULT), 31, 288);
      Program.ButtonState[4]=0;
      break;
    default:
      break;
    }
    switch(Program.ButtonState[5]) {
    case 0:
      image(getImage(ASSET_CODE.CHAT_ROOM_DEFAULT), 31, 320);
      break;
    case 1:
      image(getImage(ASSET_CODE.CHAT_ROOM_CLICKED), 31, 320);
      break;
    case 2:
      image(getImage(ASSET_CODE.CHAT_ROOM_INVALIDATE), 31, 320);
      break;
    case 3:
      Program.state=State.EXIT_PROGRAM;//todo
      image(getImage(ASSET_CODE.CHAT_ROOM_DEFAULT), 31, 320);
      Program.ButtonState[5]=0;
      break;
    default:
      break;
    }
    break;
  case LOAD_ROOM:
    tint(255,(float(35-Program.animationCounter)/35)*255);
    image(getImage(ASSET_CODE.PICTOBACKGROUND), 0, 0);
    noTint();
    image(getImage(ASSET_CODE.SCROLLBAR), 0, 0);
    image(getImage(ASSET_CODE.PICTO_FIRST_MESSAGE), 21, 169);
    if (Program.animationCounter==0) {
      Program.state=State.PICTO_CHAT;
      Program.animation=Animation.START_CHAT;
      Program.animationCounter=35;
    }
    break;
  default:
    break;
  }
}

PGraphics renderNametag(int w, int h){
  PGraphics tag=createGraphics(w,h);
  tag.beginDraw();
  tag.loadPixels();
  color hold=color(251);
  tag.pixels[xy(0,0,w)]=hold;
  for(int i=h-5;i>=0;i--){
    tag.pixels[xy(w-1,i,w)]=hold;
  }
  for(int i=w-5;i>=0;i--){
    tag.pixels[xy(i,h-1,w)]=hold;
  }
  tag.pixels[xy(w-2,h-4,w)]=hold;
  tag.pixels[xy(w-3,h-3,w)]=hold;
  tag.pixels[xy(w-4,h-2,w)]=hold;
  hold=color(65,89,105);
  tag.pixels[xy(1,0,w)]=hold;
  tag.pixels[xy(0,1,w)]=hold;
  for(int i=h-5;i>=0;i--){
    tag.pixels[xy(w-2,i,w)]=hold;
  }
  for(int i=w-5;i>=0;i--){
    tag.pixels[xy(i,h-2,w)]=hold;
  }
  tag.pixels[xy(w-3,h-4,w)]=hold;
  tag.pixels[xy(w-4,h-3,w)]=hold;
  hold=color(178,195,219);
  for(int y=0; y<h-2; y++){
    for(int x=0; x<w-2; x++){
        if(!(((x==0||x==1)&&y==0)||(x==0&&y==1)||((x==w-3||x==w-4)&&y==h-3)||(x==w-3&&y==h-4))){
          tag.pixels[xy(x,y,w)]=hold;
        }
    }
  }
  tag.updatePixels();
  tag.fill(color(65,89,105));
  tag.textFont(nds,16);
  tag.text(Program.name,3,h-5);
  tag.endDraw();
  return tag;
}