
class fifo_base_test extends uvm_test;
 
  `uvm_component_utils(fifo_base_test)

  fifo_env env_h;

  fifo_base_wseqs wseqs_h;
  fifo_base_rseqs rseqs_h;
  agent_config tb_cfg;
  
  function new (string name = "fifo_base_test", uvm_component parent);
     super.new(name,parent);
   endfunction
   
  function void build_phase (uvm_phase phase);
      tb_cfg = agent_config::type_id::create("tb_cfg");

      if(!uvm_config_db #(virtual fifo_if) :: get(this,"","fifo_vif",tb_cfg.vif))
      `uvm_fatal("VIF_CONFIG","cannot got")

      uvm_config_db#(agent_config)::set(this,"*","agent_config",tb_cfg);
      super.build_phase(phase);
      env_h = fifo_env::type_id::create("env_h",this);


       //creates sequences
   endfunction
  
  task run_phase (uvm_phase phase);
     phase.raise_objection(this);
     wseqs_h.start(env_h.wagent_h.wseqr_h);
     rseqs_h.start(env_h.ragent_h.rseqr_h);    
  phase.drop_objection(this);
  endtask
  
endclass
