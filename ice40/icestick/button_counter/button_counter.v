// Counter up on each button press and display on LEDs
module button_counter(
	// Inputs
	input	[1:0]		pmod,
	input	wire		clk,

	output	reg [3:0]	led
);
	reg div_clk;
	reg [31:0] cnt;
	wire rst;
	localparam [31:0] max_count = 3000000 - 1;

	//reset is the inverse of the first button
	assign rst = ~pmod[0];

	// only enter on reset or after 256 cycles
	always @ (posedge div_clk or posedge rst) begin
		if (rst == 1'b1) begin
			led <= 4'b0000;
		end else begin
			led <= led + 1'b1;
		end
	end

	always @ (posedge clk or posedge rst) begin
		if (rst == 1'b1) begin
			cnt <= 32'b0;
		end else if (cnt == max_count) begin
			cnt <= 32'b0;
			div_clk <= ~div_clk;
		end else begin
			cnt <= cnt + 1;
		end
	end

endmodule
