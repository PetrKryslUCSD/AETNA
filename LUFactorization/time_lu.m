% Time an implementation of the LU factorization.
%
% Call as:
%  time_lu(@mylu)
%
% The function handle represents a function that computes the 
% LU factorization _without_ pivoting. The function is called 
% exactly as the built-in lu():
%  [l,u]=lu(a)
%
% (C) 2002 Petr Krysl
%
function time_lu(theLUhandle)

rand('state',0); % reset random number generator
myeps=1000000*eps; % tolerance for correctness check
n=400; % matrix dimension
ncalls=10; % number of calls of theLUhandle
ntrials=2;  % number of trials
should_check=0; % should the code correctness be checked?
timings=[]; % collects timings

disp(['Running ' mfilename ' for ' func2str(theLUhandle) ': '...
        num2str(ntrials) ' trials, ' ...
        num2str(ncalls) ' calls, ' ...
        num2str(n) 'x' num2str(n) ' matrices']);

for itrial=1:ntrials
    tic;
    for icall=1:ncalls
        a=rand(n,n);
        [l,u]=feval(theLUhandle, a);
        if should_check
            if norm(a-l*u) > myeps
                warning([ 'norm(a-l*u)=' num2str(norm(a-l*u)) '>' num2str(myeps) ]);
            end
        end
    end
    timings=[timings toc];
end

disp(['      Done: average time ' num2str(sum(timings)/ntrials/ncalls) ' seconds']);