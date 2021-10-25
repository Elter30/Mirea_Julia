#=
ДАНО: На ограниченном внешней прямоугольной рамкой поле имеется ровно одна внутренняя перегородка в форме прямоугольника. 
Робот - в произвольной клетке поля между внешней и внутренней перегородками.
РЕЗУЛЬТАТ: Робот - в исходном положении и по всему периметру внутренней перегородки поставлены маркеры.

contour!(rob::Robot) - обводит прямоугольную перегородку и возвращает Робота в начальное положение

=#
include("roblib.jl")

function find_border!(x::Robot, direction_of_movement::HorizonSide, direction_of_border::HorizonSide)
    while isborder(x, direction_of_border) == false
        if isborder(x, direction_of_movement) == false
            move!(x, direction_of_movement)
        else
            move!(x, direction_of_border)
            direction_of_movement = inverse(direction_of_movement)
        end
    end
    return direction_of_movement
end

function mark_perimetr!(x::Robot, landmark::HorizonSide)
    if landmark == Nord
        direction_of_movement = (Nord, Ost, Sud, West)
        direction_of_border = (Ost, Sud, West, Nord)
    else
        direction_of_movement = (Sud, Ost, Nord, West)
        direction_of_border = (Ost, Nord, West, Sud)
    end
    for i in 1:4
        while isborder(x, direction_of_border[i]) == true
            putmarker!(x)
            move!(x, direction_of_movement[i])
        end
        putmarker!(x)
        if i < 4
            move!(x, direction_of_movement[i+1])
        else
            move!(x, Sud)
        end
    end
end


function contour!(rob::Robot)
    num_y1 = moves!(rob, Sud)
    num_x = moves!(rob, West)
    num_y2 = moves!(rob, Sud)
    landmark = find_border!(rob, Nord, Ost)
    mark_perimetr!(rob, landmark)
    moves!(rob, West)
    moves!(rob, Sud)
    num_move!(rob, Nord, num_y2)
    num_move!(rob, Ost, num_x)
    num_move!(rob, Nord, num_y1)
end

contour!(r)