module Register_File (
    input clk,
    input reset,
    input [3:0] read_reg1,
    input [3:0] read_reg2,
    input [3:0] write_reg,
    input [15:0] write_data,
    input reg_write,
    output [15:0] reg_data1,
    output [15:0] reg_data2
);
    reg [15:0] registers [0:15];
    integer i;

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            for(i=0;i<16;i=i+1)
                registers[i]<=16'b0;
                end
        else if (reg_write) begin
            registers[write_reg] <= write_data;
        end
    end

    assign reg_data1 = registers[read_reg1];
    assign reg_data2 = registers[read_reg2];
endmodule
