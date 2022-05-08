// count up oin each button press and display on LEDs
module button_counter(
  input             clk,
  input       [1:0] pmod,

  output  reg [3:0] led
);

  wire rst;
  wire cnt_btn;

  assign rst = ~pmod[0];
  assign cnt_btn = ~pmod[1];

  localparam STATE_IDLE       = 2'd0;
  localparam STATE_COUNTING   = 2'd1;
  localparam STATE_DEBOUNCE   = 2'd2;
  localparam DEBOUNCE_TIME    = 24'd480000;

  reg [1:0] state             = STATE_IDLE;
  reg [23:0] clk_cnt          = 24'd0;

  // count up on clock rising edge or reset on button push
  always @ (posedge clk or posedge rst) begin
    if (rst == 1'b1) begin
      led <= 4'b0;
    end else if (state == STATE_COUNTING) begin
      led <= led + 1'b1;
    end
  end

  always @ (posedge clk or posedge rst) begin
    if (rst == 1'b1) begin
      state <= STATE_IDLE;
      clk_cnt <= 24'd0;
    end else begin
      case (state)

        // idle until the count button is pressed
        STATE_IDLE: begin
          if (cnt_btn == 1'b1) begin
            state <= STATE_COUNTING;
          end
        end

        // for a single clock cycle we count
        STATE_COUNTING: begin
          state <= STATE_DEBOUNCE;
        end

        // debounce state for ```DEBOUNCE_TIME``` amount of clock cycles
        STATE_DEBOUNCE: begin
          if (clk_cnt >= DEBOUNCE_TIME) begin

            // is the button unpressed now?
            if (cnt_btn == 1'b0) begin
              state <= STATE_IDLE;
            end // else: the button is still being pressed

            clk_cnt <= 24'd0;
          end else begin
            clk_cnt <= clk_cnt + 1;
          end
        end

        default: state <= STATE_IDLE;
      endcase
    end
  end

endmodule
