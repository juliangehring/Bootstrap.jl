using Bootstrap
using Base.Test

## data
x = [1:100];
n = length(x);
m = 100;

#bs1 = boot(x, mean, m)

#wv = WeightVec(x)
#bs2 = boot_weight(x, mean, m, wv)

#bs3 = boot_balanced(x, mean, m)

# write your own tests here
@test 1 == 1
