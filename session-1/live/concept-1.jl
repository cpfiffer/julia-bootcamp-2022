z = 90

r1 = z % 2
r2 = z % 4
r3 = z % 8

# println(r1)
# println(r2)
# println(r3)

rems = map(x -> z % x, [2,4,8])
foreach(println, rems)

for r in rems
    println(rems)
end