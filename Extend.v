module Extend(
input Din,
output [7:0] Dout
    );

assign Dout = {7'b0000000,Din};

endmodule