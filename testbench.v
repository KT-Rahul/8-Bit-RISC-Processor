module testbench ();
    
    reg clk;
    reg reset;

    cpu ob1(.clk(clk), .reset(reset));

    always #5 clk = ~clk;

    initial begin
        reset = 1;
        clk = 0;
        #10 reset = 0;
        #700;
        $finish;
    end


endmodule