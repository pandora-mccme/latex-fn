def big(expr z) = 
begingroup
save a;
path a;
a = fullcircle scaled 3mm;
fill a withcolor black;
draw a shifted z;
endgroup
enddef;

beginfig(1)

big(origin); %black circle drawn
big((1cm,0)); % unfilled circle
big((2.5cm,0)); % unfilled circle
big((3cm,0)); % unfilled circle

endfig;
end;
