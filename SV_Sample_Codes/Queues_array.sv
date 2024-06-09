/**********************************************************************************************
 * Name                 : Queues.sv
 * Creation Date        : 21-10-2021
 * Last Modified        : 21-10-2021
 * Author               : Badam Mayur Krishna
 * Author's Email       : mayurkrishna.b@alpha-numero.tech
 * Description          : 
 - Declare an integer queue.
 - Initialize it with five elements (0 to 4).
 - Insert an element at beginning without any method.
 - Insert an element at beginning using predefined queue method.
 - Insert an element at the end using predefined queue method.
 - Insert an element at index - 4.
 - Get 1st element in queue.
 - Get last element in queue.
 - Delete an element at index - 4 in queue.
 - Get each element from queue and print using predefined queue method.
 - Use a method to print queue after each of the above operations.
**********************************************************************************************/
module Queues;
   string msg;
   int  q1[$] = '{1, 23,43, 12, 67};

   function automatic void display1(int q2[$], string msg2);  
      $display("q1: %p after %s",q2, msg2);
   endfunction

initial begin
   //Declaring an integer queue.
   msg="initialization";
   display1(q1, msg);
   //Insert an element at beginning without any method.
   q1 = {34,q1};
   msg="inserting an element at beginning";
   display1(q1, msg);

   //Insert an element at beginning using predefined queue method.
   q1.insert(0,98);
   msg="inserting an element at beginning using pre-defined method";
   display1(q1, msg);

   //Insert an element at the end using predefined queue method.
   q1.insert((q1.size()),55);
   msg="inserting an element at end";
   display1(q1, msg);

   //Insert an element at index - 4.
   q1.insert(4,66);
   msg="inserting an element at index 4";
   display1(q1, msg);

   //Get 1st and element in queue.
   $display("first element: %0d",q1[0]);
   $display("Last element: %0d",q1[$]);
   display1(q1, msg);
   
   //Delete an element at index 4 in queue.
   q1.delete(4);
   msg="deleting an element at index 4";
   display1(q1, msg);

   //Get each element from queue and print using predefined queue method.
   $display("Elements of the queue are:");
   foreach(q1[i]) begin
      $display("%0d",q1.pop_front()); 
   end
end
endmodule

//OUTPUTS:
//q1: '{1, 23, 43, 12, 67} after initialization
//q1: '{34, 1, 23, 43, 12, 67} after inserting an element at beginning
//q1: '{98, 34, 1, 23, 43, 12, 67} after inserting an element at beginning using pre-defined method
//q1: '{98, 34, 1, 23, 43, 12, 67, 55} after inserting an element at end
//q1: '{98, 34, 1, 23, 66, 43, 12, 67, 55} after inserting an element at index 4
//first element: 98
//Last element: 55
//q1: '{98, 34, 1, 23, 66, 43, 12, 67, 55} after inserting an element at index 4
//q1: '{98, 34, 1, 23, 43, 12, 67, 55} after deleting an element at index 4
//Elements of the queue are:
//98
//34
//1
//23
//End time: 16:08:01 on Jun 06,2022, Elapsed time: 0:00:05
//Errors: 0, Warnings: 1
