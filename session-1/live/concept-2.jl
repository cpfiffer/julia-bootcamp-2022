var_a = -100
var_b = -2

if var_a > 1 || !(var_b < 2)
    println("It's complicated")
end

(var_a > 1 || !(var_b < 2)) && println("It's complicated")

!isdir("some/folder") && mkpath("some/folder")