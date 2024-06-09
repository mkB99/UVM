`define WIDTH 8
`define DEPTH 16

interface fifo_if(input wr_clk, rd_clk);

   logic [`WIDTH-1:0] din;
   logic wr_en,rd_en;
   logic clear_n;
   logic full, almost_full;
   logic [15:0] wr_count;
   logic wr_ack, wr_err;
   logic [7:0] dout;
   logic empty, almost_empty;
   logic [`DEPTH-1:0] rd_count;
   logic rd_ack, rd_err;

//read_signals
   
   clocking wdr_cb@(posedge wr_clk);
      default input #1 output #1;
      output din,wr_en, clear_n;
   endclocking
   
   clocking wmon_cb@(posedge wr_clk);
      default input #1 output #1;
      input wr_en,wr_ack,wr_err,din;
   endclocking
   
   clocking rdr_cb@(posedge rd_clk);
      default input #1 output #1;
      output rd_en, clear_n;
   endclocking
   
   clocking rmon_cb@(posedge rd_clk);
    default input #1 output #1;
      input rd_en,rd_ack,rd_err,dout,
               full,almost_full,almost_empty,empty,
                  wr_en,wr_ack,wr_err;
      endclocking
   
   modport WDR_MP (clocking wdr_cb);
   
   modport WMON_MP (clocking wmon_cb);
   
   modport RDR_MP (clocking rdr_cb);
   
   modport RMON_MP (clocking rmon_cb);
   
 endinterface
