`timescale 1ns / 1ps
//`include "sccomp_dataflow.v"

module tb();
	reg clock;
	reg reset;
	wire [31:0]inst;
	wire [31:0]pc;
	wire [31:0]addr;

    sccomp_dataflow cpu(clock, reset, inst, pc, addr);

	integer file_output;

    initial begin
        file_output = $fopen("D:/readtest/coe_mine1.1.txt");
        clock = 0;
        reset = 1; 
        #50
        reset = 0;
    end
    
	//initial begin
		//$dumpfile("tb.vcd");
		//$dumpvars;
	//end
    
	initial begin
	//always begin
        repeat(5000) begin
        #50
        clock = ~clock; 
        end
    //end
	end
    
     always @ (posedge clock) begin
        if(clock == 1'b1) begin
            $fdisplay(file_output,"pc: %h",pc);
            $fdisplay(file_output,"instr: %h",inst);
            
            $fdisplay(file_output,"regfile0: %h",tb.cpu.sccpu.cpu_ref.array_reg[0]);
            $fdisplay(file_output,"regfile1: %h",tb.cpu.sccpu.cpu_ref.array_reg[1]);
            $fdisplay(file_output,"regfile2: %h",tb.cpu.sccpu.cpu_ref.array_reg[2]);
            $fdisplay(file_output,"regfile3: %h",tb.cpu.sccpu.cpu_ref.array_reg[3]);
            $fdisplay(file_output,"regfile4: %h",tb.cpu.sccpu.cpu_ref.array_reg[4]);
            $fdisplay(file_output,"regfile5: %h",tb.cpu.sccpu.cpu_ref.array_reg[5]);
            $fdisplay(file_output,"regfile6: %h",tb.cpu.sccpu.cpu_ref.array_reg[6]);
            $fdisplay(file_output,"regfile7: %h",tb.cpu.sccpu.cpu_ref.array_reg[7]);
            $fdisplay(file_output,"regfile8: %h",tb.cpu.sccpu.cpu_ref.array_reg[8]);
            $fdisplay(file_output,"regfile9: %h",tb.cpu.sccpu.cpu_ref.array_reg[9]);
            $fdisplay(file_output,"regfile10: %h",tb.cpu.sccpu.cpu_ref.array_reg[10]);
            $fdisplay(file_output,"regfile11: %h",tb.cpu.sccpu.cpu_ref.array_reg[11]);
            $fdisplay(file_output,"regfile12: %h",tb.cpu.sccpu.cpu_ref.array_reg[12]);
            $fdisplay(file_output,"regfile13: %h",tb.cpu.sccpu.cpu_ref.array_reg[13]);
            $fdisplay(file_output,"regfile14: %h",tb.cpu.sccpu.cpu_ref.array_reg[14]);
            $fdisplay(file_output,"regfile15: %h",tb.cpu.sccpu.cpu_ref.array_reg[15]);
            $fdisplay(file_output,"regfile16: %h",tb.cpu.sccpu.cpu_ref.array_reg[16]);
            $fdisplay(file_output,"regfile17: %h",tb.cpu.sccpu.cpu_ref.array_reg[17]);
            $fdisplay(file_output,"regfile18: %h",tb.cpu.sccpu.cpu_ref.array_reg[18]);
            $fdisplay(file_output,"regfile19: %h",tb.cpu.sccpu.cpu_ref.array_reg[19]);
            $fdisplay(file_output,"regfile20: %h",tb.cpu.sccpu.cpu_ref.array_reg[20]);
            $fdisplay(file_output,"regfile21: %h",tb.cpu.sccpu.cpu_ref.array_reg[21]);
            $fdisplay(file_output,"regfile22: %h",tb.cpu.sccpu.cpu_ref.array_reg[22]);
            $fdisplay(file_output,"regfile23: %h",tb.cpu.sccpu.cpu_ref.array_reg[23]);
            $fdisplay(file_output,"regfile24: %h",tb.cpu.sccpu.cpu_ref.array_reg[24]);
            $fdisplay(file_output,"regfile25: %h",tb.cpu.sccpu.cpu_ref.array_reg[25]);
            $fdisplay(file_output,"regfile26: %h",tb.cpu.sccpu.cpu_ref.array_reg[26]);
            $fdisplay(file_output,"regfile27: %h",tb.cpu.sccpu.cpu_ref.array_reg[27]);
            $fdisplay(file_output,"regfile28: %h",tb.cpu.sccpu.cpu_ref.array_reg[28]);
            $fdisplay(file_output,"regfile29: %h",tb.cpu.sccpu.cpu_ref.array_reg[29]);
            $fdisplay(file_output,"regfile30: %h",tb.cpu.sccpu.cpu_ref.array_reg[30]);
            $fdisplay(file_output,"regfile31: %h",tb.cpu.sccpu.cpu_ref.array_reg[31]);
            //$fdisplay(file_output,"HI: %h",tb.cpu.sccpu.hilo.hi);
            //$fdisplay(file_output,"LO: %h",tb.cpu.sccpu.hilo.lo);
        end     
    end
    //tb.cpu.sccpu.cpu_ref.array_reg

endmodule
