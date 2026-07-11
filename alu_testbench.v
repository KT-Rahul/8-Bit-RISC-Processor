module alu_testbench();

reg [7:0] a = 8'b00110111;
reg [7:0] b = 8'b01011001;
reg [1:0] opcode = 2'b00; // Manually changing opcode here

wire carryf, zerof, overflowf, signf;
wire [7:0] result;

alu ob(.a(a), .b(b), .op(opcode), .result(result), .carryf(carryf), .zerof(zerof), .overflowf(overflowf), .signf(signf));


initial begin
#1
$display("A Value : %b", a);
$display("B Value : %b", b);
$display("Opcode  : %b", opcode);
$display("Result  : %b", result);
$display("Carry flag     : %b", carryf);
$display("Zero flag      : %b", zerof);
$display("Overflow Flag  : %b", overflowf);
$display("Sign flag      : %b", signf);
end

endmodule