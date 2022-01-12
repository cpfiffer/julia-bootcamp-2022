struct DoData
    data::Vector{Float64}
end

function (f::DoData)()
    return f.data[1]
end

data_holder = DoData([1,2,3,4,5])
data_holder()


function go()
    something = [1,2,3,454]
    function zz()
        return something[1]
    end

    return zz()
end