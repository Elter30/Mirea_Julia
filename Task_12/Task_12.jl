#=
На прямоугольном поле произвольных размеров расставить маркеры в виде "шахматных" клеток, начиная с юго-западного угла поля, 
когда каждая отдельная "шахматная" клетка имеет размер n x n клеток поля (n - это параметр функции). 
Начальное положение Робота - произвольное, конечное - совпадает с начальным. Клетки на севере и востоке могут получаться "обрезанными" - зависит от соотношения размеров поля и "шахматных" клеток. 
=#

include("roblib.jl")
module Chess_Deck
    using HorizonSideRobots
    import Main.inverse, Main.num_move!, Main.go_to_corner!, Main.moves! 

    export mark_chess!

    CELL_SIZE = 0
    X_COORD = 0
    Y_COORD = 0

    function coord_move!(x::Robot, side)
        global X_COORD, Y_COORD

        if (side == Nord)
            Y_COORD += 1
        elseif (side == Sud)
            Y_COORD -= 1
        elseif (side == Ost)
            X_COORD += 1
        else
            X_COORD -= 1
        end
        move!(x, side)
        
    end

    function chess_string(x::Robot, side)
        can_draw!(x)
        while (!isborder(x, side))
            coord_move!(x, side)
            can_draw!(x)
        end
    end

    function can_draw!(x::Robot)
        if((mod(X_COORD, 2*CELL_SIZE) in 0:CELL_SIZE - 1) == (mod(Y_COORD, 2*CELL_SIZE) in 0:CELL_SIZE - 1))
            putmarker!(x)
        end
        
    end

    function mark_chess!(rob::Robot, n::Int)
        global CELL_SIZE = n
        side = Ost
        start_y = moves!(rob, Sud)
        start_x = moves!(rob, West)

        chess_string(rob, side)
        while (isborder(rob, Nord) == false)
            coord_move!(rob, Nord)
            side = inverse(side)
            chess_string(rob, side)
        end

        moves!(rob, Sud)
        moves!(rob, West)
        num_move!(rob, Nord, start_y)
        num_move!(rob, Ost, start_x)
    end
end