function y = Func_A(x)

if (x < 0) || (x >= 4)

    y = 0;

elseif (x >= 0) && (x < 1)

    y = 0;

elseif (x >= 1) && (x < 2)

    y = x-1;

elseif (x >= 2) && (x < 3)

    y = 1;

elseif (x >= 3) && (x < 4)

    y = 4-x;

end
end