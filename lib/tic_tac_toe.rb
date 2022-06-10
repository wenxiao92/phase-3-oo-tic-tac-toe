class TicTacToe

    def initialize
        @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end

    #Constant
    WIN_COMBINATIONS = [
        [0,1,2],[3,4,5],[6,7,8], #all rows
        [0,3,6],[1,4,7],[2,5,8], #all columns
        [0,4,8],[2,4,6] #diagonal wins
    ]

    #helper methods
    #helps display the boards
    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    #user sees 1 to 9 while the background is using indexes. Method is used to convert number to index
    def input_to_index(user_input)
        user_input.to_i - 1
    end

    #the method for the actual move. The token is X or O and represents the current board space occupied or the move
    def move(index, token)
        @board[index] = token
    end

    #checks if the position has been taken before. If not taken before (no longer empty space), returns a true 
    def position_taken?(index)
        @board[index] != " "
    end

    #checks a position and returns true if the move is still valid
    #submitted move is not already filled (hence the ! in position_taken?)
    def valid_move?(index)
        !position_taken?(index) && index.between?(0,8)
    end

    #counts each index and see if it still equals to empty space. For all non epmty space = that many turns
    def turn_count
        @board.count{|filled| filled != " "}
    end

    #uses the number in turn_count method and returns X if it's even
    def current_player
        turn_count.even? ? "X" : "O"
    end

    #method to taketurns on the board to make a move
    def turn
        puts "Please enter a number (1-9):"
        user_input = gets.strip #gets the input and removes the /n line
        index = input_to_index(user_input) #uses helper method to change to input into an index
        if valid_move?(index) #if the move is valid, then the index will be occupied by the token
            token = current_player
            move(index, token)
        else #if the move is invalid, then the turn method is reinvoked
            turn
        end
        display_board #always redisplay the board after a move is made
    end

    #non helper methods
    #when was combo defined?
    def won?
        WIN_COMBINATIONS.any? do |combo|
            if position_taken?(combo[0]) && @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]]
                return combo
            end
        end
    end

    #returns true if everything on the board is full. If there's one empty space, then this will return false
    def full?
        @board.all?{|filled| filled != " "}
    end

    #returns true if the board is full (full? method) and not won (! on won? method)
    def draw?
        full? && !won?
    end

    #returns true if the board is either draw (draw? method) or someone won (won? method)
    def over?
        draw? || won?
    end

    #when was combo defined?
    def winner
        if combo = won?
            @board[combo[0]]
        end
    end

    def play
        turn until over?

        puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
    end

end
