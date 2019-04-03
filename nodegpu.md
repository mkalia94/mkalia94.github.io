# DiffEqFlux.jl: Running Neural ODEs on GPU

Neural ODEs are a fantastic amalgamation of computational powers from applied dynamical systems and deep learning. The basic idea is to compute 'infinite' depth RNNs as ordinary differential equations. The method is thus depth independent, and makes use of modern ODE solvers to backpropagate. More details can be found [here](https://julialang.org/blog/2019/01/fluxdiffeq) and [here](https://arxiv.org/abs/1806.07366). However, the code from the `model-zoo`, see [here](https://github.com/FluxML/model-zoo/blob/master/other/diffeq/neural_ode.jl) is unfeasible to run on a GPU. I don't have a workaround using the `neural_ode` function, but I can get `diffeq_rd` to work atleast on the GPU on the parameter fitting to constant problem (with Lotka-Volterra).

## Temporary workaround
```julia
using DiffEqFlux, Flux, OrdinaryDiffEq, Test
using CuArrays

function lotka_volterra(du,u,p,t)
  x, y = u
  α, β, δ, γ = p
  du[1] = dx = (α - β*y)x
  du[2] = dy = (δ*x - γ)y
end
prob = ODEProblem(lotka_volterra,[1.0,1.0],(0.0,10.0))
const len = length(range(0.0,stop=10.0,step=0.1)) # 101

# Reverse-mode

p = param([2.2, 1.0, 2.0, 0.4])
params = Flux.Params([p])
function predict_rd()
  vec(diffeq_rd(p,gpu(prob),Tsit5(),saveat=0.1))
end
loss_rd() = sum(abs2,x-1 for x in predict_rd())
loss_rd()

grads = Tracker.gradient(loss_rd, params, nest=true)
grads[p]

data = Iterators.repeated((), 100)
opt = ADAM(0.1)
cb = function ()
  display(loss_rd())
  #display(plot(solve(remake(prob,p=Flux.data(p)),Tsit5(),saveat=0.1),ylim=(0,6)))
end

# Display the ODE with the current parameter values.
cb()

using TickTock
tick()
Flux.train!(loss_rd, params, data, opt, cb = cb)
tock()

```

Commenting out `using CuArrays` runs the simulation on the CPU. The gain in computation speed is small, but I assume with more number of parameters (model and network), the GPU should show significant benefit. More on that till the next headache.. 
