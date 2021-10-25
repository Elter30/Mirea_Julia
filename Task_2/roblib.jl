"""
    inverse(side::HorizonSide)
-- Возвращает направление, противоположное заданному
"""
function inverse(side::HorizonSide)
    return HorizonSide(mod(Int(side) + 2, 4))
end


"""
    moves!(x::Robot, side::HorizonSide)
-- Перемещает Робота в заданном направлении до упора и возвращает сделанное число шагов
"""
function moves!(x::Robot, side::HorizonSide)
    num_step = 0
    while !isborder(x, side)
        move!(x, side)
        num_step +=1
    end
    return num_step
end


"""
    moves!(x::Robot, side::HorizonSide, mvs::AbstractArray)
-- Перемещает Робота в заданном направление до упора и сохраняет количество сделанных шагов в массив 
"""
function moves!(x::Robot, side::HorizonSide, mvs::AbstractArray)
    while !isborder(x, side)
        move!(x, side)
        push!(mvs, side)
    end
end


"""
    num_move!(x::Robot, side::HorizonSide, num_step::Int)
-- Перемещает Робота на заданное количество шагов
"""
function num_move!(x::Robot, side::HorizonSide, num_step::Int)
    for i in 1:num_step
        move!(x, side)
    end
end


"""
    go_to_corner!(x::Robot, mvs::AbstractArray)
-- Перемещает Робота в Юго-Западный угол, обходя препядмствия, и заптсывает путь в массив
"""
function go_to_corner!(x::Robot, mvs::AbstractArray)
    while(!isborder(x, West) || !isborder(x, Sud))
        if(!isborder(x, West))
            moves!(x, West, mvs)
        else
            moves!(x, Sud, mvs)

        end
    end
end


"""
    return_back!(x::Robot, mvs::AbstractArray)
-- Возвращает Робота из промежуточного положения(путь к нему из начального положения должен быть записан в массив) в начальное
"""
function return_back!(x::Robot, mvs::AbstractArray)
    while length(mvs) > 0
        last_move = pop!(mvs)
        move!(x, inverse(last_move))
    end
end


