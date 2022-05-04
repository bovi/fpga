// count up oin each button press and display on LEDs
module button_counter(
  input       [1:0] pmod,

  output  reg [3:0] led
);

  wire rst;
  wire clk;

  // reset is the inverse of the first button
  assign rst = ~pmod[0];

  // clock signal is the inverse of second button
  assign clk = ~pmod[1];

  // count up on clock rising edge or reset on button push
  always @ (posedge clk or posedge rst) begin
    if (rst == 1'b1) begin
      led <= 4'b0000;
    end else begin
      led <= led + 1'b1;
    end
  end

endmodule
