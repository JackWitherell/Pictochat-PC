import processing.net.*; 

Client cli;
int dataIn;
int a,b;

void setup() {
  size(200, 200);
  // Connect to the local machine at port 5204.
  // This example will not run if you haven't
  // previously started a server on this port.
  cli = new Client(this, "127.0.0.1", 5204); 
}

void mousePressed(){
  cli.write('a');
}

void draw() {
  while (cli.available() > 0){
    dataIn = cli.read();
    switch(dataIn){
      case 'a':
        dataIn=cli.read();
        a=dataIn;
        break;
      case 'b':
        dataIn=cli.read();
        b=dataIn;
        break;
      case -1:
      default:
        break;
    };
  }
  background(0);
  fill(a,0,0);
  rect(0,0,width,height/2);
  fill(0,b,0);
  rect(0,height/2,width,height/2);
}