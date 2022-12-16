# NipponColors.jl

![CI](https://img.shields.io/github/actions/workflow/status/vavrines/NipponColors.jl/ci.yml?branch=main&style=flat-square)
[![codecov](https://img.shields.io/codecov/c/github/vavrines/NipponColors.jl?style=flat-square)](https://codecov.io/gh/vavrines/NipponColors.jl)

A smallish package to generate colors in traditional Japanese color system.
See [日本の伝統色](https://nipponcolors.com/) for a complete list of colors.
Both Roman and Kanji names are supported.

## Installation

NipponColors.jl can be installed with the Julia package manager. From the Julia REPL, you can get in the package manager (by pressing ]) and add the package

```julia
julia> ]
(v1.6) pkg> add NipponColors
```

## Example

```julia
using Plots, NipponColors

D = dict_color()
x = 0:0.02:1 |> collect
plot(x, sin.(2π .* x), color = D["mizu"])
plot!(x, cos.(2π .* x), color = D["梔子"])
```

<img src="https://i.postimg.cc/Bv3sR69g/plot.png" width="550"/>
