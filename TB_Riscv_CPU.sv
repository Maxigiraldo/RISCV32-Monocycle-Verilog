module TB_Riscv_CPU;
    reg clk, rst;
	 wire [31:0] out_alu_result;
    wire [6:0] hex0, hex1, hex2, hex3, hex4;
    
    Riscv_CPU DUT (
        .clk(clk),
        .rst(rst),
		  .out_alu_result(out_alu_result),
        .hex0(hex0),
        .hex1(hex1),
        .hex2(hex2),
        .hex3(hex3),
        .hex4(hex4)
    );
    
    // Generador de clock
    initial clk = 0;
    always #5 clk = ~clk;
    
    
    // Secuencia de reset y ejecución
    initial begin
		$display("Iniciando simulación RISC-V Pipeline Simple");
        $display("Soporta: R-type (ADD, SUB, AND, OR, XOR, SLL, SRL, SRA, SLT, SLTU)");
        $display("         I-type (ADDI, ANDI, ORI, XORI, SLLI, SRLI, SRAI, SLTI, SLTIU)");
        $display("");

        rst = 0;      // Activar reset (bajo = activo)
        #50;
		  #10 rst = 1;  // Desactivar reset (alto = inactivo)
		  
        #500 $finish;
    end
    
    // Volcado de formas de onda
    initial begin
        $dumpfile("Riscv_CPU.vcd");
        $dumpvars(0, TB_Riscv_CPU);
    end
endmodule