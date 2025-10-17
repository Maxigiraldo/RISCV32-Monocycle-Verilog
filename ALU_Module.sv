module ALU_Module (
   input [31:0] operand_a,
	input [31:0] operand_b,
   input [3:0] alu_control,
   output reg [31:0] result,
   output zero
);
	always @(*) begin
		case (alu_control)
				4'b0000: result = operand_a + operand_b;      // ADD
            4'b0001: result = operand_a - operand_b;      // SUB
            4'b0010: result = operand_a & operand_b;      // AND
            4'b0011: result = operand_a | operand_b;      // OR
				4'b0100: result = operand_a ^ operand_b;      // XOR
            4'b0101: result = operand_a << operand_b[4:0]; // SLL
            4'b0110: result = operand_a >> operand_b[4:0]; // SRL
            4'b0111: result = $signed(operand_a) >>> operand_b[4:0]; // SRA
            4'b1000: result = ($signed(operand_a) < $signed(operand_b)) ? 1 : 0; // SLT
            4'b1001: result = (operand_a < operand_b) ? 1 : 0; // SLTU
            default: result = 32'b0;
		endcase
		end
    
	assign zero = (result == 32'b0);
endmodule