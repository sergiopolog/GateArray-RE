// NANAO KNA65005-17 logic def
// Sergio Galiano 'Recreativos Piscis' @Recre_Piscis
// GPLV3 - See LICENSE

// Untested !

module NANAO_KNA65005(
	input H1,
	input V1,
	input H1E,
	input P1L,
	input [7:0] DA0,
	input [7:0] DB0,
	input [7:0] DA1,
	input [7:0] DB1,
	output [7:0] CA,
	output E1,
	output POL
);


reg [7:0] DA0_REG;
reg [7:0] DB0_REG;
reg [7:0] DA1_REG;
reg [7:0] DB1_REG;


always @(negedge H1)
begin
	DA0_REG <= DA0;
	DB0_REG <= DB0;
	DA1_REG <= DA1;
	DB1_REG <= DB1;
end

// CA[4] to CA[7] outputs have delays (see schematics)

assign CA = ( !V1
				? ( !H1E ? DA0_REG : DB0_REG )
				: ( !H1E ? DA1_REG : DB1_REG )
);


assign E1  = !( P1L & ( CA[0] | CA[1] | CA[2] | CA[3] ) );
assign POL =         !( CA[0] | CA[1] | CA[2] | CA[3] );


endmodule