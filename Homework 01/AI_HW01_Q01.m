clc
clear all
close all 

x = 0: 0.01: 10;
y_A = arrayfun(@Func_A, x);
y_B = arrayfun(@Func_B, x);

figure('Name', 'Fuzzy Sets', 'NumberTitle', 'off');
subplot(3, 2, 1)
plot(x, y_A, x, 1-y_A)
ylim([0, 1])
xlabel('x');
ylabel('\mu');
title('A & A^{''} Fuzzy Sets');
legend('A', 'A^{''}')

subplot(3, 2, 2)
plot(x, y_B, x, 1-y_B)
ylim([0, 1])
xlabel('x');
ylabel('\mu');
title('B & B^{''} Fuzzy Sets');
legend('B', 'B^{''}')

subplot(3, 2, 3)
plot(x, min(y_A, y_B))
ylim([0, 1.1])
xlabel('x');
ylabel('\mu');
title('A \cup B');
legend('A \cup B')

subplot(3, 2, 4)
plot(x,min(1-y_A, 1-y_B))
ylim([0, 1.1])
xlabel('x');
ylabel('\mu');
title('A^{''} \cup B^{''}');
legend('A^{''} \cup B^{''}')

subplot(3, 2, 5)
plot(x, max(y_A,y_B))
ylim([0, 1.1])
xlabel('x');
ylabel('\mu');
title('A \cap B');
legend('A \cap B')

subplot(3, 2, 6)
plot(x, max(1-y_A, 1-y_B))
ylim([0, 1.1])
xlabel('x');
ylabel('\mu');
title('A^{''} \cap B^{''}');
legend('A^{''} \cap B^{''}')
