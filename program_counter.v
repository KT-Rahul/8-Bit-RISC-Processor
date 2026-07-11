module program_counter(
    input clk,
    input reset,
    input halt,
    input pc_select,
    input [3:0] jump_address,

    output reg [3:0] pc
);

always @(posedge clk or posedge reset) begin

    if(reset)
        pc <= 4'd0;

    else if(halt)
        pc <= pc;          // Hold current value

    else if(pc_select)
        pc <= jump_address;

    else
        pc <= pc + 1;

end


endmodule