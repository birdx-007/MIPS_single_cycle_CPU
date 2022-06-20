module CPU(reset, clk, a0, v0, sp, ra);
	input reset, clk;
	
    //--------------Your code below-----------------------

	output [31:0] a0,v0,sp,ra;
	
	reg [31:0] PC;
	wire [5:0] OpCode;
	wire [5:0] Funct;
	wire [1:0] PCSrc;
	wire Branch;
	wire RegWrite;
	wire [1:0] RegDst;
	wire MemRead;
	wire MemWrite;
	wire [1:0] MemtoReg;
	wire ALUSrc1;
	wire ALUSrc2;
	wire ExtOp;
	wire LuOp;
	wire [31:0] PCnew_plus4;
	wire [31:0] PCnew_Branch;
	wire [31:0] PCnew_Jump;
	wire [31:0] PCnew;
	wire [31:0] Instruction;
	wire [4:0] RF_Read_register1;
	wire [4:0] RF_Read_register2;
	wire [4:0] RF_Write_register;
	wire [31:0] RF_Write_data;
	wire [31:0] RF_Read_data1;
	wire [31:0] RF_Read_data2;
	wire [15:0] Imm;
	wire [31:0] ImmExtOut;
	wire [31:0] Imm_in;
	wire [31:0] ALU_in1;
	wire [31:0] ALU_in2;
	wire [4:0] ALU_Ctrl;
	wire ALU_Sign;
	wire [31:0] ALU_OUT;
	wire [31:0] MEM_Address;
	wire [31:0] MEM_Write_data;
	wire [31:0] MEM_Read_data;
	wire Zero;
	Control ctr(
		.OpCode(OpCode),
		.Funct(Funct),
		.PCSrc(PCSrc),
		.Branch(Branch),
		.RegWrite(RegWrite),
		.RegDst(RegDst),
		.MemRead(MemRead),
		.MemWrite(MemWrite),
		.MemtoReg(MemtoReg),
		.ALUSrc1(ALUSrc1),
		.ALUSrc2(ALUSrc2),
		.ExtOp(ExtOp),
		.LuOp(LuOp)
	);
	InstructionMemory instmem(
		.Address(PC),
		.Instruction(Instruction)
	);
    RegisterFile rf(
		.reset(reset),
		.clk(clk),
		.RegWrite(RegWrite),
		.Read_register1(RF_Read_register1),
		.Read_register2(RF_Read_register2),
		.Write_register(RF_Write_register),
		.Write_data(RF_Write_data),
		.Read_data1(RF_Read_data1),
		.Read_data2(RF_Read_data2)
	);
	ALUControl aluctr(
		.OpCode(OpCode),
		.Funct(Funct),
		.ALUCtrl(ALU_Ctrl),
		.Sign(ALU_Sign)
	);
	ImmExt immext(
		.ExtOp(ExtOp),
		.Imm(Imm),
		.ImmExtOut(ImmExtOut)
	);
	ALU alu(
		.in1(ALU_in1),
		.in2(ALU_in2),
		.ALUCtrl(ALU_Ctrl),
		.Sign(ALU_Sign),
		.out(ALU_OUT),
		.zero(Zero)
	);
	DataMemory datamem(
		.reset(reset),
		.clk(clk),
		.Address(MEM_Address),
		.Write_data(MEM_Write_data),
		.Read_data(MEM_Read_data),
		.MemRead(MemRead),
		.MemWrite(MemWrite)
	);
	
	assign OpCode=Instruction[31:26];
	assign Funct=Instruction[5:0];
	assign RF_Read_register1=Instruction[25:21];
	assign RF_Read_register2=Instruction[20:16];
	assign RF_Write_register=(RegDst==2'h2)?5'd31:((RegDst==2'h1)?Instruction[15:11]:Instruction[20:16]);//MUX
	assign RF_Write_data=(MemtoReg==2'h2)?(PCnew_plus4):((MemtoReg==2'h1)?MEM_Read_data:ALU_OUT);//MUX
	assign ALU_in1=ALUSrc1?Instruction[10:6]:RF_Read_data1;//MUX
	assign ALU_in2=ALUSrc2?Imm_in:RF_Read_data2;//MUX
	assign Imm=Instruction[15:0];
	assign Imm_in=LuOp?{Imm,16'h0000}:ImmExtOut;//MUX
	assign MEM_Address=ALU_OUT;
	assign MEM_Write_data=RF_Read_data2;
	assign PCnew=(PCSrc==2'h2)?RF_Read_data1:((PCSrc==2'h1)?PCnew_Jump:PCnew_Branch);//MUX
	assign PCnew_Branch=(Branch&&Zero)?(PCnew_plus4+(Imm_in<<2)):PCnew_plus4;//MUX
	assign PCnew_Jump={PCnew_plus4[31:28],Instruction[25:0],2'b00};
	assign PCnew_plus4=PC+32'h4;
	
	always@(posedge reset or posedge clk)begin
		if(reset)begin
			PC<=32'd0;
		end
		else begin
			PC<=PCnew;
		end
	end
    
	assign a0=rf.RF_data[4];
	assign v0=rf.RF_data[2];
	assign sp=rf.RF_data[29];
	assign ra=rf.RF_data[31];
	
    //--------------Your code above-----------------------

endmodule
	