
module sccomp_dataflow(clk_in,reset,inst,pc,addr);
    input clk_in;
    input reset;
    output [31:0] inst;
    output [31:0] pc;
    output [31:0]addr;
    
    wire [31:0] dmem_out;
    wire [31:0] dmem_addr;
    wire [31:0] dmem_data;
    wire dmem_we;
    wire [31:0] imem_addr;
    assign pc=imem_addr;
    wire [31:0] real_pc;
    assign real_pc=imem_addr-32'h00400000;
    wire [31:0] real_store;
    assign real_store=dmem_addr-32'h10010000;
    assign addr=dmem_addr;
   
   //module InstMEM(a,spo);
    //InstMEM InstMEM_(real_pc[12:2],inst);
    imem3 imem(real_pc[12:2],inst);
    //module cpu31(clk_in,reset,instr,pc_out,dmem_out,dmem_addr,dmem_data,dmem_we);
    cpu31 sccpu(clk_in,reset,inst,imem_addr,dmem_out,dmem_addr,dmem_data,dmem_we);
    //module DataMEM(a,d,clk,we,spo);
    DataMEM DataMEM_(real_store[10:0],dmem_data,clk_in,dmem_we,dmem_out);
    
endmodule

