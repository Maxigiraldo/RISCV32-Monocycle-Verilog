module Instruction_Memory (
	input [31:0] addr,
	output reg [31:0] instruction
);
	reg [31:0] mem [0:1023];
    
	// Inicialización con programa de prueba
	initial begin
		$readmemh("instructions.hex", mem);
	end
	
	// Lectura combinacional - word aligned
	always @(*) begin
		instruction = mem[addr[11:2]];
	end
endmodule