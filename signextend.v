module signextend (out,  in ) ;
output [31 : 0]  out;
input [15 : 0]  in ;
assign out ={{16 {in [ 15 ]}},in};
endmodule

module Jumpsignextend (out,  in ) ;
output [31 : 0]  out;
input [25 : 0]  in ;
assign out ={{6 {in [ 25 ]}},in};
endmodule