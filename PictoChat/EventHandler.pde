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

boolean getCollision(int xmin, int xmax, int ymin, int ymax){
  if((mouseX>xmin&&mouseX<xmax)&&(mouseY>ymin)&&(mouseY<ymax)){
    return true;
  }
  else{
    return false;
  }
}
