module ALUControl(OpCode, Funct, ALUCtrl, Sign);
	input [5:0] OpCode;
	input [5:0] Funct;
	output [4:0] ALUCtrl;
	output Sign;
	
	// Your code below

	assign ALUCtrl=(OpCode==6'b10_0011)?(5'h1)://lw
				   (OpCode==6'b10_1011)?(5'h1)://sw
				   (OpCode==6'b00_1111)?(5'h0)://lui
				   (OpCode==6'b00_1000)?(5'h1)://addi
				   (OpCode==6'b00_1001)?(5'h1)://addiu
				   (OpCode==6'b00_1100)?(5'h3)://andi
				   (OpCode==6'b00_1010)?(5'h9)://slti
				   (OpCode==6'b00_1011)?(5'h9)://sltiu
				   (OpCode==6'b00_0100)?(5'h2)://beq
				   (OpCode==6'b00_0010)?(5'h0)://j
				   (OpCode==6'b00_0011)?(5'h0)://jal
				   (OpCode==6'b0)?(
						(Funct==6'b10_0000)?(5'h1)://add
						(Funct==6'b10_0001)?(5'h1)://addu
						(Funct==6'b10_0010)?(5'h2)://sub
						(Funct==6'b10_0011)?(5'h2)://subu
						(Funct==6'b10_0100)?(5'h3)://and
						(Funct==6'b10_0101)?(5'h4)://or
						(Funct==6'b10_0110)?(5'h5)://xor
						(Funct==6'b10_0111)?(5'h6)://nor
						(Funct==6'b0)?(5'h7)://sll
						(Funct==6'b00_0010)?(5'h8)://srl
						(Funct==6'b00_0011)?(5'h8)://sra
						(Funct==6'b10_1010)?(5'h9)://slt
						(Funct==6'b10_1011)?(5'h9)://sltu
						(Funct==6'b00_1000)?(5'h0)://jr
						(Funct==6'b00_1001)?(5'h0)://jalr
						5'b0
						):5'b0;
	assign Sign=(OpCode==6'b10_0011)?(1):
			    (OpCode==6'b10_1011)?(1):
			    (OpCode==6'b00_1111)?(1):
			    (OpCode==6'b00_1000)?(1):
			    (OpCode==6'b00_1001)?(0):
			    (OpCode==6'b00_1100)?(1):
			    (OpCode==6'b00_1010)?(1):
			    (OpCode==6'b00_1011)?(0):
			    (OpCode==6'b00_0100)?(1):
			    (OpCode==6'b00_0010)?(1):
			    (OpCode==6'b00_0011)?(1):
			    (OpCode==6'b0)?(
					(Funct==6'b10_0000)?(1):
					(Funct==6'b10_0001)?(0):
					(Funct==6'b10_0010)?(1):
					(Funct==6'b10_0011)?(0):
					(Funct==6'b10_0100)?(1):
					(Funct==6'b10_0101)?(1):
					(Funct==6'b10_0110)?(1):
					(Funct==6'b10_0111)?(1):
					(Funct==6'b0)?(0):
					(Funct==6'b00_0010)?(0):
					(Funct==6'b00_0011)?(1):
					(Funct==6'b10_1010)?(1):
					(Funct==6'b10_1011)?(0):
					(Funct==6'b00_1000)?(1):
					(Funct==6'b00_1001)?(1):1
					):1;
	     
	// Your code above

endmodule
