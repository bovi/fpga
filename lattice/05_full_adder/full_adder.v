module full_adder (
  input   [2:0] pmod,
  output  [1:0] led
);

  wire not_a = ~pmod[0];
  wire not_b = ~pmod[1];
  wire not_c = ~pmod[2];
  wire xor_a_b = not_a ^ not_b;

  assign led[0] = xor_a_b ^ not_c;
  assign led[1] = xor_a_b & not_c | not_a & not_b;

endmodule
