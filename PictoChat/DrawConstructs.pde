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
