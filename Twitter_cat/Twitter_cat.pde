import twitter4j.conf.*;
import twitter4j.internal.async.*;
import twitter4j.internal.org.json.*;
import twitter4j.internal.logging.*;
import twitter4j.http.*;
import twitter4j.api.*;
import twitter4j.util.*;
import twitter4j.internal.http.*;
import twitter4j.*;

import processing.serial.*;       

Serial port; // The serial port we will be using

int tweetcount = 0;

//Build an ArrayList to hold all of the words that we get from the imported tweets
ArrayList<String> words = new ArrayList();

void setup(){
//TwitterFactory twitterFactory;
  //Set the size of the stage, and the background to black.

  
   port = new Serial(this, Serial.list()[2], 9600); 

ConfigurationBuilder cb = new ConfigurationBuilder();
cb.setOAuthConsumerKey("***");
cb.setOAuthConsumerSecret("***");
cb.setOAuthAccessToken("***");
cb.setOAuthAccessTokenSecret("***");

Twitter twitter = new TwitterFactory(cb.build()).getInstance();
Query query = new Query("#goldenLuckyCat");
query.count(100);
 


do{
try {
  QueryResult result = twitter.search(query);
  ArrayList tweets = (ArrayList) result.getTweets();
// println(tweets.size());

if (tweets.size() > tweetcount) {
  port.write('1');         //send a 1. This tells the motor to turn. 
  println("go cat"); 
   
  for (int i = tweets.size()-1; i >= 0; i--) {
    Status t = (Status) tweets.get(i);
    User u=(User) t.getUser();
    String user=u.getName();
  //  String user = t.getFromUser();
    String msg = t.getText();
  //  Date d = t.getCreatedAt();
    println("Tweet by " + user + " at " + ": " + msg);
     
     //Break the tweet into words
   //   String[] input = msg.split(" ");
   //   for (int j = 0;  j < input.length; j++) {
       //Put each word into the words ArrayList
   //    words.add(input[j]);
   //   }
   
  };
  tweetcount = tweets.size();
}
}

catch (TwitterException te) {
  println("Couldn't connect: " + te);
  };

delay (10000);
}
while(true);
}


  
void draw() {
    size(550,550);
  background(0);
  smooth();
  //Draw a faint black rectangle over what is currently on the stage so it fades over time.
  fill(0,1);
  rect(0,0,width,height);
   
  //Draw a word from the list of words that we've built
  int i = (frameCount % words.size());
  String word = words.get(i);
   
  //Put it somewhere random on the stage, with a random size and colour
  fill(255,random(50,150));
  textSize(random(10,30));
  text(word, random(width), random(height));
}

void mousePressed() {                           //if we clicked in the window
   port.write('1');         //send a 1. This tells the motor to turn. 
   println("1");   
  } 
