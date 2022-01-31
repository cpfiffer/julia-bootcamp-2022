using LinearAlgebra, DataFrames, Statistics

n = 1000
x = [ones(n) rand(1:0.1:10, n)]
b,sigma = [2.5, -1.2], 1
y = x*b + sigma .* randn(n);

# Write types
abstract type StandardErrorEstimator end
struct Bootstrap <: StandardErrorEstimator
    bootstrap_samples::Int
    subsample_size::Int
end
struct Spherical <: StandardErrorEstimator end

# Estimator code
ols(x, y) = ols(x, y, Spherical())
function ols(x, y, se_estimator::Spherical)
    V_inv = inv(x'x)
    b_hat = V_inv*x'y
    y_hat = x*b_hat
    e = y - y_hat

    n = length(y)
    k = size(x, 2)
    s2  = e'e / (n-k)

    se=sqrt.(s2 .* diag(V_inv))

    return DataFrame(
        b_hat=b_hat, 
        se=se,
    )
end

function ols(x, y, se_estimator::Bootstrap)
    n = length(y)
    n_samples = se_estimator.bootstrap_samples
    subsample_size = se_estimator.subsample_size
    b_hats = zeros(n_samples, size(x, 2))

    for k in 1:n_samples
        inds = rand(1:n, subsample_size)
        x_sub = x[inds,:]
        y_sub = y[inds]

        b_hats[k, :] = inv(x_sub'x_sub)*x_sub'y_sub
    end

    b_hat = vec(mean(b_hats, dims=1))
    se_hat = vec(std(b_hats, dims=1))

    return DataFrame(
        b_hat=b_hat, 
        se_hat=se_hat,
    )
end

fit1 = ols(x, y, Spherical())
fit2 = ols(x, y, Bootstrap(100_000, 10))

println("Spherical")
display(fit1)

println("\nBootstrapped")
display(fit2)
