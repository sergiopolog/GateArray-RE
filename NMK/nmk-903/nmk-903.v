// NMK-903 logic def
// Sergio Galiano 'Recreativos Piscis' @Recre_Piscis
// GPLV3 - See LICENSE

// Untested !

module NMK_903(
	input ACLK,
	input ANIBSEL,
	input BCLK,
	input OCLK,
	input nOE,
	output UNK1,
	input [7:0] ABUS,
	input [3:0] BBUS,
	output [7:0] OBUS
);

reg [7:0] REGA;
reg [3:0] REGB;
reg [7:0] REGO;

wire UNK_1 = REGA[0] & REGA[1] & REGA[2] & REGA[3];


always @(posedge ACLK)
begin
	REGA <= ABUS;
end

always @(posedge BCLK)
begin
	REGB <= BBUS;
end

always @(posedge OCLK)
begin
	REGO[3:0] <= ANIBSEL ? REGA[3:0] : REGA[7:4];
	REGO[7:4] <= REGB;
end


assign OBUS = nOE ? 8'bZ : REGO;

assign UNK1 = UNK_1;

		
endmodule