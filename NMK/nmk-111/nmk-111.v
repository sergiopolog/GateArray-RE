// NMK-111 logic def
// Sergio Galiano 'Recreativos Piscis' @Recre_Piscis
// GPLV3 - See LICENSE

// Tested by @caiusarcade and works fine!  https://caiusarcade.blogspot.com/2025/04/nmk-111-and-nmk-112-reproduction.html

module NMK_111(
	input CLK1,
	input CLK2,
	input MODE,
	input RST,
	input nCS,
	input DIR,
	inout [15:0] ABUS,
	inout [15:0] BBUS,
	output [15:0] OBUS
);

reg [15:0] REG_1;
reg [11:0] REG_2;


assign ABUS = !nCS &  DIR ? BBUS : 16'bZ;	// DIR = 1:  B --> A
assign BBUS = !nCS & !DIR ? ABUS : 16'bZ;	// DIR = 0:  A --> B


always @(posedge CLK1 or posedge RST)
begin
	if (RST == 1'b1)
		REG_1 <= 16'b0;
	else
		REG_1 <= ABUS;
end

always @(posedge CLK2 or posedge RST)
begin
	if (RST == 1'b1)
		REG_2 <= 12'b0;
	else
		REG_2 <= REG_1[11:0];
end


assign OBUS = MODE ? REG_1 : {REG_1[15:12], REG_2};

		
endmodule