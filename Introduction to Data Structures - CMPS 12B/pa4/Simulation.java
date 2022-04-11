//-----------------------------------------------------------------------------
// SimulationStub.java
//-----------------------------------------------------------------------------

import java.io.*;
import java.util.Scanner;

public class Simulation{

//-----------------------------------------------------------------------------
//
// The following function may be of use in assembling the initial backup and/or
// storage queues.  You may use it as is, alter it as you see fit, or delete it
// altogether.
//
//-----------------------------------------------------------------------------

   public static Job getJob(Scanner in) {
      String[] s = in.nextLine().split(" ");
      int a = Integer.parseInt(s[0]);
      int d = Integer.parseInt(s[1]);
      return new Job(a, d);
   }

//-----------------------------------------------------------------------------
//
// The following stub for function main contains a possible algorithm for this
// project.  Follow it if you like.  Note that there are no instructions below
// which mention writing to either of the output files.  You must intersperse
// those commands as necessary.
//
//-----------------------------------------------------------------------------

  public static void main(String[] args) throws IOException{

//    1.  check command line arguments
//
//    2.  open files for reading and writing
//
//    3.  read in m jobs from input file
//
//    4.  run simulation with n processors for n=1 to n=m-1  {
//
//    5.      declare and initialize an array of n processor Queues and any
//            necessary storage Queues
//
//    6.      while unprocessed jobs remain  {
//
//    7.          determine the time of the next arrival or finish event and
//                update time
//
//    8.          complete all processes finishing now
//
//    9.          if there are any jobs arriving now, assign them to a processor
//                Queue of minimum length and with lowest index in the queue array.
//
//    10.     } end loop
//
//    11.     compute the total wait, maximum wait, and average wait for
//            all Jobs, then reset finish times
//
//    12. } end loop
//
//    13. close input and output files
    if(args.length != 1){
      System.out.println("Usage: SimulationStub <input file>");
      System.exit(1);
    }

    in = new Scanner(new File(args[0]));
    int m;
    m = Integer.parseInt(in.nextLine());
    int n = 1;
    Queue backup = new Queue();

    for(int i = 0; i < m; m++){
      backup.enqueue(getJob(in));
    }

    for(n = 1; n < m-1; n++){
      Queue[] processor = new Queue[n+1];

      for(int i = 0; i < n+1; n++){
        processor[i] = new Queue();
      }

      for(int i = 0; i < backup.length(); i++){
        processor[0].enqueue(backup.peek());
        backup.enqueue(backup.dequeue());
      }
      while(true){
        int time = 0;
        boolean processorArrayIsEmpty = true;
        for(int i = 1; i < n+1; i++){
          if(!processor[i].isEmpty()){
            processorArrayIsEmpty = false;
            break;
          }
        }
        if(((Job) processor[0].peek()).getFinish() != Job.UNDEF){
          if(processorArrayIsEmpty){
            break;

          }
        }
        if(time == 0){
          time = ((Job) processor[0].peek()).getArrival();
          processor[1].enquee(processor[0].dequeue());
          Job j = (Job)processor[1].peek();
          j.computeFinishTime(time);
        }
        time++;
      }
    }
  }
