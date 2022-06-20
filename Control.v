module Control(OpCode, Funct,
	PCSrc, Branch, RegWrite, RegDst, 
	MemRead, MemWrite, MemtoReg, 
	ALUSrc1, ALUSrc2, ExtOp, LuOp);
	input [5:0] OpCode;
	input [5:0] Funct;
	output [1:0] PCSrc;
	output Branch;
	output RegWrite;
	output [1:0] RegDst;
	output MemRead;
	output MemWrite;
	output [1:0] MemtoReg;
	output ALUSrc1;
	output ALUSrc2;
	output ExtOp;
	output LuOp;
	
	// Your code below

	assign PCSrc=  (OpCode==6'b00_0010)?(2'b01)://j
				   (OpCode==6'b00_0011)?(2'b01)://jal
				   (OpCode==6'b0)?(
						(Funct==6'b00_1000)?(2'b10)://jr
						(Funct==6'b00_1001)?(2'b10)://jalr
						2'b00
						):2'b00;
	assign Branch= (OpCode==6'b00_0100)?(1'b1)://beq
				   1'b0;
	assign RegWrite=   (OpCode==6'b10_1011)?(1'b0)://sw
					   (OpCode==6'b00_0100)?(1'b0)://beq
					   (OpCode==6'b00_0010)?(1'b0)://j
					   (OpCode==6'b0)?(
							(Funct==6'b00_1000)?(1'b0)://jr
							1'b1
							):1'b1;
	assign RegDst= (OpCode==6'b10_0011)?(2'b00)://lw
				   (OpCode==6'b00_1111)?(2'b00)://lui
				   (OpCode==6'b00_1000)?(2'b00)://addi
				   (OpCode==6'b00_1001)?(2'b00)://addiu
				   (OpCode==6'b00_1100)?(2'b00)://andi
				   (OpCode==6'b00_1010)?(2'b00)://slti
				   (OpCode==6'b00_1011)?(2'b00)://sltiu
				   (OpCode==6'b00_0011)?(2'b10)://jal
				   2'b01;
	assign MemRead=(OpCode==6'b10_0011)?(1'b1)://lw
				   1'b0;
    assign MemWrite=(OpCode==6'b10_1011)?(1'b1)://sw
					1'b0;
	assign MemtoReg=   (OpCode==6'b10_0011)?(2'b01)://lw
					   (OpCode==6'b00_0011)?(2'b10)://jal
					   (OpCode==6'b0)?(
							(Funct==6'b00_1001)?(2'b10)://jalr
							2'b00
							):2'b00;
	assign ALUSrc1=(OpCode==6'b0)?(
						(Funct==6'b0)?(1'b1)://sll
						(Funct==6'b00_0010)?(1'b1)://srl
						(Funct==6'b00_0011)?(1'b1)://sra
						1'b0
						):1'b0;
	assign ALUSrc2=(OpCode==6'b10_0011)?(1'b1)://lw
				   (OpCode==6'b10_1011)?(1'b1)://sw
				   (OpCode==6'b00_1111)?(1'b1)://lui
				   (OpCode==6'b00_1000)?(1'b1)://addi
				   (OpCode==6'b00_1001)?(1'b1)://addiu
				   (OpCode==6'b00_1100)?(1'b1)://andi
				   (OpCode==6'b00_1010)?(1'b1)://slti
				   (OpCode==6'b00_1011)?(1'b1)://sltiu
				   1'b0;
	assign ExtOp=  (OpCode==6'b00_1100)?(1'b0)://andi
				   1'b1;
	assign LuOp=   (OpCode==6'b00_1111)?(1'b1)://lui
				   1'b0;
	     
	// Your code above

	
endmodule