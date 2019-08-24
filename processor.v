module MIP_pipeline_processor();

reg clk, reset;
wire [31:0] nextPC, readPC, PCPlus4IF, PCPlus4ID, PCPlus4EX;
wire [31:0] branchAddress;
wire [31:0] instructionIF, instructionID;
wire [31:0] registerData1ID, registerData2ID, registerData1EX, registerData2EX;
wire [31:0] signExtendOutID, signExtendOutEX;
wire [31:0] shiftOut;
wire [3:0] ALUOpID, ALUOpEX;
wire [9:0] controlSignalsID;
wire [4:0] rsEX ,rtEX ,rdEX;
wire [31:0] ALUData1, ALUData2;
wire [31:0] ALUData2Mux_1Out;
wire [4:0] regDstMuxOut;
wire [4:0] writeRegMEM, writeRegWB;
wire [31:0] ALUResultEX, ALUResultMEM, ALUResultWB;
wire [31:0] memoryWriteDataMEM;
wire [4:0] RegDestMEM, RegDestWB;
wire [1:0] upperMux_sel, lowerMux_sel;
wire [1:0] comparatorMux1Selector,comparatorMux2Selector;
wire [31:0] comparatorMux1Out, comparatorMux2Out;
wire [31:0] memoryReadDataMEM, memoryReadDataWB;
wire [31:0] regWriteDataWB;
wire [3:0] ALUCtrl;

wire holdPC, PCMuxSel, branchID, equalFlag, holdIF_ID;
wire [5:0] functEX;
wire RegDestID, branchID, MemreadID, MemtoRegID, ALUopID, MemWriteID, AluSrcID, RegWriteID; 
wire reg_write_en, RegDestEX, RegWriteEX, RegWriteMEM, RegWriteWB, overflow, zero;
wire MemReadEX, MemtoRegEX, MemWriteEX, ALUSrcEX, MemReadMEM, MemtoRegMEM, MemWriteMEM, MemtoRegWB;

//---------------- IF stage -------------------
/*
    * holdPC <--- Hazard Detection
    * branchAddress  <---  (SignExt(Instruction[15:0]) << 2) + PC + 4
    * branchID  <---  Control Unit
    * equalFlag <---  read data 1 == read data 2 ;  ID stage
    * holdIF_ID --->  Hazard Detection
*/

PC pc(clk, reset, holdPC, nextPC, readPC);
InstructionStore instruc(clk, readPC, instructionIF);
Adder PCplus4(PCPlus4IF, readPC, 32'd4);
Mux_2x1 #(32) PC_Mux(nextPC, PCPlus4IF, branchAddress, PCMuxSel);
and branchDetect(PCMuxSel, branchID, equalFlag);
IF_ID IF_ID_reg(clk, holdIF_ID, instructionIF, PCPlus4IF, PCPlus4ID, instructionID);


//------------------ ID Stage -------------------
/*
    * Inputs :==> PCPlus4ID, instructionID
    * Output :==> PC_in, RegDst, reg_write, Memread, MemtoReg, MemWrite, AluSrc, AluOp, signExtImm, instrc
    * regWriteDataWB <--- WB register
    * writeRegWB <--- WB register
    * reg_write_en <--- WB register
*/

ControlUnit controlUnitID(clk, instructionID[31:26], instructionID[5:0], RegDestID, branchID, MemreadID, MemtoRegID, ALUOpID, MemWriteID, AluSrcID, RegWriteID, functEX, reset);
RegisterStore registerStore(clk, reset, instructionID[25:21], instructionID[20:16], regWriteDataWB, RegWriteWB, reg_write_en, registerData1ID, registerData2ID);
Mux_3x1 #(32) comparatorMux1(comparatorMux1Out, registerData1ID, ALUResultMEM, regWriteDataWB, comparatorMux1Selector);
Mux_3x1 #(32) comparatorMux1(comparatorMux2Out, registerData1ID, ALUResultMEM, regWriteDataWB, comparatorMux2Selector);
Comparator comparator(comparatorMux1Out, comparatorMux2Out, equalFlag);
SignExtended signExtend(instructionID[15:0], signExtendOutID);
ShiftLeft2 shiftLeft(signExtendOutID, shiftOut);
Adder branchAdder(branchAddress, PCPlus4ID, shiftOut);
HazardDetection hazardDetect(clk, MemReadEX, MemReadMEM, rtEX, rsEX, instructionID, holdPC, holdIF_ID);
ID_EX ID_EX_reg(PCPlus4ID, RegDestID, RegWriteID, MemreadID, MemtoRegID, MemWriteID, AluSrcID, ALUopID, signExtendOutID, instructionID[25:11], registerData1ID, registerData2ID,
            PCPlus4EX, RegDestEX, RegWriteEX, MemReadEX, MemtoRegEX, MemWriteEX, ALUSrcEX, ALUOpEX, signExtendOutEX,
            registerData1EX, registerData2EX, instructionID[25:21], instructionID[20:16], instructionID[15:11]);


//--------------------------- EX Stage -------------------------------

Mux_3x1 #(32) ALUSrcMux1 (ALUData1, registerData1EX, regWriteDataWB, ALUResultMEM, upperMux_sel);
Mux_3x1 #(32) ALUSrcMux2 (ALUData2Mux_1Out, registerData2EX, regWriteDataWB, ALUResultMEM, lowerMux_sel);
Mux_2x1 #(32) ALUMux (ALUData2, ALUData2Mux_1Out, signExtendOutEX, ALUSrcEX);
Mux_2x1 #(5) SrcSelect (regDstMuxOut, rtEX, rdEX, RegDestEX);
ALUControl aluControl(ALUCtrl, ALUOpEX, functEX);
ALU alu(clk, ALUData1. ALUData2, ALUCtrl, signExtendOutEX[10:6], overflow, zero, ALUResultEX, reset);
EX_MEM EX_MEM_reg(clk, RegWriteEX, MemReadEX, MemtoRegEX, MemWriteEX, ALUResultEX, ALUData2Mux_1Out,
            regDstMuxOut, RegDestMEM, MemReadMEM, MemtoRegMEM, MemWriteMEM, ALUResultMEM, memoryWriteDataMEM, RegDestMEM);
ForwardData forwadData(RegWriteMEM, RegWriteWB, writeRegMEM, writeRegWB, rsEX, rtEX);


// --------------------------- MEM Stage ------------------------------

DataMemory dataMemory(clk, MemWriteWB, MemReadWB, memoryWriteDataMEM, memoryReadDataMEM, ALUResultMEM);
MEM_WB MEM_WB_reg(clk, MemtoRegMEM, RegWriteMEM, memoryReadDataMEM, ALUResultMEM, RegDestMEM, 
                RegWriteWB, MemtoRegWB, ALUResultWB, memoryReadDataWB, RegDestWB);


// --------------------------- WB Stage --------------------------------

Mux_2x1 #(32) writeBackMux(regWriteDataWB, memoryReadDataWB, ALUResultWB, MemtoRegWB);

// --------------------------------- Test Bench --------------------------------

//pc updated, change in singel cycle testbench
always@(clk)
#100 clk <= ~clk;

initial
begin

clk <= 0;
reset <= 1;
#50
reset <= 0;

end

endmodule