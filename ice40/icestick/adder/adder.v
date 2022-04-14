/* Module: 
 * 	one button pressed, light first led
 * 	two button pressed, light second led
 * 	three button pressed, light first and second led
 */
module adder (

	// Inputs
	input 	[2:0]	pmod,

	// Outputs
	output	[1:0]	led
);

	wire a_b_and;
	wire a_b_xor;
	wire abx_c_and;
	
	// A and B to AND
	assign a_b_and = ~pmod[0] & ~pmod[1];
	// A and B to XOR
	assign a_b_xor = ~pmod[0] ^ ~pmod[1];
	// A^B and C
	assign led[0] = a_b_xor ^ ~pmod[2];

	// A^B and C
	assign abx_c_and = a_b_xor & ~pmod[2];

	// A^B and C "OR" A&B
	assign led[1] = abx_c_and | a_b_and;

endmodule
