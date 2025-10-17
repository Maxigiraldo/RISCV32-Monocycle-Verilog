module Register_Unit (
    input clk,
    input rst,
    input [4:0] rs1,      // Read register 1
    input [4:0] rs2,      // Read register 2
    input [4:0] rd,       // Write register
    input [31:0] wr_data, // Write data
    input wr_en,          // Write enable
    output [31:0] rd1,    // Read data 1
    output [31:0] rd2     // Read data 2
);

    reg [31:0] registers [0:31];
    integer i; // Usamos este 'i' en el bucle
    
    // Lectura asíncrona (combinacional)
    // x0 siempre retorna 0
    assign rd1 = (rs1 == 0) ? 32'b0 : registers[rs1];
    assign rd2 = (rs2 == 0) ? 32'b0 : registers[rs2];
    
    // Escritura síncrona con reset asíncrono (activo-bajo)
    always_ff @(posedge clk or negedge rst) begin
        if (!rst) begin
            // Reset activo-bajo: poner TODOS los registros a 0
            for (i = 0; i < 32; i = i + 1) begin
                registers[i] <= 32'b0;
            end
        end else if (wr_en && rd != 0) begin
            // Lógica de escritura normal
            registers[rd] <= wr_data;
        end
    end

endmodule
