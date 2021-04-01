function [r, c, d, xloc, yloc] = make_instance(N, M, seed)
% [r, c, b, xloc, yloc] = MAKE_INSTANCE(N, M, seed) generates an instance
% with city size N and M locations for ambulace stations.
% 
% Input:
% N    Size of the city. N >= 2
% M    Number of locations for abulace stations. M <= N
% seed Random seed (optional).
% 
% Output:
% r    Distance matrix, r(a,b) is the response time for an ambulance station
%      located at a to respond to an accident at location b.
% c    Cost vector, c(a) is the cost of opening an ambulance station at 
%      location a.
% b    Budget.
% xloc x-coordinate for locations in the city (optional).
% yloc y-coordinate for locations in the city (optional).
% 
% Example:
% [r, c, b, xloc, yloc] = MAKE_INSTANCE(4, 2, 1)
% 
% r =
% 
%          0    2.0522    1.2016    1.0212
%     2.0522         0    1.0982    1.0310
% 
% 
% c =
% 
%     2.7396    2.2526
% 
% 
% b =
% 
%     2.2526
% 
% 
% xloc =
% 
%     2.1512    1.0734    1.0462    2.0931
% 
% 
% yloc =
% 
%     2.1728    1.1984    2.2694    1.2096
% 

if N < 2
    error('labB:make_instance:smallN','N must be greater or equal to 2');
end
if M > N
    error('labB:make_instance:bigM','M must be smaller or equal to N');
end

if nargin >= 3; rng(seed);end

u = ceil(M/3);
n = ceil(sqrt(N));
n2 = n*n;
idx = randperm(n2,N);

[xloc, yloc] = ind2sub([n, n], idx);
xloc = xloc + rand(size(xloc))*0.5;
yloc = yloc + rand(size(yloc))*0.5;

r = abs(xloc-xloc(1:M).') + abs(yloc-yloc(1:M).');

xm = mean(xloc);
ym = mean(yloc);
c = log(sqrt(2)*n2./hypot(xloc-xm,yloc-ym))+rand(size(xloc));
c = c(1:M);

d = sort(c(1:M));
d = sum(d(1:u));
end
