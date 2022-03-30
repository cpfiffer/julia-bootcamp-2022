using LinearAlgebra # You'll need the inv(...) function to calculate an inverse
import ReverseDiff, ForwardDiff

# n = 100
# beta = [1.0, 2.2]
# X = [ones(n) rand(n)]
# Y = X*beta + randn(n)
# beta_hat = inv(X'X)*X'Y;

# f(β) = (Y - X*β)' * (Y - X*β)

# grad_f = ForwardDiff.gradient(f, beta_hat)
# grad_r = ReverseDiff.gradient(f, beta_hat)

# n_dims = 2
# window = range(0, 3, length=1000)
# grid = [[x,y] for x in window, y in window]

# gradients = map(
#     β_guess -> ForwardDiff.gradient(f, β_guess),
#     grid
# )

# norms = map(
#     g -> sum(g .^ 2),
#     gradients
# )

# grid[findmin(norms)[2]]

# struct Something{A, B}
#     a::A
#     b::B
# end
# Something(1.0)

# zeros(eltype([1.0]), 5)

# Imports
using Distributions, LinearAlgebra
using Optim

# Create the true distribution
n = 1000
means = [1.0, 0.0, 3.0, 4.0]
dist = MvNormal(means, I)
xs = rand(dist, n)

target(m) = -sum(logpdf(MvNormal(m,I), xs))
res = optimize(target, zeros(4))