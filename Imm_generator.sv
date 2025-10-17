module Imm_generator (
	input [31:0] instruction,
	output reg [31:0] imm
);
   wire [6:0] opcode = instruction[6:0];
    
   always @(*) begin
		case (opcode)
			7'b0010011, 7'b0000011: // I-type (ALU, Load)
				imm = {{20{instruction[31]}}, instruction[31:20]};
            
         7'b0100011: // S-type (Store)
            imm = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
            
         7'b1100011: // B-type (Branch)
            imm = {{19{instruction[31]}}, instruction[31], instruction[7], 
					instruction[30:25], instruction[11:8], 1'b0};
            
         7'b0110111, 7'b0010111: // U-type (LUI, AUIPC)
            imm = {instruction[31:12], 12'b0};
          
         7'b1101111: // J-type (JAL)
            imm = {{11{instruction[31]}}, instruction[31], instruction[19:12],
					instruction[20], instruction[30:21], 1'b0};
            
			default: 
				imm = 32'b0;
		endcase
	end
endmodule