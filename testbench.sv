module testbench();
  logic              clk;
  logic [31:0] WriteData, DataAdr;
  logic              MemWrite;
  logic [9:0] SW;
  assign SW = 10'b0000111111;
  logic [1:0] KEY;
  logic reset;
  logic [9:0] LEDR;
  logic [31:0] HEX3HEX0;
  logic [15:0] HEX5HEX4;
    // instantiate device to be tested
  top dut(clk, WriteData, DataAdr, MemWrite, SW, {KEY[1], reset}, LEDR, HEX3HEX0, HEX5HEX4);
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
          if(DataAdr === 100 & WriteData === 25) begin
              $display("Simulation succeeded");
              $stop;
           end else if (DataAdr !== 96) begin
              $display("Simulation failed");
             $stop;
           end
         end
        end
endmodule