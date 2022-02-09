using Distributions, LinearAlgebra
using UnicodePlots

# Print out the thread count
@info "" Threads.nthreads()

# Utility function
u(X, γ, β) = (1 - exp(-γ * X'β)) / γ

# Single draw of X, gamma, beta, and u
function single_draw(n)
    X = rand(MvNormal(ones(n), 0.25*I))
    gamma = rand(Exponential(0.05))
    beta = rand(MvNormal(ones(n), 0.5*I))
    return u(X, gamma, beta)
end

# Serial simulation
function simulate(n, n_draws)
    draws = zeros(n_draws)

    for i in 1:n_draws
        draws[i] = single_draw(n)
    end

    return draws
end

# Simulation using a lock
function simulate_threads(n, n_draws)
    draws = zeros(n_draws)

    Threads.@threads for i in 1:n_draws
        draw = single_draw(n)
        draws[i] = draw
        # lock(drawlock) do
        #     draws[i] = draw
        # end
    end

    return draws
end

n = 1000
n_draws = 100_000
@time draws1 = simulate(n, n_draws)
@time draws2 = simulate_threads(n, n_draws)

println("Howdy")

histogram(draws1) |> display
histogram(draws2) |> display