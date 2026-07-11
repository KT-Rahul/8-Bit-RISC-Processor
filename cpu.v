module cpu (
    input clk,
    input reset
);


// Program Counter:
wire pc_select;
wire [3:0] jump_address;
wire HALT;
wire [3:0] pc_in;
program_counter pc(.clk(clk), .reset(reset), .halt(HALT), .pc_select(pc_select), .jump_address(jump_address), .pc(pc_in));


// Instruction Memory:
wire [15:0] instruction_fromMem;
instruction_memory irM(.pc_in(pc_in), .instruction(instruction_fromMem));


// Instruction Register:
wire ir_load;
wire [15:0] instruction_outofReg;
instruction_register irR(.clk(clk), .reset(reset), .instruction_in(instruction_fromMem), .ir_load(ir_load),
                        .instruction_out(instruction_outofReg));


// Instruction Decoder:
wire [3:0] opcode; // output
wire [1:0] rd; // output
wire [1:0] rA; // output
wire [1:0] rB; // output
wire [3:0] pc_address; // output
wire [7:0] immediate_value; // output
instruction_decoder irD(.instruction(instruction_fromMem), .opcode(opcode), .rd(rd), .rA(rA), .rB(rB),
                        .pc_address(pc_address), .immediate_value(immediate_value));



// Register File:
wire reg_write;
wire [7:0] writeback_data;
wire [7:0] rdata1;
wire [7:0] rdata2;
register_file regf(.clk(clk), .reset(reset), .w_enable(reg_write), .w_address(rd),
                    .w_data(writeback_data), .raddress1(rA), .raddress2(rB), .rdata1(rdata1), .rdata2(rdata2));



// Control Unit:
wire [1:0] alu_op;
wire [1:0] writeback_sel;
wire status_carry;
wire status_zero;
wire status_overflow;
wire status_sign;
wire flag_write;
control_unit cu(.opcode(opcode), .carryf(status_carry), .zerof(status_zero), .overflowf(status_overflow), .signf(status_sign),
                .pc_address(pc_address), .flag_write(flag_write), .reg_write(reg_write), .alu_op(alu_op), .pc_select(pc_select),
                .jump_address(jump_address), .ir_load(ir_load), .halt(HALT), .writeback_sel(writeback_sel));



// ALU:
wire carryf;
wire zerof;
wire overflowf;
wire signf;
wire [7:0] alu_result;
alu al(.a(rdata1), .b(rdata2), .op(alu_op), .flag_write(flag_write), .result(alu_result), .carryf(carryf), .zerof(zerof), .overflowf(overflowf),
        .signf(signf));


// Status Registers:
status_registers sr(.clk(clk), .reset(reset), .flag_write(flag_write), .carryf(carryf), .zerof(zerof), .overflowf(overflowf),
                    .signf(signf), .status_carry(status_carry), .status_overflow(status_overflow),
                    .status_sign(status_sign), .status_zero(status_zero));


// 2:1 MUX to sort alu_result and just moving data.
mux_3 mux(.alu_result(alu_result), .rdata2(rdata1), .immediate_value(immediate_value), .writeback_sel(writeback_sel),
            .writeback_data(writeback_data));
    
endmodule