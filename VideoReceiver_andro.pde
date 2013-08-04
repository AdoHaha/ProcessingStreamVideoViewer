import java.awt.image.*; 
import javax.imageio.*;
import java.io.*;
import java.net.*;
import java.awt.Image;
// Port we are receiving.
int port = 9100; 
DatagramSocket ds; 
// A byte array to read into (max size of 65536, could be smaller)
byte[] buffer = new byte[65536]; 

PImage video;
CamStream m_imgStream = null;

URL m_mainURL= null;
String m_userAgent;
URL m_documentBase = null;
int m_retryCount = 3;
int m_retryDelay = 3000;
boolean m_debug = false;
ExceptionReporter fufu = null;
Image klatkaimage = null;


void setup() {
  size(400,300);
  //m_mainURL=new URL("192.168.0.105");
  String addd= "http://192.168.0.105:8080/?action=stream";
  try {
  m_mainURL=new URL(addd);
  m_userAgent="localyo";
  }
  catch( MalformedURLException e1)
  {
  }
  
  video = createImage(320,240,RGB);
  
   m_imgStream = new CamStream(m_mainURL, m_userAgent, m_documentBase, m_retryCount, m_retryDelay, fufu, m_debug);
   //m_imgStream.addImageChangeListener(this);
   m_imgStream.start();
  
  
  
}

 void draw() {
  // checkForImage() is blocking, stay tuned for threaded example!
  checkForImage();

  // Draw the image
  background(0);
  imageMode(CENTER);
  image(video,width/2,height/2);
}

void checkForImage() {
  
  try
  {
  klatkaimage=m_imgStream.getCurrent();
  }
  catch (ArrayIndexOutOfBoundsException e1)
  {
    klatkaimage=null;
  }
  //Graphics g = klatkaimage.getGraphics();
  if(klatkaimage!=null)
  {
  video= new PImage(klatkaimage);
  }
/*  DatagramPacket p = new DatagramPacket(buffer, buffer.length); 
  try {
    ds.receive(p);
  } catch (IOException e) {
    e.printStackTrace();
  } 
  byte[] data = p.getData();

  println("Received datagram with " + data.length + " bytes." );

  // Read incoming data into a ByteArrayInputStream
  ByteArrayInputStream bais = new ByteArrayInputStream( data );

  // We need to unpack JPG and put it in the PImage video
  video.loadPixels();
  try {
    // Make a BufferedImage out of the incoming bytes
    BufferedImage img = ImageIO.read(bais);
    // Put the pixels into the video PImage
    img.getRGB(0, 0, video.width, video.height, video.pixels, 0, video.width);
  } catch (Exception e) {
    e.printStackTrace();
  }
  // Update the PImage pixels
  video.updatePixels();*/
}

