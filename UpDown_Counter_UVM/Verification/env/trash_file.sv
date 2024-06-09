
/************************************************************************************************
 *    File Name      :
 *    Creation Date  :
 *    Last Modified  :
 ------------------------------------------------------------------------------------------------
 *    Author         : Mayur Krishna Badam
 *    Author's Email : mayurkrishna.b@alpha-numero.tech
 ------------------------------------------------------------------------------------------------
 *    Description    :
************************************************************************************************/

//transaction file
//typedefs for enable, load and UpDown
//typedef enum logic {DISABLE, ENABLE} ectrl; 
//typedef enum logic {LOAD=1, NO_LOAD=0} lctrl; 
//typedef enum logic {UP=1, DOWN=0} udctrl;

//typedef enum bit[2:0] {DISABLE=3'b000, DISABLE_LOAD=3'b010, DISABLE_UP=3'b001, LOAD=3'b110, LOAD_UP=3'b111, UP=3'b101, DOWN=3'b100} mode_e; 





//coverage file:
   //Not in use code - might be useful later
   /*)
      RESET: coverpoint OutData iff (Reset){
         bins bin1 = (['h01:'hFE] => 'h00);
      }
      RESET_PRIORITY: coverpoint {Reset, (InData inside {['h01:'hFE]}), mode, OutData}{
         bins bin2 = {[13'b1_1_110_0000_0000:13'b1_1_110_0000_0000]}; 
         bins bin3 = ([13'b0_1_100_0000_0001:13'b1_1_100_1111_1110] => 13'b1_1_100_0000_0000);
         bins bin4 = ([13'b0_1_110_0000_0001:13'b1_1_110_1111_1110] => 13'b1_1_100_0000_0000);
      }
      ELU1: coverpoint {Reset, (InData inside {['h00:'hFF]}), mode, (OutData inside {['h00:'hFF]})} {
         //wildcard bins elu1_bin_1 = {[20'b0_0000_0000_0xx_0000_0000 : 20'b0_1111_1111_0xx_0000_0000]};// => 20'b0_1111_1111_0xx0_0000_0000)
         //wildcard bins elu1_bin_2 = {[20'b0_0000_0000_0xx_0000_0000 : 20'b0_1111_1111_0xx_1111_1111]};
         //wildcard bins elu1_bin_3 = {[20'b0_0000_0000_11x_0000_0000 : 20'b0_1111_1111_11x_1111_1111]};
         wildcard bins elu1_bin_2 = {[20'b0_1_010_0000_0000 : 20'b0_1_010_1111_1111]};
         wildcard bins elu1_bin_3 = {[20'b0_1_110_0000_0000 : 20'b0_1_110_1111_1111]};
         wildcard bins elu1_bin_4 = {[20'b0_1_101_0000_0000 : 20'b0_1_101_1111_1111]};
         //wildcard bins elu1_bin_5 = {[20'b0_0000_0000_11x_0000_0000 : 20'b0_1111_1111_11x_1111_1111]};
         //wildcard bins elu1_bin_6 = {[20'b0_0000_0000_101_0000_0000 : 20'b0_1111_1111_101_1111_1111]};
         wildcard bins elu1_bin_7 = {[20'b0_1_100_0000_0000 : 20'b0_1_100_1111_1111]};
      }
   */
  /*
   //covergroup for reset
   covergroup reset_cg1;
      RESET: coverpoint ref_tr1.OutData iff (Reset){
         bins bin1 = (['h01:'hFE] => 'h00);
      }
      RESET_PRIORITY: coverpoint {Reset, (ref_tr1.InData inside {['h01:'hFE]}), ref_tr1.mode, ref_tr1.OutData}{
         bins bin2 = {[20'b1_1_110_0000_0000:20'b1_1_110_0000_0000]}; 
         bins bin3 = ([20'b0_1_100_0000_0001:20'b1_1_100_1111_1110] => [20'b1_1_100_0000_0000]);
         bins bin4 = ([20'b0_1_110_0000_0001:20'b1_1_110_1111_1110] => [20'b1_1_100_0000_0000]);
      }
   endgroup
   
   //covergroup for Enable, Load, UpDown
   covergroup elu_cg1;
      ELU1: coverpoint {Reset, (tr1.InData inside {['h00:'hFF]}), tr1.mode, (ref_tr1.OutData inside {['h00:'hFF]})} {
         //wildcard bins elu1_bin_1 = {[20'b0_0000_0000_0xx_0000_0000 : 20'b0_1111_1111_0xx_0000_0000]};// => 20'b0_1111_1111_0xx0_0000_0000)
         //wildcard bins elu1_bin_2 = {[20'b0_0000_0000_0xx_0000_0000 : 20'b0_1111_1111_0xx_1111_1111]};
         //wildcard bins elu1_bin_3 = {[20'b0_0000_0000_11x_0000_0000 : 20'b0_1111_1111_11x_1111_1111]};
         wildcard bins elu1_bin_2 = {[20'b0_1_010_0000_0000 : 20'b0_1_010_1111_1111]};
         wildcard bins elu1_bin_3 = {[20'b0_1_110_0000_0000 : 20'b0_1_110_1111_1111]};
         wildcard bins elu1_bin_4 = {[20'b0_1_101_0000_0000 : 20'b0_1_101_1111_1111]};
         //wildcard bins elu1_bin_5 = {[20'b0_0000_0000_11x_0000_0000 : 20'b0_1111_1111_11x_1111_1111]};
         //wildcard bins elu1_bin_6 = {[20'b0_0000_0000_101_0000_0000 : 20'b0_1111_1111_101_1111_1111]};
         wildcard bins elu1_bin_7 = {[20'b0_1_100_0000_0000 : 20'b0_1_100_1111_1111]};
      }
   endgroup

   //covergroup for rollback and rollover test
   covergroup roll_over_back_cg1;
      RORB1: coverpoint {tr1.mode, ref_tr1.OutData} {
         wildcard bins rorb1_bin_1 = (11'b101_1111_1111 => 11'b101_0000_0000);
         wildcard bins rorb1_bin_2 = (11'b100_0000_0000 => 11'b100_1111_1111);
      }
   endgroup

   covergroup priority_cg1;
      PRIORITY: coverpoint {Reset, tr1.InData, tr1.mode, ref_tr1.OutData} {
         bins priority1_bin_1 = (20'b0_0000_0101_110_0000_0101 => 20'b0_0000_0101_010_0000_0101);
         bins priority1_bin_2 = (20'b0_0000_0110_111_0000_0110 => 20'b0_0000_0110_001_0000_0110);
         bins priority1_bin_3 = (20'b0_0000_0101_100_0000_0100 => 20'b0_0000_0101_110_0000_0101);
         bins priority1_bin_4 = (20'b0_0000_0101_101_0000_0110 => 20'b0_0000_0101_111_0000_0101);
      }
   endgroup

   //covergroups for counter2
   //covergroup for reset
   covergroup reset_cg2;
      RESET: coverpoint {Reset, ref_tr2.OutData}{

         bins bin1 = ([9'b0_0000_0001:9'b0_1111_1111] => 9'b0_0000_0000);
      }
      RESET_PRIORITY: coverpoint {Reset, ref_tr1.InData, ref_tr1.mode, ref_tr1.OutData}{
         bins bin2 = {[20'b1_0000_0001_110_0000_0000:20'b1_1111_1110_110_0000_0000]}; 
         bins bin3 = ([20'b0_0000_0001_100_0000_0001:20'b1_1111_1110_100_1111_1110] => [20'b1_0000_0001_100_0000_0000:20'b1_1111_1110_110_0000_0000]);
         bins bin4 = ([20'b0_0000_0001_110_0000_0001:20'b1_1111_1110_110_1111_1110] => [20'b1_0000_0001_100_0000_0000:20'b1_1111_1110_110_0000_0000]);
      }
   endgroup

   //covergroup for Enable, Load, UpDown
   covergroup elu_cg2;
      ELU2: coverpoint {Reset, tr2.InData inside {['h00:'hFF]}, tr2.mode, ref_tr2.OutData} {
         //wildcard bins elu2_bin_1 = {[20'b0_0000_0000_0xx_0000_0000 : 20'b0_1111_1111_0xx_0000_0000]};
         //wildcard bins elu2_bin_2 = {[20'b0_0000_0000_0xx_0000_0000 : 20'b0_1111_1111_0xx_1111_1111]};
         //wildcard bins elu2_bin_3 = {[20'b0_0000_0000_11x_0000_0000 : 20'b0_1111_1111_11x_1111_1111]};
         wildcard bins elu2_bin_2 = {[20'b0_1_010_0000_0000]};
         wildcard bins elu2_bin_3 = {[20'b0_1_110_0000_0000]};
         wildcard bins elu2_bin_4 = {[20'b0_1_101_0000_0000]};
         wildcard bins elu2_bin_7 = {[20'b0_1_100_0000_0000]};
         //wildcard bins elu2_bin_5 = {[20'b0_0000_0000_11x_0000_0000 : 20'b0_1111_1111_11x_1111_1111]};
         //wildcard bins elu2_bin_6 = {[20'b0_0000_0000_101_0000_0000 : 20'b0_1111_1111_101_1111_1111]};
      }
   endgroup

   //covergroup for rollback and rollover test
   covergroup roll_over_back_cg2;
      RORB2: coverpoint { tr2.mode, ref_tr2.OutData} {
         wildcard bins rorb2_bin_1 = (11'b101_1111_1111 => 11'b101_0000_0000);
         wildcard bins rorb2_bin_2 = (11'b100_0000_0000 => 11'b100_1111_1111);
      }
   endgroup

   covergroup priority_cg2;
      PRIORITY: coverpoint {Reset, tr2.InData, tr2.mode, ref_tr2.OutData} {
         bins priority2_bin_1 = (20'b0_0000_0101_110_0000_0101 => 20'b0_0000_0101_010_0000_0101);
         bins priority2_bin_2 = (20'b0_0000_0110_111_0000_0110 => 20'b0_0000_0110_001_0000_0110);
         bins priority2_bin_3 = (20'b0_0000_0101_100_0000_0100 => 20'b0_0000_0101_110_0000_0101);
         bins priority2_bin_4 = (20'b0_0000_0101_101_0000_0110 => 20'b0_0000_0101_111_0000_0101);
      }
   endgroup
   //common covergroup
   covergroup ports_cg;
      PORTS: coverpoint {Reset, (tr1.InData== 'h5) , tr1.mode, tr2.InData, tr2.mode} {
         bins ports_bin_1 = {23'b0_1_010__0001_0100_110};
         bins ports_bin_2 = {23'b0_1_110__0001_0100_010};
         bins ports_bin_3 = {23'b0_1_101__0001_0100_100};//=> 22'b0000_0101_101__0001_0100_100);
      }
         bins ports_bin_1 = {39'b0_0000_0101_010_0000_0000__0001_0100_110_0001_0100};
         bins ports_bin_2 = {39'b0_0000_0101_110_0000_0101__0001_0100_010_0000_0000};
         bins ports_bin_3 = ([39'b0_0000_0000_101_0000_0101__1111_1111_100_0001_0100:39'b0_0000_0000_101_0000_0101__1111_1111_100_0001_0100] => [38'b0000_0000_101_0000_0110__1111_1111_100_0001_0011:38'b0000_0000_101_0000_0110__1111_1111_100_0001_0011]);
   endgroup
  */ 





/* driver file
      //signal drive at the posedge of the clk 
      @(posedge vif.Clk);
         vif.drv_cb.Enable <= req.mode[2];
         vif.drv_cb.Load <= req.mode[1];
         vif.drv_cb.UpDown <= req.mode[0];
         vif.drv_cb.InData <= req.InData;
*/






/* monitor file
         data2scb.InData = vif.mon_cb.InData; 
         data2scb.mode[2] = vif.mon_cb.Enable;
         data2scb.mode[1] = vif.mon_cb.Load; 
         data2scb.mode[0] = vif.mon_cb.UpDown; 
         data2scb.OutData = vif.mon_cb.OutData; 
*/




//transaction file
//setting mode at first
//rand ectrl Enable;
//rand lctrl Load;
//rand udctrl UpDown;
//rand logic Reset;

//do methods - for custom default methods - total 7 methods are needed
/*
virtual function void do_print(uvm_printer printer);
   
endfunction

virtual function void do_copy(uvm_object rhs);
   cntr_trans trans_rhs;
   if(!$cast(trans_rhs, rhs))
      `uvm_fatal(get_type_name(), "Illegal rhs argument")

   super.do_copy(rhs);

   Enable = trans_rhs.Enable;
   Load = trans_rhs.Load;
   UpDown = trans_rhs.UpDown;
   InData = trans_rhs.InData;
   OutData = trans_rhs.OutData;
endfunction

virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);
   
endfunction

virtual function string convert2string();

endfunction

virtual function void do_record(uvm_recorder recorder);

endfunction

virtual function void do_pack();

endfunction

virtual function void do_unpack();

endfunction
*/


   



//scoreboard file
//using decl for creating multiple write methods
`uvm_analysis_imp_decl (_0)
`uvm_analysis_imp_decl (_1)

class cntr_sb extends uvm_scoreboard;
   //Factory registration
   `uvm_component_utils(cntr_sb)

   //interface handle for getting Reset value
   virtual cntr_inf.RST_SC_MP rst_vif;
   
   //transaction handles for actual and expected transactions
   cntr_trans tr[], ref_tr[];
   
   //analysis imp ports
   uvm_analysis_imp_0 #(cntr_trans, cntr_sb) sb_imp0;
   uvm_analysis_imp_1 #(cntr_trans, cntr_sb) sb_imp1;
   
   local int no_of_dut;
   //local Reset signal for getting the reset from interface
   bit Reset; 

   reset_cg rcg1,rcg2;
   elu_cg ecg1,ecg2;
   roll_over_back_cg rocg1,rocg2 ;
   priority_cg pcg1,pcg2;
   ports_cg pocg;

   //Constructor method
   function new(string name, uvm_component parent);
      super.new(name,parent);
      //creating covergroups' objects 
      rcg1 = new();
      ecg1 = new();
      rocg1 = new();
      pcg1 = new();
      
      rcg2 = new();
      ecg2 = new();
      rocg2 = new();
      pcg2 = new();

      pocg = new();
   endfunction

   //build phase
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      //creating transaction handles
      //Getting rst_vif from config_db
      if(!uvm_config_db #(virtual cntr_inf)::get(this, "*","rst_vif", rst_vif))
            `uvm_fatal("RST_VIF_CONFIG","cannot get")         

      if(!uvm_config_db #(int)::get(this, "*","no_of_dut", no_of_dut))
            `uvm_fatal("NO_OF_DUT","value cannot be get")     

      `uvm_info("NO_OF_DUT", $sformatf("no_of_dut = %0d",no_of_dut), UVM_HIGH)

      for(int i=0; i< no_of_dut; i++) begin
         tr[i] = new;
         ref_tr[i] = new;
      end

      //Constucting implementation ports
      sb_imp0 = new("sb_imp0",this);
      sb_imp1 = new("sb_imp1",this);
   endfunction

   //function write for counter1
   virtual function void write_0(cntr_trans req);
      Reset = rst_vif.sb_rst_cb.Reset;
      `uvm_info("RST_SB", $sformatf("Reset: %0d", Reset), UVM_MEDIUM)
      this.tr[0].mode = req.mode;
      this.tr[0].InData = req.InData;
      this.tr[0].OutData = req.OutData;

      `uvm_info("SCOREBOARD", "scb got transaction",UVM_HIGH)
      //tr[0].print();
      `uvm_info("SCOREBOARD", "scb got transaction",UVM_HIGH)
      
      //calling ref_model method
      ref_tr[0] = ref_model(tr[0], ref_tr[0],0);

      //calling check_data method
      check_data(tr[0], ref_tr[0],0);
      `uvm_info("WRITE_0", "write0 method is working..",UVM_HIGH)
      
      //sampling covergroups
      rcg1.sample(Reset, tr[0].mode, tr[0].InData, ref_tr[0].OutData);
      ecg1.sample(Reset, tr[0].mode, tr[0].InData, ref_tr[0].OutData);
      rocg1.sample(tr[0].mode, ref_tr[0].OutData);
      pcg1.sample(Reset, tr[0].mode, tr[0].InData, ref_tr[0].OutData);
      pocg.sample(Reset, tr[0].mode, tr[1].mode, tr[0].InData, tr[1].InData);
   endfunction

   //function write for counter2
   virtual function void write_1(cntr_trans req);
      Reset = rst_vif.sb_rst_cb.Reset;
      `uvm_info("RST_SB", $sformatf("Reset: %0d", Reset), UVM_HIGH)
      this.tr[1].mode = req.mode;
      this.tr[1].InData = req.InData;
      this.tr[1].OutData = req.OutData;

      `uvm_info("WRITE_1", "write1 method is working..",UVM_HIGH)
      //tr[1].print();

      //calling ref_model method
      ref_tr[1] = ref_model(tr[1], ref_tr[1],1);

      //calling check_data method
      check_data(tr[1], ref_tr[1],2);

      //sampling covergroups
      rcg2.sample(Reset, tr[1].mode, tr[1].InData, ref_tr[1].OutData);
      ecg2.sample(Reset, tr[1].mode, tr[1].InData, ref_tr[1].OutData);
      rocg2.sample(tr[1].mode, ref_tr[1].OutData);
      pcg2.sample(Reset, tr[1].mode, tr[1].InData, ref_tr[1].OutData);
      pocg.sample(Reset, tr[0].mode, tr[1].mode, tr[0].InData, tr[1].InData);
   endfunction

   //ref_model() - method for generating expected transactions according to the requirement
   virtual function cntr_trans ref_model(cntr_trans act, exp, int n);
      `uvm_info("SCOREBOARD","Reference model started",UVM_HIGH)
      
      //Logic for generating expected transactions
      if (Reset) begin
         exp.OutData = 8'h0;
      end
      else if(act.mode == LOAD) begin
         exp.OutData = act.InData;
      end
      else if(act.mode == LOAD_UP) begin
         exp.OutData = act.InData;
      end
      else if(act.mode == UP) begin
         exp.OutData += 1;
      end
      else if (act.mode == DOWN) begin
         exp.OutData -= 1;
      end

      exp.InData = act.InData; 
      exp.mode = act.mode; 
      `uvm_info("REF_MODEL",$sformatf("%0d",exp.OutData),UVM_HIGH)

      return exp; //returning expected OutData 
   endfunction
   
   //check_data() - function for comparing expected and actual data
   virtual function void check_data(cntr_trans act, exp, int n);
      if(exp.OutData === act.OutData)
         `uvm_info("CHECK","PASS", UVM_NONE)
      else if(exp.OutData !== act.OutData)
         `uvm_error("CHECK","FAIL")
      
      `uvm_info("CHECK",$sformatf("ACT%0d: mode: %s In: %0d, Out : %0d",n, act.mode, act.InData, act.OutData), UVM_MEDIUM)
      `uvm_info("CHECK",$sformatf("EXP%0d: mode: %s In: %0d, Out : %0d",n, exp.mode, exp.InData, exp.OutData), UVM_MEDIUM)
   endfunction
endclass
 






//sequence file
/*
         else if(N >= 20 && N<25) begin
            assert(trans_h.randomize() with {
               trans_h.Enable == ENABLE;
               trans_h.Load == NO_LOAD; 
               trans_h.UpDown== DOWN; 
            });
         end
         
         else if(N >= 25 && N<30) begin
            assert(trans_h.randomize() with {
               trans_h.Enable == ENABLE;
               trans_h.Load == NO_LOAD; 
               trans_h.UpDown== DOWN; 
            });
         end

         else if(N >= 30 && N<35) begin
            assert(trans_h.randomize() with {
               trans_h.Enable == ENABLE;
               trans_h.Load == NO_LOAD; 
               trans_h.UpDown== DOWN; 
            });
         end
         else begin
            assert(trans_h.randomize() with {
               trans_h.Enable == ENABLE;
               trans_h.Load == NO_LOAD; 
               trans_h.UpDown== DOWN; 
            });
         end
*/
         /*
         
         repeat(5) assert(trans_h.randomize() with {trans_h.mode == DISABLE;});
         repeat(5) assert(trans_h.randomize() with {trans_h.mode == LOAD;});
         repeat(5) assert(trans_h.randomize() with {trans_h.mode == UP;});
         repeat(5) assert(trans_h.randomize() with {trans_h.mode == DOWN;});
         repeat(5) assert(trans_h.randomize());
         */






//base test file
   // for setting default sequence:
   /*
   virtual function start_of_simulation_phase(uvm_phase phase);
      super.start_of_simulation_phase(phase);
      uvm_config_db#(uvm_object_wrapper) :: set()
  */


   /*
   uvm_config_db#(virtual cntr_inf)::set(this,$sformatf("env_h.agent[%0d]",i),"vif",vif[i]);
   uvm_config_db#(virtual cntr_inf)::set(this,"env_h.sb_h","rst_vif",rst_vif);
   tb_cfg[i] = cntr_config::type_id::create($sformatf("tb_cfg[%0d]",i));
env_cfg = env_config::type_id::create("env_cfg");
   if(!uvm_config_db #(virtual cntr_inf) :: get(this, "",$sformatf("vif_%0d",i), tb_cfg[i].vif))
   if(!uvm_config_db #(virtual cntr_inf)::get(this, "","vif", tb_cfg[i].vif))
   $display("i: %0d, vif_%0d",i,i);

   if(!uvm_config_db #(virtual cntr_inf)::get(this, "","vif2", vif2))
      `uvm_fatal("VIF_CONFIG","cannot get")


   `uvm_info("BASE_TEST","In base_test build_phase",UVM_MEDIUM)

   if(!uvm_config_db #(int) :: get(this, "", "no_of_dut", env_cfg.no_of_dut))
      `uvm_fatal("NO_AGENTS_CONFIG","cannot got")
   tb_cfg[i].no_of_dut= no_of_dut;

   uvm_config_db#(cntr_config)::set(this,$sformatf("*.agent[%0d].*", i),$sformatf("cntr_config[%0d]",i),tb_cfg[i]);
      `uvm_info("",$sformatf("rst_vif",),UVM_MEDIUM)

uvm_config_db#(cntr_config)::set(this,"*","env_config",env_cfg);
$display("%p",tb_cfg);
*/


//For using configuration class - instead of directly using config_db
//tb_cfg = cntr_config::type_id::create("tb_cfg");

//if(!uvm_config_db #(virtual cntr_inf) :: get(this, "", "vif", tb_cfg.vif))
//   `uvm_fatal("VIF_CONFIG","cannot got")
//`uvm_info("E_L_TEST","In base_test build_phase",UVM_MEDIUM)

//uvm_config_db#(cntr_config)::set(this,"*","cntr_config",tb_cfg);
// $display("%p",tb_cfg);

//uvm_config_db#(cntr_config)::get(this,"*","cntr_config[",tb_cfg);


/* for applying reset from test class
fork
   apply_reset();
   #100 apply_reset(20);
   #200 apply_reset(5);
   #300 apply_reset(10);
   rseqs_1.start(env_h.agent[0].seqr_h);
   rseqs_2.start(env_h.agent[1].seqr_h);
join
*/






//top file
//instances of interface  
//cntr_inf inf0(Clk);
//cntr_inf inf1(Clk);

   //instantiating dut
   //dut_top dut(.Clk(inf0.Clk), .Reset(rst_inf.Reset), .Enable_1(inf0.Enable), .Load_1(inf0.Load), .UpDown_1(inf0.UpDown), .In_Data_1(inf0.InData), .Out_Data_1(inf0.OutData), .Enable_2(inf1.Enable), .Load_2(inf1.Load), .UpDown_2(inf1.UpDown), .In_Data_2(inf1.InData), .Out_Data_2(inf1.OutData));
/*setting interface reset value
   initial begin
      inf0.Reset = 1;
      repeat(1) @(posedge Clk);
      inf0.Reset = 0;
   end
   */

   //initial begin
   //   uvm_config_db #(virtual cntr_inf)::set(null,"*","vif_0", inf0);
   //   uvm_config_db #(virtual cntr_inf)::set(null,"*","vif_1", inf1);
   //   uvm_config_db #(virtual cntr_inf)::set(null,"*","rst_vif", rst_inf);
   //   uvm_config_db #(int)::set(null,"*","no_of_dut", N);
   //end 

