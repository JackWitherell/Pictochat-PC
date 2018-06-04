import java.util.Calendar;

static class Date{
  static private int dayOfWeek=0;
  static int getDayOfWeek(){
    if(dayOfWeek==0||Time.newDay()){
      Calendar c=Calendar.getInstance();
      dayOfWeek=c.get(Calendar.DAY_OF_WEEK);
    }
    return dayOfWeek;
  }
}
static class Time{
  static int hour;
  static int minute;
  static int second;
  static private boolean newDay;
  static boolean updateTime(){ //only reason why i'm doing it like this is
    int sec=second();          //to cut the amount of calls to date in half
    if(second!=sec){
      second=sec;
      int min=minute();
      if(minute!=min){
        minute=min;
        int hou=hour();
        if(hour!=hou){
          hour=hou;
        }
      }
      return true;
    }
    else return false;
  }
  static boolean newDay(){ //can only be called once. Put new day sound cues here!
    if(second==0&&minute==0&&hour==0){
      if(newDay==true){
        return false;
      }
      else{
        newDay=true;
        return newDay;
      }
    }
    else{
      if(newDay==true){
        newDay=false;
      }
      return false;
    }
  }
}

void displayTime(){
  stroke(97,130,154);
  strokeWeight(2);
  float sw=63+cos(((float(Time.second)/60)*TWO_PI)-HALF_PI)*37;
  float sh=95+sin(((float(Time.second)/60)*TWO_PI)-HALF_PI)*37;
  line(63,95,sw,sh); //render seconds
  stroke(121);
  float mw=63+cos(((float(Time.minute)/60)*TWO_PI)-HALF_PI)*31;
  float mh=95+sin(((float(Time.minute)/60)*TWO_PI)-HALF_PI)*31;
  line(63,95,mw,mh);
  float hw=63+cos((((float(Time.hour)+(float(Time.minute)/60))/12)*TWO_PI)-HALF_PI)*24;
  float hh=95+sin((((float(Time.hour)+(float(Time.minute)/60))/12)*TWO_PI)-HALF_PI)*24;
  line(63,95,hw,hh);
  fill(73);
  noStroke();
  rect(61,93,5,5);
  fill(73);
  text("0", 158, 44);//m
  text("6", 166, 44);//m
  text("/", 175, 44);///
  text("2", 182, 44);//y
  text("0", 190, 44);//y
  text("1", 198, 44);//y
  text("8", 204, 44);//y
  fill(255);
  text("this bitch empty, yeet", 4,12);
}
