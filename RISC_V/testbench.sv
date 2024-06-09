// Code your testbench here
// or browse Examples
`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

import uvm_pkg::*; 
`include "uvm_macros.svh"




//////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////



package agnt_pkg;
//`include"uvm_macros.svh"
	`include "uvm_macros.svh"

import uvm_pkg::*; 
`include "uvm_macros.svh"

//`include"uvm_macros.svh"

class processor_transaction extends uvm_sequence_item;

  `uvm_object_utils(processor_transaction)
  
  rand bit [15:0] inst_in;
  bit [7:0]pc_out;
   bit [15:0]inst_out;
  
  //////////////////////////////
  //logic [15:0]inst_in;
  //logic [7:0]pc_out;
  // logic [15:0]inst_out;
  bit [2:0]jmp_val;
  bit jmp,eop;
  bit [1:0]regwr_out2,dir_val_out2;
  bit memwr_out2,ctrl_sel_out2,wrbk_sel_out2;
 bit [2:0]aD_out2,dir_s2_out2;
  bit [3:0]alu_sel_out2;
  bit [7:0]dir_s1_out2;
  bit  [15:0]s1_out2,s2_out2;
 bit  [1:0]reg_wr_out3,reconfig_mul,reconfig_load;
  bit mem_wr_out3,wrbk_sel_out3;
  bit [2:0]aM_out3,aD_out3;
  bit [15:0]alu_out3,dM_out3;
  bit [15:0]wD_rf;
  bit [1:0]w_en;
  bit [2:0]aD_rf;
  bit s1_c0,s1_c1,s2_c0,s2_c1;
  bit [1:0]inita;
  bit [2:0]initb;
  bit [15:0]pc_2,pc_3,inst_out_tb;
  
  ////////////////////
  
   bit [15:0]reg_data;
  bit [1:0]reg_en;
   bit [2:0]reg_add;
  bit [15:0]mem_data_tb;
   bit mem_en_tb;
  bit [2:0]mem_add_tb;
constraint input_constraint
   {
	//Cosntraint to prevent EOF operation
      inst_in inside {[16'h0000:16'hEFFF]};
   }
  function new (string name = "");
    super.new(name);
  endfunction

endclass: processor_transaction


class inst_sequence extends uvm_sequence#(processor_transaction);

  `uvm_object_utils(inst_sequence)

  function new (string name = "");
    super.new(name);
  endfunction

  bit [15:0] inst;
processor_transaction req;
  task body;
    
      req = processor_transaction::type_id::create("req");

      start_item(req);

      if (!req.randomize()) begin
        `uvm_error("Instruction Sequence", "Randomize failed.");
      end
     inst = req.inst_in;

      finish_item(req);
    
  endtask: body

endclass: inst_sequence



class processor_sequence extends uvm_sequence#(processor_transaction);

  `uvm_object_utils(processor_sequence)

  function new (string name = "");
    super.new(name);
  endfunction

  inst_sequence inst_seq;

  task body;
    
	//LOOP relative to use case (say 256)
     for(int i =0;i<10000;i++) 
     begin
        inst_seq = inst_sequence::type_id::create("inst_seq");
        inst_seq.start(m_sequencer);
     end
     
  endtask: body

endclass: processor_sequence



/////////////////////////////DRIVER/////////////////////////////////////////
class processor_driver extends uvm_driver #(processor_transaction);

  `uvm_component_utils(processor_driver)

  virtual processor_interface processor_vif;

  // Analysis port to broadcast input values to scoreboard
  uvm_analysis_port #(processor_transaction) Drv2Sb_port;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
bit drv_clk;
 
  function void build_phase(uvm_phase phase);
    // Get interface reference from config database
    if(!uvm_config_db#(virtual processor_interface)::get(this, "", "processor_vif", processor_vif)) begin
      `uvm_error("", "uvm_config_db::get failed")
    end
    drv_clk=1'b0;
    Drv2Sb_port = new("Drv2Sb",this);
  endfunction 
      
  task run_phase(uvm_phase phase);

    reg[15:0]mem[0:18];
    int count = 0;
//Set initial instructions.txt file
	mem[0]=16'h9A35;
 	mem[1]=16'h9A7F;
        mem[2]=16'h9A85;
        mem[3]=16'h9AC0;
        mem[4]=16'h9B0B;
        mem[5]=16'h9B73;
        mem[6]=16'h9BBC;
        mem[7]=16'h9BC1;
        mem[8]=16'h9C04;
        mem[9]=16'h9C40;
        mem[10]=16'h9C81;
        mem[11]=16'h9CEB;
        mem[12]=16'h9D11;
        mem[13]=16'h9D40;
        mem[14]=16'h9D82;
        mem[15]=16'h9DD4;
        mem[16]=16'h0000;
        mem[17]=16'h0000;
        mem[18]=16'h0000;
    // Now drive normal traffic
    forever begin
          @(processor_vif.driver_if_mp.driver_cb)
      begin 

    	if(count < 19) begin
    	processor_vif.driver_if_mp.driver_cb.inst_in <= mem[count] ;
    		count++;
    	end
    	else
    	begin
	  seq_item_port.get_next_item(req);
	  processor_vif.driver_if_mp.driver_cb.inst_in <= req.inst_in ;
	  Drv2Sb_port.write(req);
          seq_item_port.item_done();
          count = 0;
    	end
    	end
    end
  endtask

endclass: processor_driver

////////////////////////////////////////////AGENT///////////////////////////////////



class processor_agent extends uvm_agent;
 `uvm_component_utils(processor_agent)
    
    processor_driver driver;
    uvm_sequencer#(processor_transaction) sequencer;
    
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
      driver = processor_driver::type_id::create("driver", this);
      sequencer = uvm_sequencer#(processor_transaction)::type_id::create("sequencer", this);
    endfunction    
    function void connect_phase(uvm_phase phase);
      driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction      

endclass
 endpackage






///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


interface processor_interface(input clk); 

//PC and Instruction word
  logic [15:0]inst_in;
  logic [7:0]pc_out;
   logic [15:0]inst_out;
  logic [2:0]jmp_val;
  logic jmp,eop;
  logic [1:0]regwr_out2,dir_val_out2;
  logic memwr_out2,ctrl_sel_out2,wrbk_sel_out2;
 logic [2:0]aD_out2,dir_s2_out2;
  logic [3:0]alu_sel_out2;
  logic [7:0]dir_s1_out2;
  logic  [15:0]s1_out2,s2_out2;
 logic  [1:0]reg_wr_out3,reconfig_mul,reconfig_load;
  logic mem_wr_out3,wrbk_sel_out3;
  logic [2:0]aM_out3,aD_out3;
  logic [15:0]alu_out3,dM_out3;
  logic [15:0]wD_rf;
  logic [1:0]w_en;
  logic [2:0]aD_rf;
  logic s1_c0,s1_c1,s2_c0,s2_c1;
  logic [1:0]inita;
  logic [2:0]initb;
  logic [15:0]pc_2,pc_3,inst_out_tb;
  
  
  ////////////////////////////////////////
 
  
  ////////////////////////////////////
   
//Register file Signals
   logic [15:0]reg_data;
   logic [1:0]reg_en;
   logic [2:0]reg_add;

//Data Memory Signals
  logic [15:0]mem_data_tb;
   logic mem_en_tb;
  logic [2:0]mem_add_tb;
   
	clocking driver_cb @ (negedge clk);
		output inst_in;
	endclocking : driver_cb
	
  clocking monitor_cb @ (negedge clk);
    input inst_in;
	input pc_out;
	input inst_out;
    
    ////////////////////
   input jmp_val;
   input jmp,eop;
   input regwr_out2,dir_val_out2;
    input aD_out2,dir_s2_out2;
   input  memwr_out2,ctrl_sel_out2,wrbk_sel_out2;
    input alu_sel_out2;
    input dir_s1_out2;
    input s1_out2,s2_out2;
    input reg_wr_out3,reconfig_mul,reconfig_load;
    input mem_wr_out3,wrbk_sel_out3;
    input aM_out3,aD_out3;
    input alu_out3,dM_out3;
    input wD_rf;
    input w_en;
    input aD_rf;
    input s1_c0,s1_c1,s2_c0,s2_c1;
    input inita;
    input initb;
    input pc_2,pc_3,inst_out_tb;
   
    
    ////////////// 
    
	input reg_data;
	input reg_en;
	input reg_add;
	input mem_data_tb;
	input mem_en_tb;
	input mem_add_tb;
    
    
    
  endclocking : monitor_cb

  modport driver_if_mp (clocking driver_cb);
  modport monitor_if_mp (clocking monitor_cb);
  
endinterface
    
    
    
    

////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////
    
    
    
    
    
package test_pkg;
import uvm_pkg::*;
import agnt_pkg::*;
`include "uvm_macros.svh"
class processor_monitor extends uvm_monitor;
     // register the monitor in the UVM factory
     `uvm_component_utils(processor_monitor)
     int count;
     //Declare virtual interface
     virtual processor_interface processor_vif;

     // Analysis port to broadcast results to scoreboard 
     uvm_analysis_port #(processor_transaction) Mon2Sb_port; 
     
     // Analysis port to broadcast results to subscriber 
	uvm_analysis_port #(processor_transaction) aport;     
     function new(string name, uvm_component parent);
       super.new(name, parent);
     endfunction
     
     function void build_phase(uvm_phase phase);
       // Get interface reference from config database
       if(!uvm_config_db#(virtual processor_interface)::get(this, "", "processor_vif", processor_vif)) begin
         `uvm_error("", "uvm_config_db::get failed")
       end
       Mon2Sb_port = new("Mon2Sb",this);
       aport = new("aport",this);
     endfunction

     task run_phase(uvm_phase phase);
         processor_transaction pros_trans;
         pros_trans = new ("trans");
         count = 0;
	 fork
	   forever begin
	     @(processor_vif.monitor_if_mp.monitor_cb.inst_out)
	     begin
	     if(count<17)
	        begin
	        count++;
	        end
	     else
	        begin
		//Set transaction from interface data
              
              
              
              //pros_trans.clk=processor_vif.monitor_if.monitor_cb.clk;
              pros_trans.inst_in = processor_vif.monitor_if_mp.monitor_cb.inst_in;
              pros_trans.pc_out = processor_vif.monitor_if_mp.monitor_cb.pc_out;
              pros_trans.inst_out = processor_vif.monitor_if_mp.monitor_cb.inst_out;
          pros_trans.jmp_val=processor_vif.monitor_if_mp.monitor_cb.jmp_val;
           pros_trans.jmp=processor_vif.monitor_if_mp.monitor_cb.jmp;   
           pros_trans. eop=processor_vif.monitor_if_mp.monitor_cb.eop;
           pros_trans. regwr_out2=processor_vif.monitor_if_mp.monitor_cb.regwr_out2;
             pros_trans.dir_val_out2=processor_vif.monitor_if_mp.monitor_cb.dir_val_out2;
             pros_trans.memwr_out2= processor_vif.monitor_if_mp.monitor_cb.ctrl_sel_out2;
             pros_trans. wrbk_sel_out2=processor_vif.monitor_if_mp.monitor_cb.wrbk_sel_out2;
             pros_trans. aD_out2=processor_vif.monitor_if_mp.monitor_cb.aD_out2;
              pros_trans.dir_s2_out2=processor_vif.monitor_if_mp.monitor_cb.dir_s2_out2;
              pros_trans.alu_sel_out2=processor_vif.monitor_if_mp.monitor_cb.alu_sel_out2;
              pros_trans.dir_s1_out2=processor_vif.monitor_if_mp.monitor_cb.dir_s1_out2;
             pros_trans. s1_out2=processor_vif.monitor_if_mp.monitor_cb.s1_out2;
              pros_trans.s2_out2=processor_vif.monitor_if_mp.monitor_cb.s2_out2;
              pros_trans.reg_wr_out3=processor_vif.monitor_if_mp.monitor_cb.reg_wr_out3;
              pros_trans.reconfig_mul=processor_vif.monitor_if_mp.monitor_cb.reconfig_mul;
              pros_trans.reconfig_load=processor_vif.monitor_if_mp.monitor_cb.reconfig_load;
              pros_trans.mem_wr_out3=processor_vif.monitor_if_mp.monitor_cb.mem_wr_out3;
             pros_trans. wrbk_sel_out3=processor_vif.monitor_if_mp.monitor_cb.wrbk_sel_out3;
              pros_trans.aM_out3=processor_vif.monitor_if_mp.monitor_cb.aM_out3;
              pros_trans.aD_out3=processor_vif.monitor_if_mp.monitor_cb.aD_out3;
             pros_trans. alu_out3=processor_vif.monitor_if_mp.monitor_cb.alu_out3;
              pros_trans.dM_out3=processor_vif.monitor_if_mp.monitor_cb.dM_out3;
              pros_trans.wD_rf=processor_vif.monitor_if_mp.monitor_cb.wD_rf;
              pros_trans.w_en=processor_vif.monitor_if_mp.monitor_cb.w_en;
             pros_trans.aD_rf=processor_vif.monitor_if_mp.monitor_cb.aD_rf;
             pros_trans.s1_c0=processor_vif.monitor_if_mp.monitor_cb.s1_c0;
             pros_trans. s1_c1=processor_vif.monitor_if_mp.monitor_cb.s1_c1;
             pros_trans. s2_c0=processor_vif.monitor_if_mp.monitor_cb.s2_c0;
             pros_trans. s2_c1=processor_vif.monitor_if_mp.monitor_cb.s2_c1;
              pros_trans.inita=processor_vif.monitor_if_mp.monitor_cb.inita;
             pros_trans. initb=processor_vif.monitor_if_mp.monitor_cb.initb;
             pros_trans. pc_2=processor_vif.monitor_if_mp.monitor_cb.pc_2;
              pros_trans.pc_3=processor_vif.monitor_if_mp.monitor_cb.pc_3;
             
              
              
              
		
		pros_trans.inst_out_tb = processor_vif.monitor_if_mp.monitor_cb.inst_out_tb;
		pros_trans.reg_data = processor_vif.monitor_if_mp.monitor_cb.reg_data;
		pros_trans.reg_en = processor_vif.monitor_if_mp.monitor_cb.reg_en;
		pros_trans.reg_add = processor_vif.monitor_if_mp.monitor_cb.reg_add;
		pros_trans.mem_data_tb = processor_vif.monitor_if_mp.monitor_cb.mem_data_tb;
		pros_trans.mem_en_tb = processor_vif.monitor_if_mp.monitor_cb.mem_en_tb;						
        	pros_trans.mem_add_tb = processor_vif.monitor_if_mp.monitor_cb.mem_add_tb;			
		//Send transaction to Scoreboard
	        Mon2Sb_port.write(pros_trans);
		//Send transaction to subscriber		
		aport.write(pros_trans);	   
		count = 0;             
	        end
	     end
	   end
	 join
     endtask : run_phase

endclass : processor_monitor



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class processor_subscriber extends uvm_subscriber #(processor_transaction);
//Register subscriber in uvm factory
`uvm_component_utils(processor_subscriber)
//Define variables to store read/write request and address

bit [15:0] instruction;
//Define covergroup and coverpoints
covergroup cover_processor;
coverpoint instruction
{

bins Addition = {[16'h0000:16'h0FFF]};
bins Subraction = {[16'h1000:16'h1FFF]};
bins Increment = {[16'h3000:16'h3FFF]};
bins Decrement = {[16'h2000:16'h2FFF]};
bins AND_NAND = {[16'h4000:16'h4FFF]};
bins OR_NOR = {[16'h5000:16'h5FFF]};
bins EXOR_EXNOR = {[16'h6000:16'h6FFF]};
bins Buff_Inv = {[16'h7000:16'h7FFF]};
bins Multiplication = {[16'h8000:16'h8FFF]};
bins ShiftL_ShiftR = {[16'hC000:16'hCFFF]};
bins Load = {[16'hA000:16'hAFFF]};
bins Store = {[16'hB000:16'hBFFF]};
bins Move_MoveI = {[16'h9000:16'h9FFF]};
bins Jump = {[16'hD000:16'hDFFF]};
bins NOP = {[16'hE000:16'hEFFF]};
}
endgroup
//Declare virtual interface object
virtual processor_interface processor_vif;
//Declare analysis port to get transactions from monitor
uvm_analysis_imp #(processor_transaction,processor_subscriber) aport;


  function new (string name, uvm_component parent);
  begin
    super.new(name,parent);

    //Call new for covergroup
	cover_processor = new();
  end
  endfunction

  function void build_phase(uvm_phase phase);
    // Get virtual interface reference from config database
if(!uvm_config_db#(virtual processor_interface)::get(this, "",
"processor_vif", processor_vif)) begin
`uvm_error("", "uvm_config_db::get failed")
end
    //Instantiate analysis port
aport = new("aport",this);
  endfunction 

  //Write function for the analysis port
function void write(processor_transaction t);
instruction = t.inst_out;

cover_processor.sample();
endfunction
endclass


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`uvm_analysis_imp_decl(_mon_trans)
`uvm_analysis_imp_decl(_drv_trans)

class processor_scoreboard extends uvm_scoreboard;
    
    // register the scoreboard in the UVM factory
    `uvm_component_utils(processor_scoreboard);

    //processor_transaction trans, input_trans;

    // analysis implementation ports
    uvm_analysis_imp_mon_trans #(processor_transaction,processor_scoreboard) Mon2Sb_port;
    uvm_analysis_imp_drv_trans #(processor_transaction,processor_scoreboard) Drv2Sb_port;

    // TLM FIFOs to store the actual and expected transaction values
    uvm_tlm_fifo #(processor_transaction)  drv_fifo;
    uvm_tlm_fifo #(processor_transaction)  mon_fifo;

   function new (string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      //Instantiate the analysis ports and Fifo
      Mon2Sb_port = new("Mon2Sb",  this);
      Drv2Sb_port = new("Drv2Sb",  this);
      drv_fifo     = new("drv_fifo", this,8);
      mon_fifo     = new("mon_fifo", this,8);
   endfunction : build_phase

   // write_drv_trans will be called when the driver broadcasts a transaction
   // to the scoreboard
   function void write_drv_trans (processor_transaction input_trans);
        void'(drv_fifo.try_put(input_trans));
   endfunction : write_drv_trans

   // write_mon_trans will be called when the monitor broadcasts the DUT results
   // to the scoreboard 
   function void write_mon_trans (processor_transaction trans);
        void'(mon_fifo.try_put(trans));
   endfunction : write_mon_trans

   task run_phase(uvm_phase phase);
      processor_transaction exp_trans, out_trans;
      reg [15:0]file[0:7];
      bit [15:0]h1,i1,i2; 
      bit [7:0]dir;
      bit store,jmp,eop,nop,inter1,multiply,shift;
      int s1,s2;
      forever begin
			drv_fifo.get(exp_trans);
			mon_fifo.get(out_trans);
			h1=0;
			dir=0;
			s1=0;
			s2=0;
			//Initialize Reg File
			file[0] = 16'h0435;
			file[1] = 16'h407F;
			file[2] = 16'h8185;
			file[3] = 16'hEBC0;
			file[4] = 16'h110B;
			file[5] = 16'h4073;
			file[6] = 16'h82BC;
			file[7] = 16'hD4C1;
        //Compare Instructions
        /*
instrn[15:12]=> OPCODE
instrn[11]=> CTRL
instrn[10:9]=>RECONFIG
instrn[8:6]=>DESTINATION
instrn[5:3]=>Source 1
instrn[2:0]=>Source 2
*/
        if(exp_trans.inst_in == out_trans.inst_out)		//FULL INST CHECK
begin
`uvm_info ("INSTRUCTION_WORD_PASS ", $sformatf("Actual Instruction=%h Expected Instruction=%h \n",out_trans.inst_out, exp_trans.inst_in), UVM_LOW)
  if(exp_trans.inst_in[8:6]==out_trans.reg_add)	//DESTINATION REG CHECK
	begin
	`uvm_info ("REG_ADDR_PASS ", $sformatf("Actual Reg Addr=%d Expected Reg Addr=%d \n",out_trans.reg_add, exp_trans.inst_in[8:6]), UVM_LOW)
	s1=exp_trans.inst_in[5:3];
	s2=exp_trans.inst_in[2:0];
      dir=({{8{exp_trans.inst_in[10]}}& exp_trans.inst_in[7:0],{8{exp_trans.inst_in[9]}}& exp_trans.inst_in[7:0]});
	//This dir is for MOV Immediate
	
      store=(exp_trans.inst_in[15]&~exp_trans.inst_in[14]&exp_trans.inst_in[13]&exp_trans.inst_in[12]);	//Resetting reconfig for variables aptly named
	jmp=(exp_trans.inst_in[15]&exp_trans.inst_in[14]&~exp_trans.inst_in[13]&exp_trans.inst_in[12]);
      nop=(exp_trans.inst_in[15]&exp_trans.inst_in[14]&exp_trans.inst_in[13]&~exp_trans.inst_in[12]);
	eop=(exp_trans.inst_in[15]&exp_trans.inst_in[14]&exp_trans.inst_in[13]&exp_trans.inst_in[12]);;
	inter1=store|jmp|nop|eop;
	
	multiply=(exp_trans.inst_in[15]&~exp_trans.inst_in[14]&~exp_trans.inst_in[13]&~exp_trans.inst_in[12]);
	shift=(exp_trans.inst_in[15]&exp_trans.inst_in[14]&~exp_trans.inst_in[13]&~exp_trans.inst_in[12]&exp_trans.inst_in[10]&exp_trans.inst_in[9]);
	
		if(out_trans.reg_en[1:0]==({{(exp_trans.inst_in[10]|multiply|shift)&(~inter1)},{(exp_trans.inst_in[9]|multiply|shift)&(~inter1)}}))		//Register write enable check
		begin	
			i1=({{8{exp_trans.inst_in[10]}}& file[s1][15:8],{8{exp_trans.inst_in[9]}}& file[s1][7:0]});
			i2=({{8{exp_trans.inst_in[10]}}& file[s2][15:8],{8{exp_trans.inst_in[9]}}& file[s2][7:0]});
			case(out_trans.inst_out[15:12])
				4'b0000:begin
					 h1=i1+i2;				
						if((h1)==(out_trans.reg_data))
						begin
						`uvm_info ("ADDITION_PASS ", $sformatf("Actual Calculation=%d Expected Calculation=%d \n",out_trans.reg_data, h1), UVM_LOW)
						end
						else
						begin
						`uvm_error("ADDITION_FAIL", $sformatf("Actual Calculation=%d Expected Calculation=%d \n",out_trans.reg_data, h1))
						end
					end
				4'b0001:begin
					h1=i1-i2;
						if(h1==out_trans.reg_data)
						begin
						`uvm_info ("SUBTRACTION_PASS ", $sformatf("Actual Calculation=%d Expected Calculation=%d \n",out_trans.reg_data, h1), UVM_LOW)
						end
						else
						begin
						`uvm_error("SUBTRACTION_FAIL", $sformatf("Actual Calculation=%d Expected Calculation=%d \n",out_trans.reg_data, h1))
						end
					end
				4'b0011:begin
					h1=i1+1'b1;
						if(h1==out_trans.reg_data)
						begin
						`uvm_info ("INCREMENT_PASS ", $sformatf("Actual Calculation=%d Expected Calculation=%d \n",out_trans.reg_data, h1), UVM_LOW)
						end
						else
						begin
						`uvm_error("INCREMENT_FAIL", $sformatf("Actual Calculation=%d Expected Calculation=%d \n",out_trans.reg_data, h1))
						end
					end
				4'b0010:begin
					h1=i1-1'b1;
						if(h1==out_trans.reg_data)
						begin
						`uvm_info ("DECREMENT_PASS ", $sformatf("Actual Calculation=%d Expected Calculation=%d \n",out_trans.reg_data, h1), UVM_LOW)
						end
						else
						begin
						`uvm_error("DECREMENT_FAIL", $sformatf("Actual Calculation=%d Expected Calculation=%d \n",out_trans.reg_data, h1))
						end
					end
				4'b0100:begin
					if(!exp_trans.inst_in[11])		//FOR two variations of AND, OR, EXOR, SHIFT, INV
						begin
						h1=i1&i2;
						end
						else
						begin
						h1=~(i1&i2);
						end
						if(h1==out_trans.reg_data)
						begin
						`uvm_info ("AND/NAND_PASS ", $sformatf("Actual Calculation=%d Expected Calculation=%d \n",out_trans.reg_data, h1), UVM_LOW)
						end
						else
						begin
						`uvm_error("AND/NAND_FAIL", $sformatf("Actual Calculation=%d Expected Calculation=%d \n",out_trans.reg_data, h1))
						end
					end
				4'b0101:begin
					if(!exp_trans.inst_in[11])
						begin
						h1=i1|i2;
						end
						else
						begin
						h1=~(i1|i2);
						end
						if(h1==out_trans.reg_data)
						begin
						`uvm_info ("OR/NOR_PASS ", $sformatf("Actual Calculation=%d Expected Calculation=%d \n",out_trans.reg_data, h1), UVM_LOW)
						end
						else
						begin
						`uvm_error("OR/NOR_FAIL", $sformatf("Actual Calculation=%d Expected Calculation=%d \n",out_trans.reg_data, h1))
						end
					end	
				4'b0110:begin
					if(!exp_trans.inst_in[11])
						begin
						h1=i1^i2;
						end
						else
						begin
						h1=~(i1^i2);
						end
						if(h1==out_trans.reg_data)
						begin
						`uvm_info ("EXOR/EXNOR_PASS ", $sformatf("Actual Calculation=%d Expected Calculation=%d \n",out_trans.reg_data, h1), UVM_LOW)
						end
						else
						begin
						`uvm_error("EXOR/EXNOR_FAIL", $sformatf("Actual Calculation=%d Expected Calculation=%d \n",out_trans.reg_data, h1))
						end
					end
				4'b0111:begin
					if(!exp_trans.inst_in[11])
						begin
						h1=i1;
						end
						else
						begin
						h1=~(i1);
						end
						if(h1==out_trans.reg_data)
						begin
						`uvm_info ("BUFF/INV_PASS ", $sformatf("Actual Calculation=%d Expected Calculation=%d \n",out_trans.reg_data, h1), UVM_LOW)
						end
						else
						begin
						`uvm_error("BUFF/INV_FAIL", $sformatf("Actual Calculation=%d Expected Calculation=%d \n",out_trans.reg_data, h1))
						end
					end	
				4'b1100:begin
					if(!exp_trans.inst_in[11])
						begin
						h1=i1<<s2;
						end
						else
						begin
						h1=i1>>s2;
						end
						if(h1==out_trans.reg_data)
						begin
						`uvm_info ("SHIFT_PASS ", $sformatf("Actual Calculation=%d Expected Calculation=%d \n",out_trans.reg_data, h1), UVM_LOW)
						end
						else
						begin
						`uvm_error("SHIFT_FAIL", $sformatf("Actual Calculation=%d Expected Calculation=%d \n",out_trans.reg_data, h1))
						end
					end
				4'b1000:begin
					if(exp_trans.inst_in[10:9]==2'b01|exp_trans.inst_in[10:9]==2'b11)
					begin
					h1=i1[7:0]*i2[7:0];
					end
					else
					begin
						if(exp_trans.inst_in[10:9]==2'b10)
						begin
						h1=i1[15:8]*i2[15:8];
						end 
					end
						if(h1==out_trans.reg_data)
						begin
						`uvm_info ("MULTIPLY_PASS ", $sformatf("Actual Calculation=%d Expected Calculation=%d \n",out_trans.reg_data, h1), UVM_LOW)
						end
						else
						begin
						`uvm_error("MULTIPLY_FAIL", $sformatf("Actual Calculation=%d Expected Calculation=%d \n",out_trans.reg_data, h1))
						end
					end
				4'b1010:begin
					h1=0;			
						if(h1==out_trans.reg_data)
						begin
						`uvm_info ("LOAD_PASS ", $sformatf("Actual Calculation=%d Expected Calculation=%d \n",out_trans.reg_data, h1), UVM_LOW)
						end
						else
						begin
						`uvm_error("LOAD_FAIL", $sformatf("Actual Calculation=%d Expected Calculation=%d \n",out_trans.reg_data, h1))
						end
					end
				4'b1011:begin
					h1=i1;
                  if(exp_trans.inst_in[2:0] == out_trans.mem_add_tb)
						begin
						`uvm_info ("MEM_STORE_ADDR_PASS ", $sformatf("Actual Mem Addr=%d Expected Mem Addr=%d \n",out_trans.mem_add_tb, exp_trans.inst_in[2:0]), UVM_LOW)
                          if(out_trans.mem_en_tb)
							begin
								`uvm_info ("MEM_STORE_EN_PASS ", $sformatf("Actual Mem Addr=%d Expected Mem Addr=%d \n",out_trans.mem_en_tb, 1'b1), UVM_LOW)
                              if(h1==out_trans.mem_data_tb)
								begin
								`uvm_info ("STORE_PASS ", $sformatf("Actual Calculation=%d Expected Calculation=%d \n",out_trans.reg_data, h1), UVM_LOW)
								end
								else
								begin
								`uvm_error("STORE_FAIL", $sformatf("Actual Calculation=%d Expected Calculation=%d \n",out_trans.reg_data, h1))
								end
							end
							else
							begin
							`uvm_error("MEM_STORE_EN_FAIL", $sformatf("Actual Calculation=%d Expected Calculation=%d \n",out_trans.mem_en_tb, 1'b1))
							end
						end
						else
						begin
						`uvm_error("MEM_STORE_ADDR_FAIL", $sformatf("Actual Dest=%d Expected Dest=%d\n",out_trans.mem_add_tb,exp_trans.inst_in[2:0]))
						end
					end	
				4'b1001:begin
					$display("in1=%d, in2=%d, reconfig=%d reg scr1 and 2= %d %d",i1,i2,out_trans.reg_en,s1,s2);
					if(!exp_trans.inst_in[11])			//For MOVE(0) and MOVE_IMMEDIATE(1)
						begin
						h1=i1;
						end
						else
						begin 
						h1=({{8{exp_trans.inst_in[10]}}& exp_trans.inst_in[7:0],{8{exp_trans.inst_in[9]}}& exp_trans.inst_in[7:0]});
						end
						if(h1==out_trans.reg_data)
						begin
						`uvm_info ("MOVE_PASS ", $sformatf("Actual Calculation=%d Expected Calculation=%d \n",out_trans.reg_data, h1), UVM_LOW)
						end
						else
						begin
						`uvm_error("MOVE_FAIL", $sformatf("Actual Calculation=%d Expected Calculation=%d \n",out_trans.reg_data, h1))
						end
					end
				default:`uvm_info ("JUMP/EOP_PASS ", $sformatf("Actual Calculation=%d Expected Calculation=%d \n",out_trans.inst_out, exp_trans.inst_in[15:12]), UVM_LOW)
			endcase
		end
		else
		begin
		`uvm_error("REG_EN_FAIL", $sformatf("Actual Reg Enable=%d Expected Reg Enable=%d \n",out_trans.reg_en, exp_trans.inst_in[10:9]))
		end
	end
	else
	begin
	`uvm_error("REG_ADDR_FAIL", $sformatf("Actual Reg Addr=%d Expected Reg Addr=%d \n",out_trans.reg_add, exp_trans.inst_in[8:6]))
	end
	
end	
else
begin
`uvm_error("INSTRUCTION_ERROR", $sformatf("Actual=%d Expected=%d \n",out_trans.inst_out, exp_trans.inst_in))			
end				
      end
   endtask
endclass : processor_scoreboard

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class processor_env extends uvm_env;
  `uvm_component_utils(processor_env)
    
    processor_agent agent;
    processor_monitor mon;
    processor_scoreboard sb;
    processor_subscriber sub;

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
      agent = processor_agent::type_id::create("agent", this);
      mon   = processor_monitor::type_id::create("mon",this);
      sb    = processor_scoreboard::type_id::create("sb",this);
      sub   = processor_subscriber::type_id::create("sub",this);
    endfunction
  
    // connect ports of various TB components here
   function void connect_phase(uvm_phase phase);
      `uvm_info("", "Called env::connect_phase", UVM_NONE);
      
      // connect driver's analysis port to scoreboard's analysis
      // implementation por
      agent.driver.Drv2Sb_port.connect(sb.Drv2Sb_port);
      
      // connect monitor's analysis port to scoreboard's analysis
      // implementation port
      mon.Mon2Sb_port.connect(sb.Mon2Sb_port);

      // connect monitor's analysis port to subscriber's analysis
      // implementation port
mon.aport.connect(sub.aport);
   endfunction: connect_phase
endclass

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


class processor_test extends uvm_test;
 `uvm_component_utils(processor_test)
   
   processor_env env;
   processor_sequence processor_seq;

   function new(string name, uvm_component parent);
     super.new(name, parent);
   endfunction
   
   function void build_phase(uvm_phase phase);
     env = processor_env::type_id::create("env", this);
     processor_seq = processor_sequence::type_id::create("processor_seq");
	endfunction

   function void end_of_elaboration_phase(uvm_phase phase);
     print();
   endfunction
   
   
   task run_phase(uvm_phase phase);
     
     // We raise objection to keep the test from completing
     phase.raise_objection(this);
     `uvm_warning("", "processor test!")
     #10;
    
     processor_seq.start(env.agent.sequencer);
     
     #1000;
     // We drop objection to allow the test to complete
     phase.drop_objection(this);
   endtask
endclass
 endpackage





////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module testbench;
 
 import uvm_pkg::*;
`include "uvm_macros.svh" 
 import agnt_pkg::*;
 import test_pkg::*;
  bit clk;
  
  //clock generation
  always #5 clk = ~clk;
  
  initial 
  begin
    clk = 0;
  end

  // Instantiate the interface
  processor_interface processor_if(clk);
	// Instantiate dut
  Main_Processor dut(
    .clk(processor_if.clk),
    .inst_in(processor_if.inst_in),
    .pc_out(processor_if.pc_out),
	.inst_out(processor_if.inst_out),
    .jmp_val(processor_if.jmp_val),
    .jmp(processor_if.jmp),
    .eop(processor_if.eop),
    .regwr_out2(processor_if.regwr_out2),
    .dir_val_out2(processor_if.dir_val_out2),
    .memwr_out2(processor_if.memwr_out2),
    .ctrl_sel_out2(processor_if.ctrl_sel_out2),
    .wrbk_sel_out2(processor_if.wrbk_sel_out2),
    .aD_out2(processor_if.aD_out2),
    .dir_s2_out2(processor_if.dir_s2_out2),
    .alu_sel_out2(processor_if.alu_sel_out2),
    .dir_s1_out2(processor_if.dir_s1_out2),
    .s1_out2(processor_if.s1_out2),
    .s2_out2(processor_if.s2_out2),
    .reg_wr_out3(processor_if.reg_wr_out3),
    .reconfig_mul(processor_if.reconfig_mul),
    .reconfig_load(processor_if.reconfig_load),
    .mem_wr_out3(processor_if.mem_wr_out3),
    .wrbk_sel_out3(processor_if.wrbk_sel_out3),
    .aM_out3(processor_if.aM_out3),
    .aD_out3(processor_if.aD_out3),
    .alu_out3(processor_if.alu_out3),
    .dM_out3(processor_if.dM_out3),
    
	.wD_rf(processor_if.reg_data),
	.w_en(processor_if.reg_en),
	.aD_rf(processor_if.reg_add),
    .s1_c0(processor_if.s1_c0),
    .s1_c1(processor_if.s1_c1),
    .s2_c0(processor_if.s2_c0),
    .s2_c1(processor_if.s2_c1),
    .inita(processor_if.inita),
    .initb(processor_if.initb),
    .pc_2(processor_if.pc_2),
    .pc_3(processor_if.pc_3),
    .inst_out_tb(processor_if.inst_out_tb),
    
    .mem_data_tb(processor_if.mem_data_tb),
    .mem_en_tb(processor_if.mem_en_tb),
    .mem_add_tb(processor_if.mem_add_tb) 
	);  
  initial 
  begin
    
    // Place the interface into the UVM configuration database
    uvm_config_db#(virtual processor_interface)::set(null, "*", "processor_vif", processor_if);
    
    // Start the test
    run_test("processor_test");
  end

 // initial begin
 // $vcdpluson();
 // end

endmodule

