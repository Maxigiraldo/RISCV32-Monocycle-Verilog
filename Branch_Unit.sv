module Branch_Unit (
	input [31:0] rs1_data,
	input [31:0] rs2_data,
	input [2:0] funct3,
	input branch,
	output reg pc_src
);
always @(*) begin
	pc_src = 0;
		if (branch) begin
			case (funct3)
				3'b000: pc_src = (rs1_data == rs2_data);           // BEQ
            3'b001: pc_src = (rs1_data != rs2_data);           // BNE
            3'b100: pc_src = ($signed(rs1_data) < $signed(rs2_data));  // BLT
            3'b101: pc_src = ($signed(rs1_data) >= $signed(rs2_data)); // BGE
            3'b110: pc_src = (rs1_data < rs2_data);            // BLTU
            3'b111: pc_src = (rs1_data >= rs2_data);           // BGEU
            default: pc_src = 0;
			endcase
		end
	end
endmodule