module status_registers (
    input clk,
    input reset,
    input flag_write,

    input carryf,
    input zerof,
    input overflowf,
    input signf,

    output reg status_carry,
    output reg status_zero,
    output reg status_overflow,
    output reg status_sign
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        status_carry <= 0;
        status_overflow <= 0;
        status_sign <= 0;
        status_zero <= 0;
    end

    else if (flag_write) begin
        status_carry <= carryf;
        status_overflow <= overflowf;
        status_sign <= signf;
        status_zero <= zerof;
    end
    
end
    
endmodule