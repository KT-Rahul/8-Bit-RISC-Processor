module alu (
    input [7:0] a,
    input [7:0] b,
    input [1:0] op,
    input flag_write,
    output reg [7:0] result,
    output reg carryf,
    output zerof,
    output reg overflowf,
    output signf
);

reg [8:0] hold;

assign zerof = (result == 8'b0);
assign signf = result[7];

always @(*) begin
    result = 8'b0;
    carryf = 1'b0;
    overflowf = 1'b0;
    if (flag_write) begin
        case (op)
            2'b00: begin
                hold = a + b;
                result = hold[7:0];
                carryf = hold[8];
                overflowf = ~(a[7]^b[7]) & (a[7]^result[7]);
            end

            2'b01: begin
                result = a - b;
                hold = result;
                carryf = ~hold[8];
                overflowf = (a[7]^b[7]) & (a[7]^result[7]);
            end

            2'b10: result = a & b;

            2'b11: result = a | b;

            default: result = a & b;
        endcase
    end
end

endmodule