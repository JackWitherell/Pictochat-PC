import java.util.Calendar;
Cal cal;

class Cal{
  private int dayOfWeek=-1;
  private int getDayOfWeek(){
    Calendar c=Calendar.getInstance();
    return c.get(Calendar.DAY_OF_WEEK);
  }
  private boolean init=false;
  private PGraphics calendar;
  private int today;
  private boolean isleap(int year){
    return (year%4==0)&&(year%100!=0)||(year%400==0);
  }
  private int days_in_month(int month){
    switch(month){
      case 9:
      case 4:
      case 6:
      case 11:
        return 30;
      case 2:
        return (isleap(year())?29:28);
      default:
        return 31;
    }
  }
  
  int tintAndOffset(int day, int today){
    if(day==0){
      calendar.tint(121,0,0);
    }
    else if(day==6){
      calendar.tint(0,0,129);
    }
    else{
      calendar.tint(48);
    }
    int offset;
    if(today>9&&today<20){
      offset=2;
    }
    else if(today>19){
      offset=3;
    }
    else{
      offset=0;
    }
    return offset;
  }
  PImage getCalendarImg(){
    boolean newDay=Time.newDay();
    if(newDay){
      dayOfWeek=-1;
      init=false;
    }
    if(dayOfWeek==-1){
      dayOfWeek=getDayOfWeek();
    }
    if(!init){
      calendar=createGraphics(115,114);
      calendar.beginDraw();
      println(dayOfWeek);
      int day=dayOfWeek-1;
      int offset;
      int line;
      today=day();
      int m_days=days_in_month(month());
      calendar.image(getImage(ASSET_CODE.DATE_SELECTION),(16*day)+2,((((today-day)/7)+1)*16)+34);
      for(int i=0;i<7;i++){
        offset=tintAndOffset(day, today);
        line=(((today-day)/7)+1);
        if(offset!=0){
          calendar.image(getImage(small_letter_a_code(today/10)),(16*day)-offset+7,(line*16)+37);
        }
        if(offset==3) offset--;
        calendar.image(getImage(small_letter_a_code(today%10)),(16*day)+offset+7,(line*16)+37);
        int back=today-7;
        int t_line=line;
        while(back>0){
          offset=tintAndOffset(day,back);
          t_line--;
          if(offset!=0){
            calendar.image(getImage(small_letter_a_code(back/10)),(16*day)-offset+7,(t_line*16)+37);
          }
          if(offset==3) offset--;
          calendar.image(getImage(small_letter_a_code(back%10)),(16*day)+offset+7,(t_line*16)+37);
          back-=7;
        }
        int forward=today+7;
        t_line=line;
        while(forward<=m_days){
          offset=tintAndOffset(day,forward);
          t_line++;
          if(offset!=0){
            calendar.image(getImage(small_letter_a_code(forward/10)),(16*day)-offset+7,(t_line*16)+37);
          }
          if(offset==3) offset--;
          calendar.image(getImage(small_letter_a_code(forward%10)),(16*day)+offset+7,(t_line*16)+37);
          forward+=7;
        }
        today--;
        day--;
        if(day==-1){
          day=6;
          today+=7;
        }
      }
      calendar.noTint();
      calendar.endDraw();
      init=true;
    }
    Date.updateDate();
    return calendar;
  }
}

static class Date{
  static int month;
  static int day;
  static int year;
  static void updateDate(){
    month=month();
    day=day();
    year=year();
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
  text(Date.month/10, 158, 44);//m
  text(Date.month%10, 166, 44);//m
  text("/", 175, 44);///
  text(Date.year/1000, 182, 44);//y
  text((Date.year/100)%10, 190, 44);//y
  text((Date.year/10)%10, 198, 44);//y
  text(Date.year%10, 204, 44);//y
  fill(255);
  image(cal.getCalendarImg(),127,31);
  println("x: "+mouseX+" y: "+mouseY);
}
