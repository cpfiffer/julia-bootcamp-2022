using BenchmarkTools

function expensive()
    X = randn(10_000, 1_000)
    return inv(X'X)
end

function go_serial()
    A = expensive()
    B = expensive()
    
    return A + B
end

function go_threads()
    A = Threads.@spawn expensive()
    B = Threads.@spawn expensive()
    
    # Wait for both to complete
    return fetch(A) + fetch(B)
end

display(@benchmark go_serial())
display(@benchmark go_threads())