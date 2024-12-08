// Hazard Detection Unit
module Hazard_Detection_Unit (
    input [15:0] if_id_instr,
    input id_ex_mem_read,
    input [3:0] id_ex_write_reg,
    output reg hazard_detected
);
    always @(*) begin
        hazard_detected = (id_ex_mem_read &&
                           (id_ex_write_reg == if_id_instr[11:8] ||
                            id_ex_write_reg == if_id_instr[7:4]));
    end
endmodule
