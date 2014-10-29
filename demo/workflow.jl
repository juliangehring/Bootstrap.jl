using Bootstrap

## sample data, taken from a standard normal distribution
r = randn(50);

## bootstrap the 'mean'
## not the most interesting case, but let's start light and simple

## basic bootstrap
bs1 = boot(r, mean, 1000);

bs1

## bias and variance of the bootstrapped estimates
bias(bs1)
se(bs1)

## balanced bootstrap
bs2 = boot(r, mean, 1000, method = :balanced);

bias(bs2)
se(bs2)

## 95% confidence intervals
## basic CIs
bci1 = ci(bs1, level = 0.95);

interval(bci1)

## percentile CIs
bci2 = ci(bs1, level = 0.95, method = :perc);
