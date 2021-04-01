function [x, fval] = labB(N, M, seed)
% [x, fval] = LABB(N, M, seed)
% 
% Input:
% N    Size of the city.
% M    Number of abulace stations.
% seed Random seed (optional).
%
% Output:
% x    Binary vector indicating which stations to open.
% fval Maximum response time for the solution.
%
% Example:
% [x, fval] = LABB(4,2,1)
% LP:                Optimal objective value is 2.052185.                                             
% 
% 
% Optimal solution found.
% 
% Intlinprog stopped at the root node because the
% objective value is within a gap tolerance of the optimal value,
% options.AbsoluteGapTolerance = 0 (the default value). The intcon variables are
% integer within tolerance, options.IntegerTolerance = 1e-05 (the default value).
% 
% 
% x =
% 
%      0     1
% 
% 
% fval =
% 
%     2.0522
% 
% See also INTLINPROG
%
% Name: Samia Nasir

if nargin >= 3
    [r, c, b] = make_instance(N,M, seed);
else
    [r, c, b] = make_instance(N, M);
end

% You solve the problem here.

lb=zeros(1,M+N*M+1);%lower bound
ub=[ones(1,M) ones(1,N*M) inf()];%upper bound
r = r';%transpose of distance matrix
A=[c,zeros(1,N*M),0;
    zeros(M*N,M) diag(r(:)) -ones(N*M,1);
    kron(eye(M),-ones(N,1)) eye(M*N) zeros(N*M,1);
    ];%the matrix of inequality constraints
Aeq = [zeros(N,M) repmat(eye(N),1,M) zeros(N,1)];%matrix of the equality constraint
b = [b; zeros(2*N*M,1)];
beq = ones(N,1);
f = [zeros(1,M+M*N) 1];%objective function
intcon = 1:M+N*M;
[x, fval] = intlinprog(f,intcon,A,b,Aeq,beq,lb,ub);

end
