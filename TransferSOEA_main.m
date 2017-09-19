function TransferSOEA_main(every_,amount_,p_il_)

    % This MATLAB R2014b code is for EVOLUTIONARY MULTITASKING across minimization problems. 
    % For maximization problems, multiply objective function by -1.

    % Settings of simulated binary crossover (SBX) in this code is Pc = 1, 
    % and probability of variable sawpping = 0. 

    % For suggestions please contact: Bingshui Da (Email: da0002ui@e.ntu.edu.sg)

    %% Calling the solvers
    % For large population sizes, consider using the Parallel Computing Toolbox
    % of MATLAB.
    % Else, program can be slow.
    pop_M=100; % population size 100
    gen=1000; % generation count 1000
    selection_pressure = 'elitist'; % choose either 'elitist' or 'roulette wheel'
    p_il = p_il_; % probability of individual learning (BFGA quasi-Newton Algorithm) --> Indiviudal Learning is an IMPORTANT component of the MFEA.
    reps = 20; % repetitions 20
    every = every_;
    amount = amount_;


    if exist('result') == 0
     mkdir('result');
    end
    al = 'TransferSOEA';
    test = strcat('every' , num2str(every) , 'amuont' , num2str(amount));
    if abs(p_il) == 1
        if exist('result\Newton') == 0
            mkdir('result\Newton');
        end
        algorithmname = strcat('result\','Newton\',al);
    elseif abs(p_il) == 0 
        if exist('result\without') == 0
            mkdir('result\without');
        end
        algorithmname = strcat('result\','without\',al);
    end

    if exist(algorithmname) == 0
        mkdir(algorithmname);
    end
    algorithmname=strcat(algorithmname,'\',test);
    if exist(algorithmname) == 0
        mkdir(algorithmname);
    end
    filename = strcat(algorithmname,'\',test, '.mat');




    for index = 1:9
        Tasks = benchmark(index);

        problemname = strcat(algorithmname,'\',Tasks(1).task);
        if exist(problemname) == 0
            mkdir(problemname);
        end
        data_Island(index)=TransferSOEA(Tasks,pop_M,gen,selection_pressure,p_il,reps,every,amount,problemname);   
    end

    save( filename,'data_Island');
