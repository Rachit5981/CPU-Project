module Memory_Bank (
    input clk,
    input [15:0] address,
    inout [15:0] data,
    input mem_read,
    input mem_write
);
    reg [15:0] memory [0:255]; // 256 words of 16-bit memory
    reg [15:0] data_out;

    always @(posedge clk) begin
        if (mem_write)
            memory[address] <= data;
        else if (mem_read)
            data_out <= memory[address];
    end

    assign data = mem_read ? data_out : 16'bz;
endmodule
