function g(x, t1, t2, t3, t4)
    return t1 * x^3 + t2 * x^2 + t3 * x + t4
end

h(x) = g(x, 4, -3, 2, 10)

h(1.2)