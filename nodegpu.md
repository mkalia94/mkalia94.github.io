# DiffEqFlux.jl: Running Neural ODEs on GPU

Neural ODEs are a fantastic amalgamation of computational powers from applied dynamical systems and deep learning. The basic idea is to compute 'infinite' depth RNNs as ordinary differential equations. The method is thus depth independent, and makes use of modern ODE solvers to backpropagate. More details can be found [here](https://julialang.org/blog/2019/01/fluxdiffeq) and [here](https://arxiv.org/abs/1806.07366). However, the code from the `model-zoo`, see [here](https://github.com/FluxML/model-zoo/blob/master/other/diffeq/neural_ode.jl) is unfeasible to run on a GPU.

## Workaround
```julia
using CuArrays
ode_data = gpu.(Array(solve(prob,BS3(),saveat=t)))

dudt = Chain(x -> x.^3,
             Dense(2,50,tanh),
             Dense(50,2)) |> gpu
ps = Flux.params(dudt)
n_ode = x->neural_ode(gpu(dudt),gpu(x),tspan, BS3(),saveat=t,reltol=1e-7,abstol=1e-9)
```

Note that `Tsit5()` only works well on the CPU, as indicated [here](https://julialang.org/blog/2019/01/fluxdiffeq). However, `BS3()` is pretty good as well. On to more interesting things...
