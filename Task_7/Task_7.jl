#=

ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля (без внутренних перегородок)
РЕЗУЛЬТАТ: Робот - в исходном положении, в клетке с роботом стоит маркер, и все остальные клетки поля промаркированы в шахматном порядке

chess!(rob::Robot) - закрашивает поле в шахматном порядке относительно начального положения Робота и возвращает его в него

=#
include("roblib.jl")

function go_to_corner!(x::Robot, mvs::AbstractArray)
    prom_sum = max_move!(x, Sud, mvs)
    prom_sum = prom_sum + max_move!(x, West, mvs)
end

function inverse(side::HorizonSide)
    return HorizonSide(mod(Int(side) + 2, 4))
end

function max_move!(x::Robot, side::HorizonSide, mvs::AbstractArray)
    coun = 0
    while !isborder(x, side)
        move!(x, side)
        push!(mvs, side)
        coun +=1
    end
    return coun
end

function draw!(x::Robot, side::HorizonSide, sum::Number)
    while !isborder(x, side)
        if (sum % 2 == 1)
            move!(x, side)
            sum +=1
        else
            putmarker!(x)
            move!(x, side)
            sum +=1
        end
    end
    if !isborder(x, Nord)
        if(sum % 2 == 0)
            putmarker!(x)
        end
        move!(x, Nord)
        sum +=1
    end
    if isborder(x, Nord) && isborder(x, Ost) && (sum % 2 == 0)
        putmarker!(x)
    end
    return sum
end



function chess!(rob::Robot)
    arr = []
    sum = go_to_corner!(rob, arr)
    while (isborder(rob, Nord) && isborder(rob, Ost)) == false
        if !isborder(rob, Ost)
            sum = draw!(rob, Ost, sum)
        else
            sum = draw!(rob, West, sum)
        end
    end
    moves!(rob, Sud)
    moves!(rob, West)
    return_back!(rob, arr)
end

chess!(r)