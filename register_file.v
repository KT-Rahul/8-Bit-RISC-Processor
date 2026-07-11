module register_file(clk, reset, w_enable, w_address, w_data, raddress1, raddress2, rdata1, rdata2);

input clk, reset, w_enable;
input [1:0] w_address, raddress1, raddress2;
input [7:0] w_data;
output reg [7:0] rdata1, rdata2;


reg [7:0] register [0:3];

// Combinational Logic
always @(*) begin
    case (raddress1)
    2'b00: rdata1 = register[0];
    2'b01: rdata1 = register[1];
    2'b10: rdata1 = register[2];
    2'b11: rdata1 = register[3];
    default: rdata1 = 8'b0;
    endcase
end

always @(*) begin
    case (raddress2)
    2'b00: rdata2 = register[0];
    2'b01: rdata2 = register[1];
    2'b10: rdata2 = register[2];
    2'b11: rdata2 = register[3];
    default: rdata2 = 8'b0;
    endcase
end

// Sequential Logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        register[0] <= 8'b0;
        register[1] <= 8'b0;
        register[2] <= 8'b0;
        register[3] <= 8'b0;
    end

    else if (w_enable) begin
        case (w_address)
            2'b00: register[0] <= w_data;
            2'b01: register[1] <= w_data;
            2'b10: register[2] <= w_data;
            2'b11: register[3] <= w_data;
        endcase
    end

end


endmodule