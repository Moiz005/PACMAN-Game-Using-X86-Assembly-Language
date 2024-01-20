INCLUDE Irvine32.inc

includelib Winmm.lib

PlaySound PROTO,
pszSound:PTR BYTE,
hmod:DWORD,
fdwSound:DWORD

BUFFER_SIZE = 501
.data
ground BYTE "------------------------------------------------------------------------------------------------------------------------",0
ground1 BYTE "|",0ah,0
ground2 BYTE "|",0

temp byte ?
temp1 db ?
len dd ?
time dd 0
xarr db 19 dup(?)
yarr db 19 dup(?)

strScore BYTE "Your score is: ",0
score dd 0
test_score dd 0
test_score1 dd 0
score1 BYTE 0

xPos BYTE 5
yPos BYTE 20

xg1Pos BYTE 5
xg2Pos BYTE 5
xg3Pos BYTE 5
xg4Pos BYTE 5
xg5Pos BYTE 5
xg6Pos BYTE 5

yg1Pos BYTE 20
yg2Pos BYTE 20
yg3Pos BYTE 20
yg4Pos BYTE 20
yg5Pos BYTE 20
yg6Pos BYTE 20

xCoinPos BYTE 210 dup(?)
yCoinPos BYTE 210 dup(?)
xEaten db 210 dup(0)
yEaten db 210 dup(0)
ind1 dd 0
ind2 dd 0
choice db 0
player_destroyed db 0
lives_counter db 3
gover db 0
life_coor db 115

prompt_gameover db "Game Over!!!",0
prompt_win db "You win!!!",0
Final_score db "With Score : ",0
prompt_level1_completed db "Level 1 Completed",0
prompt_level2_completed db "Level 2 Completed",0
prompt_level3_completed db "Level 3 Completed",0

inputChar BYTE ?

Name_of_game db "!!!Welcome to Pacman Game!!!",0
play_game db "1. Play Game",0
high_score db "2. High Score",0
instructions db "3. Instructions",0
exit_game db "4. Exit",0
input_choice db 0

instruct1 db "1. Press 'w' to move up",0
instruct2 db "2. Press 's' to move down",0
instruct3 db "3. Press 'a' to move left",0
instruct4 db "4. Press 'd' to move right",0
Horizontal db "-----",0
Horizontal1 db "----------",0

enter_name db "Enter the name : ",0
player_name db 501 dup(?)

check_scenario2 db 0
check_scenario3 db 0
check_scenario4 db 0
check_gravity db 0
check_down db 0
collision_successful_up db 0
collision_successful_down db 0
collision_successful_left db 0
collision_successful_right db 0

ghost_collision_successful_up db 0
ghost_collision_successful_down db 0
ghost_collision_successful_left db 0
ghost_collision_successful_right db 0

ghost_coin_collision_successful db 0
ghost_coin_collision_successful_up db 0
ghost_coin_collision_successful_down db 0
ghost_coin_collision_successful_left db 0
ghost_coin_collision_successful_right db 0

ghost_bup db 0
ghost_bdown db 0
ghost_bdown2 db 0
ghost_bleft db 0
ghost_bright db 0

ghost2_bup db 0
ghost2_bdown db 0
ghost2_bdown2 db 0
ghost2_bleft db 0
ghost2_bright db 0

ghost3_bup db 0
ghost3_bdown db 0
ghost3_bdown2 db 0
ghost3_bleft db 0
ghost3_bright db 0

ghost4_bup db 0
ghost4_bup2 db 0
ghost4_bdown db 0
ghost4_bdown2 db 0
ghost4_bleft db 0
ghost4_bleft2 db 0
ghost4_bright db 0
ghost4_bright2 db 0

ghost5_bup db 0
ghost5_bdown db 0
ghost5_bleft db 0
ghost5_bright db 0

ghost6_bup db 0
ghost6_bdown db 0
ghost6_bleft db 0
ghost6_bright db 0

check_scenario1 db 0
is_coin_eaten db 0
levels db 0
level1 db 0
level2 db 0
level3 db 0
space db " "

sacrifice db " "
score_in_string db 3 dup(0)
scoreis db " score : ",0

buffer_ind dd 0
error_reading_file db "Error reading file.",0
buffer_error_file db "Buffer too small for the file",0
buffer BYTE BUFFER_SIZE DUP(?)
filename db "Highscore.txt",0
fileHandle HANDLE ?
stringLength DWORD ?
bytesWritten DWORD ?
str1 BYTE "Cannot create file",0dh,0ah,0
str2 BYTE "Bytes written to file [Highscore.txt]:",0
str3 BYTE "Enter up to 500 characters and press"
     BYTE "[Enter]: ",0dh,0ah,0

     soundFile db ".\1.wav", 0
     
pacman db "   ..................         .....          ..........       .....        .....         .....	      .....          ... ",0
       db "  ....................      .......       .............      ......      ......        .......       ......         ...",0
       db "  ...               ...    ...   ...     ...         ....    ... ...    ... ...       ...   ...      ... ...        ...",0
       db "  ...               ...   ...     ...    ...                 ...  ...  ...  ...      ...     ...     ...  ...       ...",0
       db "  ...              ...   ...       ...   ...                 ...   ......   ...     ...       ...    ...   ...      ...",0
       db "  ...................    .............   ...                 ...    ....    ...     .............    ...    ...     ...",0
       db "  ..................     .............   ...                 ...            ...     .............    ...     ...    ...",0
       db "  ...		                  ...       ...   ...                 ...            ...     ...       ...    ...      ...   ...",0
       db "  ...		                 ...       ...   ...                 ...            ...     ...       ...    ...       ...  ...",0
       db "   ...	  	                ...       ...    ...        ....    ...            ...     ...       ...    ...        ... ...",0
       db "  ... 		                ...       ...     .............     ...            ...     ...       ...    ...         ......",0
       db "  ---		             -----     -----      .........      -----          -----   -----     -----  -----       --------",0

.code
main PROC
    ;First Page
    mov eax , white
    call setTextColor
    mov dl , 0
    mov dh , 4
    call Gotoxy
    call draw_pacman
    ;mov edx , offset Name_of_game
    ;call writestring
    call crlf

    mov dl , 40
    mov dh , 18
    call Gotoxy
    mov edx , offset enter_name
    call writestring

    mov dl , 40
    mov dh , 19
    call Gotoxy
    mov edx , offset player_name
    mov ecx , 501
    call readstring
    mov stringLength , eax

    call clrscr
    main_menu:
    mov dl , 40
    mov dh , 11
    call Gotoxy
    mov edx , offset play_game
    call writestring
    call crlf

    mov dl , 40
    mov dh , 12
    call Gotoxy
    mov edx , offset high_score
    call writestring
    call crlf

    mov dl , 40
    mov dh , 13
    call Gotoxy
    mov edx , offset instructions
    call writestring
    call crlf

    mov dl , 40
    mov dh , 14
    call Gotoxy
    mov edx , offset exit_game
    call writestring
    call crlf

    mov dl , 40
    mov dh , 15
    call Gotoxy
    mov eax , 0
    call readint

    cmp al , 1
    je start_of_game

    cmp al , 2
    je display_Highscore

    cmp al , 3
    je writing_instructions_page

    cmp al , 4
    je exitGame

    writing_instructions_page:
        call clrscr
        mov dl , 40
        mov dh , 10
        call Gotoxy
        mov edx , offset instruct1
        call writestring

        mov dl , 40
        mov dh , 11
        call Gotoxy
        mov edx , offset instruct2
        call writestring

        mov dl , 40
        mov dh , 12
        call Gotoxy
        mov edx , offset instruct3
        call writestring

        mov dl , 40
        mov dh , 13
        call Gotoxy
        mov edx , offset instruct4
        call writestring
         mov dl , 40
        mov dh , 14
        call Gotoxy
        call waitmsg
        call clrscr
        jmp main_menu

        display_Highscore:
        call clrscr
        call Reading_from_file
        mov edx , offset buffer
        call writestring
        call crlf
        call waitmsg
        call clrscr
        jmp main_menu

    mov eax , 0
    ; draw ground at (0,29):
    start_of_game:
    call clrscr

    cmp levels , 3
    jne start_over
    call Win_msg
    cmp gover , 1
    je exitGame

    start_over:
    mov eax,blue(blue * 16)
    call SetTextColor
    mov dl,0
    mov dh,29
    call Gotoxy
    mov edx,OFFSET ground
    call WriteString
    mov dl,0
    mov dh,1
    call Gotoxy
    mov edx,OFFSET ground
    call WriteString

    mov ecx,27
    mov dh,2
    l1:
        mov dl,0
        call Gotoxy
        mov edx,OFFSET ground1
        call WriteString
        ;inc dh
    loop l1

    mov ecx,27
    mov dh,2
    mov temp,dh
    l2:
        mov dh,temp
        mov dl,119
        call Gotoxy
        mov edx,OFFSET ground2
        call WriteString
        inc temp
    loop l2
    call DrawPlayer1
    call DrawCoin
    ; Draw Walls
    Drawing_scenarios:
    call Randomize

    mov check_scenario2 , 1
    mov check_scenario3 , 1
    mov check_scenario4 , 0

    
    calling_scenario2:
    ;cmp level1 , 1
    ;je calling_scenario3
    ;call scenario2
    ;jmp no_scenario

    ;calling_scenario3:
    ;cmp level2 , 1
    ;je calling_scenario4
    ;call scenario3
    ;jmp no_scenario

    calling_scenario4:
    cmp level3 , 1
    je Drawing_scenarios
    call scenario4
    call teleportation
    jmp no_scenario

    no_scenario:
    call Drawlife

    cmp check_scenario2 , 1
    je calling_drawghost

    cmp check_scenario3 , 1
    je calling_drawghost2

    cmp check_scenario4 , 1
    je calling_drawghost4

    jmp gameLoop
    calling_drawghost:
    call DrawGhost

    jmp gameLoop
    calling_drawghost2:
    call DrawGhost2
    call DrawGhost3
    jmp gameLoop

    calling_drawghost4:
    call DrawGhost4
    call DrawGhost5
    call DrawGhost6
    jmp gameLoop

    gameLoop:

        mov eax,white (black * 16)
        call SetTextColor

        cmp check_scenario2 , 1
        je checking_scenario2

        cmp check_scenario3 , 1
        je checking_scenario3

        cmp check_scenario4 , 1
        je checking_scenario4

        jmp ovr_checking_scenario

        checking_scenario2:
        call player_ghost_collision
        jmp ovr_checking_scenario

        checking_scenario3:
        call player_ghost2_collision
        call player_ghost3_collision
        jmp ovr_checking_scenario

        checking_scenario4:
        call player_ghost4_collision
        call player_ghost5_collision
        call player_ghost6_collision
        jmp ovr_checking_scenario

        ovr_checking_scenario:
        cmp player_destroyed , 1
        jne loop_again_gameloop
        call player_respawn
        mov player_destroyed , 0

        cmp lives_counter , 0
        jne loop_again_gameloop
        call Game_Over
        cmp gover , 1
        je exitGame

        loop_again_gameloop:
        ; draw score:
        mov dl,0
        mov dh,0
        call Gotoxy
        mov edx,OFFSET strScore
        call WriteString
        mov eax , score
        call WriteInt
        
        cmp check_scenario2 , 1
        je checking_scenario2_completed

        cmp check_scenario3 , 1
        je checking_scenario3_completed

        cmp check_scenario4 , 1
        je checking_scenario4_completed

        jmp ovr_checking_scenario_completed

        checking_scenario2_completed:
        call scenario2_level_completed
        cmp level1 , 1
        jne ovr_checking_scenario_completed
        jmp start_of_game

        checking_scenario3_completed:
        call scenario3_level_completed
        cmp level2 , 1
        jne ovr_checking_scenario_completed
        jmp start_of_game

        checking_scenario4_completed:
        call scenario4_level_completed
        cmp level3 , 1
        jne ovr_checking_scenario_completed
        jmp start_of_game

        ovr_checking_scenario_completed:
        cmp check_scenario2 , 1
        je calling_path1

        cmp check_scenario3 , 1
        je calling_path2

        cmp check_scenario4 , 1
        je calling_path4

        jmp ovr_paths
        calling_path1:
        call path1
        jmp ovr_paths

        calling_path2:
        call path2
        call path3
        jmp ovr_paths

        calling_path4:
        call path4
        call path5
        call path6
        jmp ovr_paths

        ovr_paths:
        call ghost_collision_check_with_coin

        mov eax,70
        call Delay
        call collision_check_with_coin
        mov check_gravity , 1
        ; get user key input:
        call Readkey
        mov inputChar,al

        cmp inputChar , " "
        je calling_resume

        ; exit game if user types 'x':
        cmp inputChar , "x"
        je exitGame

        cmp inputChar,"w"
        je moveUp

        cmp inputChar,"s"
        je moveDown

        cmp inputChar,"a"
        je moveLeft

        cmp inputChar,"d"
        je moveRight

        jmp gameLoop
        moveUp:
            cmp xPos , 0
            je check_out_up
            cmp xPos , 119
            je check_out_up
            cmp yPos , 2
            je return_to_game_loop_from_moveUp

            cmp check_scenario2 , 1
            je calling_collision_check_scenario1_up
            cmp check_scenario3 , 1
            je calling_collision_check_scenario2_up
            cmp check_scenario4 , 1
            je calling_collision_check_scenario3_up
            jmp move_up_properly

;---------------------- Collision checks for MAP 1 --------------------------------------------------------
            calling_collision_check_scenario1_up:
            call collision_check_scenario1
            cmp collision_successful_up , 1
            je return_to_game_loop_from_moveUp
            jmp move_up_properly

;---------------------- Collision checks for MAP 2 --------------------------------------------------------
            calling_collision_check_scenario2_up:
            call collision_check_scenario2_up
            cmp collision_successful_up , 1
            je return_to_game_loop_from_moveUp
            jmp move_up_properly

;---------------------- Collision checks for MAP 3 --------------------------------------------------------
            check_out_up:
            cmp yPos , 14
            je return_to_game_loop_from_moveUp
            calling_collision_check_scenario3_up:
            call collision_check_scenario3_up
            cmp collision_successful_up , 1
            je return_to_game_loop_from_moveUp
            jmp move_up_properly

            move_up_properly:
            
            mov ecx,1
            jumpLoop:
                call UpdatePlayer
                dec yPos
                call DrawPlayer
                mov eax,70
                call Delay
            loop jumpLoop
            return_to_game_loop_from_moveUp:
        jmp gameLoop

        moveDown:
            cmp xPos , 0
            je check_out_down
            cmp xPos , 119
            je check_out_down
            cmp yPos , 28
            je return_to_game_loop_from_moveDown
            cmp check_scenario2 , 1
            je calling_collision_check_scenario1_down
            cmp check_scenario3 , 1
            je calling_collision_check_scenario2_down
            cmp check_scenario4 , 1
            je calling_collision_check_scenario3_down
            jmp move_down_properly

;---------------------- Collision checks for MAP 1 --------------------------------------------------------
            calling_collision_check_scenario1_down:
            call collision_check_scenario1
            cmp collision_successful_down , 1
            je return_to_game_loop_from_moveDown
            jmp move_down_properly

;---------------------- Collision checks for MAP 2 --------------------------------------------------------
            calling_collision_check_scenario2_down:
            call collision_check_scenario2_down
            cmp collision_successful_down , 1
            je return_to_game_loop_from_moveDown
            jmp move_down_properly

;---------------------- Collision checks for MAP 3 --------------------------------------------------------
            check_out_down:
            cmp yPos , 16
            je return_to_game_loop_from_moveDown

            calling_collision_check_scenario3_down:
            call collision_check_scenario3_down
            cmp collision_successful_down , 1
            je return_to_game_loop_from_moveDown
            jmp move_down_properly

            move_down_properly:
            
            call UpdatePlayer
            inc yPos
            call DrawPlayer
            return_to_game_loop_from_moveDown:
        jmp gameLoop

        moveLeft:
            mov bl , 14
            mov ecx , 3
            moveLeft_l1:
                cmp yPos , bl
                je calling_teleport1
                inc bl
            loop moveLeft_l1
            cmp xPos , 1
            je return_to_game_loop_from_moveLeft

            cmp check_scenario2 , 1
            je calling_collision_check_scenario1_left
            cmp check_scenario3 , 1
            je calling_collision_check_scenario2_left
            cmp check_scenario4 , 1
            je calling_collision_check_scenario3_left
            jmp move_left_properly

;---------------------- Collision checks for MAP 1 --------------------------------------------------------
            calling_collision_check_scenario1_left:
            call collision_check_scenario1
            cmp collision_successful_left , 1
            je return_to_game_loop_from_moveLeft
            jmp move_left_properly

;---------------------- Collision checks for MAP 2 --------------------------------------------------------
            calling_collision_check_scenario2_left:
            call collision_check_scenario2_left
            cmp collision_successful_left , 1
            je return_to_game_loop_from_moveLeft
            jmp move_left_properly

;---------------------- Collision checks for MAP 3 --------------------------------------------------------
            calling_teleport1:
            call teleportation1
            
            calling_collision_check_scenario3_left:
            call collision_check_scenario3_left
            cmp collision_successful_left , 1
            je return_to_game_loop_from_moveLeft
            
            move_left_properly:
            
            call UpdatePlayer
            dec xPos
            call DrawPlayer
            return_to_game_loop_from_moveLeft:
         jmp gameLoop

        moveRight:
            mov bl , 14
            mov ecx , 3
            moveRight_l1:
                cmp yPos , bl
                je calling_teleport2
                inc bl
            loop moveRight_l1
            cmp xPos , 118
            je return_to_game_loop_from_moveRight

            cmp check_scenario2 , 1
            je calling_collision_check_scenario1_right
            cmp check_scenario3 , 1
            je calling_collision_check_scenario2_right
            cmp check_scenario4 , 1
            je calling_collision_check_scenario3_right
            jmp move_right_properly

;---------------------- Collision checks for MAP 1 --------------------------------------------------------
            calling_collision_check_scenario1_right:
            call collision_check_scenario1
            cmp collision_successful_right , 1
            je return_to_game_loop_from_moveRight
            jmp move_right_properly

;---------------------- Collision checks for MAP 2 --------------------------------------------------------
            calling_collision_check_scenario2_right:
           call collision_check_scenario2_right
            cmp collision_successful_right , 1
            je return_to_game_loop_from_moveRight
            jmp move_right_properly

;---------------------- Collision checks for MAP 3 --------------------------------------------------------
            calling_teleport2:
            call teleportation1

            calling_collision_check_scenario3_right:
            call collision_check_scenario3_right
            cmp collision_successful_right , 1
            je return_to_game_loop_from_moveRight
            jmp move_right_properly

            move_right_properly:
      
            call UpdatePlayer
            inc xPos
            call DrawPlayer
            return_to_game_loop_from_moveRight:
        jmp gameLoop

        calling_resume:
            mov dl , 40
            mov dh , 0
            call Gotoxy
            call waitmsg
            mov dl , 40
            mov dh , 0
            call Gotoxy
            mov ecx , 28
            call remove_waitmsg
            mov dl , xPos
            mov dh , yPos
            call Gotoxy
        jmp gameLoop

    jmp gameLoop

    exitGame:
    call Reading_from_file
    call Writing_to_file
    exit
    ret
main ENDP

DrawPlayer PROC
    ; draw player at (xPos,yPos):
    mov eax,yellow ;(blue*16)
    call SetTextColor
    mov dl,xPos
    mov dh,yPos
    call Gotoxy
    mov al,"X"
    call WriteChar
    ret
DrawPlayer ENDP

DrawPlayer1 PROC
    mov eax,yellow
    call SetTextColor
    mov dl,xPos
    mov dh,yPos
    call Gotoxy
    mov al," "
    call WriteChar

    mov xPos , 5
    mov yPos , 20
    mov dl,xPos
    mov dh,yPos
    call Gotoxy
    mov al,"X"
    call WriteChar
    ret
DrawPlayer1 ENDP

UpdatePlayer PROC
    mov dl,xPos
    mov dh,yPos
    call Gotoxy
    mov al," "
    call WriteChar
    ret
UpdatePlayer ENDP

DrawGhost proc
    mov xg1Pos , 25
    mov dl , xg1Pos
    mov yg1Pos , 5
    mov dh , yg1Pos
    call Gotoxy
    mov al , "G"
    call writechar
    mov dl , xPos
    mov dh , yPos
    call Gotoxy
    ret
DrawGhost endp

DrawGhost2 proc
    mov xg2Pos , 25
    mov dl , xg2Pos
    mov yg2Pos , 5
    mov dh , yg2Pos
    call Gotoxy
    mov eax , red
    call setTextColor
    mov al , "G"
    call writechar
    mov dl , xPos
    mov dh , yPos
    call Gotoxy
    mov eax , white
    call setTextColor
    ret
DrawGhost2 endp

DrawGhost3 proc
    mov xg3Pos , 32
    mov dl , xg3Pos
    mov yg3Pos , 10
    mov dh , yg3Pos
    call Gotoxy
    mov eax , yellow
    call setTextColor
    mov al , "G"
    call writechar
    mov dl , xPos
    mov dh , yPos
    call Gotoxy
    mov eax , white
    call setTextColor
    ret
DrawGhost3 endp

DrawGhost4 proc
    mov xg4Pos , 46
    mov dl , xg4Pos
    mov yg4Pos , 19
    mov dh , yg4Pos
    call Gotoxy
    mov eax , red
    call setTextColor
    mov al , "G"
    call writechar
    mov dl , xPos
    mov dh , yPos
    call Gotoxy
    mov eax , white
    call setTextColor
    ret
DrawGhost4 endp

DrawGhost5 proc
    mov xg5Pos , 20
    mov dl , xg5Pos
    mov yg5Pos , 5
    mov dh , yg5Pos
    call Gotoxy
    mov eax , yellow
    call setTextColor
    mov al , "G"
    call writechar
    mov dl , xPos
    mov dh , yPos
    call Gotoxy
    mov eax , white
    call setTextColor
    ret
DrawGhost5 endp

DrawGhost6 proc
    mov xg6Pos , 8
    mov dl , xg6Pos
    mov yg6Pos , 27
    mov dh , yg6Pos
    call Gotoxy
    mov eax , green
    call setTextColor
    mov al , "G"
    call writechar
    mov dl , xPos
    mov dh , yPos
    call Gotoxy
    mov eax , white
    call setTextColor
    ret
DrawGhost6 endp

;------------------------------------- Ghost 1 Movement ---------------------------------------------------------
move_ghost_left proc
    call ghost_collision_check_with_coin
    cmp ghost_coin_collision_successful , 1
    je printing_coins
    mov al , " "
    jmp printing_space

    printing_coins:
    mov al , "."

    printing_space:
    mov dl , xg1Pos
    mov dh , yg1Pos
    call Gotoxy
    call writechar
    sub xg1Pos , 1
    mov dl , xg1Pos
    mov dh , yg1Pos
    call Gotoxy
    mov al , "G"
    call writechar
    returning_from_move_ghost_left:
    ret
move_ghost_left endp

move_ghost_right proc
    call ghost_collision_check_with_coin
    cmp ghost_coin_collision_successful , 1
    je printing_coins
    mov al , " "
    jmp printing_space

    printing_coins:
    mov al , "."

    printing_space:
    mov dl , xg1Pos
    mov dh , yg1Pos
    call Gotoxy
    call writechar
    add xg1Pos , 1
    mov dl , xg1Pos
    mov dh , yg1Pos
    call Gotoxy
    mov al , "G"
    call writechar
    returning_from_move_ghost_right:
    ret
move_ghost_right endp

move_ghost_up proc
    call ghost_collision_check_with_coin
    cmp ghost_coin_collision_successful , 1
    je printing_coins
    mov al , " "
    jmp printing_space

    printing_coins:
    mov al , "."

    printing_space:
    mov dl , xg1Pos
    mov dh , yg1Pos
    call Gotoxy
    call writechar
    sub yg1Pos , 1
    mov dl , xg1Pos
    mov dh , yg1Pos
    call Gotoxy
    mov al , "G"
    call writechar
    returning_from_move_ghost_up:
    ret
move_ghost_up endp

move_ghost_down proc
    call ghost_collision_check_with_coin
    cmp ghost_coin_collision_successful , 1
    je printing_coins
    mov al , " "
    jmp printing_space

    printing_coins:
    mov al , "."

    printing_space:
    mov dl , xg1Pos
    mov dh , yg1Pos
    call Gotoxy
    call writechar
    add yg1Pos , 1
    mov dl , xg1Pos
    mov dh , yg1Pos
    call Gotoxy
    mov al , "G"
    call writechar
    returning_from_move_ghost_down:
    ret
move_ghost_down endp

;-------------------------------------- Ghost 2 Movement ---------------------------------------------------------

move_ghost_left2 proc
    call ghost2_collision_check_with_coin
    cmp ghost_coin_collision_successful , 1
    je printing_coins
    mov al , " "
    jmp printing_space

    printing_coins:
    mov al , "."

    printing_space:
    mov dl , xg2Pos
    mov dh , yg2Pos
    call Gotoxy
    call writechar
    sub xg2Pos , 1
    mov dl , xg2Pos
    mov dh , yg2Pos
    call Gotoxy
    mov eax , red
    call setTextColor
    mov al , "G"
    call writechar
    returning_from_move_ghost_left:
    ret
move_ghost_left2 endp

move_ghost_right2 proc
    call ghost2_collision_check_with_coin
    cmp ghost_coin_collision_successful , 1
    je printing_coins
    mov al , " "
    jmp printing_space

    printing_coins:
    mov al , "."

    printing_space:
    mov dl , xg2Pos
    mov dh , yg2Pos
    call Gotoxy
    call writechar
    add xg2Pos , 1
    mov dl , xg2Pos
    mov dh , yg2Pos
    call Gotoxy
    mov eax , red
    call setTextColor
    mov al , "G"
    call writechar
    returning_from_move_ghost_right:
    ret
move_ghost_right2 endp

move_ghost_up2 proc
    call ghost2_collision_check_with_coin
    cmp ghost_coin_collision_successful , 1
    je printing_coins
    mov al , " "
    jmp printing_space

    printing_coins:
    mov al , "."

    printing_space:
    mov dl , xg2Pos
    mov dh , yg2Pos
    call Gotoxy
    call writechar
    sub yg2Pos , 1
    mov dl , xg2Pos
    mov dh , yg2Pos
    call Gotoxy
    mov eax , red
    call setTextColor
    mov al , "G"
    call writechar
    returning_from_move_ghost_up:
    ret
move_ghost_up2 endp

move_ghost_down2 proc
    call ghost2_collision_check_with_coin
    cmp ghost_coin_collision_successful , 1
    je printing_coins
    mov al , " "
    jmp printing_space

    printing_coins:
    mov al , "."

    printing_space:
    mov dl , xg2Pos
    mov dh , yg2Pos
    call Gotoxy
    call writechar
    add yg2Pos , 1
    mov dl , xg2Pos
    mov dh , yg2Pos
    call Gotoxy
    mov eax , red
    call setTextColor
    mov al , "G"
    call writechar
    returning_from_move_ghost_down:
    ret
move_ghost_down2 endp

;--------------------------- Ghost 3 Movement ---------------------------------------------------------

move_ghost_left3 proc
    call ghost3_collision_check_with_coin
    cmp ghost_coin_collision_successful , 1
    je printing_coins
    mov al , " "
    jmp printing_space

    printing_coins:
    mov eax , yellow
    call setTextColor
    mov al , "."

    printing_space:
    mov dl , xg3Pos
    mov dh , yg3Pos
    call Gotoxy
    call writechar
    sub xg3Pos , 1
    mov dl , xg3Pos
    mov dh , yg3Pos
    call Gotoxy
    mov eax , yellow
    call setTextColor
    mov al , "G"
    call writechar
    returning_from_move_ghost_left:
    ret
move_ghost_left3 endp

move_ghost_right3 proc
    call ghost3_collision_check_with_coin
    cmp ghost_coin_collision_successful , 1
    je printing_coins
    mov al , " "
    jmp printing_space

    printing_coins:
    mov eax , yellow
    call setTextColor
    mov al , "."

    printing_space:
    mov dl , xg3Pos
    mov dh , yg3Pos
    call Gotoxy
    call writechar
    add xg3Pos , 1
    mov dl , xg3Pos
    mov dh , yg3Pos
    call Gotoxy
    mov eax , yellow
    call setTextColor
    mov al , "G"
    call writechar
    returning_from_move_ghost_right:
    ret
move_ghost_right3 endp

move_ghost_up3 proc
    call ghost3_collision_check_with_coin
    cmp ghost_coin_collision_successful , 1
    je printing_coins
    mov al , " "
    jmp printing_space

    printing_coins:
    mov eax , yellow
    call setTextColor
    mov al , "."

    printing_space:
    mov dl , xg3Pos
    mov dh , yg3Pos
    call Gotoxy
    call writechar
    sub yg3Pos , 1
    mov dl , xg3Pos
    mov dh , yg3Pos
    call Gotoxy
    mov eax , yellow
    call setTextColor
    mov al , "G"
    call writechar
    returning_from_move_ghost_up:
    ret
move_ghost_up3 endp

move_ghost_down3 proc
    call ghost3_collision_check_with_coin
    cmp ghost_coin_collision_successful , 1
    je printing_coins
    mov al , " "
    jmp printing_space

    printing_coins:
    mov eax , yellow
    call setTextColor
    mov al , "."

    printing_space:
    mov dl , xg3Pos
    mov dh , yg3Pos
    call Gotoxy
    call writechar
    add yg3Pos , 1
    mov dl , xg3Pos
    mov dh , yg3Pos
    call Gotoxy
    mov eax , yellow
    call setTextColor
    mov al , "G"
    call writechar
    returning_from_move_ghost_down:
    ret
move_ghost_down3 endp

;--------------------------- Ghost 4 Movement ---------------------------------------------------------

move_ghost_left4 proc
    call ghost4_collision_check_with_coin
    cmp ghost_coin_collision_successful , 1
    je printing_coins
    mov al , " "
    jmp printing_space

    printing_coins:
    mov eax , yellow
    call setTextColor
    mov al , "."

    printing_space:
    mov dl , xg4Pos
    mov dh , yg4Pos
    call Gotoxy
    call writechar
    sub xg4Pos , 1
    mov dl , xg4Pos
    mov dh , yg4Pos
    call Gotoxy
    mov eax , red
    call setTextColor
    mov al , "G"
    call writechar
    returning_from_move_ghost_left:
    ret
move_ghost_left4 endp

move_ghost_right4 proc
    call ghost4_collision_check_with_coin
    cmp ghost_coin_collision_successful , 1
    je printing_coins
    mov al , " "
    jmp printing_space

    printing_coins:
    mov eax , yellow
    call setTextColor
    mov al , "."

    printing_space:
    mov dl , xg4Pos
    mov dh , yg4Pos
    call Gotoxy
    call writechar
    add xg4Pos , 1
    mov dl , xg4Pos
    mov dh , yg4Pos
    call Gotoxy
    mov eax , red
    call setTextColor
    mov al , "G"
    call writechar
    returning_from_move_ghost_right:
    ret
move_ghost_right4 endp

move_ghost_up4 proc
    call ghost4_collision_check_with_coin
    cmp ghost_coin_collision_successful , 1
    je printing_coins
    mov al , " "
    jmp printing_space

    printing_coins:
    mov eax , yellow
    call setTextColor
    mov al , "."

    printing_space:
    mov dl , xg4Pos
    mov dh , yg4Pos
    call Gotoxy
    call writechar
    sub yg4Pos , 1
    mov dl , xg4Pos
    mov dh , yg4Pos
    call Gotoxy
    mov eax , red
    call setTextColor
    mov al , "G"
    call writechar
    returning_from_move_ghost_up:
    ret
move_ghost_up4 endp

move_ghost_down4 proc
    call ghost4_collision_check_with_coin
    cmp ghost_coin_collision_successful , 1
    je printing_coins
    mov al , " "
    jmp printing_space

    printing_coins:
    mov eax , yellow
    call setTextColor
    mov al , "."

    printing_space:
    mov dl , xg4Pos
    mov dh , yg4Pos
    call Gotoxy
    call writechar
    add yg4Pos , 1
    mov dl , xg4Pos
    mov dh , yg4Pos
    call Gotoxy
    mov eax , red
    call setTextColor
    mov al , "G"
    call writechar
    returning_from_move_ghost_down:
    ret
move_ghost_down4 endp

;--------------------------- Ghost 5 Movement ---------------------------------------------------------

move_ghost_left5 proc
    call ghost5_collision_check_with_coin
    cmp ghost_coin_collision_successful , 1
    je printing_coins
    mov al , " "
    jmp printing_space

    printing_coins:
    mov eax , yellow
    call setTextColor
    mov al , "."

    printing_space:
    mov dl , xg5Pos
    mov dh , yg5Pos
    call Gotoxy
    call writechar
    sub xg5Pos , 1
    mov dl , xg5Pos
    mov dh , yg5Pos
    call Gotoxy
    mov eax , yellow
    call setTextColor
    mov al , "G"
    call writechar
    returning_from_move_ghost_left:
    ret
move_ghost_left5 endp

move_ghost_right5 proc
    call ghost5_collision_check_with_coin
    cmp ghost_coin_collision_successful , 1
    je printing_coins
    mov al , " "
    jmp printing_space

    printing_coins:
    mov eax , yellow
    call setTextColor
    mov al , "."

    printing_space:
    mov dl , xg5Pos
    mov dh , yg5Pos
    call Gotoxy
    call writechar
    add xg5Pos , 1
    mov dl , xg5Pos
    mov dh , yg5Pos
    call Gotoxy
    mov eax , yellow
    call setTextColor
    mov al , "G"
    call writechar
    returning_from_move_ghost_right:
    ret
move_ghost_right5 endp

move_ghost_up5 proc
    call ghost5_collision_check_with_coin
    cmp ghost_coin_collision_successful , 1
    je printing_coins
    mov al , " "
    jmp printing_space

    printing_coins:
    mov eax , yellow
    call setTextColor
    mov al , "."

    printing_space:
    mov dl , xg5Pos
    mov dh , yg5Pos
    call Gotoxy
    call writechar
    sub yg5Pos , 1
    mov dl , xg5Pos
    mov dh , yg5Pos
    call Gotoxy
    mov eax , yellow
    call setTextColor
    mov al , "G"
    call writechar
    returning_from_move_ghost_up:
    ret
move_ghost_up5 endp

move_ghost_down5 proc
    call ghost5_collision_check_with_coin
    cmp ghost_coin_collision_successful , 1
    je printing_coins
    mov al , " "
    jmp printing_space

    printing_coins:
    mov eax , yellow
    call setTextColor
    mov al , "."

    printing_space:
    mov dl , xg5Pos
    mov dh , yg5Pos
    call Gotoxy
    call writechar
    add yg5Pos , 1
    mov dl , xg5Pos
    mov dh , yg5Pos
    call Gotoxy
    mov eax , yellow
    call setTextColor
    mov al , "G"
    call writechar
    returning_from_move_ghost_down:
    ret
move_ghost_down5 endp

;--------------------------- Ghost 6 Movement ---------------------------------------------------------

move_ghost_left6 proc
    call ghost6_collision_check_with_coin
    cmp ghost_coin_collision_successful , 1
    je printing_coins
    mov al , " "
    jmp printing_space

    printing_coins:
    mov eax , yellow
    call setTextColor
    mov al , "."

    printing_space:
    mov dl , xg6Pos
    mov dh , yg6Pos
    call Gotoxy
    call writechar
    sub xg6Pos , 1
    mov dl , xg6Pos
    mov dh , yg6Pos
    call Gotoxy
    mov eax , green
    call setTextColor
    mov al , "G"
    call writechar
    returning_from_move_ghost_left:
    ret
move_ghost_left6 endp

move_ghost_right6 proc
    call ghost6_collision_check_with_coin
    cmp ghost_coin_collision_successful , 1
    je printing_coins
    mov al , " "
    jmp printing_space

    printing_coins:
    mov eax , yellow
    call setTextColor
    mov al , "."

    printing_space:
    mov dl , xg6Pos
    mov dh , yg6Pos
    call Gotoxy
    call writechar
    add xg6Pos , 1
    mov dl , xg6Pos
    mov dh , yg6Pos
    call Gotoxy
    mov eax , green
    call setTextColor
    mov al , "G"
    call writechar
    returning_from_move_ghost_right:
    ret
move_ghost_right6 endp

move_ghost_up6 proc
    call ghost6_collision_check_with_coin
    cmp ghost_coin_collision_successful , 1
    je printing_coins
    mov al , " "
    jmp printing_space

    printing_coins:
    mov eax , yellow
    call setTextColor
    mov al , "."

    printing_space:
    mov dl , xg6Pos
    mov dh , yg6Pos
    call Gotoxy
    call writechar
    sub yg6Pos , 1
    mov dl , xg6Pos
    mov dh , yg6Pos
    call Gotoxy
    mov eax , green
    call setTextColor
    mov al , "G"
    call writechar
    returning_from_move_ghost_up:
    ret
move_ghost_up6 endp

move_ghost_down6 proc
    call ghost6_collision_check_with_coin
    cmp ghost_coin_collision_successful , 1
    je printing_coins
    mov al , " "
    jmp printing_space

    printing_coins:
    mov eax , yellow
    call setTextColor
    mov al , "."

    printing_space:
    mov dl , xg6Pos
    mov dh , yg6Pos
    call Gotoxy
    call writechar
    add yg6Pos , 1
    mov dl , xg6Pos
    mov dh , yg6Pos
    call Gotoxy
    mov eax , green
    call setTextColor
    mov al , "G"
    call writechar
    returning_from_move_ghost_down:
    ret
move_ghost_down6 endp

;--------------------------- Drawing Coins on the screen ------------------------------------------------

DrawCoin PROC
    mov esi , offset xCoinPos
    mov edi , offset yCoinPos
    mov eax,yellow
    call SetTextColor
    mov ecx , 7
    mov dh , 2
    drawing_coins_lines:
        mov dl , 1
        mov len , ecx
        mov ecx , 30
        drawing_coins:
            mov [esi] , dl
            mov [edi] , dh
            inc esi
            inc edi
            call Gotoxy
            mov al , "."
            call WriteChar
            add dl , 4
        loop drawing_coins
        add dh , 4
        mov ecx , len
    loop drawing_coins_lines
    ret
DrawCoin ENDP

CreateRandomCoin PROC
    mov eax,55
    inc eax
    call RandomRange
    mov xCoinPos,al
    mov yCoinPos,27
    ret
CreateRandomCoin ENDP

remove_waitmsg PROC
    remove_this_msg:
        mov al," "
        call writechar
    loop remove_this_msg
    ret
remove_waitmsg ENDP

;------------------------------ Drawing Player Life ----------------------------------------------------

Drawlife PROC
    mov dl , 115
    mov dh , 0
    call Gotoxy
    mov eax , red
    call settextcolor
    mov al , 'L'
    call writechar
    call writechar
    call writechar
    ret
Drawlife ENDP

;------------------------------------------ Map 1 ----------------------------------------------------------

scenario2 proc
    mov score1 , 0
    mov check_scenario2 , 1
    mov eax,white(white * 16)
    call settextcolor
    mov esi , offset xarr
    mov edi , offset yarr
    mov dh , 4
    mov dl , 20
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    mov edx , offset horizontal
    call writestring

    inc esi
    inc edi
    mov dh , 4
    mov dl , 40
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    mov edx , offset horizontal
    call writestring

    inc esi
    inc edi
    mov dh , 4
    mov dl , 60
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    mov edx , offset horizontal
    call writestring

    inc esi
    inc edi
    mov dh , 4
    mov dl , 80
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    mov edx , offset horizontal
    call writestring

    inc esi
    inc edi
    mov dh , 4
    mov dl , 100
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    mov edx , offset horizontal
    call writestring

    inc esi
    inc edi
    mov dh , 26
    mov dl , 20
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    mov edx , offset horizontal
    call writestring

    inc esi
    inc edi
    mov dh , 26
    mov dl , 40
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    mov edx , offset horizontal
    call writestring

    inc esi
    inc edi
    mov dh , 26
    mov dl , 60
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    mov edx , offset horizontal
    call writestring

    inc esi
    inc edi
    mov dh , 26
    mov dl , 80
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    mov edx , offset horizontal
    call writestring

    inc esi
    inc edi
    mov dh , 26
    mov dl , 100
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    mov edx , offset horizontal
    call writestring

    inc esi
    inc edi
    mov dh,12
    mov dl,22
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    call Draw_verticle

    inc esi
    inc edi
    mov dh,7
    mov dl,32
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    call Draw_verticle

    inc esi
    inc edi
    mov dh,17
    mov dl,32
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    call Draw_verticle

    inc esi
    inc edi
    mov dh,7
    mov dl,62
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    call Draw_verticle

    inc esi
    inc edi
    mov dh,17
    mov dl,62
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    call Draw_verticle

    inc esi
    inc edi
    mov dh,7
    mov dl,92
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    call Draw_verticle

    inc esi
    inc edi
    mov dh,17
    mov dl,92
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    call Draw_verticle

    ret
scenario2 endp

;----------------------------------------------------- MAP 2 -----------------------------------------------------------
scenario3 proc
    mov score1 , 0
    mov check_scenario3 , 1
    mov eax,white(white * 16)
    call settextcolor
    mov esi , offset xarr
    mov edi , offset yarr
    mov dh , 9
    mov dl , 30
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    mov edx , offset horizontal1
    call writestring

    inc esi
    inc edi
    mov dh , 9
    mov dl , 80
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    mov edx , offset horizontal1
    call writestring

    inc esi
    inc edi
    mov dh , 19
    mov dl , 80
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    mov edx , offset horizontal1
    call writestring

    inc esi
    inc edi
    mov dh , 19
    mov dl , 30
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    mov edx , offset horizontal1
    call writestring

    inc esi
    inc edi
    mov dh , 4
    mov dl , 23
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    mov edx , offset horizontal1
    call writestring

    inc esi
    inc edi
    mov dh , 4
    mov dl , 88
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    mov edx , offset horizontal1
    call writestring

    inc esi
    inc edi
    mov dh , 24
    mov dl , 23
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    mov edx , offset horizontal1
    call writestring

    inc esi
    inc edi
    mov dh , 24
    mov dl , 88
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    mov edx , offset horizontal1
    call writestring

    inc esi
    inc edi
    mov dh , 7
    mov dl , 30
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    call Draw_verticle

    inc esi
    inc edi
    mov dh , 7
    mov dl , 90
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    call Draw_verticle

    inc esi
    inc edi
    mov dh , 17
    mov dl , 30
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    call Draw_verticle

    inc esi
    inc edi
    mov dh , 17
    mov dl , 90
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    call Draw_verticle

    inc esi
    inc edi
    mov dh , 19
    mov dl , 15
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    call Draw_verticle

    inc esi
    inc edi
    mov dh , 5
    mov dl , 15
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    call Draw_verticle

    inc esi
    inc edi
    mov dh , 5
    mov dl , 105
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    call Draw_verticle

    inc esi
    inc edi
    mov dh , 19
    mov dl , 105
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    call Draw_verticle

    inc esi
    inc edi
    mov dh , 12
    mov dl , 20
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    call Draw_verticle

    inc esi
    inc edi
    mov dh , 12
    mov dl , 100
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    call Draw_verticle

    ret
scenario3 endp

;------------------------------------------------ MAP 3 ------------------------------------------------------
scenario4 proc
    mov score1 , 0
    mov check_scenario4 , 1
    mov eax,white(white * 16)
    call settextcolor
    mov esi , offset xarr
    mov edi , offset yarr
    mov dh , 7
    mov dl , 45
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    mov edx , offset horizontal1
    call writestring

    inc esi
    inc edi
    mov dh , 7
    mov dl , 55
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    mov edx , offset horizontal1
    call writestring

    inc esi
    inc edi
    mov dh , 20
    mov dl , 45
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    mov edx , offset horizontal1
    call writestring

    inc esi
    inc edi
    mov dh , 20
    mov dl , 55
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    mov edx , offset horizontal1
    call writestring

    inc esi
    inc edi
    mov dh , 9
    mov dl , 34
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    mov edx , offset horizontal1
    call writestring

    inc esi
    inc edi
    mov dh , 18
    mov dl , 66
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    mov edx , offset horizontal1
    call writestring

    inc esi
    inc edi
    mov dh , 13
    mov dl , 50
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    call Draw_verticle

    inc esi
    inc edi
    mov dh , 9
    mov dl , 33
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    call Draw_verticle

    inc esi
    inc edi
    mov dh ,7
    mov dl , 44
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    call Draw_verticle

    inc esi
    inc edi
    mov dh , 16
    mov dl , 65
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    call Draw_verticle

    inc esi
    inc edi
    mov dh , 7
    mov dl , 65
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    call Draw_verticle

    inc esi
    inc edi
    mov dh , 16
    mov dl , 44
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    call Draw_verticle

    inc esi
    inc edi
    mov dh , 14
    mov dl , 76
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    call Draw_verticle

    inc esi
    inc edi
    mov dh , 11
    mov dl , 60
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    call Draw_verticle

    inc esi
    inc edi
    mov dh , 5
    mov dl , 105
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    call Draw_verticle

    inc esi
    inc edi
    mov dh , 19
    mov dl , 105
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    call Draw_verticle

    inc esi
    inc edi
    mov dh , 5
    mov dl , 13
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    call Draw_verticle

    inc esi
    inc edi
    mov dh , 19
    mov dl , 13
    mov [esi] , dl
    mov [edi] , dh
    call Gotoxy
    call Draw_verticle

    ret
scenario4 endp

Draw_verticle proc
    mov ecx , 5
    mov temp , dl
    mov temp1 , dh
    looping:
        mov edx , offset ground2
        call writestring
        mov dl , temp
        inc temp1
        mov dh , temp1
        call Gotoxy
    loop looping
    ret
Draw_verticle endp

;---------------------------------------- SCENARIO 1 COLLISION --------------------------------------------------------
collision_check_scenario1 proc
    mov collision_successful_up , 0
    mov collision_successful_right , 0
    mov collision_successful_left , 0
    mov collision_successful_down , 0
    mov esi , offset xarr
    mov edi , offset yarr
    mov ecx , 10
    scenario1_collision_check_up_horizontal:
        mov len , ecx
        mov ecx , 5
        mov al , xPos
        mov bl , yPos
        mov dh , [edi]
        add dh , 1
        cmp bl , dh
        jne end_of_scenario1_collision_check_up_horizontal
        mov dl , [esi]
        collision_check_up:
            cmp al , dl
            je map1_colliding_up
            inc dl
        loop collision_check_up
        end_of_scenario1_collision_check_up_horizontal:
        inc esi
        inc edi
        mov ecx , len
    loop scenario1_collision_check_up_horizontal
    
    mov ecx , 7
    scenario1_collision_check_up_vertical:
        mov al , xPos
        mov bl , yPos
        mov dh , [edi]
        add dh , 5
        cmp bl , dh
        jne end_of_scenario1_collision_check_up_verticle
        mov dl , [esi]
        cmp al , dl
        je map1_colliding_up
        end_of_scenario1_collision_check_up_verticle:
        inc esi
        inc edi
    loop scenario1_collision_check_up_vertical
    mov esi , offset xarr
    mov edi , offset yarr
    mov ecx , 10

    scenario1_collision_check_right_horizontal:
        mov al , xPos
        mov bl , yPos
        mov dh , [edi]
        cmp bl , dh
        jne end_of_scenario1_collision_check_right_horizontal
        mov dl , [esi]
        sub dl , 1
        cmp al , dl
        je map1_colliding_right
        end_of_scenario1_collision_check_right_horizontal:
        inc esi
        inc edi
    loop scenario1_collision_check_right_horizontal

    mov ecx , 7
    scenario1_collision_check_right_verticle:
        mov len , ecx
        mov ecx , 5
        mov al , xPos
        mov bl , yPos
        mov dl , [esi]
        sub dl , 1
        cmp al , dl
        jne end_of_scenario1_collision_check_right_verticle
        mov dh , [edi]
        collision_check_right:
            cmp bl , dh
            je map1_colliding_right
            inc dh
        loop collision_check_right
        end_of_scenario1_collision_check_right_verticle:
        inc esi
        inc edi
        mov ecx , len
    loop scenario1_collision_check_right_verticle

    mov ecx , 10
    mov esi , offset xarr
    mov edi , offset yarr
    scenario1_collision_check_left_horizontal:
        mov al , xPos
        mov bl , yPos
        mov dh , [edi]
        cmp bl , dh
        jne end_of_scenario1_collision_check_left_horizontal
        mov dl , [esi]
        add dl , 5
        cmp al , dl
        je map1_colliding_left
        end_of_scenario1_collision_check_left_horizontal:
        inc esi
        inc edi
    loop scenario1_collision_check_left_horizontal

    mov ecx , 7
    scenario1_collision_check_left_verticle:
        mov len , ecx
        mov ecx , 5
        mov al , xPos
        mov bl , yPos
        mov dl , [esi]
        add dl , 1
        cmp al , dl
        jne end_of_scenario1_collision_check_left_verticle
        mov dh , [edi]
        collision_check_left:
            cmp bl , dh
            je map1_colliding_left
            inc dh
        loop collision_check_left
        end_of_scenario1_collision_check_left_verticle:
        inc esi
        inc edi
        mov ecx , len
    loop scenario1_collision_check_left_verticle

    mov ecx , 10
    mov esi , offset xarr
    mov edi , offset yarr
    scenario1_collision_check_down_horizontal:
        mov len , ecx
        mov ecx , 5
        mov al , xPos
        mov bl , yPos
        mov dh , [edi]
        sub dh , 1
        cmp bl , dh
        jne end_of_scenario1_collision_check_down_horizontal
        mov dl , [esi]
        collision_check_down:
            cmp al , dl
            je map1_colliding_down
            inc dl
        loop collision_check_down
        end_of_scenario1_collision_check_down_horizontal:
        inc esi
        inc edi
        mov ecx , len
    loop scenario1_collision_check_down_horizontal

    mov ecx , 7
    scenario1_collision_check_down_vertical:
        mov al , xPos
        mov bl , yPos
        mov dh , [edi]
        sub dh , 1
        cmp bl , dh
        jne end_of_scenario1_collision_check_down_verticle
        mov dl , [esi]
        cmp al , dl
        je map1_colliding_down
        end_of_scenario1_collision_check_down_verticle:
        inc esi
        inc edi
    loop scenario1_collision_check_down_vertical

    jmp return_from_func
    map1_colliding_up:
    mov collision_successful_up , 1
    jmp return_from_func
    map1_colliding_right:
    mov collision_successful_right , 1
    jmp return_from_func
    map1_colliding_left:
    mov collision_successful_left , 1
    jmp return_from_func
    map1_colliding_down:
    mov collision_successful_down , 1
    jmp return_from_func
    return_from_func:
    ret
collision_check_scenario1 endp

;---------------------------------------- SCENARIO 2 COLLISION --------------------------------------------------------
collision_check_scenario2_up proc
    mov collision_successful_up , 0
    mov collision_successful_right , 0
    mov collision_successful_left , 0
    mov collision_successful_down , 0
    mov esi , offset xarr
    mov edi , offset yarr
    mov ecx , 8
    scenario1_collision_check_up_horizontal:
        mov len , ecx
        mov ecx , 10
        mov al , xPos
        mov bl , yPos
        mov dh , [edi]
        add dh , 1
        cmp bl , dh
        jne end_of_scenario1_collision_check_up_horizontal
        mov dl , [esi]
        collision_check_up:
            cmp al , dl
            je map1_colliding_up
            inc dl
        loop collision_check_up
        end_of_scenario1_collision_check_up_horizontal:
        inc esi
        inc edi
        mov ecx , len
    loop scenario1_collision_check_up_horizontal
    
    mov ecx , 10
    scenario1_collision_check_up_vertical:
        mov al , xPos
        mov bl , yPos
        mov dh , [edi]
        add dh , 5
        cmp bl , dh
        jne end_of_scenario1_collision_check_up_verticle
        mov dl , [esi]
        cmp al , dl
        je map1_colliding_up
        end_of_scenario1_collision_check_up_verticle:
        inc esi
        inc edi
    loop scenario1_collision_check_up_vertical

    jmp return_from_func
    map1_colliding_up:
    mov collision_successful_up , 1
    return_from_func:
    ret
collision_check_scenario2_up endp

collision_check_scenario2_left proc
    mov collision_successful_up , 0
    mov collision_successful_right , 0
    mov collision_successful_left , 0
    mov collision_successful_down , 0
    mov esi , offset xarr
    mov edi , offset yarr
    mov ecx , 8
    mov esi , offset xarr
    mov edi , offset yarr
    scenario1_collision_check_left_horizontal:
        mov al , xPos
        mov bl , yPos
        mov dh , [edi]
        cmp bl , dh
        jne end_of_scenario1_collision_check_left_horizontal
        mov dl , [esi]
        add dl , 10
        cmp al , dl
        je map1_colliding_left
        end_of_scenario1_collision_check_left_horizontal:
        inc esi
        inc edi
    loop scenario1_collision_check_left_horizontal

    mov ecx , 10
    scenario1_collision_check_left_verticle:
        mov len , ecx
        mov ecx , 5
        mov al , xPos
        mov bl , yPos
        mov dl , [esi]
        add dl , 1
        cmp al , dl
        jne end_of_scenario1_collision_check_left_verticle
        mov dh , [edi]
        collision_check_left:
            cmp bl , dh
            je map1_colliding_left
            inc dh
        loop collision_check_left
        end_of_scenario1_collision_check_left_verticle:
        inc esi
        inc edi
        mov ecx , len
    loop scenario1_collision_check_left_verticle
    jmp return_from_func
    map1_colliding_left:
    mov collision_successful_left , 1
    return_from_func:
    ret
collision_check_scenario2_left endp

collision_check_scenario2_right proc
    mov collision_successful_up , 0
    mov collision_successful_right , 0
    mov collision_successful_left , 0
    mov collision_successful_down , 0
    mov esi , offset xarr
    mov edi , offset yarr
    mov ecx , 8
    scenario1_collision_check_right_horizontal:
        mov al , xPos
        mov bl , yPos
        mov dh , [edi]
        cmp bl , dh
        jne end_of_scenario1_collision_check_right_horizontal
        mov dl , [esi]
        sub dl , 1
        cmp al , dl
        je map1_colliding_right
        end_of_scenario1_collision_check_right_horizontal:
        inc esi
        inc edi
    loop scenario1_collision_check_right_horizontal

    mov ecx , 10
    scenario1_collision_check_right_verticle:
        mov len , ecx
        mov ecx , 5
        mov al , xPos
        mov bl , yPos
        mov dl , [esi]
        sub dl , 1
        cmp al , dl
        jne end_of_scenario1_collision_check_right_verticle
        mov dh , [edi]
        collision_check_right:
            cmp bl , dh
            je map1_colliding_right
            inc dh
        loop collision_check_right
        end_of_scenario1_collision_check_right_verticle:
        inc esi
        inc edi
        mov ecx , len
    loop scenario1_collision_check_right_verticle
    jmp return_from_func
    map1_colliding_right:
    mov collision_successful_right , 1
    return_from_func:
    ret
collision_check_scenario2_right endp

collision_check_scenario2_down proc
    mov collision_successful_up , 0
    mov collision_successful_right , 0
    mov collision_successful_left , 0
    mov collision_successful_down , 0
    mov ecx , 8
    mov esi , offset xarr
    mov edi , offset yarr
    scenario1_collision_check_down_horizontal:
        mov len , ecx
        mov ecx , 10
        mov al , xPos
        mov bl , yPos
        mov dh , [edi]
        sub dh , 1
        cmp bl , dh
        jne end_of_scenario1_collision_check_down_horizontal
        mov dl , [esi]
        collision_check_down:
            cmp al , dl
            je map1_colliding_down
            inc dl
        loop collision_check_down
        end_of_scenario1_collision_check_down_horizontal:
        inc esi
        inc edi
        mov ecx , len
    loop scenario1_collision_check_down_horizontal

    mov ecx , 10
    scenario1_collision_check_down_vertical:
        mov al , xPos
        mov bl , yPos
        mov dh , [edi]
        sub dh , 1
        cmp bl , dh
        jne end_of_scenario1_collision_check_down_verticle
        mov dl , [esi]
        cmp al , dl
        je map1_colliding_down
        end_of_scenario1_collision_check_down_verticle:
        inc esi
        inc edi
    loop scenario1_collision_check_down_vertical
    jmp return_from_func
    map1_colliding_down:
    mov collision_successful_down , 1
    return_from_func:
    ret
collision_check_scenario2_down endp

;---------------------------------------- SCENARIO 3 COLLISION --------------------------------------------------------
collision_check_scenario3_up proc
    mov collision_successful_up , 0
    mov collision_successful_right , 0
    mov collision_successful_left , 0
    mov collision_successful_down , 0
    mov esi , offset xarr
    mov edi , offset yarr
    mov ecx , 6
    scenario1_collision_check_up_horizontal:
        mov len , ecx
        mov ecx , 10
        mov al , xPos
        mov bl , yPos
        mov dh , [edi]
        add dh , 1
        cmp bl , dh
        jne end_of_scenario1_collision_check_up_horizontal
        mov dl , [esi]
        collision_check_up:
            cmp al , dl
            je map1_colliding_up
            inc dl
        loop collision_check_up
        end_of_scenario1_collision_check_up_horizontal:
        inc esi
        inc edi
        mov ecx , len
    loop scenario1_collision_check_up_horizontal
    
    mov ecx , 12
    scenario1_collision_check_up_vertical:
        mov al , xPos
        mov bl , yPos
        mov dh , [edi]
        add dh , 5
        cmp bl , dh
        jne end_of_scenario1_collision_check_up_verticle
        mov dl , [esi]
        cmp al , dl
        je map1_colliding_up
        end_of_scenario1_collision_check_up_verticle:
        inc esi
        inc edi
    loop scenario1_collision_check_up_vertical

    jmp return_from_func
    map1_colliding_up:
    mov collision_successful_up , 1
    return_from_func:
    ret
collision_check_scenario3_up endp

collision_check_scenario3_left proc
    mov collision_successful_up , 0
    mov collision_successful_right , 0
    mov collision_successful_left , 0
    mov collision_successful_down , 0
    mov esi , offset xarr
    mov edi , offset yarr
    mov ecx , 6
    mov esi , offset xarr
    mov edi , offset yarr
    scenario1_collision_check_left_horizontal:
        mov al , xPos
        mov bl , yPos
        mov dh , [edi]
        cmp bl , dh
        jne end_of_scenario1_collision_check_left_horizontal
        mov dl , [esi]
        add dl , 10
        cmp al , dl
        je map1_colliding_left
        end_of_scenario1_collision_check_left_horizontal:
        inc esi
        inc edi
    loop scenario1_collision_check_left_horizontal

    mov ecx , 12
    scenario1_collision_check_left_verticle:
        mov len , ecx
        mov ecx , 5
        mov al , xPos
        mov bl , yPos
        mov dl , [esi]
        add dl , 1
        cmp al , dl
        jne end_of_scenario1_collision_check_left_verticle
        mov dh , [edi]
        collision_check_left:
            cmp bl , dh
            je map1_colliding_left
            inc dh
        loop collision_check_left
        end_of_scenario1_collision_check_left_verticle:
        inc esi
        inc edi
        mov ecx , len
    loop scenario1_collision_check_left_verticle
    jmp return_from_func
    map1_colliding_left:
    mov collision_successful_left , 1
    return_from_func:
    ret
collision_check_scenario3_left endp

collision_check_scenario3_right proc
    mov collision_successful_up , 0
    mov collision_successful_right , 0
    mov collision_successful_left , 0
    mov collision_successful_down , 0
    mov esi , offset xarr
    mov edi , offset yarr
    mov ecx , 6
    scenario1_collision_check_right_horizontal:
        mov al , xPos
        mov bl , yPos
        mov dh , [edi]
        cmp bl , dh
        jne end_of_scenario1_collision_check_right_horizontal
        mov dl , [esi]
        sub dl , 1
        cmp al , dl
        je map1_colliding_right
        end_of_scenario1_collision_check_right_horizontal:
        inc esi
        inc edi
    loop scenario1_collision_check_right_horizontal

    mov ecx , 12
    scenario1_collision_check_right_verticle:
        mov len , ecx
        mov ecx , 5
        mov al , xPos
        mov bl , yPos
        mov dl , [esi]
        sub dl , 1
        cmp al , dl
        jne end_of_scenario1_collision_check_right_verticle
        mov dh , [edi]
        collision_check_right:
            cmp bl , dh
            je map1_colliding_right
            inc dh
        loop collision_check_right
        end_of_scenario1_collision_check_right_verticle:
        inc esi
        inc edi
        mov ecx , len
    loop scenario1_collision_check_right_verticle
    jmp return_from_func
    map1_colliding_right:
    mov collision_successful_right , 1
    return_from_func:
    ret
collision_check_scenario3_right endp

collision_check_scenario3_down proc
    mov collision_successful_up , 0
    mov collision_successful_right , 0
    mov collision_successful_left , 0
    mov collision_successful_down , 0
    mov ecx , 6
    mov esi , offset xarr
    mov edi , offset yarr
    scenario1_collision_check_down_horizontal:
        mov len , ecx
        mov ecx , 10
        mov al , xPos
        mov bl , yPos
        mov dh , [edi]
        sub dh , 1
        cmp bl , dh
        jne end_of_scenario1_collision_check_down_horizontal
        mov dl , [esi]
        collision_check_down:
            cmp al , dl
            je map1_colliding_down
            inc dl
        loop collision_check_down
        end_of_scenario1_collision_check_down_horizontal:
        inc esi
        inc edi
        mov ecx , len
    loop scenario1_collision_check_down_horizontal

    mov ecx , 12
    scenario1_collision_check_down_vertical:
        mov al , xPos
        mov bl , yPos
        mov dh , [edi]
        sub dh , 1
        cmp bl , dh
        jne end_of_scenario1_collision_check_down_verticle
        mov dl , [esi]
        cmp al , dl
        je map1_colliding_down
        end_of_scenario1_collision_check_down_verticle:
        inc esi
        inc edi
    loop scenario1_collision_check_down_vertical
    jmp return_from_func
    map1_colliding_down:
    mov collision_successful_down , 1
    return_from_func:
    ret
collision_check_scenario3_down endp

Ghost_collision_check_scenario1 proc
    mov ghost_collision_successful_up , 0
    mov ghost_collision_successful_right , 0
    mov ghost_collision_successful_left , 0
    mov ghost_collision_successful_down , 0
    mov esi , offset xarr
    mov edi , offset yarr
    mov ecx , 10
    scenario1_Ghost_collision_check_up_horizontal:
        mov len , ecx
        mov ecx , 5
        mov al , xg1Pos
        mov bl , yg1Pos
        mov dh , [edi]
        add dh , 1
        cmp bl , dh
        jne end_of_scenario1_Ghost_collision_check_up_horizontal
        mov dl , [esi]
        Ghost_collision_check_up:
            cmp al , dl
            je map1_Ghost_colliding_up
            inc dl
        loop Ghost_collision_check_up
        end_of_scenario1_Ghost_collision_check_up_horizontal:
        inc esi
        inc edi
        mov ecx , len
    loop scenario1_Ghost_collision_check_up_horizontal
    
    mov ecx , 7
    scenario1_Ghost_collision_check_up_vertical:
        mov al , xg1Pos
        mov bl , yg1Pos
        mov dh , [edi]
        add dh , 5
        cmp bl , dh
        jne end_of_scenario1_Ghost_collision_check_up_verticle
        mov dl , [esi]
        cmp al , dl
        je map1_Ghost_colliding_up
        end_of_scenario1_Ghost_collision_check_up_verticle:
        inc esi
        inc edi
    loop scenario1_Ghost_collision_check_up_vertical
    mov esi , offset xarr
    mov edi , offset yarr
    mov ecx , 10

    scenario1_Ghost_collision_check_right_horizontal:
        mov al , xg1Pos
        mov bl , yg1Pos
        mov dh , [edi]
        cmp bl , dh
        jne end_of_scenario1_Ghost_collision_check_right_horizontal
        mov dl , [esi]
        sub dl , 1
        cmp al , dl
        je map1_Ghost_colliding_right
        end_of_scenario1_Ghost_collision_check_right_horizontal:
        inc esi
        inc edi
    loop scenario1_Ghost_collision_check_right_horizontal

    mov ecx , 7
    scenario1_Ghost_collision_check_right_verticle:
        mov len , ecx
        mov ecx , 5
        mov al , xg1Pos
        mov bl , yg1Pos
        mov dl , [esi]
        sub dl , 1
        cmp al , dl
        jne end_of_scenario1_Ghost_collision_check_right_verticle
        mov dh , [edi]
        Ghost_collision_check_right:
            cmp bl , dh
            je map1_Ghost_colliding_right
            inc dh
        loop Ghost_collision_check_right
        end_of_scenario1_Ghost_collision_check_right_verticle:
        inc esi
        inc edi
        mov ecx , len
    loop scenario1_Ghost_collision_check_right_verticle

    mov ecx , 10
    mov esi , offset xarr
    mov edi , offset yarr
    scenario1_Ghost_collision_check_left_horizontal:
        mov al , xg1Pos
        mov bl , yg1Pos
        mov dh , [edi]
        cmp bl , dh
        jne end_of_scenario1_Ghost_collision_check_left_horizontal
        mov dl , [esi]
        add dl , 5
        cmp al , dl
        je map1_Ghost_colliding_left
        end_of_scenario1_Ghost_collision_check_left_horizontal:
        inc esi
        inc edi
    loop scenario1_Ghost_collision_check_left_horizontal

    mov ecx , 7
    scenario1_Ghost_collision_check_left_verticle:
        mov len , ecx
        mov ecx , 5
        mov al , xg1Pos
        mov bl , yg1Pos
        mov dl , [esi]
        add dl , 1
        cmp al , dl
        jne end_of_scenario1_Ghost_collision_check_left_verticle
        mov dh , [edi]
        Ghost_collision_check_left:
            cmp bl , dh
            je map1_Ghost_colliding_left
            inc dh
        loop Ghost_collision_check_left
        end_of_scenario1_Ghost_collision_check_left_verticle:
        inc esi
        inc edi
        mov ecx , len
    loop scenario1_Ghost_collision_check_left_verticle

    mov ecx , 10
    mov esi , offset xarr
    mov edi , offset yarr
    scenario1_Ghost_collision_check_down_horizontal:
        mov len , ecx
        mov ecx , 5
        mov al , xg1Pos
        mov bl , yg1Pos
        mov dh , [edi]
        sub dh , 1
        cmp bl , dh
        jne end_of_scenario1_Ghost_collision_check_down_horizontal
        mov dl , [esi]
        Ghost_collision_check_down:
            cmp al , dl
            je map1_Ghost_colliding_down
            inc dl
        loop Ghost_collision_check_down
        end_of_scenario1_Ghost_collision_check_down_horizontal:
        inc esi
        inc edi
        mov ecx , len
    loop scenario1_Ghost_collision_check_down_horizontal

    mov ecx , 7
    scenario1_Ghost_collision_check_down_vertical:
        mov al , xg1Pos
        mov bl , yg1Pos
        mov dh , [edi]
        sub dh , 1
        cmp bl , dh
        jne end_of_scenario1_Ghost_collision_check_down_verticle
        mov dl , [esi]
        cmp al , dl
        je map1_Ghost_colliding_down
        end_of_scenario1_Ghost_collision_check_down_verticle:
        inc esi
        inc edi
    loop scenario1_Ghost_collision_check_down_vertical

    jmp return_from_Ghostfunc
    map1_Ghost_colliding_up:
    mov Ghost_collision_successful_up , 1
    jmp return_from_Ghostfunc
    map1_Ghost_colliding_right:
    mov Ghost_collision_successful_right , 1
    jmp return_from_Ghostfunc
    map1_Ghost_colliding_left:
    mov Ghost_collision_successful_left , 1
    jmp return_from_Ghostfunc
    map1_Ghost_colliding_down:
    mov Ghost_collision_successful_down , 1
    jmp return_from_Ghostfunc
    return_from_Ghostfunc:
    ret
Ghost_collision_check_scenario1 endp

collision_check_with_coin proc
    mov ecx , 210
    mov esi , offset xCoinPos
    mov edi , offset yCoinPos
    collision_check_with_coin_x:
        mov al , [esi]
        mov bl , [edi]
        cmp xPos , al
        jne loop_again_from_collision_check_with_coin_x
        cmp yPos , bl
        je collide_coin
        loop_again_from_collision_check_with_coin_x:
        inc esi
        inc edi
    loop collision_check_with_coin_x
    jmp returning_collision_check_with_coin
    collide_coin:
    call check_coins_eaten
    cmp is_coin_eaten , 1
    je returning_collision_check_with_coin
    inc score
    INVOKE PlaySound,OFFSET SoundFile,NULL,11h
    inc score1
    mov al , xPos
    mov bl , yPos
    mov esi , offset xEaten
    mov edi , offset yEaten
    mov edx , ind1
    mov [esi + edx] , al
    mov [edi + edx] , bl
    inc ind1
    returning_collision_check_with_coin:
    ret
collision_check_with_coin endp

check_coins_eaten proc
    mov is_coin_eaten , 0
    mov esi , offset xEaten
    mov edi , offset yEaten
    mov al , xPos
    mov bl , yPos
    mov ecx , 210
    check_coins_eaten_l1:
        cmp [esi] , al
        jne loop_again_check_coins_eaten
        cmp [edi] , bl
        je coin_is_eaten
        loop_again_check_coins_eaten:
        inc esi
        inc edi
    loop check_coins_eaten_l1
    mov ind2 , 0
    jmp returning_from_check_coins_eaten
    coin_is_eaten:
    mov is_coin_eaten , 1
    returning_from_check_coins_eaten:
    ret
check_coins_eaten endp

reset_coins_eaten proc
    mov esi , offset xEaten
    mov edi , offset yEaten
    mov ecx , 210
    mov al , 0
    reset_l1:
        mov [esi] , al
        mov [edi] , al
        inc esi
        inc edi
    loop reset_l1
    ret
reset_coins_eaten endp

;--------------------------- Ghost 1 Collision with coins -----------------------------------------------

ghost_collision_check_with_coin proc
    mov ghost_coin_collision_successful , 0
    mov ghost_coin_collision_successful_up , 0
    mov ghost_coin_collision_successful_down , 0
    mov ghost_coin_collision_successful_left , 0
    mov ghost_coin_collision_successful_right , 0
    mov ecx , 210
    mov esi , offset xCoinPos
    mov edi , offset yCoinPos
    ghost_collision_check_with_coin_x:
        mov al , [esi]
        mov bl , [edi]
        cmp xg1Pos , al
        jne loop_again_from_ghost_collision_check_with_coin_x
        cmp yg1Pos , bl
        je ghost_check_collide_coin
        loop_again_from_ghost_collision_check_with_coin_x:
        inc esi
        inc edi
    loop ghost_collision_check_with_coin_x
    jmp returning_from_ghost_collision_check_with_coin

    ghost_check_collide_coin:
    mov ghost_coin_collision_successful , 1
    call ghost_check_coins_eaten
    cmp is_coin_eaten , 1
    jne returning_from_ghost_collision_check_with_coin
    mov ghost_coin_collision_successful , 0

    returning_from_ghost_collision_check_with_coin:
    ret
ghost_collision_check_with_coin endp

ghost_check_coins_eaten proc
    mov is_coin_eaten , 0
    mov esi , offset xEaten
    mov edi , offset yEaten
    mov al , xg1Pos
    mov bl , yg1Pos
    mov ecx , 210
    check_coins_eaten_l1:
        cmp [esi] , al
        jne loop_again_check_coins_eaten
        cmp [edi] , bl
        je coin_is_eaten
        loop_again_check_coins_eaten:
        inc esi
        inc edi
    loop check_coins_eaten_l1
    mov ind2 , 0
    jmp returning_from_check_coins_eaten
    coin_is_eaten:
    mov is_coin_eaten , 1
    returning_from_check_coins_eaten:
    ret
ghost_check_coins_eaten endp

;--------------------------- Ghost 2 Collision with coins -----------------------------------------------
ghost2_collision_check_with_coin proc
    mov ghost_coin_collision_successful , 0
    mov ghost_coin_collision_successful_up , 0
    mov ghost_coin_collision_successful_down , 0
    mov ghost_coin_collision_successful_left , 0
    mov ghost_coin_collision_successful_right , 0
    mov ecx , 210
    mov esi , offset xCoinPos
    mov edi , offset yCoinPos
    ghost_collision_check_with_coin_x:
        mov al , [esi]
        mov bl , [edi]
        cmp xg2Pos , al
        jne loop_again_from_ghost_collision_check_with_coin_x
        cmp yg2Pos , bl
        je ghost_check_collide_coin
        loop_again_from_ghost_collision_check_with_coin_x:
        inc esi
        inc edi
    loop ghost_collision_check_with_coin_x
    jmp returning_from_ghost_collision_check_with_coin

    ghost_check_collide_coin:
    mov ghost_coin_collision_successful , 1
    call ghost2_check_coins_eaten
    cmp is_coin_eaten , 1
    jne returning_from_ghost_collision_check_with_coin
    mov ghost_coin_collision_successful , 0

    returning_from_ghost_collision_check_with_coin:
    ret
ghost2_collision_check_with_coin endp

ghost2_check_coins_eaten proc
    mov is_coin_eaten , 0
    mov esi , offset xEaten
    mov edi , offset yEaten
    mov al , xg2Pos
    mov bl , yg2Pos
    mov ecx , 210
    check_coins_eaten_l1:
        cmp [esi] , al
        jne loop_again_check_coins_eaten
        cmp [edi] , bl
        je coin_is_eaten
        loop_again_check_coins_eaten:
        inc esi
        inc edi
    loop check_coins_eaten_l1
    mov ind2 , 0
    jmp returning_from_check_coins_eaten
    coin_is_eaten:
    mov is_coin_eaten , 1
    returning_from_check_coins_eaten:
    ret
ghost2_check_coins_eaten endp

;--------------------------- Ghost 3 Collision with coins -----------------------------------------------
ghost3_collision_check_with_coin proc
    mov ghost_coin_collision_successful , 0
    mov ecx , 210
    mov esi , offset xCoinPos
    mov edi , offset yCoinPos
    ghost_collision_check_with_coin_x:
        mov al , [esi]
        mov bl , [edi]
        cmp xg3Pos , al
        jne loop_again_from_ghost_collision_check_with_coin_x
        cmp yg3Pos , bl
        je ghost_check_collide_coin
        loop_again_from_ghost_collision_check_with_coin_x:
        inc esi
        inc edi
    loop ghost_collision_check_with_coin_x
    jmp returning_from_ghost_collision_check_with_coin

    ghost_check_collide_coin:
    mov ghost_coin_collision_successful , 1
    call ghost3_check_coins_eaten
    cmp is_coin_eaten , 1
    jne returning_from_ghost_collision_check_with_coin
    mov ghost_coin_collision_successful , 0

    returning_from_ghost_collision_check_with_coin:
    ret
ghost3_collision_check_with_coin endp

ghost3_check_coins_eaten proc
    mov is_coin_eaten , 0
    mov esi , offset xEaten
    mov edi , offset yEaten
    mov al , xg3Pos
    mov bl , yg3Pos
    mov ecx , 210
    check_coins_eaten_l1:
        cmp [esi] , al
        jne loop_again_check_coins_eaten
        cmp [edi] , bl
        je coin_is_eaten
        loop_again_check_coins_eaten:
        inc esi
        inc edi
    loop check_coins_eaten_l1
    mov ind2 , 0
    jmp returning_from_check_coins_eaten
    coin_is_eaten:
    mov is_coin_eaten , 1
    returning_from_check_coins_eaten:
    ret
ghost3_check_coins_eaten endp

;--------------------------- Ghost 4 Collision with coins -----------------------------------------------
ghost4_collision_check_with_coin proc
    mov ghost_coin_collision_successful , 0
    mov ecx , 210
    mov esi , offset xCoinPos
    mov edi , offset yCoinPos
    ghost_collision_check_with_coin_x:
        mov al , [esi]
        mov bl , [edi]
        cmp xg4Pos , al
        jne loop_again_from_ghost_collision_check_with_coin_x
        cmp yg4Pos , bl
        je ghost_check_collide_coin
        loop_again_from_ghost_collision_check_with_coin_x:
        inc esi
        inc edi
    loop ghost_collision_check_with_coin_x
    jmp returning_from_ghost_collision_check_with_coin

    ghost_check_collide_coin:
    mov ghost_coin_collision_successful , 1
    call ghost4_check_coins_eaten
    cmp is_coin_eaten , 1
    jne returning_from_ghost_collision_check_with_coin
    mov ghost_coin_collision_successful , 0

    returning_from_ghost_collision_check_with_coin:
    ret
ghost4_collision_check_with_coin endp

ghost4_check_coins_eaten proc
    mov is_coin_eaten , 0
    mov esi , offset xEaten
    mov edi , offset yEaten
    mov al , xg4Pos
    mov bl , yg4Pos
    mov ecx , 210
    check_coins_eaten_l1:
        cmp [esi] , al
        jne loop_again_check_coins_eaten
        cmp [edi] , bl
        je coin_is_eaten
        loop_again_check_coins_eaten:
        inc esi
        inc edi
    loop check_coins_eaten_l1
    mov ind2 , 0
    jmp returning_from_check_coins_eaten
    coin_is_eaten:
    mov is_coin_eaten , 1
    returning_from_check_coins_eaten:
    ret
ghost4_check_coins_eaten endp

;--------------------------- Ghost 5 Collision with coins -----------------------------------------------
ghost5_collision_check_with_coin proc
    mov ghost_coin_collision_successful , 0
    mov ecx , 210
    mov esi , offset xCoinPos
    mov edi , offset yCoinPos
    ghost_collision_check_with_coin_x:
        mov al , [esi]
        mov bl , [edi]
        cmp xg5Pos , al
        jne loop_again_from_ghost_collision_check_with_coin_x
        cmp yg5Pos , bl
        je ghost_check_collide_coin
        loop_again_from_ghost_collision_check_with_coin_x:
        inc esi
        inc edi
    loop ghost_collision_check_with_coin_x
    jmp returning_from_ghost_collision_check_with_coin

    ghost_check_collide_coin:
    mov ghost_coin_collision_successful , 1
    call ghost5_check_coins_eaten
    cmp is_coin_eaten , 1
    jne returning_from_ghost_collision_check_with_coin
    mov ghost_coin_collision_successful , 0

    returning_from_ghost_collision_check_with_coin:
    ret
ghost5_collision_check_with_coin endp

ghost5_check_coins_eaten proc
    mov is_coin_eaten , 0
    mov esi , offset xEaten
    mov edi , offset yEaten
    mov al , xg5Pos
    mov bl , yg5Pos
    mov ecx , 210
    check_coins_eaten_l1:
        cmp [esi] , al
        jne loop_again_check_coins_eaten
        cmp [edi] , bl
        je coin_is_eaten
        loop_again_check_coins_eaten:
        inc esi
        inc edi
    loop check_coins_eaten_l1
    mov ind2 , 0
    jmp returning_from_check_coins_eaten
    coin_is_eaten:
    mov is_coin_eaten , 1
    returning_from_check_coins_eaten:
    ret
ghost5_check_coins_eaten endp

;--------------------------- Ghost 6 Collision with coins -----------------------------------------------
ghost6_collision_check_with_coin proc
    mov ghost_coin_collision_successful , 0
    mov ecx , 210
    mov esi , offset xCoinPos
    mov edi , offset yCoinPos
    ghost_collision_check_with_coin_x:
        mov al , [esi]
        mov bl , [edi]
        cmp xg6Pos , al
        jne loop_again_from_ghost_collision_check_with_coin_x
        cmp yg6Pos , bl
        je ghost_check_collide_coin
        loop_again_from_ghost_collision_check_with_coin_x:
        inc esi
        inc edi
    loop ghost_collision_check_with_coin_x
    jmp returning_from_ghost_collision_check_with_coin

    ghost_check_collide_coin:
    mov ghost_coin_collision_successful , 1
    call ghost6_check_coins_eaten
    cmp is_coin_eaten , 1
    jne returning_from_ghost_collision_check_with_coin
    mov ghost_coin_collision_successful , 0

    returning_from_ghost_collision_check_with_coin:
    ret
ghost6_collision_check_with_coin endp

ghost6_check_coins_eaten proc
    mov is_coin_eaten , 0
    mov esi , offset xEaten
    mov edi , offset yEaten
    mov al , xg6Pos
    mov bl , yg6Pos
    mov ecx , 210
    check_coins_eaten_l1:
        cmp [esi] , al
        jne loop_again_check_coins_eaten
        cmp [edi] , bl
        je coin_is_eaten
        loop_again_check_coins_eaten:
        inc esi
        inc edi
    loop check_coins_eaten_l1
    mov ind2 , 0
    jmp returning_from_check_coins_eaten
    coin_is_eaten:
    mov is_coin_eaten , 1
    returning_from_check_coins_eaten:
    ret
ghost6_check_coins_eaten endp

collision_handle_down proc
    mov dl , xg1Pos
    mov dh , yg1Pos
    call Gotoxy
    mov al , "."
    call writechar
    add yg1Pos , 1
    ret
collision_handle_down endp

collision_handle_up proc
    mov dl , xg1Pos
    mov dh , yg1Pos
    call Gotoxy
    mov al , "."
    call writechar
    sub yg1Pos , 1
    ret
collision_handle_up endp

;------------------------------------ Player And Ghost1 Collision --------------------------------------------------------
player_ghost_collision proc
    mov al , xg1Pos
    mov bl , yg1Pos
    cmp xPos , al
    jne returning_from_player_ghost_collision
    cmp yPos , bl
    jne returning_from_player_ghost_collision
    mov player_destroyed , 1
    sub lives_counter , 1
    call remove_life
    returning_from_player_ghost_collision:
    ret
player_ghost_collision endp

;------------------------------------ Player And Ghost2 Collision --------------------------------------------------------
player_ghost2_collision proc
    mov al , xg2Pos
    mov bl , yg2Pos
    cmp xPos , al
    jne returning_from_player_ghost_collision
    cmp yPos , bl
    jne returning_from_player_ghost_collision
    mov player_destroyed , 1
    sub lives_counter , 1
    call remove_life
    returning_from_player_ghost_collision:
    ret
player_ghost2_collision endp

;------------------------------------ Player And Ghost3 Collision --------------------------------------------------------
player_ghost3_collision proc
    mov al , xg3Pos
    mov bl , yg3Pos
    cmp xPos , al
    jne returning_from_player_ghost_collision
    cmp yPos , bl
    jne returning_from_player_ghost_collision
    mov player_destroyed , 1
    sub lives_counter , 1
    call remove_life
    returning_from_player_ghost_collision:
    ret
player_ghost3_collision endp

;------------------------------------ Player And Ghost4 Collision --------------------------------------------------------
player_ghost4_collision proc
    mov al , xg4Pos
    mov bl , yg4Pos
    cmp xPos , al
    jne returning_from_player_ghost_collision
    cmp yPos , bl
    jne returning_from_player_ghost_collision
    mov player_destroyed , 1
    sub lives_counter , 1
    call remove_life
    returning_from_player_ghost_collision:
    ret
player_ghost4_collision endp

;------------------------------------ Player And Ghost5 Collision --------------------------------------------------------
player_ghost5_collision proc
    mov al , xg5Pos
    mov bl , yg5Pos
    cmp xPos , al
    jne returning_from_player_ghost_collision
    cmp yPos , bl
    jne returning_from_player_ghost_collision
    mov player_destroyed , 1
    sub lives_counter , 1
    call remove_life
    returning_from_player_ghost_collision:
    ret
player_ghost5_collision endp

;------------------------------------ Player And Ghost6 Collision --------------------------------------------------------
player_ghost6_collision proc
    mov al , xg6Pos
    mov bl , yg6Pos
    cmp xPos , al
    jne returning_from_player_ghost_collision
    cmp yPos , bl
    jne returning_from_player_ghost_collision
    mov player_destroyed , 1
    sub lives_counter , 1
    call remove_life
    returning_from_player_ghost_collision:
    ret
player_ghost6_collision endp

remove_life proc
    mov dh , 0
    mov dl , life_coor
    call Gotoxy
    mov al , " "
    call writechar
    add life_coor , 1
    ret
remove_life endp


;-------------------------------------------- Player Respawn -------------------------------------------------
player_respawn proc
    mov xPos , 5
    mov yPos , 20
    mov dl , xPos
    mov dh , yPos
    call Gotoxy
    mov al , "X"
    call writechar
    ret
player_respawn endp

Game_Over proc
    call clrscr
    mov dl , 40
    mov dh , 14
    call Gotoxy
    mov edx , offset prompt_gameover
    call writestring
    call crlf
    mov dl , 40
    mov dh , 15
    call Gotoxy
    call waitmsg
    mov gover , 1
    ret
Game_Over endp

Win_msg proc
    call clrscr
    mov dl , 40
    mov dh , 14
    call Gotoxy
    mov edx , offset prompt_win
    call writestring
    mov dl , 40
    mov dh , 15
    call Gotoxy
    mov edx , offset Final_score
    call writestring
    mov eax , 0
    mov al , byte ptr score
    call writeint
    mov dl , 40
    mov dh , 16
    call Gotoxy
    call waitmsg
    mov gover , 1
    ret
Win_msg endp

scenario2_level_completed proc
    cmp score1 , 205
    jne returning_from_scenario2_level_completed
    inc levels
    mov level1 , 1
    call clrscr
    mov dl , 55
    mov dh , 13
    call Gotoxy

    cmp levels , 1
    je level1_completed

    cmp levels , 2
    je level2_completed

    cmp levels , 3
    je level3_completed

    jmp ovr_level_completed

    level1_completed:
    mov edx , offset prompt_level1_completed
    jmp ovr_level_completed

    level2_completed:
    mov edx , offset prompt_level2_completed
    jmp ovr_level_completed

    level3_completed:
    mov edx , offset prompt_level3_completed
    jmp ovr_level_completed

    ovr_level_completed:
    call writestring
    mov dl , 55
    mov dh , 14
    call Gotoxy
    call waitmsg
    mov dl , 60
    mov dh , 14
    call Gotoxy
    mov ecx , 28
    call remove_waitmsg
    call reset_coins_eaten
    returning_from_scenario2_level_completed:
    ret
scenario2_level_completed endp

scenario3_level_completed proc
    cmp score1 , 208
    jne returning_from_scenario2_level_completed
    inc levels
    mov level2 , 1
    call clrscr
    mov dl , 55
    mov dh , 13
    call Gotoxy

    cmp levels , 1
    je level1_completed

    cmp levels , 2
    je level2_completed

    cmp levels , 3
    je level3_completed

    jmp ovr_level_completed

    level1_completed:
    mov edx , offset prompt_level1_completed
    jmp ovr_level_completed

    level2_completed:
    mov edx , offset prompt_level2_completed
    jmp ovr_level_completed

    level3_completed:
    mov edx , offset prompt_level3_completed
    jmp ovr_level_completed

    ovr_level_completed:
    call writestring
    mov dl , 55
    mov dh , 14
    call Gotoxy
    call waitmsg
    mov dl , 55
    mov dh , 14
    call Gotoxy
    mov ecx , 28
    call remove_waitmsg
    call reset_coins_eaten
    returning_from_scenario2_level_completed:
    ret
scenario3_level_completed endp

scenario4_level_completed proc
    cmp score1 , 201
    jne returning_from_scenario2_level_completed
    inc levels
    mov level3 , 1
    call clrscr
    mov dl , 55
    mov dh , 13
    call Gotoxy

    cmp levels , 1
    je level1_completed

    cmp levels , 2
    je level2_completed

    cmp levels , 3
    je level3_completed

    jmp ovr_level_completed

    level1_completed:
    mov edx , offset prompt_level1_completed
    jmp ovr_level_completed

    level2_completed:
    mov edx , offset prompt_level2_completed
    jmp ovr_level_completed

    level3_completed:
    mov edx , offset prompt_level3_completed
    jmp ovr_level_completed

    ovr_level_completed:
    call writestring
    mov dl , 55
    mov dh , 14
    call Gotoxy
    call waitmsg
    mov dl , 55
    mov dh , 14
    call Gotoxy
    mov ecx , 28
    call remove_waitmsg
    call reset_coins_eaten
    returning_from_scenario2_level_completed:
    ret
scenario4_level_completed endp

;-------------------------------------------- Path 1 for scenario 1 -------------------------------------------------
path1 proc
        cmp ghost_bright , 1
        je check_ghost_collision_down
        check_ghost_collision_right:
        cmp xg1Pos , 105
        je path1_right
        call move_ghost_right
        jmp onGround

        check_ghost_collision_down:
        cmp ghost_bdown , 1
        je check_ghost_collision_left
        cmp yg1Pos , 25
        je path1_down
        call move_ghost_down
        jmp onGround

        check_ghost_collision_left:
        cmp ghost_bleft , 1
        je check_ghost_collision_up
        cmp xg1Pos , 25
        je path1_left
        call move_ghost_left
        jmp onGround

        check_ghost_collision_up:
        cmp yg1Pos , 5
        je path1_up
        call move_ghost_up
        jmp onGround

        path1_right:
        mov ghost_bright , 1
        jmp onGround

        path1_down:
        mov ghost_bdown , 1
        jmp onGround

        path1_left:
        mov ghost_bleft , 1
        jmp onGround

        path1_up:
        mov ghost_bright , 0
        mov ghost_bleft , 0
        mov ghost_bdown , 0

        onGround:
    ret
path1 endp

;-------------------------------------------- Path 2 for scenario 2 -------------------------------------------------
path2 proc
        cmp ghost2_bdown , 1
        je check_ghost_collision_right
        check_ghost_collision_down:
        cmp yg2Pos , 15
        je path1_down
        call move_ghost_down2
        jmp onGround
        
        check_ghost_collision_right:
        cmp ghost2_bright , 1
        je check_ghost_collision_down2
        cmp xg2Pos , 97
        je path1_right
        call move_ghost_right2
        jmp onGround

        check_ghost_collision_down2:
        cmp ghost2_bdown2 , 1
        je check_ghost_collision_left
        cmp yg2Pos , 22
        je path1_down2
        call move_ghost_down2
        jmp onGround

        check_ghost_collision_left:
        cmp ghost2_bleft , 1
        je check_ghost_collision_up
        cmp xg2Pos , 25
        je path1_left
        call move_ghost_left2
        jmp onGround

        check_ghost_collision_up:
        cmp yg2Pos , 5
        je path1_up
        call move_ghost_up2
        jmp onGround


        path1_right:
        mov ghost2_bright , 1
        jmp onGround

        path1_down:
        mov ghost2_bdown , 1
        jmp onGround

        path1_down2:
        mov ghost2_bdown2 , 1
        jmp onGround

        path1_left:
        mov ghost2_bleft , 1
        jmp onGround

        path1_up:
        mov ghost2_bright , 0
        mov ghost2_bleft , 0
        mov ghost2_bdown , 0
        mov ghost2_bdown2 , 0

        onGround:
    ret
path2 endp

;-------------------------------------------- Path 3 for scenario 2 -------------------------------------------------
path3 proc
        cmp ghost3_bdown , 1
        je check_ghost_collision_right
        check_ghost_collision_down:
        cmp yg3Pos , 18
        je path1_down
        call move_ghost_down3
        jmp onGround
        
        check_ghost_collision_right:
        cmp ghost3_bright , 1
        je check_ghost_collision_up
        cmp xg3Pos , 88
        je path1_right
        call move_ghost_right3
        jmp onGround

        check_ghost_collision_up:
        cmp ghost3_bup , 1
        je check_ghost_collision_left
        cmp yg3Pos , 10
        je path1_up
        call move_ghost_up3
        jmp onGround

        check_ghost_collision_left:
        cmp xg3Pos , 32
        je path1_left
        call move_ghost_left3
        jmp onGround


        path1_right:
        mov ghost3_bright , 1
        jmp onGround

        path1_down:
        mov ghost3_bdown , 1
        jmp onGround

        path1_up:
        mov ghost3_bup , 1
        jmp onGround

        path1_left:
        mov ghost3_bright , 0
        mov ghost3_bup , 0
        mov ghost3_bdown , 0

        onGround:
    ret
path3 endp

;-------------------------------------------- Path 4 for scenario 3 -------------------------------------------------
path4 proc
        cmp ghost4_bup , 1
        je check_ghost_collision_right
        check_ghost_collision_up:
        cmp yg4Pos , 8
        je path1_up
        call move_ghost_up4
        jmp onGround
        
        check_ghost_collision_right:
        cmp ghost4_bright , 1
        je check_ghost_collision_down
        cmp xg4Pos , 55
        je path1_right
        call move_ghost_right4
        jmp onGround

        check_ghost_collision_down:
        cmp ghost4_bdown , 1
        je check_ghost_collision_right2
        cmp yg4Pos , 19
        je path1_down
        call move_ghost_down4
        jmp onGround

        check_ghost_collision_right2:
        cmp ghost4_bright2 , 1
        je check_ghost_collision_up2
        cmp xg4Pos , 64
        je path1_right2
        call move_ghost_right4
        jmp onGround

        check_ghost_collision_up2:
        cmp ghost4_bup2 , 1
        je check_ghost_collision_left2
        cmp yg4Pos , 8
        je path1_up2
        call move_ghost_up4
        jmp onGround

        check_ghost_collision_left2:
        cmp ghost4_bleft2 , 1
        je check_ghost_collision_down2
        cmp xg4Pos , 55
        je path1_left2
        call move_ghost_left4
        jmp onGround

        check_ghost_collision_down2:
        cmp ghost4_bdown2 , 1
        je check_ghost_collision_left
        cmp yg4Pos , 19
        je path1_down2
        call move_ghost_down4
        jmp onGround

        check_ghost_collision_left:
        cmp xg4Pos , 46
        je path1_left
        call move_ghost_left4
        jmp onGround


        path1_right:
        mov ghost4_bright , 1
        jmp onGround

        path1_right2:
        mov ghost4_bright2 , 1
        jmp onGround

        path1_down:
        mov ghost4_bdown , 1
        jmp onGround

        path1_down2:
        mov ghost4_bdown2 , 1
        jmp onGround

        path1_up:
        mov ghost4_bup , 1
        jmp onGround

        path1_up2:
        mov ghost4_bup2 , 1
        jmp onGround

        path1_left2:
        mov ghost4_bleft2 , 1
        jmp onGround

        path1_left:
        mov ghost4_bright , 0
        mov ghost4_bright2 , 0
        mov ghost4_bup , 0
        mov ghost4_bup2 , 0
        mov ghost4_bdown , 0
        mov ghost4_bdown2 , 0
        mov ghost4_bleft2 , 0

        onGround:
    ret
path4 endp

;-------------------------------------------- Path 5 for scenario 3 -------------------------------------------------
path5 proc
        cmp ghost5_bup , 1
        je check_ghost_collision_right
        check_ghost_collision_up:
        cmp yg5Pos , 5
        je path1_up
        call move_ghost_up5
        jmp onGround
        
        check_ghost_collision_right:
        cmp ghost5_bright , 1
        je check_ghost_collision_down
        cmp xg5Pos , 90
        je path1_right
        call move_ghost_right5
        jmp onGround

        check_ghost_collision_down:
        cmp ghost5_bdown , 1
        je check_ghost_collision_left
        cmp yg5Pos , 23
        je path1_down
        call move_ghost_down5
        jmp onGround

        check_ghost_collision_left:
        cmp xg5Pos , 20
        je path1_left
        call move_ghost_left5
        jmp onGround


        path1_right:
        mov ghost5_bright , 1
        jmp onGround

        path1_down:
        mov ghost5_bdown , 1
        jmp onGround

        path1_up:
        mov ghost5_bup , 1
        jmp onGround

        path1_left:
        mov ghost5_bright , 0
        mov ghost5_bup , 0
        mov ghost5_bdown , 0

        onGround:
    ret
path5 endp

;-------------------------------------------- Path 6 for scenario 3 -------------------------------------------------
path6 proc
        cmp ghost6_bup , 1
        je check_ghost_collision_right
        check_ghost_collision_up:
        cmp yg6Pos , 3
        je path1_up
        call move_ghost_up6
        jmp onGround
        
        check_ghost_collision_right:
        cmp ghost6_bright , 1
        je check_ghost_collision_down
        cmp xg6Pos , 108
        je path1_right
        call move_ghost_right6
        jmp onGround

        check_ghost_collision_down:
        cmp ghost6_bdown , 1
        je check_ghost_collision_left
        cmp yg6Pos , 27
        je path1_down
        call move_ghost_down6
        jmp onGround

        check_ghost_collision_left:
        cmp xg6Pos , 8
        je path1_left
        call move_ghost_left6
        jmp onGround


        path1_right:
        mov ghost6_bright , 1
        jmp onGround

        path1_down:
        mov ghost6_bdown , 1
        jmp onGround

        path1_up:
        mov ghost6_bup , 1
        jmp onGround

        path1_left:
        mov ghost6_bright , 0
        mov ghost6_bup , 0
        mov ghost6_bdown , 0

        onGround:
    ret
path6 endp

;-------------------------------------------- Writing to file -------------------------------------------------
Writing_to_file proc
    mov edx,OFFSET filename
    call CreateOutputFile
    mov fileHandle,eax

    cmp eax, INVALID_HANDLE_VALUE
    jne file_ok

    mov edx,OFFSET str1
    call WriteString
    jmp quit

    file_ok:

    mov esi , offset player_name
    mov edi , offset buffer
    mov ecx , buffer_ind
    add edi , ecx
    mov edx , offset player_name
    call StrLength
    mov ecx , eax

    l1:
        mov al , [esi]
        mov [edi] , al
        inc edi
        inc esi
        inc buffer_ind
    loop l1

    mov esi , offset scoreis
    mov edi , offset buffer
    mov ecx , buffer_ind
    add edi , ecx
    mov edx , offset scoreis
    call StrLength
    mov ecx , eax

    l2:
        mov al , [esi]
        mov [edi] , al
        inc edi
        inc esi
        inc buffer_ind
    loop l2

    mov edi , offset score_in_string
    mov ecx , 3
    mov al , "0"
    l4:
        mov [edi] , al
        inc edi
    loop l4

    mov eax , score
    mov edx, offset score_in_string
    call writing_decimal_to_string

    mov edi , offset buffer
    mov ecx , buffer_ind
    add edi , ecx
    mov [edi] , edx

    mov esi , offset buffer
    mov edi , offset score_in_string
    mov ecx , buffer_ind
    add esi , ecx
    mov ecx , 3
    dec esi
    l3:
        mov al , [edi]
        mov [esi] , al
        inc esi
        inc edi
        inc buffer_ind
    loop l3

    mov eax,fileHandle
    mov edx,OFFSET buffer
    dec buffer_ind
    mov ecx , buffer_ind
    add edx , buffer_ind
    mov byte ptr [edx] , 10
    inc ecx
    mov edx,OFFSET buffer
    call WriteToFile
    mov eax,fileHandle
    call CloseFile
    quit:

    ret
Writing_to_file endp

;-------------------------------------------- Reading from file -------------------------------------------------
Reading_from_file proc
    mov edx,OFFSET filename
    call OpenInputFile
    mov fileHandle,eax
    cmp eax,INVALID_HANDLE_VALUE ; error opening file?
    jne file_ok

    mov edx,OFFSET str1
    call WriteString
    jmp quit
    
    file_ok:
    mov edx,OFFSET buffer
    mov ecx,BUFFER_SIZE
    call ReadFromFile
    jnc check_buffer_size

    mov edx , offset error_reading_file
    call writestring
    jmp close_file

    check_buffer_size:
    cmp eax,BUFFER_SIZE
    jb buf_size_ok

    mov edx , offset buffer_error_file
    call writestring
    jmp quit

    buf_size_ok:
    ;mov buffer[eax] , 0
    mov stringLength , eax
    mov buffer_ind , eax

    close_file:
    mov eax,fileHandle
    call CloseFile

    quit:

    ret
Reading_from_file endp

writing_decimal_to_string PROC
    mov ecx, 10
    mov ebx, edx
    add ebx , 3
convert_loop:
    dec ebx
    xor edx, edx
    div ecx
    add dl, '0'
    mov [ebx], dl

    test eax, eax
    jnz convert_loop

    ret
writing_decimal_to_string ENDP

teleportation proc
    mov eax , black
    call setTextColor
    mov dl , 0
    mov dh , 14
    mov ecx , 3
    l1:
        call Gotoxy
        mov al , " "
        call writechar
        inc dh
    loop l1

    mov dl , 119
    mov dh , 14
    mov ecx , 3
    l2:
        call Gotoxy
        mov al , " "
        call writechar
        inc dh
    loop l2

    ret
teleportation endp

teleportation1 proc
    cmp xPos , 0
    jne checking_teleportation_for_right
    mov bl , 14
    mov ecx , 3
    l1:
        cmp yPos , bl
        je teleport_left
        inc bl
    loop l1

    checking_teleportation_for_right:
    cmp xPos , 119
    jne returning_from_teleportation1
    mov bl , 14
    mov ecx , 3
    l2:
        cmp yPos , bl
        je teleport_right
        inc bl
    loop l2

    jmp returning_from_teleportation1
    teleport_left:
    mov dl , 0
    mov dh , yPos
    call Gotoxy
    mov al , " "
    call writechar
    
    mov eax , white
    call setTextColor
    mov xPos , 118
    mov yPos , bl
    mov dl , xPos
    mov dh , yPos
    call Gotoxy
    mov al , "X"
    call writechar
    jmp returning_from_teleportation1

    teleport_right:
    mov dl , 119
    mov dh , bl
    call Gotoxy
    mov al , " "
    call writechar

    mov eax , white
    call setTextColor
    mov xPos , 2
    mov yPos , bl
    mov dl , xPos
    mov dh , yPos
    call Gotoxy
    mov al , "X"
    call writechar

    returning_from_teleportation1:
    ret
teleportation1 endp

draw_pacman proc
    mov ecx , 1296
    mov esi , offset pacman
    l1:
        mov al , [esi]
        cmp al , "."
        jne uncheck
        mov eax , yellow(yellow * 16)
        call setTextColor
        mov al , "."
        call writechar

        jmp loop_again

        uncheck:
        mov eax , black
        call setTextColor
        mov al , " "
        call writechar

        loop_again:
        inc esi
        inc bl
    loop l1

    mov eax , white
    call setTextColor
    ret
draw_pacman endp


END main