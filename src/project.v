/*
 * Copyright (c) 2024 Toivo Henningsson
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module ripple_carry_adder #(parameter BITS=8) (
		input wire carry_in,
		input wire [BITS-1:0] x, y,

		output wire [BITS-1:0] sum,
		output wire carry_out
	);

	wire [BITS:0] carry;
	assign carry[0] = carry_in;

	genvar i;
	generate
		for (i = 0; i < BITS; i++) begin
			assign {carry[i+1], sum[i]} = x[i] + y[i] + carry[i];
		end
	endgenerate

	assign carry_out = carry[BITS];
endmodule


module tt_um_example (
		input  wire [7:0] ui_in,    // Dedicated inputs
		output wire [7:0] uo_out,   // Dedicated outputs
		input  wire [7:0] uio_in,   // IOs: Input path
		output wire [7:0] uio_out,  // IOs: Output path
		output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
		input  wire       ena,      // always 1 when the design is powered, so you can ignore it
		input  wire       clk,      // clock
		input  wire       rst_n     // reset_n - low to reset
	);

	localparam BITS = 64;

	wire reset = !rst_n;

	wire [BITS-1:0] sum;
	reg [BITS-1:0] x, y, out;

	ripple_carry_adder #(.BITS(BITS)) adder(
		.carry_in(1'b0), .x(x), .y(y),
		.sum(sum)
	);

	always @(posedge clk) begin
		if (reset) begin
			x <= 0;
			y <= 0;
		end else if (ui_in[2]) begin
			x <= {x, ui_in[0]};
			y <= {y, ui_in[1]};
		end
		out <= sum;
	end

	assign uo_out = out[uio_in[$clog2(BITS)-1:0]];
	assign uio_oe = 0;
	assign uio_out = 0;

	wire _unused = &{ena, clk, rst_n};
endmodule
