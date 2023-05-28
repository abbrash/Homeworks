clc;
clear all; 
close all;

salary_data = readmatrix('Salary_Data.csv');
exp = salary_data(:,1);
salary = salary_data(:,2);
input_mf_num = 5;
output_mf_num = 5; 
exp_range = range(salary_data(:,1)); 
salary_range = range(salary_data(:,2));
input_x_step = 0.01; 
output_x_step = 100;

exp_input = 4.2;

% Input

input_x = min(exp): input_x_step: max(exp); 

gauss_sd = 1.5;
gauss_mean_nov = min(exp);
gauss_mean_adv_beg = gauss_mean_nov + exp_range/(input_mf_num - 1);
gauss_mean_comp = gauss_mean_adv_beg + exp_range/(input_mf_num - 1); 
gauss_mean_prof = gauss_mean_comp + exp_range/(input_mf_num - 1); 
gauss_mean_exp = max(exp); 

nov_mf = gaussmf(input_x, [gauss_sd gauss_mean_nov]);               % Novice
adv_beg_mf = gaussmf(input_x, [gauss_sd gauss_mean_adv_beg]);       % Advanced Beginner
comp_mf = gaussmf(input_x, [gauss_sd gauss_mean_comp]);             % Competent
prof_mf = gaussmf(input_x, [gauss_sd gauss_mean_prof]);             % Proficient
exp_mf = gaussmf(input_x, [gauss_sd gauss_mean_exp]);               % Expert


% Output

output_x = min(salary): output_x_step: max(salary); 

gauss_sd = 10000;
gauss_mean_grade_1 = min(salary);
gauss_mean_grade_2 = gauss_mean_grade_1 + salary_range/(output_mf_num - 1);
gauss_mean_grade_3 = gauss_mean_grade_2 + salary_range/(output_mf_num - 1); 
gauss_mean_grade_4 = gauss_mean_grade_3 + salary_range/(output_mf_num - 1); 
gauss_mean_grade_5 = max(salary); 

grade_1_mf = gaussmf(output_x, [gauss_sd gauss_mean_grade_1]);               % Grade 1
grade_2_mf = gaussmf(output_x, [gauss_sd gauss_mean_grade_2]);               % Grade 2
grade_3_mf = gaussmf(output_x, [gauss_sd gauss_mean_grade_3]);               % Grade 3
grade_4_mf = gaussmf(output_x, [gauss_sd gauss_mean_grade_4]);               % Grade 4
grade_5_mf = gaussmf(output_x, [gauss_sd gauss_mean_grade_5]);               % Grade 5

% Plot

figure('Name','Membership Functions','NumberTitle','off');
subplot(2,1,1)
plot(input_x, nov_mf, input_x, adv_beg_mf, input_x, comp_mf, input_x, prof_mf, input_x, exp_mf)
xlim([min(exp), max(exp)])
ylim([0, 1])
title('Input "Experience"')
ylabel('\mu')
xlabel('Year')
legend(["Novice" "Advanced Beginner" "Competent" "Proficient" "Expert"])

subplot(2,1,2)
plot(output_x, grade_1_mf, output_x, grade_2_mf, output_x, grade_3_mf, output_x, grade_4_mf, output_x, grade_5_mf)
xlim([min(salary), max(salary)])
ylim([0, 1])
title('Output "Salary"')
ylabel('\mu')
xlabel('US Dollar ($)')
legend(["Grade 1" "Grade 2" "Grade 3" "Grade 4" "Grade 5"])

% Rules

% IF    exp = Novice                THEN    salary = Grade 1
% IF    exp = Advanced Beginner     THEN    salary = Grade 2
% IF    exp = Competent             THEN    salary = Grade 3
% IF    exp = Proficient            THEN    salary = Grade 4
% IF    exp = Expert                THEN    salary = Grade 5

gauss_sd = 1.5;
nov_mf = gaussmf(exp_input, [gauss_sd gauss_mean_nov]);               % Novice
adv_beg_mf = gaussmf(exp_input, [gauss_sd gauss_mean_adv_beg]);       % Advanced Beginner
comp_mf = gaussmf(exp_input, [gauss_sd gauss_mean_comp]);             % Competent
prof_mf = gaussmf(exp_input, [gauss_sd gauss_mean_prof]);             % Proficient
exp_mf = gaussmf(exp_input, [gauss_sd gauss_mean_exp]);               % Expert

rule_1 = min(nov_mf, grade_1_mf); 
rule_2 = min(adv_beg_mf, grade_2_mf); 
rule_3 = min(comp_mf, grade_3_mf); 
rule_4 = min(prof_mf, grade_4_mf); 
rule_5 = min(exp_mf, grade_5_mf); 

figure('Name','Rules','NumberTitle','off');
subplot(2,1,1)
plot(output_x, rule_1, output_x, rule_2, output_x, rule_3, output_x, rule_4, output_x, rule_5)
xlim([min(output_x), max(output_x)])
ylim([0, 1])
title('Output "Rules"')
ylabel('\mu')
xlabel('US Dollar ($)')
legend(["Grade 1" "Grade 2" "Grade 3" "Grade 4" "Grade 5"])

% Defuzzification
% Method: Mean of Maxima

agg = max(rule_1, max(rule_2, max(rule_3, max(rule_4, rule_5))));

subplot(2,1,2)
plot(output_x, agg)
xlim([min(output_x), max(output_x)])
ylim([0, 1])
title('Output "Aggregated"')
ylabel('\mu')
xlabel('US Dollar ($)')
legend(["Aggregated"])

mean_of_maxima_index = round(mean(find(agg==max(agg))));
est_salary = ['For ', num2str(exp_input), ' years of experience, the estimated salary is ', num2str(output_x(mean_of_maxima_index)), ' USD.'];
disp(est_salary)

