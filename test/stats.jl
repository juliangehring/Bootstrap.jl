module TestStats

using Bootstrap
using FactCheck

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

facts("Normal-interpolated quantiles") do

    context("Reference values: alpha scalar") do
        for (alpha, ref) in qr
            @fact Bootstrap.iquantile(x, alpha) --> roughly(ref, 1e-5)
        end
    end

    context("Reference values: alpha vector") do
        a = Float64[x[1] for x in qr]
        r = Float64[x[2] for x in qr]
        y = Bootstrap.iquantile(x, a)
        ## workaround, since roughly cannot handle 'Inf' here
        y = round(y, 4)
        r = round(r, 4)
        @fact y --> r
    end

    context("Monotone quantiles") do
        x = collect(0:100)
        ## check that quantiles are monotone
        y0 = -Inf
        for alpha in 0:0.001:1
            y1 = Bootstrap.iquantile(x, alpha)
            @fact y1 --> greater_than_or_equal(y0)
            y0 = y1
        end
    end

end

end
