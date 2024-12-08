//Control Unit
module Control_Unit (
    input [15:0] instr,
    output reg [3:0] alu_op,
    output reg mem_read,
    output reg mem_write,
    output reg reg_write,
    output reg [3:0] write_reg
);
    always @(*) begin
        case(instr[15:12])
            4'b0000: begin // NOP
                alu_op = 4'b0000;
                mem_read = 1'b0;
                mem_write = 1'b0;
                reg_write = 1'b0;
                write_reg = 4'b0000;
            end
            4'b0001: begin // ADD
                alu_op = 4'b0000;
                mem_read = 1'b0;
                mem_write = 1'b0;
                reg_write = 1'b1;
                write_reg = instr[11:8];
            end
            4'b0010: begin // SUB
                alu_op = 4'b0001;
                mem_read = 1'b0;
                mem_write = 1'b0;
                reg_write = 1'b1;
                write_reg = instr[11:8];
            end
            4'b0011: begin // AND
                alu_op = 4'b0010;
                mem_read = 1'b0;
                mem_write = 1'b0;
                reg_write = 1'b1;
                write_reg = instr[11:8];
            end
            4'b0100: begin // OR
                alu_op = 4'b0011;
                mem_read = 1'b0;
                mem_write = 1'b0;
                reg_write = 1'b1;
                write_reg = instr[11:8];
            end
            4'b0101: begin // LW (Load Word)
                alu_op = 4'b0000; // Use ALU for address calculation
                mem_read = 1'b1;
                mem_write = 1'b0;
                reg_write = 1'b1;
                write_reg = instr[11:8];
            end
            4'b0110: begin // SW (Store Word)
                alu_op = 4'b0000; // Use ALU for address calculation
                mem_read = 1'b0;
                mem_write = 1'b1;
                reg_write = 1'b0;
                write_reg = 4'b0000;
            end
            default: begin
                alu_op = 4'b0000;
                mem_read = 1'b0;
                mem_write = 1'b0;
                reg_write = 1'b0;
                write_reg = 4'b0000;
            end
        endcase
    end
endmodule
