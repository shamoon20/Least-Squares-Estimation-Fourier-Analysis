%% Exercise 2 – Linear estimation of sinusoidal components

% Parameters given in the assignment
N = 16;
M = 1;
a1 = 1;
b1 = 0.7;
sigma2 = 0.001;
MC = 100000;

n = (0:N-1)';

%% 2.1 Feature matrix construction

k = 1:M;
X = [cos(2*pi*n*k/N), sin(2*pi*n*k/N)];
% X is N x (2M)

%% 2.2 Least Squares estimation

% Generate measurement vector y
rng(1);   % fixed seed for reproducibility
noise = sqrt(sigma2)*randn(N,1);
y = a1*cos(2*pi*n/N) + b1*sin(2*pi*n/N) + noise;

% LS estimate of w = [a1; b1]
w_hat = (X.'*X)\(X.'*y);

%% 2.3 Covariance and Monte Carlo verification

% Theoretical covariance
C_theory = sigma2 * inv(X.'*X);

% Monte Carlo simulation
W_hat_MC = zeros(2, MC);

for i = 1:MC
    noise = sqrt(sigma2)*randn(N,1);
    y = a1*cos(2*pi*n/N) + b1*sin(2*pi*n/N) + noise;
    W_hat_MC(:,i) = (X.'*X)\(X.'*y);
end

C_MC = cov(W_hat_MC.');

%% Display results

disp('LS estimate [a1_hat; b1_hat]:');
disp(w_hat)

disp('Theoretical covariance:');
disp(C_theory)

disp('Monte Carlo covariance:');
disp(C_MC)

disp('Difference (MC - Theory):');
disp(C_MC - C_theory)

%% 2.4 BLUE discussion
% LS is BLUE here since the noise is zero-mean, white, and has equal variance.
