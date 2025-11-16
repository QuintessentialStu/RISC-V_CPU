/////////////////////////////////////////////////
// 32 Bit Kogge-Stone Adder
// By: salzhang on Github
// 
// MIT License
//
 //Copyright (c) 2024 Zeyu Zhang
//
// is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.
//
/////////////////////////////////////////////////

module ksa (
    output wire [31:0] sum,
    output wire cout,
    input wire [31:0] ksa_a,
    input wire [31:0] ksa_b,
    input wire sub,
    input wire cin
);
    wire [31:0] B_sub;
    assign B_sub = ksa_b ^ {32{sub}};
    
    wire [31:0] g; wire [31:0] p;
    KSA_Stage1 Stage1(.a(ksa_a),.b(B_sub),.g(g),.p(p));
    
    wire [31:0] g_stage2; wire [31:0] p_stage2;
    KSA_Stage2 Stage2(.g_in(g),.p_in(p),.g_out(g_stage2),.p_out(p_stage2));
    
    wire [31:0] g_stage3; wire [31:0] p_stage3;
    KSA_Stage3 Stage3(.g_in(g_stage2),.p_in(p_stage2),.g_out(g_stage3),.p_out(p_stage3));
    
    wire [31:0] g_stage4; wire [31:0] p_stage4;
    KSA_Stage4 Stage4(.g_in(g_stage3),.p_in(p_stage3),.g_out(g_stage4),.p_out(p_stage4));
    
    wire [31:0] g_stage5; wire [31:0] p_stage5;
    KSA_Stage5 Stage5(.g_in(g_stage4),.p_in(p_stage4),.g_out(g_stage5),.p_out(p_stage5));
    
    wire [31:0] g_stage6; wire [31:0] p_stage6;
    KSA_Stage6 Stage6(.g_in(g_stage5),.p_in(p_stage5),.g_out(g_stage6),.p_out(p_stage6));
    
    wire [32:0] carry;
    KSA_Stage7 Stage7(.g_in(g_stage6),.p_in(p_stage6),.cin(cin),.carry(carry));
    
    assign cout = carry[32];
    assign sum = p^carry[31:0];
endmodule

module KSA_Stage1(input wire [31:0] a, input wire [31:0] b,
output wire [31:0] g, output wire [31:0] p);
    gp1 gp0(.a(a[0]),.b(b[0]),.g(g[0]),.p(p[0]));
    gp1 gp1(.a(a[1]),.b(b[1]),.g(g[1]),.p(p[1]));
    gp1 gp2(.a(a[2]),.b(b[2]),.g(g[2]),.p(p[2]));
    gp1 gp3(.a(a[3]),.b(b[3]),.g(g[3]),.p(p[3]));
    gp1 gp4(.a(a[4]),.b(b[4]),.g(g[4]),.p(p[4]));
    gp1 gp5(.a(a[5]),.b(b[5]),.g(g[5]),.p(p[5]));
    gp1 gp6(.a(a[6]),.b(b[6]),.g(g[6]),.p(p[6]));
    gp1 gp7(.a(a[7]),.b(b[7]),.g(g[7]),.p(p[7]));
    gp1 gp8(.a(a[8]),.b(b[8]),.g(g[8]),.p(p[8]));
    gp1 gp9(.a(a[9]),.b(b[9]),.g(g[9]),.p(p[9]));
    
    gp1 gp10(.a(a[10]),.b(b[10]),.g(g[10]),.p(p[10]));
    gp1 gp11(.a(a[11]),.b(b[11]),.g(g[11]),.p(p[11]));
    gp1 gp12(.a(a[12]),.b(b[12]),.g(g[12]),.p(p[12]));
    gp1 gp13(.a(a[13]),.b(b[13]),.g(g[13]),.p(p[13]));
    gp1 gp14(.a(a[14]),.b(b[14]),.g(g[14]),.p(p[14]));
    gp1 gp15(.a(a[15]),.b(b[15]),.g(g[15]),.p(p[15]));
    gp1 gp16(.a(a[16]),.b(b[16]),.g(g[16]),.p(p[16]));
    gp1 gp17(.a(a[17]),.b(b[17]),.g(g[17]),.p(p[17]));
    gp1 gp18(.a(a[18]),.b(b[18]),.g(g[18]),.p(p[18]));
    gp1 gp19(.a(a[19]),.b(b[19]),.g(g[19]),.p(p[19]));
    
    gp1 gp20(.a(a[20]),.b(b[20]),.g(g[20]),.p(p[20]));
    gp1 gp21(.a(a[21]),.b(b[21]),.g(g[21]),.p(p[21]));
    gp1 gp22(.a(a[22]),.b(b[22]),.g(g[22]),.p(p[22]));
    gp1 gp23(.a(a[23]),.b(b[23]),.g(g[23]),.p(p[23]));
    gp1 gp24(.a(a[24]),.b(b[24]),.g(g[24]),.p(p[24]));
    gp1 gp25(.a(a[25]),.b(b[25]),.g(g[25]),.p(p[25]));
    gp1 gp26(.a(a[26]),.b(b[26]),.g(g[26]),.p(p[26]));
    gp1 gp27(.a(a[27]),.b(b[27]),.g(g[27]),.p(p[27]));
    gp1 gp28(.a(a[28]),.b(b[28]),.g(g[28]),.p(p[28]));
    gp1 gp29(.a(a[29]),.b(b[29]),.g(g[29]),.p(p[29]));
    
    gp1 gp30(.a(a[30]),.b(b[30]),.g(g[30]),.p(p[30]));
    gp1 gp31(.a(a[31]),.b(b[31]),.g(g[31]),.p(p[31]));
endmodule

module KSA_Stage2(input wire [31:0] g_in, input wire [31:0] p_in,
output wire [31:0] g_out, output wire [31:0] p_out
    );
    assign g_out[0] = g_in[0]; assign p_out[0] = p_in[0];
    
    gp_window gp1_to_0(.g_iplus1(g_in[1]),.gi(g_in[0]),.p_iplus1(p_in[1]),.pi(p_in[0]),.g_window(g_out[1]),.p_window(p_out[1]));
    gp_window gp2_to_1(.g_iplus1(g_in[2]),.gi(g_in[1]),.p_iplus1(p_in[2]),.pi(p_in[1]),.g_window(g_out[2]),.p_window(p_out[2]));
    gp_window gp3_to_2(.g_iplus1(g_in[3]),.gi(g_in[2]),.p_iplus1(p_in[3]),.pi(p_in[2]),.g_window(g_out[3]),.p_window(p_out[3]));
    gp_window gp4_to_3(.g_iplus1(g_in[4]),.gi(g_in[3]),.p_iplus1(p_in[4]),.pi(p_in[3]),.g_window(g_out[4]),.p_window(p_out[4]));
    gp_window gp5_to_4(.g_iplus1(g_in[5]),.gi(g_in[4]),.p_iplus1(p_in[5]),.pi(p_in[4]),.g_window(g_out[5]),.p_window(p_out[5]));
    gp_window gp6_to_5(.g_iplus1(g_in[6]),.gi(g_in[5]),.p_iplus1(p_in[6]),.pi(p_in[5]),.g_window(g_out[6]),.p_window(p_out[6]));
    gp_window gp7_to_6(.g_iplus1(g_in[7]),.gi(g_in[6]),.p_iplus1(p_in[7]),.pi(p_in[6]),.g_window(g_out[7]),.p_window(p_out[7]));
    gp_window gp8_to_7(.g_iplus1(g_in[8]),.gi(g_in[7]),.p_iplus1(p_in[8]),.pi(p_in[7]),.g_window(g_out[8]),.p_window(p_out[8]));
    gp_window gp9_to_8(.g_iplus1(g_in[9]),.gi(g_in[8]),.p_iplus1(p_in[9]),.pi(p_in[8]),.g_window(g_out[9]),.p_window(p_out[9]));
    gp_window gp10_to_9(.g_iplus1(g_in[10]),.gi(g_in[9]),.p_iplus1(p_in[10]),.pi(p_in[9]),.g_window(g_out[10]),.p_window(p_out[10]));
    
    gp_window gp11_to_10(.g_iplus1(g_in[11]),.gi(g_in[10]),.p_iplus1(p_in[11]),.pi(p_in[10]),.g_window(g_out[11]),.p_window(p_out[11]));
    gp_window gp12_to_12(.g_iplus1(g_in[12]),.gi(g_in[11]),.p_iplus1(p_in[12]),.pi(p_in[11]),.g_window(g_out[12]),.p_window(p_out[12]));
    gp_window gp13_to_12(.g_iplus1(g_in[13]),.gi(g_in[12]),.p_iplus1(p_in[13]),.pi(p_in[12]),.g_window(g_out[13]),.p_window(p_out[13]));
    gp_window gp14_to_13(.g_iplus1(g_in[14]),.gi(g_in[13]),.p_iplus1(p_in[14]),.pi(p_in[13]),.g_window(g_out[14]),.p_window(p_out[14]));
    gp_window gp15_to_14(.g_iplus1(g_in[15]),.gi(g_in[14]),.p_iplus1(p_in[15]),.pi(p_in[14]),.g_window(g_out[15]),.p_window(p_out[15]));
    gp_window gp16_to_15(.g_iplus1(g_in[16]),.gi(g_in[15]),.p_iplus1(p_in[16]),.pi(p_in[15]),.g_window(g_out[16]),.p_window(p_out[16]));
    gp_window gp17_to_16(.g_iplus1(g_in[17]),.gi(g_in[16]),.p_iplus1(p_in[17]),.pi(p_in[16]),.g_window(g_out[17]),.p_window(p_out[17]));
    gp_window gp18_to_17(.g_iplus1(g_in[18]),.gi(g_in[17]),.p_iplus1(p_in[18]),.pi(p_in[17]),.g_window(g_out[18]),.p_window(p_out[18]));
    gp_window gp19_to_18(.g_iplus1(g_in[19]),.gi(g_in[18]),.p_iplus1(p_in[19]),.pi(p_in[18]),.g_window(g_out[19]),.p_window(p_out[19]));
    gp_window gp20_to_19(.g_iplus1(g_in[20]),.gi(g_in[19]),.p_iplus1(p_in[20]),.pi(p_in[19]),.g_window(g_out[20]),.p_window(p_out[20]));
    
    gp_window gp21_to_20(.g_iplus1(g_in[21]),.gi(g_in[20]),.p_iplus1(p_in[21]),.pi(p_in[20]),.g_window(g_out[21]),.p_window(p_out[21]));
    gp_window gp22_to_21(.g_iplus1(g_in[22]),.gi(g_in[21]),.p_iplus1(p_in[22]),.pi(p_in[21]),.g_window(g_out[22]),.p_window(p_out[22]));
    gp_window gp23_to_22(.g_iplus1(g_in[23]),.gi(g_in[22]),.p_iplus1(p_in[23]),.pi(p_in[22]),.g_window(g_out[23]),.p_window(p_out[23]));
    gp_window gp24_to_23(.g_iplus1(g_in[24]),.gi(g_in[23]),.p_iplus1(p_in[24]),.pi(p_in[23]),.g_window(g_out[24]),.p_window(p_out[24]));
    gp_window gp25_to_24(.g_iplus1(g_in[25]),.gi(g_in[24]),.p_iplus1(p_in[25]),.pi(p_in[24]),.g_window(g_out[25]),.p_window(p_out[25]));
    gp_window gp26_to_25(.g_iplus1(g_in[26]),.gi(g_in[25]),.p_iplus1(p_in[26]),.pi(p_in[25]),.g_window(g_out[26]),.p_window(p_out[26]));
    gp_window gp27_to_26(.g_iplus1(g_in[27]),.gi(g_in[26]),.p_iplus1(p_in[27]),.pi(p_in[26]),.g_window(g_out[27]),.p_window(p_out[27]));
    gp_window gp28_to_27(.g_iplus1(g_in[28]),.gi(g_in[27]),.p_iplus1(p_in[28]),.pi(p_in[27]),.g_window(g_out[28]),.p_window(p_out[28]));
    gp_window gp29_to_28(.g_iplus1(g_in[29]),.gi(g_in[28]),.p_iplus1(p_in[29]),.pi(p_in[28]),.g_window(g_out[29]),.p_window(p_out[29]));
    gp_window gp30_to_29(.g_iplus1(g_in[30]),.gi(g_in[29]),.p_iplus1(p_in[30]),.pi(p_in[29]),.g_window(g_out[30]),.p_window(p_out[30]));
    
    gp_window gp31_to_30(.g_iplus1(g_in[31]),.gi(g_in[30]),.p_iplus1(p_in[31]),.pi(p_in[30]),.g_window(g_out[31]),.p_window(p_out[31]));
endmodule

module KSA_Stage3(input wire [31:0] g_in, input wire [31:0] p_in,
output wire [31:0] g_out, output wire [31:0] p_out);
    //g0 & p0
    assign g_out[0] = g_in[0]; assign p_out[0] = p_in[0];
    //g1-0 & p1-0
    assign g_out[1] = g_in[1]; assign p_out[1] = p_in[1];
    //g2-0 & p2-0
    gp_window gp2_to_0(.g_iplus1(g_in[2]),.gi(g_in[0]),.p_iplus1(p_in[2]),.pi(p_in[0]),.g_window(g_out[2]),.p_window(p_out[2]));
    //g3-0 & p3-0
    gp_window gp3_to_0(.g_iplus1(g_in[3]),.gi(g_in[1]),.p_iplus1(p_in[3]),.pi(p_in[1]),.g_window(g_out[3]),.p_window(p_out[3]));
    //Rest at Stage 3
    gp_window gp4_to_1(.g_iplus1(g_in[4]),.gi(g_in[2]),.p_iplus1(p_in[4]),.pi(p_in[2]),.g_window(g_out[4]),.p_window(p_out[4]));
    gp_window gp5_to_2(.g_iplus1(g_in[5]),.gi(g_in[3]),.p_iplus1(p_in[5]),.pi(p_in[3]),.g_window(g_out[5]),.p_window(p_out[5]));
    gp_window gp6_to_3(.g_iplus1(g_in[6]),.gi(g_in[4]),.p_iplus1(p_in[6]),.pi(p_in[4]),.g_window(g_out[6]),.p_window(p_out[6]));
    gp_window gp7_to_4(.g_iplus1(g_in[7]),.gi(g_in[5]),.p_iplus1(p_in[7]),.pi(p_in[5]),.g_window(g_out[7]),.p_window(p_out[7]));
    gp_window gp8_to_5(.g_iplus1(g_in[8]),.gi(g_in[6]),.p_iplus1(p_in[8]),.pi(p_in[6]),.g_window(g_out[8]),.p_window(p_out[8]));
    gp_window gp9_to_6(.g_iplus1(g_in[9]),.gi(g_in[7]),.p_iplus1(p_in[9]),.pi(p_in[7]),.g_window(g_out[9]),.p_window(p_out[9]));
    gp_window gp10_to_7(.g_iplus1(g_in[10]),.gi(g_in[8]),.p_iplus1(p_in[10]),.pi(p_in[8]),.g_window(g_out[10]),.p_window(p_out[10]));
    gp_window gp11_to_8(.g_iplus1(g_in[11]),.gi(g_in[9]),.p_iplus1(p_in[11]),.pi(p_in[9]),.g_window(g_out[11]),.p_window(p_out[11]));
    gp_window gp12_to_9(.g_iplus1(g_in[12]), .gi(g_in[10]), .p_iplus1(p_in[12]), .pi(p_in[10]), .g_window(g_out[12]), .p_window(p_out[12]));
    gp_window gp13_to_10(.g_iplus1(g_in[13]), .gi(g_in[11]), .p_iplus1(p_in[13]), .pi(p_in[11]), .g_window(g_out[13]), .p_window(p_out[13]));
    gp_window gp14_to_11(.g_iplus1(g_in[14]), .gi(g_in[12]), .p_iplus1(p_in[14]), .pi(p_in[12]), .g_window(g_out[14]), .p_window(p_out[14]));
    gp_window gp15_to_12(.g_iplus1(g_in[15]), .gi(g_in[13]), .p_iplus1(p_in[15]), .pi(p_in[13]), .g_window(g_out[15]), .p_window(p_out[15]));
    gp_window gp16_to_13(.g_iplus1(g_in[16]), .gi(g_in[14]), .p_iplus1(p_in[16]), .pi(p_in[14]), .g_window(g_out[16]), .p_window(p_out[16]));
    gp_window gp17_to_14(.g_iplus1(g_in[17]), .gi(g_in[15]), .p_iplus1(p_in[17]), .pi(p_in[15]), .g_window(g_out[17]), .p_window(p_out[17]));
    gp_window gp18_to_15(.g_iplus1(g_in[18]), .gi(g_in[16]), .p_iplus1(p_in[18]), .pi(p_in[16]), .g_window(g_out[18]), .p_window(p_out[18]));
    gp_window gp19_to_16(.g_iplus1(g_in[19]), .gi(g_in[17]), .p_iplus1(p_in[19]), .pi(p_in[17]), .g_window(g_out[19]), .p_window(p_out[19]));
    gp_window gp20_to_17(.g_iplus1(g_in[20]), .gi(g_in[18]), .p_iplus1(p_in[20]), .pi(p_in[18]), .g_window(g_out[20]), .p_window(p_out[20]));
    gp_window gp21_to_18(.g_iplus1(g_in[21]), .gi(g_in[19]), .p_iplus1(p_in[21]), .pi(p_in[19]), .g_window(g_out[21]), .p_window(p_out[21]));
    gp_window gp22_to_19(.g_iplus1(g_in[22]), .gi(g_in[20]), .p_iplus1(p_in[22]), .pi(p_in[20]), .g_window(g_out[22]), .p_window(p_out[22]));
    gp_window gp23_to_20(.g_iplus1(g_in[23]), .gi(g_in[21]), .p_iplus1(p_in[23]), .pi(p_in[21]), .g_window(g_out[23]), .p_window(p_out[23]));
    gp_window gp24_to_21(.g_iplus1(g_in[24]), .gi(g_in[22]), .p_iplus1(p_in[24]), .pi(p_in[22]), .g_window(g_out[24]), .p_window(p_out[24]));
    gp_window gp25_to_22(.g_iplus1(g_in[25]), .gi(g_in[23]), .p_iplus1(p_in[25]), .pi(p_in[23]), .g_window(g_out[25]), .p_window(p_out[25]));
    gp_window gp26_to_23(.g_iplus1(g_in[26]), .gi(g_in[24]), .p_iplus1(p_in[26]), .pi(p_in[24]), .g_window(g_out[26]), .p_window(p_out[26]));
    gp_window gp27_to_24(.g_iplus1(g_in[27]), .gi(g_in[25]), .p_iplus1(p_in[27]), .pi(p_in[25]), .g_window(g_out[27]), .p_window(p_out[27]));
    gp_window gp28_to_25(.g_iplus1(g_in[28]), .gi(g_in[26]), .p_iplus1(p_in[28]), .pi(p_in[26]), .g_window(g_out[28]), .p_window(p_out[28]));
    gp_window gp29_to_26(.g_iplus1(g_in[29]), .gi(g_in[27]), .p_iplus1(p_in[29]), .pi(p_in[27]), .g_window(g_out[29]), .p_window(p_out[29]));
    gp_window gp30_to_27(.g_iplus1(g_in[30]), .gi(g_in[28]), .p_iplus1(p_in[30]), .pi(p_in[28]), .g_window(g_out[30]), .p_window(p_out[30]));
    gp_window gp31_to_28(.g_iplus1(g_in[31]), .gi(g_in[29]), .p_iplus1(p_in[31]), .pi(p_in[29]), .g_window(g_out[31]), .p_window(p_out[31]));

endmodule

module KSA_Stage4(input wire [31:0] g_in, input wire [31:0] p_in,
output wire [31:0] g_out, output wire [31:0] p_out);
     //g0 & p0
    assign g_out[0] = g_in[0]; assign p_out[0] = p_in[0];
    //g1-0 & p1-0
    assign g_out[1] = g_in[1]; assign p_out[1] = p_in[1];
    //g2-0 & p2-0
    assign g_out[2] = g_in[2]; assign p_out[2] = p_in[2];
    //g3-0 & p3-0
    assign g_out[3] = g_in[3]; assign p_out[3] = p_in[3];
    //g4-0 & p4-0
    gp_window gp4_to_0(.g_iplus1(g_in[4]),.gi(g_in[0]),.p_iplus1(p_in[4]),.pi(p_in[0]),.g_window(g_out[4]),.p_window(p_out[4]));
    //g5-0 & p5-0
    gp_window gp5_to_0(.g_iplus1(g_in[5]),.gi(g_in[1]),.p_iplus1(p_in[5]),.pi(p_in[1]),.g_window(g_out[5]),.p_window(p_out[5]));
    //g6-0 & p6-0
    gp_window gp6_to_0(.g_iplus1(g_in[6]),.gi(g_in[2]),.p_iplus1(p_in[6]),.pi(p_in[2]),.g_window(g_out[6]),.p_window(p_out[6]));
    //g7-0 & p7-0
    gp_window gp7_to_0(.g_iplus1(g_in[7]),.gi(g_in[3]),.p_iplus1(p_in[7]),.pi(p_in[3]),.g_window(g_out[7]),.p_window(p_out[7]));
    //Rest of bubble in stage 4
    gp_window gp8_to_1(.g_iplus1(g_in[8]),.gi(g_in[4]),.p_iplus1(p_in[8]),.pi(p_in[4]),.g_window(g_out[8]),.p_window(p_out[8]));
    gp_window gp9_to_2(.g_iplus1(g_in[9]),.gi(g_in[5]),.p_iplus1(p_in[9]),.pi(p_in[5]),.g_window(g_out[9]),.p_window(p_out[9]));
    gp_window gp10_to_3(.g_iplus1(g_in[10]),.gi(g_in[6]),.p_iplus1(p_in[10]),.pi(p_in[6]),.g_window(g_out[10]),.p_window(p_out[10]));
    gp_window gp11_to_4(.g_iplus1(g_in[11]),.gi(g_in[7]),.p_iplus1(p_in[11]),.pi(p_in[7]),.g_window(g_out[11]),.p_window(p_out[11]));
    gp_window gp12_to_5(.g_iplus1(g_in[12]),.gi(g_in[8]),.p_iplus1(p_in[12]),.pi(p_in[8]),.g_window(g_out[12]),.p_window(p_out[12]));
    gp_window gp13_to_6(.g_iplus1(g_in[13]),.gi(g_in[9]),.p_iplus1(p_in[13]),.pi(p_in[9]),.g_window(g_out[13]),.p_window(p_out[13]));
    gp_window gp14_to_7(.g_iplus1(g_in[14]),.gi(g_in[10]),.p_iplus1(p_in[14]),.pi(p_in[10]),.g_window(g_out[14]),.p_window(p_out[14]));
    gp_window gp15_to_8(.g_iplus1(g_in[15]),.gi(g_in[11]),.p_iplus1(p_in[15]),.pi(p_in[11]),.g_window(g_out[15]),.p_window(p_out[15]));
    gp_window gp16_to_9(.g_iplus1(g_in[16]),.gi(g_in[12]),.p_iplus1(p_in[16]),.pi(p_in[12]),.g_window(g_out[16]),.p_window(p_out[16]));
    gp_window gp17_to_10(.g_iplus1(g_in[17]),.gi(g_in[13]),.p_iplus1(p_in[17]),.pi(p_in[13]),.g_window(g_out[17]),.p_window(p_out[17]));
    gp_window gp18_to_11(.g_iplus1(g_in[18]),.gi(g_in[14]),.p_iplus1(p_in[18]),.pi(p_in[14]),.g_window(g_out[18]),.p_window(p_out[18]));
    gp_window gp19_to_12(.g_iplus1(g_in[19]),.gi(g_in[15]),.p_iplus1(p_in[19]),.pi(p_in[15]),.g_window(g_out[19]),.p_window(p_out[19]));
    gp_window gp20_to_13(.g_iplus1(g_in[20]),.gi(g_in[16]),.p_iplus1(p_in[20]),.pi(p_in[16]),.g_window(g_out[20]),.p_window(p_out[20]));
    gp_window gp21_to_14(.g_iplus1(g_in[21]),.gi(g_in[17]),.p_iplus1(p_in[21]),.pi(p_in[17]),.g_window(g_out[21]),.p_window(p_out[21]));
    gp_window gp22_to_15(.g_iplus1(g_in[22]),.gi(g_in[18]),.p_iplus1(p_in[22]),.pi(p_in[18]),.g_window(g_out[22]),.p_window(p_out[22]));
    gp_window gp23_to_16(.g_iplus1(g_in[23]),.gi(g_in[19]),.p_iplus1(p_in[23]),.pi(p_in[19]),.g_window(g_out[23]),.p_window(p_out[23]));
    gp_window gp24_to_17(.g_iplus1(g_in[24]),.gi(g_in[20]),.p_iplus1(p_in[24]),.pi(p_in[20]),.g_window(g_out[24]),.p_window(p_out[24]));
    gp_window gp25_to_18(.g_iplus1(g_in[25]),.gi(g_in[21]),.p_iplus1(p_in[25]),.pi(p_in[21]),.g_window(g_out[25]),.p_window(p_out[25]));
    gp_window gp26_to_19(.g_iplus1(g_in[26]),.gi(g_in[22]),.p_iplus1(p_in[26]),.pi(p_in[22]),.g_window(g_out[26]),.p_window(p_out[26]));
    gp_window gp27_to_20(.g_iplus1(g_in[27]),.gi(g_in[23]),.p_iplus1(p_in[27]),.pi(p_in[23]),.g_window(g_out[27]),.p_window(p_out[27]));
    gp_window gp28_to_21(.g_iplus1(g_in[28]),.gi(g_in[24]),.p_iplus1(p_in[28]),.pi(p_in[24]),.g_window(g_out[28]),.p_window(p_out[28]));
    gp_window gp29_to_22(.g_iplus1(g_in[29]),.gi(g_in[25]),.p_iplus1(p_in[29]),.pi(p_in[25]),.g_window(g_out[29]),.p_window(p_out[29]));
    gp_window gp30_to_23(.g_iplus1(g_in[30]),.gi(g_in[26]),.p_iplus1(p_in[30]),.pi(p_in[26]),.g_window(g_out[30]),.p_window(p_out[30]));
    gp_window gp31_to_24(.g_iplus1(g_in[31]),.gi(g_in[27]),.p_iplus1(p_in[31]),.pi(p_in[27]),.g_window(g_out[31]),.p_window(p_out[31]));
endmodule

module KSA_Stage5(input wire [31:0] g_in, input wire [31:0] p_in,
output wire [31:0] g_out, output wire [31:0] p_out);
    //g0 & p0
    assign g_out[0] = g_in[0]; assign p_out[0] = p_in[0];
    //g1-0 & p1-0
    assign g_out[1] = g_in[1]; assign p_out[1] = p_in[1];
    //g2-0 & p2-0
    assign g_out[2] = g_in[2]; assign p_out[2] = p_in[2];
    //g3-0 & p3-0
    assign g_out[3] = g_in[3]; assign p_out[3] = p_in[3];
    //g4-0 & p4-0
    assign g_out[4] = g_in[4]; assign p_out[4] = p_in[4];
    //g5-0 & p5-0
    assign g_out[5] = g_in[5]; assign p_out[5] = p_in[5];
    //g6-0 & p6-0
    assign g_out[6] = g_in[6]; assign p_out[6] = p_in[6];
    //g7-0 & p7-0
    assign g_out[7] = g_in[7]; assign p_out[7] = p_in[7];
    
   
    gp_window gp8_to_0(.g_iplus1(g_in[8]),.gi(g_in[0]),.p_iplus1(p_in[8]),.pi(p_in[0]),.g_window(g_out[8]),.p_window(p_out[8]));
    gp_window gp9_to_0(.g_iplus1(g_in[9]),.gi(g_in[1]),.p_iplus1(p_in[9]),.pi(p_in[1]),.g_window(g_out[9]),.p_window(p_out[9]));
    gp_window gp10_to_0(.g_iplus1(g_in[10]),.gi(g_in[2]),.p_iplus1(p_in[10]),.pi(p_in[2]),.g_window(g_out[10]),.p_window(p_out[10]));
    gp_window gp11_to_0(.g_iplus1(g_in[11]),.gi(g_in[3]),.p_iplus1(p_in[11]),.pi(p_in[3]),.g_window(g_out[11]),.p_window(p_out[11]));
    gp_window gp12_to_0(.g_iplus1(g_in[12]),.gi(g_in[4]),.p_iplus1(p_in[12]),.pi(p_in[4]),.g_window(g_out[12]),.p_window(p_out[12]));
    gp_window gp13_to_0(.g_iplus1(g_in[13]),.gi(g_in[5]),.p_iplus1(p_in[13]),.pi(p_in[5]),.g_window(g_out[13]),.p_window(p_out[13]));
    gp_window gp14_to_0(.g_iplus1(g_in[14]),.gi(g_in[6]),.p_iplus1(p_in[14]),.pi(p_in[6]),.g_window(g_out[14]),.p_window(p_out[14]));
    gp_window gp15_to_0(.g_iplus1(g_in[15]),.gi(g_in[7]),.p_iplus1(p_in[15]),.pi(p_in[7]),.g_window(g_out[15]),.p_window(p_out[15]));
    
    gp_window gp16_to_1(.g_iplus1(g_in[16]),.gi(g_in[8]),.p_iplus1(p_in[16]),.pi(p_in[8]),.g_window(g_out[16]),.p_window(p_out[16]));
    gp_window gp17_to_2(.g_iplus1(g_in[17]),.gi(g_in[9]),.p_iplus1(p_in[17]),.pi(p_in[9]),.g_window(g_out[17]),.p_window(p_out[17]));
    gp_window gp18_to_3(.g_iplus1(g_in[18]),.gi(g_in[10]),.p_iplus1(p_in[18]),.pi(p_in[10]),.g_window(g_out[18]),.p_window(p_out[18]));
    gp_window gp19_to_4(.g_iplus1(g_in[19]),.gi(g_in[11]),.p_iplus1(p_in[19]),.pi(p_in[11]),.g_window(g_out[19]),.p_window(p_out[19]));
    gp_window gp20_to_5(.g_iplus1(g_in[20]),.gi(g_in[12]),.p_iplus1(p_in[20]),.pi(p_in[12]),.g_window(g_out[20]),.p_window(p_out[20]));
    gp_window gp21_to_6(.g_iplus1(g_in[21]),.gi(g_in[13]),.p_iplus1(p_in[21]),.pi(p_in[13]),.g_window(g_out[21]),.p_window(p_out[21]));
    gp_window gp22_to_7(.g_iplus1(g_in[22]),.gi(g_in[14]),.p_iplus1(p_in[22]),.pi(p_in[14]),.g_window(g_out[22]),.p_window(p_out[22]));
    gp_window gp23_to_8(.g_iplus1(g_in[23]),.gi(g_in[15]),.p_iplus1(p_in[23]),.pi(p_in[15]),.g_window(g_out[23]),.p_window(p_out[23]));
    gp_window gp24_to_9(.g_iplus1(g_in[24]),.gi(g_in[16]),.p_iplus1(p_in[24]),.pi(p_in[16]),.g_window(g_out[24]),.p_window(p_out[24]));
    gp_window gp25_to_10(.g_iplus1(g_in[25]),.gi(g_in[17]),.p_iplus1(p_in[25]),.pi(p_in[17]),.g_window(g_out[25]),.p_window(p_out[25]));
    gp_window gp26_to_11(.g_iplus1(g_in[26]),.gi(g_in[18]),.p_iplus1(p_in[26]),.pi(p_in[18]),.g_window(g_out[26]),.p_window(p_out[26]));
    gp_window gp27_to_12(.g_iplus1(g_in[27]),.gi(g_in[19]),.p_iplus1(p_in[27]),.pi(p_in[19]),.g_window(g_out[27]),.p_window(p_out[27]));
    gp_window gp28_to_13(.g_iplus1(g_in[28]),.gi(g_in[20]),.p_iplus1(p_in[28]),.pi(p_in[20]),.g_window(g_out[28]),.p_window(p_out[28]));
    gp_window gp29_to_14(.g_iplus1(g_in[29]),.gi(g_in[21]),.p_iplus1(p_in[29]),.pi(p_in[21]),.g_window(g_out[29]),.p_window(p_out[29]));
    gp_window gp30_to_15(.g_iplus1(g_in[30]),.gi(g_in[22]),.p_iplus1(p_in[30]),.pi(p_in[22]),.g_window(g_out[30]),.p_window(p_out[30]));
    gp_window gp31_to_16(.g_iplus1(g_in[31]),.gi(g_in[23]),.p_iplus1(p_in[31]),.pi(p_in[23]),.g_window(g_out[31]),.p_window(p_out[31]));
endmodule

module KSA_Stage6(input wire [31:0] g_in, input wire [31:0] p_in,
output wire [31:0] g_out, output wire [31:0] p_out);
    //g0 & p0
    assign g_out[0] = g_in[0]; assign p_out[0] = p_in[0];
    //g1-0 & p1-0
    assign g_out[1] = g_in[1]; assign p_out[1] = p_in[1];
    //g2-0 & p2-0
    assign g_out[2] = g_in[2]; assign p_out[2] = p_in[2];
    //g3-0 & p3-0
    assign g_out[3] = g_in[3]; assign p_out[3] = p_in[3];
    //g4-0 & p4-0
    assign g_out[4] = g_in[4]; assign p_out[4] = p_in[4];
    //g5-0 & p5-0
    assign g_out[5] = g_in[5]; assign p_out[5] = p_in[5];
    //g6-0 & p6-0
    assign g_out[6] = g_in[6]; assign p_out[6] = p_in[6];
    //g7-0 & p7-0
    assign g_out[7] = g_in[7]; assign p_out[7] = p_in[7];
    
    //g8-0 & p8-0
    assign g_out[8] = g_in[8]; assign p_out[8] = p_in[8];
    //g9-0 & p9-0
    assign g_out[9] = g_in[9]; assign p_out[9] = p_in[9];
    //g10-0 & p10-0
    assign g_out[10] = g_in[10]; assign p_out[10] = p_in[10];
    //g11-0 & p11-0
    assign g_out[11] = g_in[11]; assign p_out[11] = p_in[11];
    //g12-0 & p12-0
    assign g_out[12] = g_in[12]; assign p_out[12] = p_in[12];
    //g13-0 & p13-0
    assign g_out[13] = g_in[13]; assign p_out[13] = p_in[13];
    //g14-0 & p14-0
    assign g_out[14] = g_in[14]; assign p_out[14] = p_in[14];
    //g15-0 & p15-0
    assign g_out[15] = g_in[15]; assign p_out[15] = p_in[15];
    
    gp_window gp16_to_0(.g_iplus1(g_in[16]),.gi(g_in[0]),.p_iplus1(p_in[16]),.pi(p_in[0]),.g_window(g_out[16]),.p_window(p_out[16]));
    gp_window gp17_to_0(.g_iplus1(g_in[17]),.gi(g_in[1]),.p_iplus1(p_in[17]),.pi(p_in[1]),.g_window(g_out[17]),.p_window(p_out[17]));
    gp_window gp18_to_0(.g_iplus1(g_in[18]),.gi(g_in[2]),.p_iplus1(p_in[18]),.pi(p_in[2]),.g_window(g_out[18]),.p_window(p_out[18]));
    gp_window gp19_to_0(.g_iplus1(g_in[19]),.gi(g_in[3]),.p_iplus1(p_in[19]),.pi(p_in[3]),.g_window(g_out[19]),.p_window(p_out[19]));
    gp_window gp20_to_0(.g_iplus1(g_in[20]),.gi(g_in[4]),.p_iplus1(p_in[20]),.pi(p_in[4]),.g_window(g_out[20]),.p_window(p_out[20]));
    gp_window gp21_to_0(.g_iplus1(g_in[21]),.gi(g_in[5]),.p_iplus1(p_in[21]),.pi(p_in[5]),.g_window(g_out[21]),.p_window(p_out[21]));
    gp_window gp22_to_0(.g_iplus1(g_in[22]),.gi(g_in[6]),.p_iplus1(p_in[22]),.pi(p_in[6]),.g_window(g_out[22]),.p_window(p_out[22]));
    gp_window gp23_to_0(.g_iplus1(g_in[23]),.gi(g_in[7]),.p_iplus1(p_in[23]),.pi(p_in[7]),.g_window(g_out[23]),.p_window(p_out[23]));
    gp_window gp24_to_0(.g_iplus1(g_in[24]),.gi(g_in[8]),.p_iplus1(p_in[24]),.pi(p_in[8]),.g_window(g_out[24]),.p_window(p_out[24]));
    gp_window gp25_to_0(.g_iplus1(g_in[25]),.gi(g_in[9]),.p_iplus1(p_in[25]),.pi(p_in[9]),.g_window(g_out[25]),.p_window(p_out[25]));
    gp_window gp26_to_0(.g_iplus1(g_in[26]),.gi(g_in[10]),.p_iplus1(p_in[26]),.pi(p_in[10]),.g_window(g_out[26]),.p_window(p_out[26]));
    gp_window gp27_to_0(.g_iplus1(g_in[27]),.gi(g_in[11]),.p_iplus1(p_in[27]),.pi(p_in[11]),.g_window(g_out[27]),.p_window(p_out[27]));
    gp_window gp28_to_0(.g_iplus1(g_in[28]),.gi(g_in[12]),.p_iplus1(p_in[28]),.pi(p_in[12]),.g_window(g_out[28]),.p_window(p_out[28]));
    gp_window gp29_to_0(.g_iplus1(g_in[29]),.gi(g_in[13]),.p_iplus1(p_in[29]),.pi(p_in[13]),.g_window(g_out[29]),.p_window(p_out[29]));
    gp_window gp30_to_0(.g_iplus1(g_in[30]),.gi(g_in[14]),.p_iplus1(p_in[30]),.pi(p_in[14]),.g_window(g_out[30]),.p_window(p_out[30]));
    gp_window gp31_to_0(.g_iplus1(g_in[31]),.gi(g_in[15]),.p_iplus1(p_in[31]),.pi(p_in[15]),.g_window(g_out[31]),.p_window(p_out[31]));
endmodule

module KSA_Stage7(input wire [31:0] g_in, input wire [31:0] p_in, input wire cin,
output wire [32:0] carry);
    assign carry[0] = cin;
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin
            assign carry[i+1] = g_in[i] | (p_in[i] & carry[i]);
        end
    endgenerate
endmodule

module gp1(input a, input b, output g, output p);
    assign g = a & b;
    assign p = a ^ b;
endmodule

module gp_window(input g_iplus1, input gi, input p_iplus1, input pi,
output g_window, output p_window
    );
    assign p_window = p_iplus1 & pi;
    assign g_window = g_iplus1 | (gi & p_iplus1); 
endmodule