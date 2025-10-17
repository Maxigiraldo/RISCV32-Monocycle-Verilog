module Control_Unit (
   input [6:0] opcode,
   input [2:0] funct3,
   input [6:0] funct7,
   output reg branch,
   output reg mem_read,
   output reg mem_to_reg,
   output reg [1:0] alu_op,
   output reg mem_write,
   output reg alu_src,
   output reg reg_write
);

	// Definir los opcodes
    localparam OPCODE_R = 7'b0110011; // ADD, SUB, XOR, OR, AND, etc.
    localparam OPCODE_I = 7'b0010011; // ADDI, XORI, ORI, ANDI, etc.

   always @(*) begin
       // Valores por defecto
       {branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write} = 6'b0;
        alu_op    = 2'b00;  // Default
        alu_src   = 1'b0;   // Default
        reg_write = 1'b0;   // Default
       
       case (opcode)
           OPCODE_R: begin // Instrucción TIPO-R
                alu_op    = 2'b10; // '10' para TIPO-R
                alu_src   = 1'b0;  // Operando B viene de un registro
                reg_write = 1'b1;
            end

            OPCODE_I: begin // Instrucción TIPO-I
                alu_op    = 2'b00; // '00' para TIPO-I (ADDI)
                alu_src   = 1'b1;  // Operando B es el inmediato
                reg_write = 1'b1;
            end
           
           7'b0000011: begin // Load
               alu_src = 1;
               mem_to_reg = 1;
               reg_write = 1;
               mem_read = 1;
               alu_op = 2'b00;
           end
           
           7'b0100011: begin // Store
               alu_src = 1;
               mem_write = 1;
               alu_op = 2'b00;
           end
           
           7'b1100011: begin // Branch
               branch = 1;
               alu_op = 2'b01;
           end
			  
			  default: begin
               // NOP o instrucción no reconocida
               {branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write} = 6'b0;
               alu_op = 2'b00;
           end
       endcase
   end

endmodule
