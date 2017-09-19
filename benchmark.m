function [Tasks, g1, g2] = benchmark(index)
%BENCHMARK function
%   Input
%   - index: the index number of problem set
%
%   Output:
%   - Tasks: benchmark problem set
%   - g1: global optima of Task 1
%   - g2: global optima of Task 2
    switch(index)
        case 1 % complete intersection with high similarity, Griewank and Rastrigin
            dim = 30;
            GO_Task1 = zeros(1,dim);
            Rotation_Task1 = orth(randn(dim,dim));
            Tasks(1).dims = dim;    % dimensionality of Task 1
            Tasks(1).fnc = @(x)Rastrigin(x,Rotation_Task1,GO_Task1);
            Tasks(1).Lb=-50*ones(1,dim);   % Upper bound of Task 1
            Tasks(1).Ub=50*ones(1,dim);    % Lower bound of Task 1            
            Rotation_Task2 = orth(randn(dim,dim));
            GO_Task2       = zeros(1,dim);
            Tasks(2).dims = dim;    % dimensionality of Task 2
            Tasks(2).fnc = @(x)Sphere(x,Rotation_Task2,GO_Task2);
            Tasks(2).Lb=-50*ones(1,dim);    % Upper bound of Task 2
            Tasks(2).Ub=50*ones(1,dim);     % Lower bound of Task 2
            
            Tasks(1).name = 'Rastrigin';
            Tasks(2).name = 'Sphere';
            Tasks(1).task = '30R30S';
            Tasks(2).task = '30R30S';
        
            g1 = GO_Task1;
            g2 = GO_Task2;
        case 2 % complete intersection with medium similarity, Ackley and Rastrigin
            dim = 30;
            GO_Task1 = zeros(1,dim);
            Rotation_Task1 = orth(randn(dim,dim));
            Tasks(1).dims = dim;    % dimensionality of Task 1
            Tasks(1).fnc = @(x)Ackley(x,Rotation_Task1,GO_Task1);
            Tasks(1).Lb=-50*ones(1,dim);   % Upper bound of Task 1
            Tasks(1).Ub=50*ones(1,dim);    % Lower bound of Task 1            
            Rotation_Task2 = orth(randn(dim,dim));
            GO_Task2       = zeros(1,dim);
            Tasks(2).dims = dim;    % dimensionality of Task 2
            Tasks(2).fnc = @(x)Sphere(x,Rotation_Task2,GO_Task2);
            Tasks(2).Lb=-50*ones(1,dim);    % Upper bound of Task 2
            Tasks(2).Ub=50*ones(1,dim);     % Lower bound of Task 2
            
            Tasks(1).name = 'Ackley';
            Tasks(2).name = 'Sphere';
            Tasks(1).task = '30A30S';
            Tasks(2).task = '30A30S';
            g1 = GO_Task1;
            g2 = GO_Task2;
        case 3 % complete intersection with low similarity, Ackley and Schwefel
            dim = 30;
            GO_Task1 = zeros(1,dim);
            Rotation_Task1 = orth(randn(dim,dim));
            Tasks(1).fnc = @(x)Ackley(x,Rotation_Task1,GO_Task1);
    
            Tasks(1).dims = dim;    % dimensionality of Task 1
            Tasks(1).Lb=-50*ones(1,dim);   % Upper bound of Task 1
            Tasks(1).Ub=50*ones(1,dim);    % Lower bound of Task 1            
            
            Rotation_Task2 = orth(randn(dim,dim));
            GO_Task2       = zeros(1,dim);
            Tasks(2).dims = dim;    % dimensionality of Task 2
            Tasks(2).fnc = @(x)Rastrigin(x,Rotation_Task2,GO_Task2);
            Tasks(2).Lb=-50*ones(1,dim);    % Upper bound of Task 2
            Tasks(2).Ub=50*ones(1,dim);     % Lower bound of Task 2
            
            Tasks(1).name = 'Ackley';
            Tasks(2).name = 'Rastrigin';
            Tasks(1).task = '30A30R';
            Tasks(2).task = '30A30R';
            g1 = GO_Task1;
            g2 = GO_Task2;
        case 4 % partially intersection with high similarity, Rastrigin and Sphere
            dim = 30;
            GO_Task1 = zeros(1,dim);
            Rotation_Task1 = orth(randn(dim,dim));
            Tasks(1).dims = dim;    % dimensionality of Task 1
            Tasks(1).fnc = @(x)Rastrigin(x,Rotation_Task1,GO_Task1);
            Tasks(1).Lb=-50*ones(1,dim);   % Upper bound of Task 1
            Tasks(1).Ub=50*ones(1,dim);    % Lower bound of Task 1            
            dim = 20;
            Rotation_Task2 = orth(randn(dim,dim));
            GO_Task2       = zeros(1,dim);
            Tasks(2).dims = dim;    % dimensionality of Task 2
            Tasks(2).fnc = @(x)Sphere(x,Rotation_Task2,GO_Task2);
            Tasks(2).Lb=-50*ones(1,dim);    % Upper bound of Task 2
            Tasks(2).Ub=50*ones(1,dim);     % Lower bound of Task 2
            
            Tasks(1).name = 'Rastrigin';
            Tasks(2).name = 'Sphere';
            Tasks(1).task = '30R20S';
            Tasks(2).task = '30R20S';
        
            g1 = GO_Task1;
            g2 = GO_Task2;
        case 5 % partially intersection with medium similarity, Ackley and Rosenbrock
            dim = 30;
            GO_Task1 = zeros(1,dim);
            Rotation_Task1 = orth(randn(dim,dim));
            Tasks(1).dims = dim;    % dimensionality of Task 1
            Tasks(1).fnc = @(x)Ackley(x,Rotation_Task1,GO_Task1);
            Tasks(1).Lb=-50*ones(1,dim);   % Upper bound of Task 1
            Tasks(1).Ub=50*ones(1,dim);    % Lower bound of Task 1            
            
            dim = 20;
            Rotation_Task2 = orth(randn(dim,dim));
            GO_Task2       = zeros(1,dim);
            Tasks(2).dims = dim;    % dimensionality of Task 2
            Tasks(2).fnc = @(x)Sphere(x,Rotation_Task2,GO_Task2);
            Tasks(2).Lb=-50*ones(1,dim);    % Upper bound of Task 2
            Tasks(2).Ub=50*ones(1,dim);     % Lower bound of Task 2
            
            Tasks(1).name = 'Ackley';
            Tasks(2).name = 'Sphere';
            Tasks(1).task = '30A20S';
            Tasks(2).task = '30A20S';
            g1 = GO_Task1;
            g2 = GO_Task2;
        
        case 6 % partially intersection with low similarity, Ackley and Weierstrass
            dim = 30;
            GO_Task1 = zeros(1,dim);
            Rotation_Task1 = orth(randn(dim,dim));
            Tasks(1).dims = dim;    % dimensionality of Task 1
            Tasks(1).fnc = @(x)Ackley(x,Rotation_Task1,GO_Task1);
            Tasks(1).Lb=-50*ones(1,dim);   % Upper bound of Task 1
            Tasks(1).Ub=50*ones(1,dim);    % Lower bound of Task 1            
            
            Rotation_Task2 = orth(randn(dim,dim));
            GO_Task2       = zeros(1,dim);
            Tasks(2).dims = dim;    % dimensionality of Task 2
            Tasks(2).fnc = @(x)Rastrigin(x,Rotation_Task2,GO_Task2);
            Tasks(2).Lb=-50*ones(1,dim);    % Upper bound of Task 2
            Tasks(2).Ub=50*ones(1,dim);     % Lower bound of Task 2
            
            Tasks(1).name = 'Ackley';
            Tasks(2).name = 'Rastrigin';
            Tasks(1).task = '30A30R';
            Tasks(2).task = '30A30R';
            g1 = GO_Task1;
        case 7
            dim = 30;
            GO_Task1 = zeros(1,dim);
            Rotation_Task1 = orth(randn(dim,dim));
            Tasks(1).dims = dim;    % dimensionality of Task 1
            Tasks(1).fnc = @(x)Ackley(x,Rotation_Task1,GO_Task1);
            Tasks(1).Lb=-50*ones(1,dim);   % Upper bound of Task 1
            Tasks(1).Ub=50*ones(1,dim);    % Lower bound of Task 1            
    
            dim = 20;
            Rotation_Task2 = orth(randn(dim,dim));
            GO_Task2       = zeros(1,dim);
            Tasks(2).dims = dim;    % dimensionality of Task 2
            Tasks(2).fnc = @(x)Rastrigin(x,Rotation_Task2,GO_Task2);
            Tasks(2).Lb=-50*ones(1,dim);    % Upper bound of Task 2
            Tasks(2).Ub=50*ones(1,dim);     % Lower bound of Task 2
            
            Tasks(1).name = 'Ackley';
            Tasks(2).name = 'Rastrigin';
            Tasks(1).task = '30A20R';
            Tasks(2).task = '30A20R';
            g1 = GO_Task1;
            g2 = GO_Task2; 
        case 8
            dim = 20;
            GO_Task1 = zeros(1,dim);
            Rotation_Task1 = orth(randn(dim,dim));
            Tasks(1).dims = dim;    % dimensionality of Task 1
            Tasks(1).fnc = @(x)Ackley(x,Rotation_Task1,GO_Task1);
            Tasks(1).Lb=-50*ones(1,dim);   % Upper bound of Task 1
            Tasks(1).Ub=50*ones(1,dim);    % Lower bound of Task 1            
    
            dim = 30;
            Rotation_Task2 = orth(randn(dim,dim));
            GO_Task2       = zeros(1,dim);
            Tasks(2).dims = dim;    % dimensionality of Task 2
            Tasks(2).fnc = @(x)Rastrigin(x,Rotation_Task2,GO_Task2);
            Tasks(2).Lb=-50*ones(1,dim);    % Upper bound of Task 2
            Tasks(2).Ub=50*ones(1,dim);     % Lower bound of Task 2
            
            Tasks(1).name = 'Ackley';
            Tasks(2).name = 'Rastrigin';
            Tasks(1).task = '20A30R';
            Tasks(2).task = '20A30R';
            g1 = GO_Task1;
            g2 = GO_Task2; 
            
    end
    
    
end