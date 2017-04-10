//statement: making a wall react to body positions. >>
//a wall projected of an ocean view, detecting body positons and sound varies with body movement. 3/13/17

//think about using a mirror/(order it?)
// get it to work with projector
//think of where the audio/speaker should be, (should I borrow one?)
//feedback and other consideration from Kathrine 3_13_1_17
//*****input camera height image trigger sound output
//multiple-channel sound out
//moving the sound around the space
//Consider what importance will visual and sound have
//Sensing the body, maybe break the body down, consider tracking the  top of the head is
//for tracking the top of the head, try Dan's example to build upon
//triggering the outputs (sounds, filed recording and sound examples collecting)
//sea like image-ok 3_20_17 see sketch_ocean
//sound collection list in evernote_
//need to add pause when moving out off range


//Daily log
//try synapse to track body motion 3_14_17 (delete)
//delete skeleton tracking 3_17_17
//try get kinect to work http://shiffman.net/p5/kinect/ 3_20_17
//consider using other method to track the body movement(possible skeleton tracking instead of the highest point 3_25_17
//change kinect detection into ----depth dectection, walk into the sea feeling. 3_25_17 
//try customed funtion to make kinect act as a switch, try to play video test no successful
//try to play audio successful 3_27_17

// Synapse tracked skeketon data, seems like I need a seperate OOP to let the synapese run, yet install 3_14_17
//Skeleton skeleton = new Skeleton(); 3_17_17

import org.openkinect.freenect.*;
import org.openkinect.processing.*;
import ddf.minim.*;
import processing.video.*;
Movie myMovie;

Kinect kinect;// reference a Kinect object
Minim minim;
AudioPlayer farSea;

// Depth image
PImage depthImg;

// how far the person should stand to trigger the sound
int minDepth = 1000;
int maxDepth = 1000;

boolean flag = false;//make audio play once

void setup()
{
 //size(800, 480);//with seaview
 size(1920, 1080);//withseaviewbig
 //myMovie = new Movie(this, "seaview.mp4");
 myMovie = new Movie(this, "seaviewbig.mp4");

 myMovie.play();
  kinect = new Kinect(this);
   kinect.initDepth();
   //kinect.initDevice(); //initialize the kinect object
  depthImg = new PImage(kinect.width, kinect.height);    // Blank image_need this to work
}
  //tracker = new KinectTracker(); 3_17_17
  
//need to impport ocean image video
//project the ocean image 

//try accessing data from the kinect sensor, question? which data is better for head tracking
//try greyscale depth image
//try closest and hightest point of the image 3_20_17
//https://www.youtube.com/watch?v=nYCvdtZGveg&list=PLRqwX-V7Uu6ZMlWHdcy8hAGDy6IaoxUKf&index=5
//see sketch


void draw()
{
  background(0,0,0);
  PImage img = kinect.getDepthImage();//request greyscale image
  image(img, 0, 0); //request greyscale image,
  image(myMovie, 0, 0);
  
  
    // Threshold the depth image
  int[] rawDepth = kinect.getRawDepth();// get raw depth data
  for (int i=0; i < rawDepth.length; i++) {
    if (rawDepth[i] >= minDepth && rawDepth[i] <= maxDepth)    
 {
      depthImg.pixels[i] = color(255);//white
      if (!flag)
      {
        music();
      }
    } else
    {
      depthImg.pixels[i] = color(0);
    }
    //else 
    //{
    //  farSea.pause();
    //}
  }

   // Draw the thresholded image
  depthImg.updatePixels();
  //image(depthImg, -100 , -100);// orignal reads image(depthImg, kinect.width, 0);
}
  void music()
{
  minim = new Minim(this);
  //farSea = minim.loadFile("farSea.mp3");
  farSea = minim.loadFile("midSea.mp3");//bubbly
  farSea.loop();
  flag = true;
}

void movieEvent(Movie m) 
{
  m.read();
}