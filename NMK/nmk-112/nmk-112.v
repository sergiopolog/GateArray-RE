// NMK-112 logic def
// Sergio Galiano 'Recreativos Piscis' @Recre_Piscis
// GPLV3 - See LICENSE

// Tested by @caiusarcade and works fine!  https://caiusarcade.blogspot.com/2025/04/nmk-111-and-nmk-112-reproduction.html

module NMK_112(
	input RST,
	input nCS,
	input nWR,
	input [4:0] A,
	input [5:0] D,
	input [17:8] OKI1_A,
	input [17:8] OKI2_A,
	output nOKI1_SEL,
	output [5:0] OKI1_BANK,
	output nOKI2_SEL,
	output [5:0] OKI2_BANK
);


assign    nOKI1_SEL = !( !nCS & !A[4] & !A[3] );
assign    nOKI2_SEL = !( !nCS & !A[4] &  A[3] );

wire REG_CLK = !( !nWR & !nCS &  A[4] & !A[3] );

// 4 of 6-bit registers for each OKI
reg [5:0] OKI1_REGS [3:0];
reg [5:0] OKI2_REGS [3:0];

// selects the 6-bit register which determines the OKI bank value to output
// when OKI_A10-17 == 0, OKI device is addressing the sample table, so the Bank register is selected by OKI_A8-9. Otherwise OKI_A16-17 is used
wire [1:0] OKI1_REG_SEL = ( OKI1_A[17:10] == 8'b0 ? OKI1_A[9:8] : OKI1_A[17:16] );
wire [1:0] OKI2_REG_SEL = ( OKI2_A[17:10] == 8'b0 ? OKI2_A[9:8] : OKI2_A[17:16] );


always @(posedge REG_CLK or posedge RST) begin
	if (RST) begin
		OKI1_REGS <= '{6'b0, 6'b0, 6'b0, 6'b0};
		OKI2_REGS <= '{6'b0, 6'b0, 6'b0, 6'b0};
	end else begin
		case (A[2:0])
			3'b000: begin OKI1_REGS[0] <= D; end
			3'b001: begin OKI1_REGS[1] <= D; end
			3'b010: begin OKI1_REGS[2] <= D; end
			3'b011: begin OKI1_REGS[3] <= D; end
			
			3'b100: begin OKI2_REGS[0] <= D; end
			3'b101: begin OKI2_REGS[1] <= D; end
			3'b110: begin OKI2_REGS[2] <= D; end
			3'b111: begin OKI2_REGS[3] <= D; end
		endcase
	end
end


assign OKI1_BANK = OKI1_REGS[OKI1_REG_SEL];
assign OKI2_BANK = OKI2_REGS[OKI2_REG_SEL];


endmodule