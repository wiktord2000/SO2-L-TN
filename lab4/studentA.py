
from numpy import append


def print_board(board):
    
    size = len(board)
    for i in range(0 , size):
        
        if i > 0 and i < size:
            if size == 3:
                print("-------")
            elif size == 5:
                print("-----------")
            
        row = ""
        for j in range(0, size):
            
            if j > 0 and i < size:
                row += board[i][j] + '|'
            else:
                row += board[i][j]
        print(row)
            
        
        
                
    

def new_board(board_size):
    return [[" " for x in range(board_size)] for y in range(board_size)]
    

def is_game_over(board):
    board_size = len(board)
    if board_size == 3:
        for i in range(0, board_size):
            
            if((board[i][0] == board[i][1]) and (board[i][1] == board[i][2])):
                return True
            
            if((board[0][i] == board[1][i]) and (board[1][i] == board[2][i])):
                return True
            
            if((board[0][0] == board[1][1]) and (board[1][1] == board[2][2])):
                return True
            
            if((board[0][2] == board[1][1]) and (board[1][1] == board[2][0])):
                return True
    elif board_size == 5:
        pass 
    
    return False

board = new_board(3)
board[0][0] = "X"
board[0][1] = "X"
board[0][2] = "O"

print(is_game_over(board))