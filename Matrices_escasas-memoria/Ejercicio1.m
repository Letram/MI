clear;
M = eye(10,10);
S = sparse(M);
N = rand(10);
whos;

tic();

S * N;

toc();