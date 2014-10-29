function plot(x::BootstrapSample, bincount::Integer = 10)
    p = plot(x = x.t0,
             xintercept = x.t1,
             Geom.histogram(bincount = bincount),
             Geom.vline(color = "red", size = 0.8mm),
             Guide.xlabel("Statistic"),
             Guide.ylabel("Density")
             )

    return p
end
