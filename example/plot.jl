using Plots, NipponColors

D = dict_color()

x = 0:0.02:1 |> collect
plot(x, sin.(2π .* x), color = D["mizu"])
plot!(x, cos.(2π .* x), color = D["梔子"])
