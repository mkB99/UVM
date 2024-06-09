//`ifndef RAM_WAGENT_SV
//typedef RAM_WAGENT_SV

class fifo_wagent extends uvm_agent;

    `uvm_component_utils(fifo_wagent)
   
   //virtual fifo_if vif;
   
   fifo_wmon wmon_h;
   fifo_wdr  wdr_h;
   fifo_wseqr wseqr_h;
   
   function new (string name = "fifo_wagent", uvm_component parent);
     super.new(name,parent);
   endfunction
   
   function void build_phase (uvm_phase phase);
     super.build_phase(phase);
    wmon_h = fifo_wmon::type_id::create("wmon_h",this);
    
    wdr_h = fifo_wdr::type_id::create("wdr_h",this);
    wseqr_h = fifo_wseqr::type_id::create("wseqr_h",this);
    //if (!uvm_config_db#(virtual fifo_if)::get(,"","vif", vif)) begin
      //  `uvm_fatal("WRITE_AGENT", "The virtual interface get failed");
   endfunction
   
   function void connect_phase (uvm_phase phase);
      wdr_h.seq_item_port.connect(wseqr_h.seq_item_export);
     //wdr_h.vif = vif;
     //wmon_h.vif = vif;
   endfunction
   
endclass
//`endif
