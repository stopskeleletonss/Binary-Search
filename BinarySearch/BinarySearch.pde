String[] readvalues, splitvalues; //string arrays for reading the values from the csv file and for splitting the joined data from the csv file
String combinevalues; //string that combines the data from the csv file
int[] numvalues; //int array for switching the data from the csv file to numerical
int temp; //variable that temporarily holds a value in order for the two values being compared to switch
int middle; //variable that holds the section of the array currently being used as the "middle" in the binary search
int first, last; //variables for the first and last numbers being used in the binary search
int wantednum; //variable for the value currently being searched for in the numvalues array
float currenttime; //float variable for the current time passed in milliseconds since the program began
boolean timerstop; //boolean for whether the timer has stopped or not

void setup() {
  size(200,200);
  valuesetup();
  sortvalues();
}

void draw() {
  background(0);
  timer();
  binarysearch();
}

void valuesetup() { //function to prepare the values from the csv file to be sorted
  readvalues = loadStrings("numbers.txt"); //loads the data from the file into the readvalues array
  combinevalues = join(readvalues, ","); //combines the values held in the readvalues array into one line
  splitvalues = split(combinevalues, ","); //splits the values held in the combinevalues array back into their own separate lines
  numvalues = int(splitvalues); //converts the strings held in the splitevalues array to numerical values
  first = numvalues[0]; //first is equal to the first value in the numvalues array
  last = numvalues.length; //last is equal to the last value in the numvalues array
  wantednum = 33; //the value being searched for in the data is currently 33, but can be changed to any number
}


void sortvalues() { //function that sorts the values from least to greatest by comparingthem to the adjacent value to the right
  for (int index = 0; index < splitvalues.length; index++) { //index variable has an initial value of 0, must be less than the length of splitvalues array, and increases by increments of 1
    for (int index1 = 0; index1 < splitvalues.length-index-1; index1++) { //index1 variable has an initial value of 0, must be less than the length of splitvalues array minus the value of index and an additional -1, and increases by increments of 1
      if (numvalues[index1] > numvalues[index1+1]) { //if a value in the array is larger than the next value in the array
        temp = (numvalues[index1]); //the value of the larger number is stored in the temp variable
        numvalues[index1] = numvalues[index1+1]; //the smaller number moves to the position in the array that contained the larger number
        numvalues[index1+1] = (temp); //the larger number moves to the position in the array that contained the smaller number
      }
    }
  }
}

void timer() {
 fill(255);
 textAlign(CENTER);
 textSize(50);
 text(currenttime/1000, width/2, height/2);
 if (timerstop==false) { //if the timer hasn't been stopped
   currenttime=millis(); //currenttime is equal to the amount of milliseconds since the program was opened
 }
}


void binarysearch() { //function to search the data in the array by dividing the interval being searched in half over and over until it finds the desired value
  while (first <= last) { //while the first number is less than or equal to the highest number
    if (numvalues[middle] < wantednum) { //if the middle number in the numbers array is less than the desired value
      first = middle++; //the lowest number is equal to the middle number plus one
    } else if (numvalues[middle] == wantednum) { //if the desired value has been located
      println (wantednum +" is in section " +middle +" of the array."); //states where the desired value is located within the array
      timerstop=true; //stop the timer
      break; //ends the while loop
    } else { 
      last = middle++; //the last number is equal to the middle number plus one
    }
    middle = (first + last)/2; //the middle number is equal to the number in the middle of the first and last numbers
  }
}
