module control_unit (
    input [3:0] opcode,
    input carryf,
    input zerof,
    input overflowf,
    input signf,
    input [3:0] pc_address,

    output reg flag_write,
    output reg reg_write,
    output reg [1:0] alu_op,
    output reg pc_select,
    output reg [3:0] jump_address,
    output reg ir_load,
    output reg halt,
    output reg [1:0] writeback_sel
);

localparam ADD = 2'd0;
localparam SUB = 2'd1;
localparam AND = 2'd2;
localparam OR = 2'd3;
localparam ALU_NOP = 2'd0;


always @(*) begin
    flag_write = 0;
    reg_write = 0;
    alu_op = ALU_NOP;
    pc_select = 0;
    jump_address = 0;
    ir_load = 0;
    halt = 0;
    writeback_sel = 0;

    case (opcode)
        4'd0: begin
            reg_write = 1;
            pc_select = 0;
            ir_load = 1;
        end

        4'd1: begin
            flag_write = 1;
            alu_op = ADD;
            reg_write = 1;
            pc_select = 0;
            writeback_sel = 2'd1;
            ir_load = 1;
        end

        4'd2: begin
            ir_load = 1;
            if (carryf) begin
                pc_select = 1;
                jump_address = pc_address;
            end
        end

        4'd3: begin
            pc_select = 1;
            jump_address = pc_address;
            ir_load = 1;
        end

        4'd4: begin
            pc_select = 0;
            halt = 1;
            ir_load = 0;
        end

        4'd5: begin
            reg_write = 1;
            pc_select = 0;
            writeback_sel = 2'd2;
            ir_load = 1;
        end
        default: halt = 1;
    endcase
end

endmodule