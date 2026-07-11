module instruction_memory (
    input [3:0] pc_in,
    output reg [15:0] instruction
);

localparam MOV = 4'd0;
localparam ADD = 4'd1;
localparam BOV = 4'd2;
localparam JMP = 4'd3;
localparam HALT = 4'd4;
localparam LOADI = 4'd5;

always @(*) begin
    case (pc_in)
        4'd0: instruction = {LOADI, 2'b01, 8'd1, 2'b0}; // LOADI r1, 0000_0001, unused

        4'd1: instruction = {MOV, 2'b10, 2'b00, 8'b0}; // MOV r2, r0

        4'd2: instruction = {ADD, 2'b10, 2'b00, 2'b01, 6'b0}; // ADD r2, r0, r1
        
        4'd3: instruction = {BOV, 4'b0111, 8'b0}; // BOV 111
        
        4'd4: instruction = {MOV, 2'b00, 2'b01, 8'b0}; // MOV r0, r1
        
        4'd5: instruction = {MOV, 2'b01, 2'b10, 8'b0}; // MOV r1, r2

        4'd6: instruction = {JMP, 4'b0010, 8'b0}; // JMP 010

        4'd7: instruction = {HALT, 12'b0}; // HALT (PC Address:111)

        default: instruction = {HALT, 12'b0}; // HALT
endcase
end

    
endmodule