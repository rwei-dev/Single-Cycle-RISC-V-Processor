module testbench();
  logic              clk;
  logic [31:0] WriteData, DataAdr;
  logic              MemWrite;
  logic [9:0] SW;
  assign SW = 10'b0000111111;
  logic [1:0] KEY;
  logic reset;
  logic [9:0] LEDR;
  logic [7:0] HEX0;
  logic [7:0] HEX1;
  logic [7:0] HEX2;
  logic [7:0] HEX3;
  logic [7:0] HEX4;
  logic [7:0] HEX5;
    // instantiate device to be tested
  top dut(clk, WriteData, DataAdr, MemWrite, SW, {KEY[1], reset}, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
    // initialize test
    initial
     begin
       reset <= 0; # 22; reset <= 1;
     end
    // generate clock to sequence tests
    always
    begin
        clk <= 1; # 5; clk <= 0; # 5;
    end
    // check results
    always @(negedge clk)
   begin
        if(MemWrite) begin
	  $display("Time = %0t ns | MemWrite: Addr = %0h, Data = %0h", $time, DataAdr, WriteData);
	      if ($time > 100) begin
                  $display("Stopping simulation after 100ns.");
                  $stop;
              end
        end
    end
endmodule