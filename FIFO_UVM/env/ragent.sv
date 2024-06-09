
class fifo_ragent extends uvm_agent;

    `uvm_component_utils(fifo_ragent)
   
    //virtual fifo_if vif;
   
   //fifo_wmon  wmon_h;
   fifo_rmon  rmon_h;
   //fifo_wdr   wdr_h;
   fifo_rdr   rdr_h;
//   fifo_wseqr wseqr_h;
   fifo_rseqr rseqr_h;
   agent_config agnt_cfg;
   
   function new (string name = "fifo_ragent", uvm_component parent);
     super.new(name,parent);
   endfunction
   
   function void build_phase (uvm_phase phase);
     super.build_phase(phase);
//    wmon_h = fifo_wmon::type_id::create("wmon_h",this);
    rmon_h = fifo_rmon::type_id::create("rmon_h",this);
//    wdr_h = fifo_wdr::type_id::create("wdr_h",this);
    rdr_h = fifo_rdr::type_id::create("rdr_h",this);
//    wseqr_h = fifo_wseqr::type_id::create("wseqr_h",this);
    rseqr_h = fifo_rseqr::type_id::create("rseqr_h",this);
    //if (!uvm_config_db#(virtual fifo_if)::get(this,"","vif", vif)) begin
      //  `uvm_fatal("READ_AGENT", "The virtual interface get failed");
   endfunction
   
   function void connect_phase (uvm_phase phase);
      rdr_h.seq_item_port.connect(rseqr_h.seq_item_export);
  //    wdr_h.seq_item_port.connect(wseqr_h.seq_item_export);
     //rdr_h.vif = vif;
     //rmon_h.vif = vif;
   endfunction
   
endclass
