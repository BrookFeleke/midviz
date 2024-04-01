Table table; // Declare a Table variable
float totalDuration;
int rowCount;
float maxDur = 0;
float minDur;
String NOC = " Note_on_c";
String NOFC = " Note_off_c";
void setup() {
fullScreen();
  // Load the CSV file "data.csv" from the data folder
  table = loadTable("tchaipc.csv", "header");
  totalDuration = table.getRow(table.getRowCount()-1).getFloat(1);
  rowCount = table.getRowCount();
  println(rowCount);
  // Print the number of rows and columns in the table
  println("Loaded " + table.getRowCount() + " rows and " + table.getColumnCount() + " columns.");
  int count = 0;
  // Print the column names
  for (int i = 0; i < rowCount; i++) {
    //println("Column " + ": " + table.getColumnTitle(2));
    //println(row.getString(2));
    int tempI = i;
    
    String value = table.getString(i, 2);
    int note = table.getInt(i, 4);
    float duration;
    
    if (value.equals(NOC)) {

      while (table.getString(tempI, 2) != NOFC & table.getInt(tempI, 4) == note & tempI<rowCount-1) {
        tempI++;
      }
      if (tempI<rowCount-1)  duration = table.getFloat(tempI, 1)-table.getFloat(i, 1);
      else duration = totalDuration -table.getFloat(i, 1);
       if(i==0) {maxDur = duration;minDur=duration;}
       else{
      if(duration > maxDur) maxDur = duration;
      if(duration < minDur) minDur = duration;
       }
      println("Duration for "+note+ " is "+duration);
      count = count + 1;
    }
  }
 
  // Print the data in each row
}

void draw() {
  background(5);
  strokeWeight(5);
  stroke(0);
  //fill(125,54,12,70);
  float r = 50;
  for (int i = 0; i < rowCount; i++) {
    int tempI = i;
    int note = table.getInt(i, 4);
    float duration; 
    String value = table.getString(i, 2);
    if (value.equals(NOC)) {
      while (table.getString(tempI, 2) != NOFC & table.getInt(tempI, 4) == note & tempI<rowCount-1) {
        tempI++;
      }
      if (tempI<rowCount-1)  duration = table.getFloat(tempI, 1)-table.getFloat(i, 1);
      else duration = totalDuration -table.getFloat(i, 1);
      PVector cords = getCoords(table.getFloat(i, 1), totalDuration, table.getFloat(i, 4));
      //strokeWeight(5);
      fill(200,127,140,100);
      noStroke();
      
      circle(width/2 + cords.x, height/2+cords.y,map(duration,minDur,maxDur,5,50));
      //strokeWeight(2);
      
      point(width/2 + cords.x, height/2+cords.y);
    }
  }
 
}


PVector getCoords(float cur, float max, float r) {
  float angleDegrees = map(cur, 0, max, 0, 360);
  float angleRadians = radians(angleDegrees);
  float radius = 150;
  float add;
  if(r>60) {add = map(r, 60, 75, 0, 100);}
  else { add = map(r,0,60,-100,0);  println(add);}
   //println(add);
  // Calculate x and y coordinates using trigonometric functions
  float x = (radius+add) *cos(angleRadians); // x = cos(angle)
  float y = (radius+add) *sin(angleRadians); // y = sin(angle)
  PVector coords = new PVector(x, y);
  return coords;
}
