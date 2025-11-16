/////////////////////////////////////////////////////
//                 ALU operations
// Link to alu op codes: 
// https://docs.google.com/spreadsheets/d/1bhyEDXL5TtY6bxWDE8mKeAr9lQd4MnKYHftdssVT9jw/edit?usp=sharing
// Might switch RCA in Adder to a KSA
/////////////////////////////////////////////////////
module ALU (
    output wire [31:0] alu_Result,
    output wire alu_Cout,
    input wire [31:0] alu_A, alu_B,
    input wire [3:0] alu_op
);

//Logic
    wire [31:0] logic_res;
    logic logic_inst (
        .logic_res(logic_res),
        .logic_A(alu_A), // Shift operand A
        .logic_B(alu_B),
        .logic_op(alu_op[1:0])
    );
    
//Add/Subtract
    wire [31:0] sum_res;
    ksa adder_inst(
        .sum(sum_res),
        .cout(alu_Cout),
        .ksa_a(alu_A),
        .ksa_b(alu_B),
        .sub(alu_op[1]),
        .cin(alu_op[0])
    );
    
//Barrell Shifter
    wire [31:0] shift_res;
    shifter shift_inst (
        .Shift_Result(shift_res),
        .num_shift(alu_A), // Shift operand A
        .shift_amount(alu_B[4:0]), // Shift amount from B's LSBs
        .shift_op(alu_op[1:0])
    );
    
//Comparator
    wire [31:0] comparator_res; // 32-bit result wire for MUX
    wire comp_less_out; 
    wire comp_equal_out; 
    wire comp_greater_out; 
    
    assign comparator_res = {{31{1'b0}}, comp_less_out};
    
    comparator comp_inst (
        .less_out(comp_less_out),       // The MUXed SLT/SLTU result is output here
        .equal_out(comp_equal_out),     // Equality is often needed for branch logic
        .greater_out(comp_greater_out), // Greater than is often needed for branch logic
        .A(alu_A), 
        .B(alu_B),
        .Signed_Control(alu_op[1]) // The control bit tells the comparator which result to put on 'less_out'
    );

//MUX
// 00 - Logic & Adder/Subtractor 
// 01 - Adder
// 10 - Shifter
// 11 - Comparator
    reg [31:0] alu_Result_reg;
    always @(*) begin
        case (alu_op[3:2])
            2'b00: alu_Result_reg = logic_res; // Logic
            2'b01: alu_Result_reg = sum_res; //Add or Sub
            2'b10: alu_Result_reg = shift_res;     // Shifter
            2'b11: alu_Result_reg = comparator_res;// Comparator
            default: alu_Result_reg = 32'b0;      // <--- This line prevents 'Z'
        endcase
    end
    
    assign alu_Result = alu_Result_reg;
endmodule