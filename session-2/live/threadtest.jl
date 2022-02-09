using BenchmarkTools

# Threads.threadid() tells us the ID number of the thread currently doing a task.
function thread_test()
    Threads.@threads for i in 1:6
        id = Threads.threadid()
        println("Thread ID: ", id, " | i: ", i)
    end
end

# thread_test()

function serialsum(xs)
    r = 0
    for i in xs
        r += i
    end
    return r
end

function threadsum(xs)
    r = zeros(Threads.nthreads())
    Threads.@threads for i in xs
        # Each thread has it's own "sum bucket" to accumulate 
        # bits and pieces of xs -- we'll add these buckets together
        # at the end.
        r[Threads.threadid()] += i
    end
    return sum(r)
end

values = randn(10_000, 10_000);
# values = randn(100);

# @time serialsum(values)
# @time threadsum(values)

xs = []
Threads.@threads for i in 1:1000
    push!(xs, i) # Add i to the end of xs
end

println(length(xs))