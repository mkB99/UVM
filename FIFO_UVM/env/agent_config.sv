class agent_config extends uvm_object;
`uvm_object_utils(agent_config)

virtual fifo_if vif;

uvm_active_passive_enum active;

function new(string name = "agent_config");
   super.new(name);
endfunction
endclass
