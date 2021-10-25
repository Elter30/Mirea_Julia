#=

ДАНО: Где-то на неограниченном со всех сторон поле и без внутренних перегородок имеется единственный маркер. 
Робот - в произвольной клетке поля.
РЕЗУЛЬТАТ: Робот - в клетке с тем маркером.

marker!(rob::Robot) - передвигает Робота в клетку с маркером

=#
function marker!(rob::Robot)
    count = 0
    step = 1
    flag = false
    while flag == false
        for s in [Ost, Nord, West, Sud]
            if count == 2
                step += 1
                count = 0
            end
            for i in 1:step
                move!(rob, s)
                flag = ismarker(rob)
                if flag == true
                    break
                end
            end
            if flag == true
                break
            end
            count += 1
        end
    end
end

marker!(r)