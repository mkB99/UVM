
class fifo_env extends uvm_env;

    `uvm_component_utils(fifo_env)
   
   fifo_wagent wagent_h;
   fifo_ragent ragent_h;
   fifo_sb sb_h;
   
   function new (string name = "fifo_env", uvm_component parent=null);
     super.new(name,parent);
   endfunction
   
   function void build_phase (uvm_phase phase);
     super.build_phase(phase);
    wagent_h = fifo_wagent::type_id::create("wagent_h",this);
    ragent_h = fifo_ragent::type_id::create("ragent_h",this);
    sb_h = fifo_sb::type_id::create("sb_h",this);
   endfunction
   function void end_of_elaboration_phase(uvm_phase phase);
      //   uvm_top.print_topology();
   endfunction
   
endclass
