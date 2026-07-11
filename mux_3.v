module mux_3 (
    input [7:0] rdata2,
    input [7:0] alu_result,
    input [7:0] immediate_value,
    input [1:0] writeback_sel,

    output reg [7:0] writeback_data
);
    
    always @(*) begin
        case (writeback_sel)
            2'd0: writeback_data = rdata2;

            2'd1: writeback_data = alu_result;

            2'd2: writeback_data = immediate_value;
        endcase
    end
    
endmodule