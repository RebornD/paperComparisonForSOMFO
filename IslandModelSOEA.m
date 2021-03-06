function data_Island = IslandModelSOEA(Task,pop,gen,selection_process,p_il,reps,every,amount,directoryname)
%SOEA function: implementation of SOEA algorithm
    clc    
    tic         
    D(1) = Task(1).dims;
    D(2) = Task(2).dims;
    D_multitask=max(D);
    options = optimoptions(@fminunc,'Display','off','Algorithm','quasi-newton','MaxIter',2);  % settings for individual learning
    no_of_tasks=length(Task);
    pop_ = pop/no_of_tasks;
    fnceval_calls = zeros(1,reps); 
    calls_per_individual=zeros(1,pop_);
    calls_per_individual=zeros(1,pop_);
    EvBestFitness = zeros(no_of_tasks*reps,gen);    % best fitness found
    TotalEvaluations=zeros(reps,gen);   % total number of task evaluations so fer
    evaluations_=0;
    evaluation_=zeros(2);
    for rep = 1:reps   
        evaluation_=zeros(2);
        disp(rep);
        counter = zeros(no_of_tasks);
        bestobj = Inf(2);
        for tasknumber = 1 : no_of_tasks
           for i = 1 : pop_
               population(tasknumber,i) = Chromosome();
               population(tasknumber,i) = initialize(population(tasknumber,i),D_multitask);
           end
           for i = 1 : pop_
               [population(tasknumber,i),calls_per_individual(i)] = evaluate_SOO(population(tasknumber,i),Task(tasknumber),p_il,options);
               evaluations_ = evaluations_ +  1;
               evaluation_(tasknumber) = evaluation_(tasknumber) + 1 ;
           end
           
           intpopulation_first(1:pop_)=population(tasknumber,1:pop_);
           [xxx,y]=sort([intpopulation_first.factorial_costs]);          
           intdpopulation=intpopulation_first(y);

           fnceval_calls(rep)=fnceval_calls(rep) + sum(calls_per_individual);
           TotalEvaluations(2*(rep-1)+tasknumber,1,1)=fnceval_calls(rep);     
          
           population(tasknumber,1:pop_)=intdpopulation(1:pop_);
           
           bestobj(tasknumber)=population(tasknumber,1:pop_).factorial_costs;
           bestInd_data(2*(rep-1)+tasknumber)=intdpopulation(1);
           if tasknumber == 1
                 counter(1) = counter(1) + 1 ;
                 EvBestFitnessone(rep,counter(1)) = bestobj(tasknumber);
           elseif tasknumber == 2
                 counter(2) = counter(2) + 1;
                 EvBestFitnesstwo(rep,counter(2)) = bestobj(tasknumber);
           end             
           EvBestFitness(2*(rep-1)+tasknumber,1) = bestobj(tasknumber);           
        end
        
        mu = 2;     % Index of Simulated Binary Crossover (tunable)
        mum = 5;    % Index of polynomial mutation
     for t = 1: gen/every         
          if t ~= 1
               intpopulation_1(1:pop_-amount)=population(1,1:pop_-amount);
               intpopulation_2(1:pop_-amount)=population(2,1:pop_-amount);
               indorder_1=randperm(pop_);
               indorder_2=randperm(pop_);          
               intpopulation_1(pop_-amount+1:pop_)=population(2,indorder_1(1:amount));
               intpopulation_2(pop_-amount+1:pop_)=population(1,indorder_2(1:amount));
               for i = 1:amount
                  intpopulation_1(pop_-amount+i).factorial_costs = Inf(1);
                  intpopulation_2(pop_-amount+i).factorial_costs = Inf(1);
               end
               population(1,1:pop_)=intpopulation_1(1:pop_);
               population(2,1:pop_)=intpopulation_2(1:pop_);
         end        
  
         
         
         for tasknumber = 1 : no_of_tasks
            if t == 1 
             generation = 1;
            else                  
             generation = 0;
            end
            
            while generation < every
                 generation = generation + 1;
                 indorder = randperm(pop_);
                 count=1;
                 for i = 1 : pop_/2   
                    p1 = indorder(i);
                    p2 = indorder(i+(pop_/2));
                    child(count)=Chromosome();
                    child(count+1)=Chromosome();
                    u = rand(1,D_multitask);
                    cf = zeros(1,D_multitask);
                    cf(u<=0.5)=(2*u(u<=0.5)).^(1/(mu+1));
                    cf(u>0.5)=(2*(1-u(u>0.5))).^(-1/(mu+1));
                    child(count) = crossover(child(count),population(tasknumber,p1),population(tasknumber,p2),cf);
                    child(count+1) = crossover(child(count+1),population(tasknumber,p2),population(tasknumber,p1),cf);
                    if rand(1) < 1
                        child(count)=mutate(child(count),child(count),D_multitask,mum);
                        child(count+1)=mutate(child(count+1),child(count+1),D_multitask,mum);
                    end           
                    count=count+2;
                 end        
                 for i = 1 : pop_            
                     [child(i),calls_per_individual(i)] = evaluate_SOO(child(i),Task(tasknumber),p_il,options);           
                     evaluation_(tasknumber) = evaluation_(tasknumber) + 1 ;
                     evaluations_ = evaluations_ + 1;
                 end
                 
                 
                 fnceval_calls(2*(rep-1)+tasknumber)=fnceval_calls(rep) + sum(calls_per_individual);
                 TotalEvaluations(2*(rep-1)+tasknumber,generation+(t-1)*(every))=fnceval_calls(rep);
            
                 intpopulation(1:pop_)=population(tasknumber,1:pop_);
            
                 intpopulation(pop_+1:2*pop_)=child(1:pop_);
                 
                 [xxx,y]=sort([intpopulation.factorial_costs]);
                 intpopulation=intpopulation(y);
    %            disp([num2str(intpopulation(1).factorial_costs),'  ',num2str(intpopulation(pop_).factorial_costs)]);
                 if intpopulation(1).factorial_costs<=bestobj(tasknumber)
                     bestobj(tasknumber)=intpopulation(1).factorial_costs;
                     bestInd_data(2*(rep-1)+tasknumber)=intpopulation(1);
                 end

                 if tasknumber == 1
                       counter(1) = counter(1) + 1;
                       EvBestFitnessone(rep,generation+(t-1)*(every)) = bestobj(tasknumber);
                 elseif tasknumber == 2
                       counter(2) = counter(2) + 1;
                       EvBestFitnesstwo(rep,generation+(t-1)*(every)) = bestobj(tasknumber);
                 end    
                 EvBestFitness(2*(rep-1)+tasknumber,generation+(t-1)*(every))=bestobj(tasknumber);
                 if strcmp(selection_process,'elitist')
 %                    [xxx,y]=sort(-1*[intpopulation.scalar_fitness]);
 %                    intpopulation = intpopulation(y);
%                     population(tasknumber,1:pop_) = intpopulation(1:pop);
                      population(tasknumber,1:pop_)=intpopulation(1:pop_);            
                 elseif strcmp(selection_process,'roulette wheel')
                   for i=1:pop_
                    population(tasknumber,i)=intpopulation(RouletteWheelSelection([intpopulation.scalar_fitness]));
                   end
                 end % selection e
	             disp(['Island number', num2str(tasknumber) ,' Generation ', num2str(generation+(t-1)*(every)), ' best objective1 = ', num2str(bestobj(1)) ,' best objective2 = ', num2str(bestobj(2))  ])
              end % every generation
              disp(['make Transfer  ',tasknumber])
            end   % every tasks    
        end % end of generation
        disp(['test'])
        disp([num2str(counter(1) )   , '         ' ,num2str(counter(2))]);            
        disp(['test'])
        disp([num2str(evaluations_)]);
        disp(['each'])
        disp([num2str(evaluation_(1)),'   ',num2str(evaluation_(2))])
    end  % end of repeats
    tasknumber=1;
    filename = strcat(directoryname,'\','task',num2str(tasknumber),'.csv');   
    dlmwrite(filename,EvBestFitnessone,'precision','%.14f');
    tasknumber=2;
    filename = strcat(directoryname,'\','task',num2str(tasknumber),'.csv');
    dlmwrite(filename,EvBestFitnesstwo,'precision','%.14f');
    
    data_Island.wall_clock_time=toc;
    data_Island.EvBestFitness=EvBestFitness;
    data_Island.bestInd_data=bestInd_data;
    data_Island.TotalEvaluations=TotalEvaluations;

    
         
         
          
      
         