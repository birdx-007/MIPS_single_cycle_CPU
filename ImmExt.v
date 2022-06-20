module ImmExt(ExtOp, Imm, ImmExtOut); 
    input ExtOp; //'0'-zero extension, '1'-signed extension
    input [15:0] Imm;
    output [31:0] ImmExtOut;
    
    assign ImmExtOut = {ExtOp? {16{Imm[15]}}: 16'h0000, Imm};
	
endmodule