function  MFEA_main(p_il_,rmp_,mu,sigma)
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
    gen=500; % generation count 1000
    selection_pressure = 'elitist'; % choose either 'elitist' or 'roulette wheel'
    p_il = p_il_; % probability of individual learning (BFGA quasi-Newton Algorithm) --> Indiviudal Learning is an IMPORTANT component of the MFEA.
    rmp=rmp_; % random mating probability
    reps = 30; % repetitions 20

    al = 'MFEA';

    if exist('result') == 0
     mkdir('result');
    end
    test = 'result';

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
    
    
    algorithmname = strcat(algorithmname,'\rmp',num2str(rmp));
    
    
    if exist(algorithmname) == 0
        mkdir(algorithmname);
    end
    
    algorithmname = strcat(algorithmname,'\sigma',num2str(sigma),'mu',num2str(mu));
    
    filename = strcat(algorithmname,'\',test, '.mat');


    for index = 1:7
        Tasks = benchmark(index);
        problemname = strcat(algorithmname,'\',Tasks(1).task);
        if exist(problemname) == 0
            mkdir(problemname);
        end
        data_MFEA(index)=MFEA(Tasks,pop_M,gen,selection_pressure,rmp,p_il,reps,problemname,index,mu,sigma);   
    end

    save( filename,'data_MFEA');
