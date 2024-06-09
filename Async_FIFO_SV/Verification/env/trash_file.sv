//reference model file

//temperory varaibles
//protected logic w_ack,r_ack,w_err,r_err;
//protected logic [`WIDTH-1:0]d_out;
//protected logic clear;
//event got;//, wgetn;

         //wildcard bins wr_fh_bin4 = (6'b110111 => 6'b111011);                  
         //wildcard bins wr_fh_bin6 = (6'b101000 => 6'b101000);                  
         //wildcard bins rd_fh_bin4 = (6'b110000 => 6'b110000);                  
         //wildcard bins rd_fh_bin6 = (6'b111001 => 6'b111000);                  




/*
 else if(fifo_mem.size() == 0) begin
                     fifo_mem.push_front(wr_data.din);
                     
                     wdata2scb.wr_en = wr_data.wr_en;   
                     wdata2scb.din = wr_data.din;   
                     wdata2scb.full = 0;   
                     wdata2scb.almost_full = 0;   
                        w_ack = 1;
                        w_err = 0;
                  end
                  else if(fifo_mem.size() == 1) begin
                     fifo_mem.push_front(wr_data.din);

                     wdata2scb.wr_en = wr_data.wr_en;   
                     wdata2scb.din = wr_data.din;   
                     wdata2scb.full = 0;   
                     wdata2scb.almost_full = 0;   
                        w_ack = 1;
                        w_err = 0;
                     //cg_fifo.sample();
                  end


*/


/*
                  else if(!rd_data.rd_en) begin
                  data2scb.rd_en = wr_data.rd_en;   
                  data2scb.din = wr_data.din;   
                  r_ack = 0;
                  r_err = 0;
                  if(fifo_mem.size() == 0) begin
                     data2scb.rd_en = wr_data.rd_en;   
                     data2scb.din = wr_data.din;   
                     data2scb.empty = 0;   
                     data2scb.almost_empty = 0;
                  end
                  else if(fifo_mem.size() == 1) begin
                     data2scb.rd_en = wr_data.rd_en;   
                     data2scb.din = wr_data.din;   
                     data2scb.empty = 0;   
                     data2scb.almost_empty = 1;
                  end
                  else if(fifo_mem.size() == `DEPTH-1) begin
                     data2scb.rd_en = wr_data.rd_en;   
                     data2scb.din = wr_data.din;   
                     data2scb.empty = 0;   
                     data2scb.almost_empty = 0;
                  end
                  else if(fifo_mem.size() == `DEPTH) begin
                     data2scb.rd_en = wr_data.rd_en;   
                     data2scb.din = wr_data.din;   
                     data2scb.empty = 0;   
                     data2scb.almost_empty = 0;
                  end
               end
               */
                            
               /*else if(rd_data.rd_en === 1'bx) begin
                  data2scb.full = 0;   
                  data2scb.almost_full = 0;   
                  data2scb.empty = 1;   
                  data2scb.almost_empty = 1;

                     r_ack = 0; 
                     r_err = 0; 
               end
            end
         end*/

         /*
         //generating the handshake signals and d_out seperately
         begin
            #RDCLK_PERIOD;
            if(rd_data.rd_en == READ) begin
               if(fifo_mem.size==`DEPTH) begin
                  d_out = fifo_mem.pop_back();
                  //w_ack = 0; 
                  //w_err = 1; 
                  r_ack = 1; 
                  r_err = 0; 
               end
               else if(fifo_mem.size==`DEPTH-1) begin
                  d_out = fifo_mem.pop_back();
                  //w_ack = 0; 
                  //w_err = 1; 
                  r_ack = 1; 
                  r_err = 0; 
               end
               else if(fifo_mem.size==1) begin
                  d_out = fifo_mem.pop_back();
                  //w_ack = 0; 
                  //w_err = 1; 
                  r_ack = 1; 
                  r_err = 0; 
               end
               else if(fifo_mem.size==0) begin
                  //w_ack = 0; 
                  //w_err = 1; 
                  r_ack = 0; 
                  r_err = 1; 
               end
               else begin
                  r_ack = 1; 
                  r_err = 0; 
               end
            end
            else if(rd_data.rd_en == DONT_READ) begin
               r_ack = 0; 
               r_err = 0; 
            end
         end
         */


/*
virtual function fifo_trans predict_data(fifo_trans wr_data1, rd_data1, data2scb1);
fork
//   forever begin
//      @(vintf1.wr_monitor_cb, wr_data1.clear_n) 
      begin
      $display("============ wr_data1.clear_n: %0d",wr_data1.clear_n);
      $display("============ wr_data1.wr_en: %0d",wr_data1.wr_en);
      $display("============ wr_data1.rd_en: %0d",rd_data1.rd_en);
      $display("============ wr_data1.full: %0d",rd_data1.full);
      if(!wr_data1.clear_n)         
      begin
         data2scb1.full<=1'b1;
         data2scb1.almost_full<=1'b1;
         data2scb1.almost_empty<=1'b1;
         data2scb1.empty<=1'b1;
         //data2scb1.flag<=1'b1;
         $display("============= data2scb1.full: %0d",data2scb1.full);
      end
      
      else if(wr_data1.wr_en)
      begin
      if(rd_data1.full) begin
               data2scb1.wr_err<=1'b1;
               data2scb1.wr_ack<=1'b0;
      end
         
      else if(rd_data1.almost_full) begin
               ref_mem[wptr]<= wr_data1.din;
               wptr <= wptr+1;
               data2scb1.wr_ack <= 1'b1;
               data2scb1.wr_err <= 1'b0;
      end
      else begin
               ref_mem[wptr]<= wr_data1.din;
               $display("============= ref_mem: %p, wptr: %0d",ref_mem, wptr);
               wptr<=wptr+1;
               data2scb1.wr_ack<=1'b1;
               data2scb1.wr_err<=1'b0;
               $display("============= data2scb1.wr_ack: %0d",data2scb1.wr_ack);
               $display("============= data2scb1.wr_err: %0d",data2scb1.wr_err);
      end
      end
      else
      begin
         data2scb1.wr_ack<=1'b0;
         data2scb1.wr_err<=1'b0;
      end
      end
//   end
//   forever begin
//   @(vintf2.rd_monitor_cb, rd_data1.clear_n) 
   begin
      if(!rd_data1.clear_n)         
      begin
         data2scb1.full<=1'b1;
         data2scb1.almost_full<=1'b1;
         data2scb1.almost_empty<=1'b1;
         data2scb1.empty<=1'b1;
         //data2scb1.flag<=1'b1;
      end

      else if(rd_data1.rd_en)   
      begin
      $display("============= rd_data1.rd_en : %0d",rd_data1.rd_en);
         if(rd_data1.empty)
            begin
               data2scb1.rd_ack<=1'b0;
               data2scb1.rd_err<=1'b1;
            end
         else if(rd_data1.almost_empty)
            begin
               data2scb1.d_out <= ref_mem[rptr];
               $display("============= data2scb1.d_out: %0d",data2scb1.d_out);
               rptr<=rptr+1;
               data2scb1.rd_ack <= 1'b1;
               data2scb1.rd_err<=1'b0;
            end
         else
            begin
               data2scb1.d_out<=ref_mem[rptr];
               rptr<=rptr+1;
               data2scb1.rd_ack<=1'b1;
               data2scb1.rd_err<=1'b0;
            end
      end
      else
      begin
         data2scb1.rd_ack<=1'b0;
         data2scb1.rd_err<=1'b0;
      end
   end
join
$display("data2scb: %p", data2scb1);
   return data2scb1;
endfunction
*/
               /*
               else if(fifo_mem.size() == (`DEPTH-1)) begin
                  fifo_mem.push_front(wr_data.din);
                  w_ack = 1;
                  w_err = 0;
               end
               else if(fifo_mem.size() == (`DEPTH-2)) begin
                  fifo_mem.push_front(wr_data.din);

                  w_ack = 1;
                  w_err = 0;
               end
               */

               /*
               if(fifo_mem.size() == `DEPTH-1) begin
                  wdata2scb.full = 0;   
                  wdata2scb.almost_full = 1;   
               end
               else if(fifo_mem.size() == `DEPTH) begin
                  wdata2scb.full = 1;   
                  wdata2scb.almost_full = 1;   
               end
               else begin
                  wdata2scb.full = 0;   
                  wdata2scb.almost_full = 0;   
               end
               */
               /*
               else if(fifo_mem.size() == 1) begin
               //else begin
                  rdata2scb.dout = fifo_mem.pop_back();

                  r_ack = 1;
                  r_err = 0;
               end
               else if(fifo_mem.size() == 2) begin
                  rdata2scb.dout = fifo_mem.pop_back();
                  
                  r_ack = 1;
                  r_err = 0;
               end*/






//read_trans file:

  /*
  function void copy(Transaction rhs);
  endfunction

  function Transaction clone();
     clone = new();
     clone.copy(this);
  endfunction
*/


