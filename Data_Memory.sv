module Data_Memory (
    input clk,              // Clock implícito (no dibujado en diagrama)
    input [31:0] addr,      // DMWr en el diagrama
    input [31:0] write_data,
    input mem_write,        // Señal de control
    input mem_read,         // Señal de control
    output [31:0] read_data // DMCtrl en el diagrama
);

    reg [31:0] mem [0:1023];
    
    // Lectura COMBINACIONAL (sin clock) - datos disponibles inmediatamente
    assign read_data = mem_read ? mem[addr[11:2]] : 32'b0;
    
    // Escritura SÍNCRONA (con clock) - sincronizada con el pipeline
    always @(posedge clk) begin
        if (mem_write)
            mem[addr[11:2]] <= write_data;
    end

endmodule
