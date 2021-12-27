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
-- Перемещает Робота в любой угол, обходя препядствия, и записывает путь в массив
"""
function go_to_corner!(x::Robot, mvs::AbstractArray, side1::HorizonSide, side2::HorizonSide)
    while (!isborder(x, side1) || !isborder(x, side2))
        if !isborder(x, side1)
            moves!(x, side1, mvs)
        else
            moves!(x, side2, mvs)

        end
    end
end


"""
    go_to_corner!(x::Robot, angle::NTuple{2,HorizonSide})
--Перемещает Робота в любой угол и
 возвращает массив с количеством сделанных шагов в каждую из сторон
"""
function go_to_corner!(x::Robot, angle::NTuple{2,HorizonSide})
    num_steps = []
    while (!isborder(x, angle[1]) || !isborder(x, angle[2]))
        push!(num_steps, moves!(x, angle[2]))
        push!(num_steps, moves!(x, angle[1]))
    end
    return num_steps
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


"""
    move_if_possible(r::Robot, main_side::HorizonSide)
-- Двигает робота в заданном направлении, обходя препятствия, и возвращает true или возвращает false если
робот упирается во внешнюю границу
"""
function move_if_possible(r, main_side::HorizonSide)
    orthogonal_side = next(main_side)
    reverse_side = inverse(orthogonal_side)
    num_steps = 0

    if isborder(r, main_side) == false
        move!(r, main_side)
        return true
    else
        while (isborder(r, orthogonal_side) == false  && isborder(r, main_side) == true)
            move!(r, orthogonal_side)
            num_steps += 1
        end
        if isborder(r, main_side) && isborder(r, orthogonal_side) == true
            num_move!(r, reverse_side, num_steps)
            return false
        else
            move!(r, main_side)
            while isborder(r, reverse_side) == true
                move!(r, main_side)
            end
            num_move!(r, reverse_side, num_steps)
            return true
        end
    end

end
