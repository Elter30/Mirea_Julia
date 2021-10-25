#=

ДАНО: Робот - в юго-западном углу поля, на котором расставлено некоторое количество маркеров
РЕЗУЛЬТАТ: Функция вернула значение средней температуры всех замаркированных клеток

temp_value(rob::Robot) - возвращает срденее значение температуры клеток с маркерами

=#

function move_line!(x::Robot, side::HorizonSide, mvs::AbstractArray)
    coun = 0
    while isborder(x, side) == false
        if ismarker(x)
            coun +=1
            push!(mvs, temperature(x))
        end
        move!(x, side)
    end
    if !isborder(x, Nord)
        if ismarker(x)
            coun +=1
            push!(mvs, temperature(x))
        end
        move!(x, Nord)
    end
    return coun
end

function temp_value(rob::Robot)
    del = 0
    arr = []
    sum = 0
    while (isborder(rob, Nord) && isborder(rob, Ost)) == false
        if !isborder(rob, Ost)
            del = del + move_line!(rob, Ost, arr)
        else
            del = del + move_line!(rob, West, arr)
        end
    end
    for i in 1:length(arr)
        sum = sum + arr[i]
    end
   return sum / del
end



println(temp_value(r))