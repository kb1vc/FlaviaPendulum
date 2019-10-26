

#define COIL 7
#define SENSE A2


// the setup function runs once when you press reset or power the board
void setup() {
  // initialize digital pin LED_BUILTIN as an output.
  pinMode(LED_BUILTIN, OUTPUT);
  pinMode(COIL, OUTPUT);
  pinMode(SENSE, INPUT);
  digitalWrite(SENSE, LOW);


}


#define KICK_DELAY 5
#define KICK_DURATION 200  // 50 seemed adequate not quite -- 100 not quite 
#define POST_KICK_WAIT 400
#define THRESHOLD 80// 60 100 400 -- certainly not 400 ? not 200 80 too much

int max_value = 0;
void loop()
{
  unsigned int val, filt;


  filt = 0; 

  delay(10);

  while (filt < THRESHOLD) { //  || (dvdt_filt < 0)) {
    val = analogRead(SENSE);

    // need to low pass filter this stuff. 
    filt = (filt + 8 * val - val) >> 3;  // y[n] = 7/8 x[n] + 1/8 y[n-1]

  }

  // kick
  delay(KICK_DELAY);
  digitalWrite(COIL, HIGH);
  digitalWrite(LED_BUILTIN, HIGH);
  delay(KICK_DURATION);
  digitalWrite(COIL, LOW);

  delay(POST_KICK_WAIT);
  digitalWrite(LED_BUILTIN, LOW);
}


