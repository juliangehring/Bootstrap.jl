module TestStats

using Bootstrap
using Base.Test

x = collect(100:-1:0) ## avoid sorting

## reference values, computed with boot:::norm_inter (R)
qr = (
      (1.0,      Inf),
      (0.0,     -Inf),
      (0.5,     50.0),
      (0.4713,  47.07265),
      (0.1,      9.205641),
      (0.052,    4.319606)
      )

for (alpha, ref) in qr
    @test_approx_eq_eps Bootstrap.iquantile(x, alpha) ref 1e-5
end

a = Float64[x[1] for x in qr]
b = Float64[x[2] for x in qr]
@test_approx_eq_eps Bootstrap.iquantile(x, a) b 1e-5

x = collect(0:100)
## check that quantiles are monotone
y0 = -Inf
for alpha in 0:0.001:1
    y1 = Bootstrap.iquantile(x, alpha)
    @test y1 >= y0
end

end
