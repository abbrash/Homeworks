function y = Func_B(x)

if (x < 0) || (x >= 10)

    y = 0;

elseif (x >= 0) && (x < 3)

    y = exp(x-3);

elseif (x >= 3) && (x < 5)

    y = 1;

elseif (x >= 5) && (x < 10)

    y = 1 - ((x - 5)/5);

end
end
