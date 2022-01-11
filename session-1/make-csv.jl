using DataFrames, CSV
using Distributions
using RDatasets

df = DataFrame(
    name = ["todd", "jane", "yiting", "emilio", "betty"],
    attribute = randn(5),
    awesomeness = rand(1:5, 5),
    wealth = rand(0:0.1:5_000_000, 5),
    owns_hat = rand(Bool, 5),
)

CSV.write("session-1/example.csv", df)