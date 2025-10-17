module Register_Unit (
	input clk,
	input [4:0] rs1,      // Read register 1
	input [4:0] rs2,      // Read register 2
	input [4:0] rd,       // Write register
	input [31:0] wr_data, // Write data
	input wr_en,          // Write enable
	output [31:0] rd1,    // Read data 1
	output [31:0] rd2     // Read data 2
);
	reg [31:0] registers [0:31];
	integer i;
    
	// Inicialización de registros a cero
	initial begin
		for (i = 0; i < 32; i = i + 1) begin
			registers[i] = 32'b0;
		end
	end
    
	// Lectura asíncrona (combinacional)
	// x0 siempre retorna 0
	assign rd1 = (rs1 == 0) ? 32'b0 : registers[rs1];
	assign rd2 = (rs2 == 0) ? 32'b0 : registers[rs2];
	
	// Escritura síncrona
	// x0 nunca se puede escribir
	always @(negedge clk) begin
		if (wr_en && rd != 0)
			registers[rd] <= wr_data;
	end
endmodule