void mousePressed(){
  Program.LClick=true;
}

void mouseReleased(){
  Program.LClick=false;
  Program.mReset();
  switch(Program.ButtonState[0]){
    case 1:
      Program.ButtonState[0]=3;
      Program.display.invalidate();
      break;
    case 2:
      Program.ButtonState[0]=0;
      Program.display.invalidate();
      break;
    default:
      break;
  }
}

boolean getCollision(int xloc, int yloc, int xwid, int yhei){
  if((mouseX>xloc-1&&mouseX<xloc+xwid)&&(mouseY>yloc-1)&&(mouseY<yloc+yhei)){
    return true;
  }
  else{
    return false;
  }
}

void buttonHandle(int button_id, boolean state, int x, int y, int wid, int hei){
  if(state){                            //if currently not colliding
    if(getCollision(x,y,wid,hei)){      //and it collides
      Program.ButtonState[button_id]=1; //return to colliding position
      Program.display.invalidate();     //draw
    }
  }
  else{ //if currently colliding
    if(!getCollision(x,y,wid,hei)){ //and no longer colliding
      Program.ButtonState[button_id]=2; //stop colliding
      Program.display.invalidate();
    }
  }
}

void buttonStateUpdate(int button, int x, int y, int wid, int hei){
  switch(Program.ButtonState[button]){ //look at currently active button
    case 0: //if hasn't been pressed
      break; //nothing
    case 1:
      buttonHandle(button,false,x,y,wid,hei);
      break;
    case 2:
      buttonHandle(button,true,x,y,wid,hei);
      break;
    default:
      break;
  }
}
