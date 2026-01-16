%%Task 1

x = [-0.5; 0.2; 0.7; 1.3; 2.1]; %data
y = [2.3; 3.5; 3.9; 4.5; 5.3];  %data

X = [ones(length(x),1), x];     %design-matrix

w_hat = (X' * X) \ (X' * y);    %LS formula

b_hat = w_hat(1);
a_hat = w_hat(2);

%%Task 2

figure;
plot(x, y, 'o');
grid on;
xlabel('x');
ylabel('y');
title('Data points');

%% Task 3
x0 = 0.8;
mu = a_hat * x0 + b_hat;

sigma2 = 1;
sigma = sqrt(sigma2);

y_vals = linspace(mu - 4*sigma, mu + 4*sigma, 1000); %plotting over the range mu +4*sigma, for better visualization
pdf_vals = normpdf(y_vals, mu, sigma);

figure;
plot(y_vals, pdf_vals, 'LineWidth', 2);
grid on;
xlabel('y');
ylabel('p(y | x = 0.8)');
title('Conditional PDF p(y | x = 0.8)');

%% Task 4
% Task 4a: Effect of changing x

x1 = 0.8;
x2 = 0.1;

mu1 = a_hat * x1 + b_hat;
mu2 = a_hat * x2 + b_hat;

sigma2 = 1;
sigma = sqrt(sigma2);

y_vals = linspace(mu2 - 4*sigma, mu1 + 4*sigma, 1000);

pdf1 = normpdf(y_vals, mu1, sigma);
pdf2 = normpdf(y_vals, mu2, sigma);

figure;
plot(y_vals, pdf1, 'LineWidth', 2); hold on;
plot(y_vals, pdf2, '--', 'LineWidth', 2);
grid on;
xlabel('y');
ylabel('p(y | x)');
legend('x = 0.8', 'x = 0.1');
title('Effect of x on the conditional PDF');

% Task 4b: Effect of changing noise variance

x0 = 0.8;
mu = a_hat * x0 + b_hat;

sigma2_1 = 1;
sigma2_2 = 2;

sigma1 = sqrt(sigma2_1);
sigma2 = sqrt(sigma2_2);

y_vals = linspace(mu - 6*sigma2, mu + 6*sigma2, 1000);

pdf_sigma1 = normpdf(y_vals, mu, sigma1);
pdf_sigma2 = normpdf(y_vals, mu, sigma2);

figure;
plot(y_vals, pdf_sigma1, 'LineWidth', 2); hold on;
plot(y_vals, pdf_sigma2, '--', 'LineWidth', 2);
grid on;
xlabel('y');
ylabel('p(y | x = 0.8)');
legend('\sigma^2 = 1', '\sigma^2 = 2');
title('Effect of noise variance on the conditional PDF');

% Task 4ab: Effect of decreasing x and increasing sigma^2

% Original case (reference)
x_ref = 0.8;
sigma2_ref = 1;

mu_ref = a_hat * x_ref + b_hat;
sigma_ref = sqrt(sigma2_ref);

% Modified case
x_new = 0.1;
sigma2_new = 2;

mu_new = a_hat * x_new + b_hat;
sigma_new = sqrt(sigma2_new);

% Common y-axis range
y_vals = linspace(mu_new - 6*sigma_new, mu_ref + 6*sigma_ref, 1000);

% PDFs
pdf_ref = normpdf(y_vals, mu_ref, sigma_ref);
pdf_new = normpdf(y_vals, mu_new, sigma_new);

% Plot
figure;
plot(y_vals, pdf_ref, 'LineWidth', 2); hold on;
plot(y_vals, pdf_new, '--', 'LineWidth', 2);
grid on;

xlabel('y');
ylabel('p(y | x)');
legend('x = 0.8, \sigma^2 = 1', 'x = 0.1, \sigma^2 = 2');
title('Combined effect of decreasing x and increasing noise variance');
