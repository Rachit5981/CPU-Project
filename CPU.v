// Top-level CPU module
module CPU (
    input clk, 
    input reset, 
    output [15:0] pc, 
    input [15:0] instr, 
    output [15:0] alu_out, 
    output mem_read, 
    output mem_write, 
    input [15:0] mem_data
);
    // CPU components with pipelining
    reg [15:0] pc_reg;
    reg [15:0] if_id_instr;
    reg [15:0] id_ex_reg_data1, id_ex_reg_data2;
    reg [3:0] id_ex_alu_op;
    reg [15:0] id_ex_instr;
    reg id_ex_mem_read, id_ex_mem_write, id_ex_reg_write;
    reg [3:0] id_ex_write_reg;
    wire [15:0] alu_result;
    wire hazard_detected;
    wire [15:0] rf_reg_data1, rf_reg_data2;
    wire [3:0] alu_op;
    wire reg_write;
    wire [3:0] write_reg;
    wire [15:0] write_data;
    reg [15:0] ex_mem_alu_result;
    reg ex_mem_mem_read, ex_mem_mem_write, ex_mem_reg_write;
    reg [3:0] ex_mem_write_reg;

    // Instruction Fetch (IF)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc_reg <= 0;
            if_id_instr <= 16'b0;
        end else if (!hazard_detected) begin
            pc_reg <= pc_reg + 1;
            if_id_instr <= instr;
        end
    end

    // Instruction Decode (ID)
    Control_Unit cu (
        .instr(if_id_instr), 
        .alu_op(alu_op), 
        .mem_read(mem_read), 
        .mem_write(mem_write), 
        .reg_write(reg_write), 
        .write_reg(write_reg)
    );

    Register_File rf (
        .clk(clk), 
        .reset(reset),
        .read_reg1(if_id_instr[11:8]), 
        .read_reg2(if_id_instr[7:4]), 
        .write_reg(ex_mem_write_reg), 
        .write_data(write_data), 
        .reg_write(ex_mem_reg_write), 
        .reg_data1(rf_reg_data1), 
        .reg_data2(rf_reg_data2)
    );

    // Execute (EX)
    ALU alu (
        .data1(id_ex_reg_data1), 
        .data2(id_ex_reg_data2), 
        .alu_op(id_ex_alu_op), 
        .result(alu_result)
    );

    // Hazard Detection
    Hazard_Detection_Unit hdu (
        .if_id_instr(if_id_instr),
        .id_ex_mem_read(id_ex_mem_read),
        .id_ex_write_reg(id_ex_write_reg),
        .hazard_detected(hazard_detected)
    );

    // Outputs
    assign pc = pc_reg;
    assign alu_out = ex_mem_alu_result;

    // Pipeline registers update (ID/EX stage)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            id_ex_reg_data1 <= 16'b0;
            id_ex_reg_data2 <= 16'b0;
            id_ex_alu_op <= 4'b0;
            id_ex_instr <= 16'b0;
            id_ex_mem_read <= 1'b0;
            id_ex_mem_write <= 1'b0;
            id_ex_reg_write <= 1'b0;
            id_ex_write_reg <= 4'b0;
        end else if (!hazard_detected) begin
            id_ex_reg_data1 <= rf_reg_data1;
            id_ex_reg_data2 <= rf_reg_data2;
            id_ex_alu_op <= alu_op;
            id_ex_instr <= if_id_instr;
            id_ex_mem_read <= mem_read;
            id_ex_mem_write <= mem_write;
            id_ex_reg_write <= reg_write;
            id_ex_write_reg <= write_reg;
        end
    end

    // Pipeline registers update (EX/MEM stage)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            ex_mem_alu_result <= 16'b0;
            ex_mem_mem_read <= 1'b0;
            ex_mem_mem_write <= 1'b0;
            ex_mem_reg_write <= 1'b0;
            ex_mem_write_reg <= 4'b0;
        end else begin
            ex_mem_alu_result <= alu_result;
            ex_mem_mem_read <= id_ex_mem_read;
            ex_mem_mem_write <= id_ex_mem_write;
            ex_mem_reg_write <= id_ex_reg_write;
            ex_mem_write_reg <= id_ex_write_reg;
        end
    end

    // Write-back logic
    assign write_data = ex_mem_mem_read ? mem_data : ex_mem_alu_result;

endmodule
