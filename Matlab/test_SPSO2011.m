clear; %Clear workspace

global initial_flag


disp_fun;
fun = input('Select a function:');
D = input('Choose the dimension of the function:');

N = 40; %No. of particles
FE_max = 1e5; %Max. no. of function evaluations

Nr = 25; % No. of runs
normalize = 0; % 0 => no normalisation, else 1

[LB UB opt_f err] = get_fun_info(fun,D);

FE = zeros(1,Nr);
new_f = zeros(1,Nr);
tot_time = zeros(1,Nr);

FE1 = zeros(1,Nr);
new_f1 = zeros(1,Nr);
tot_time1 = zeros(1,Nr);

SR = 0;
SR1 = 0;
tot_time = 0;

% % Warm up the RNG
for t=1:1:10000
    zz=alea(0,1); %rand;
end


for r=1:1:Nr

    initial_flag = 0;
    

 tic; %Reset the timer
    
 
[y new_f1(r) FE1(r)] = SPSO2011(N,D, FE_max, fun, err, LB, UB, opt_f,normalize);
        
        if new_f1(r) <= err
            SR1 = SR1 + 1;
         
        end
        
        fprintf('Run = %d error = %e\n', r, new_f1(r));
        
     

tot_time1(r) = toc;


end %r


fprintf('SPSO 2011\n');
fprintf('Avg. fitness = %1.2e(%1.2e) Avg. FEs = %1.2e(%1.2e) SR = %1.2e\n', mean(new_f1), std(new_f1), mean(FE1), std(FE1), 100*(SR1/Nr));
fprintf('Avg. time = %1.2e(%1.2e)\n', mean(tot_time1), std(tot_time1));

