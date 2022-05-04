// count up oin each button press and display on LEDs
module clock(
  input       clk,
  input       pmod,
  output  reg [3:0] led
);

  wire rst;
  wire clk;

  // reset is the inverse of the first button
  assign rst = ~pmod[0];

  // counter for the clock
  reg [31:0] cnt = 32'b0;
  parameter DIVISOR = 32'd12000000 - 1;

  // count up on clock rising edge or reset on button push
  always @ (posedge clk or posedge rst) begin
    if (rst == 1'b1) begin
      led <= 4'b0000;
    end else begin
      if (cnt == DIVISOR) begin
        led <= led + 1'b1;
      end
    end
  end

  // counting the clock cycles
  always @ (posedge clk) begin
    if (cnt >= DIVISOR) begin
      cnt <= 32'b0;
    end else begin
      cnt <= cnt + 1'b1;
    end
  end

endmodule
