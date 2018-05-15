import processing.net.*;

Server net;

int a=0;
int b=0;

void setup(){
  size(300,100);
  net = new Server(this,5204);
}

void draw(){
  background(0);
  Client incoming = net.available();
  while(incoming!=null){
    int in=incoming.read();
    switch(in){
      case'a':
        a++;
        break;
      case'b':
        b++;
        break;
    }
    incoming=net.available();
  }
  net.write(-1);
  net.write('a');
  net.write(a);
  net.write(-1);
  net.write('b');
  net.write(b);
}