// Implemented the ALU Module
module ALU (
    input [15:0] data1,
    input [15:0] data2,
    input [3:0] alu_op, // Opcode
    output reg [15:0] result
);
    always @(*) begin
        case (alu_op)
            4'b0000: result = data1 + data2; // ADD
            4'b0001: result = data1 - data2; // SUB
            4'b0010: result = data1 & data2; // AND
            4'b0011: result = data1 | data2; // OR
            4'b0100: result = data1 ^ data2; // XOR
            4'b0101: result = ~data1;        // NOT
            4'b0110: result = data1 << data2[3:0]; // Shift left
            4'b0111: result = data1 >> data2[3:0]; // Shift right
            4'b1000: result = (data1 < data2) ? 16'b1 : 16'b0; // SLT
            default: result = 16'b0;
        endcase
    end
endmodule
