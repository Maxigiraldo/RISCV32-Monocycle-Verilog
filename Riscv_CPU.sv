module Riscv_CPU (
    input clk,
    input rst,
	 output [31:0] out_alu_result,
	 output [6:0] hex0,
	 output [6:0] hex1,
	 output [6:0] hex2,
	 output [6:0] hex3,
	 output [6:0] hex4
);

// ========== SEÑALES ENTRE ETAPAS ==========
    
   // Fetch (IF)
   wire [31:0] pc_out;
   wire [31:0] instruction;
    
   // Decode (ID)
   wire [4:0] rs1, rs2, rd;
   wire [31:0] rd1_data, rd2_data;
   wire [31:0] immediate;
   wire [6:0] opcode;
   wire [2:0] funct3;
   wire [6:0] funct7;
   
   // Control signals
   wire reg_write;
   wire alu_src;      // 0=reg, 1=immediate
   wire [1:0] alu_op;
    
   // Execute (IE)
   wire [3:0] alu_control;
   wire [31:0] alu_operand_b;
   wire [31:0] alu_result;
   wire alu_zero;
    
   // Write Back (WB)
   wire [31:0] write_back_data;
	 
// ========== EXTRACCIÓN DE CAMPOS DE LA INSTRUCCIÓN ==========
   assign opcode = instruction[6:0];
   assign rd     = instruction[11:7];
   assign funct3 = instruction[14:12];
   assign rs1    = instruction[19:15];
   assign rs2    = instruction[24:20];
   assign funct7 = instruction[31:25];
	 
// ========== ETAPA 1: FETCH (IF) ==========
   
	assign pc_next = pc_out + 4;
	
   Program_Counter PC (
       .pc_in(pc_next),      // Por ahora solo PC+4 (sin branches)
       .clk(clk),
       .rst(rst),
       .pc_out(pc_out)
   );
    
   Instruction_Memory IMEM (
       .addr(pc_out),
       .instruction(instruction)
   );
   
// ========== ETAPA 2: DECODE (ID) ==========
    
   Register_Unit REG_FILE (
       .clk(clk),
		 .rst(rst),
       .rs1(rs1),
       .rs2(rs2),
       .rd(rd),
       .wr_data(write_back_data),
       .wr_en(reg_write),
       .rd1(rd1_data),
       .rd2(rd2_data)
   );
    
   Imm_generator IMM_GEN (
       .instruction(instruction),
       .imm(immediate)
   );
    
   Control_Unit CONTROL (
       .opcode(opcode),
       .funct3(funct3),
       .funct7(funct7),
       .branch(),           // No usado por ahora
       .mem_read(),         // No usado por ahora
       .mem_to_reg(),       // No usado por ahora
       .alu_op(alu_op),
       .mem_write(),        // No usado por ahora
       .alu_src(alu_src),
       .reg_write(reg_write)
   );

// ========== ETAPA 3: EXECUTE (IE) ==========
    
   // MUX para seleccionar segundo operando de la ALU (registro o inmediato)
   mux2to1 #(.WIDTH(32)) ALU_SRC_MUX (
       .in0(rd2_data),      // Operando desde registro (R-type)
       .in1(immediate),     // Operando inmediato (I-type)
       .sel(alu_src),
       .out(alu_operand_b)
   );
    
   ALU_Control ALU_CTRL (
       .alu_op(alu_op),
       .funct3(funct3),
       .funct7(funct7),
       .alu_control(alu_control)
   );
    
   ALU_Module ALU_UNIT (
       .operand_a(rd1_data),
       .operand_b(alu_operand_b),
       .alu_control(alu_control),
       .result(alu_result),
       .zero(alu_zero)      // No usado por ahora
   );
	
// ========== ETAPA 5: WRITE BACK (WB) ==========
   // Por ahora, solo escribimos el resultado de la ALU
   assign write_back_data = alu_result;
	
	assign out_alu_result = alu_result;
	
	wire [3:0] hex_d0;
	wire [3:0] hex_d1;
	wire [3:0] hex_d2;
	wire [3:0] hex_d3;
	wire [3:0] hex_d4;
	
	assign hex_d0 = alu_result[3:0];
	assign hex_d1 = alu_result[7:4];
	assign hex_d2 = alu_result[11:8];
	assign hex_d3 = alu_result[15:12];
	assign hex_d4 = alu_result[19:16];
	
	hex7seg result4 (
		.hex_in(hex_d4),
		.segments(hex4)
	);
	hex7seg result3 (
		.hex_in(hex_d3),
		.segments(hex3)
	);
	hex7seg result2 (
		.hex_in(hex_d2),
		.segments(hex2)
	);
	hex7seg result1 (
		.hex_in(hex_d1),
		.segments(hex1)
	);
	hex7seg result0 (
		.hex_in(hex_d0),
		.segments(hex0)
	);
	
	// ========== MONITOR PARA DEPURACIÓN ==========
   always @(posedge clk) begin
       if (!rst) begin
           $display("======================");
           $display("Ciclo | PC    | Instr    | Operación");
           $display("------|-------|----------|----------");
       end
       if (reg_write && rd != 0) begin
           $display("%5d | %5h | %8h | x%2d = %h", 
                    $time/2, pc_out, instruction, rd, alu_result);
       end
   end
endmodule
