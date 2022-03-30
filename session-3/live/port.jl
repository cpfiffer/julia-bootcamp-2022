# Set up return distribution
using Random; Random.seed!(15)
n_stocks = 10
μ = rand(MvNormal(zeros(n_stocks), 0.1I))
Σ = rand(InverseWishart(n_stocks, diagm(ones(n_stocks))))

# Imports
using JuMP
using Ipopt

function opt_portfolio(R)
    # Preallocate model
    model = Model(Ipopt.Optimizer)

    # Set up variables
    @variable(model, -1 <= q[n_stocks] <= 1)
    @objective(model, Min, q'Σ*q)
    @constraint(model, sum(q) == 1)
    @constraint(model, q'μ == R)
    optimize!(model)

    # Extract optimal values
    q_star = value.(q)
    return q_star'Σ*q_star, q_star'μ
end
