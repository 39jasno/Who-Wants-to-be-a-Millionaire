org 100h

.data

;String for Title Screen
mmtitle db "                      WHO WANTS TO BE A MILLIONAIRE$"
mmstart db "                             Press any key$"
mmauthors db "     by Jiro Madrid, Justin Moscoso, Jason Miran, Xavier Hipolito$"

;String for enter username
username_prompt db "                     Enter name: $"

;String for Win/Lose
gamewin1 db "          Congratulations $"
gamewin2 db ", you just became a millionaire!$"
gameover db "                          Game over, you lost $"
try_again_str db "              Would you like to try again? press 'y'?$"
forfeit_str db "                Thank you for playing, you won $"

;String for welcome
welcome_user db ", welcome to Who Wants to be a Millionaire! Here is the scoreboard$"
gamestart_str db "Press any key to start playing... Who Wants to be a Millionaire!$" 

;String for Scoreboard
scoreboard_str db "Scoreboard $"
prize_prompt1 db "Question 1 - $"
prize_prompt2 db "Question 2 - $"
prize_prompt3 db "Question 3 - $"
prize_prompt4 db "Question 4 - $"
prize_prompt5 db "Question 5 - $"
prize_prompt6 db "Question 6 - $"
prize_prompt7 db "Question 7 - $"
prize_prompt8 db "Question 8 - $"
prize_prompt9 db "Question 9 - $"
prize0 db "0$"
prize1 db "1,000 $"
prize2 db "5,000 $"
prize3 db "8,000 $"
prize4 db "16,000 $"
prize5 db "32,000 $"
prize6 db "64,000 $"
prize7 db "125,000 $"
prize8 db "500,000 $"
prize9 db "1,000,000 $"

;current player money
correct_str db "Your answer is correct! your current winning is $"

checkpoint_str1 db "You reached a checkpoint! Leave now with $"
checkpoint_str2 db "[q]$"
checkpoint_str3 db "or risk it for a chance to win a Million? [y] $"

warn_str db "If you lose, you leave with nothing! $"

;String for answer prompt
answer_str db "What is your final answer?: $"
invalid_input_str db "Invalid answer $"

nextquestion_str db "Press any key to proceed to the next question$"
                                    

;Questions
; Question 1
q1 db "Question 1$"
q1_str db "Which of these names is not a tech brand?$"
q1_choices1 db "a. Dell   b. Samsung$"
q1_choices2 db "c. Apple  d. Nike$"

; Question 2
q2 db "Question 2$"
q2_str db "Which is not a primary color?$"
q2_choices1 db "a. Red    b. Yellow$" 
q2_choices2 db "c. Green  d. Blue$"

; Question 3
q3 db "Question 3$"
q3_str db "What animal is printed on the PH 1000 peso polymer bill?$"
q3_choices1 db "a. Palawan Peacock    b. Zebra Dove$"
q3_choices2 db "c. Philippine Eagle   d. Bukidnon Woodcock$"

; Question 4
q4 db "Question 4$"
q4_str db "What year did the Filipino-American War start?$"
q4_choices1 db "a. 1886   b. 1923$"
q4_choices2 db "c. 1840   d. 1899$"

; Question 5 
q5 db "Question 5$"
q5_str db "What is the name of the crab in Disney's The Little Mermaid?$"
q5_choices1 db "a. Sibastian   b. Sebastien$"
q5_choices2 db "c. Sebastian   d. Sibastean$"

; Question 6 
q6 db "Question 6$"
q6_str db "In the popular game Genshin Impact, what is the name of the residence of the gods in the sky?$"
q6_choices1 db "a. Jade Palace  b. Celestia$"
q6_choices2 db "c. Khaenri'ah   d. The Chasm$"

; Question 7 
q7 db "Question 7$"
q7_str db "According to the American Kennel Club, what is the most popular dog breed of 2022?$"
q7_choices1 db "a. Golden Retriever b. Poodle$"
q7_choices2 db "c. French Bulldog   d. German Shepherd$"

; Question 8 
q8 db "Question 8$"
q8_str db "In the new Inside Out movie trailer, which new emotion showed up and turned the console orange?$"
q8_choices1 db "a. Ennui     b. Embarrassment$"
q8_choices2 db "c. Anxiety   d. Envy$"

; Question 9  
q9 db "Question 9$"
q9_str db "How many nanometers are there in a meter?$"
q9_choices1 db "a. 1 Million    b. 1 Billion$"
q9_choices2 db "c. 1 Trillion   d. 10 Million$"



.code
load_data:
      mov bx, 800h
      ;correct answers
      mov [800h], 'a'
      mov [801h], 'a'
      mov [802h], 'a'
      mov [803h], 'a'
      mov [804h], 'a'
      mov [805h], 'a'
      mov [806h], 'a'
      mov [807h], 'a'
      mov [808h], 'a'
                             
main_menu:
      call clear_screen
      ; for main title        
      mov ah, 02h
      mov bh, 00h
      mov dh, 04h
      mov dl, 04h
      int 10h  
      
      mov ah, 09h
      mov dx, offset mmtitle
      int 21h 
      
      ; for main authors
      mov ah, 02h
      mov bh, 00h
      mov dh, 17h
      mov dl, 04h
      int 10h  
      
      mov ah, 09h
      mov dx, offset mmauthors
      int 21h  
      
      ; for main press start
      mov ah, 02h
      mov bh, 00h
      mov dh, 0ch
      mov dl, 04h
      int 10h  
      
      mov ah, 09h
      mov dx, offset mmstart
      int 21h         
    
       ; waits for a key press         
      mov ah, 01h
      int 21h
      
      call clear_screen   
      call enter_username   
      call main_game

enter_username: 
      mov ah, 02h
      mov bh, 00h
      mov dh, 0ch
      mov dl, 04h
      int 10h
      
	; input
      mov ah,09h
      mov dx, offset username_prompt
      int 21h
      
	; move allocation to 809
      mov bx, 809h   
      
      inputloop:
      mov ah, 01h
      int 21h
      mov [bx], al
      inc bx
      cmp bx, 80ch
      jne inputloop:
      
      call clear_screen
      
	;after name input -> start game
      call main_game
      
      ret

main_game:
      mov bx , 809h ;must use this before calling output_username
      call output_username 
      
      mov ah, 09h
      mov dx, offset welcome_user       
      int 21h
      
      call scoreboard
      call newline
      call newline
      
      mov ah, 09h
      mov dx, offset gamestart_str
      int 21h
      
      mov ah,01h
      int 21h
      
      mov bx, 800h
      
      call question1
      
question1:
      call clear_screen
      mov ah, 09h
      mov dx, offset q1
      int 21h
      call newline
      call newline 
      mov ah, 09h
      mov dx, offset q1_str
      int 21h
      call newline
      call newline
      mov ah, 09h
      mov dx, offset q1_choices1
      int 21h
      call newline
      mov ah, 09h
      mov dx, offset q1_choices2
      int 21h
      
      ;Answer input and checking
      call answer_prompt
      cmp [bx], cl
         
      jne gameover_screen
      call correct
      call nextquestion_prompt 
      call question2      
      
question2:
      call clear_screen
      mov ah, 09h
      mov dx, offset q2
      int 21h
      call newline
      call newline
      mov ah, 09h
      mov dx, offset q2_str
      int 21h
      call newline
      call newline
      mov ah, 09h
      mov dx, offset q2_choices1
      int 21h
      call newline
      mov ah, 09h
      mov dx, offset q2_choices2
      int 21h
      
      ;Answer input and checking
      call answer_prompt  
      cmp [bx], cl
              
      jne gameover_screen     
      call correct
      call nextquestion_prompt     
      call question3

question3:
      call clear_screen
      mov ah, 09h
      mov dx, offset q3
      int 21h
      call newline
      call newline
      mov ah, 09h
      mov dx, offset q3_str
      int 21h
      call newline
      call newline
      mov ah, 09h
      mov dx, offset q3_choices1
      int 21h
      call newline
      mov ah, 09h
      mov dx, offset q3_choices2
      int 21h
      
      ;Answer input and checking
      call answer_prompt  
      cmp [bx], cl
              
      jne gameover_screen     
      call correct
      call scoreboard
      call checkpoint ;user can take home current prize or take chance and go to next question
      call question4

question4:
      call clear_screen
      mov ah, 09h
      mov dx, offset q4
      int 21h
      call newline
      call newline
      mov ah, 09h
      mov dx, offset q4_str
      int 21h
      call newline
      call newline
      mov ah, 09h
      mov dx, offset q4_choices1
      int 21h
      call newline
      mov ah, 09h
      mov dx, offset q4_choices2
      int 21h
      
      ;Answer input and checking
      call answer_prompt  
      cmp [bx], cl
              
      jne gameover_screen     
      call correct
      call nextquestion_prompt 
      call question5

question5:
      call clear_screen
      mov ah, 09h
      mov dx, offset q5
      int 21h
      call newline
      call newline
      mov ah, 09h
      mov dx, offset q5_str
      int 21h
      call newline
      call newline
      mov ah, 09h
      mov dx, offset q5_choices1
      int 21h
      call newline
      mov ah, 09h
      mov dx, offset q5_choices2
      int 21h
      
      ;Answer input and checking
      call answer_prompt  
      cmp [bx], cl
              
      jne gameover_screen     
      call correct
      call scoreboard
      call checkpoint ;user can take home current prize or take chance and go to next question
      call question6

question6:
      call clear_screen
      mov ah, 09h
      mov dx, offset q6
      int 21h
      call newline
      call newline
      mov ah, 09h
      mov dx, offset q6_str
      int 21h
      call newline
      call newline
      mov ah, 09h
      mov dx, offset q6_choices1
      int 21h
      call newline
      mov ah, 09h
      mov dx, offset q6_choices2
      int 21h
      
      ;Answer input and checking
      call answer_prompt  
      cmp [bx], cl
              
      jne gameover_screen     
      call correct
      call nextquestion_prompt 
      call question7

question7:
      call clear_screen
      mov ah, 09h
      mov dx, offset q7
      int 21h
      call newline
      call newline
      mov ah, 09h
      mov dx, offset q7_str
      int 21h
      call newline
      call newline
      mov ah, 09h
      mov dx, offset q7_choices1
      int 21h
      call newline
      mov ah, 09h
      mov dx, offset q7_choices2
      int 21h
      
      ;Answer input and checking
      call answer_prompt  
      cmp [bx], cl
              
      jne gameover_screen     
      call correct
      call scoreboard
      call checkpoint ;user can take home current prize or take chance and go to next question
      call question8

question8:
      call clear_screen
      mov ah, 09h
      mov dx, offset q8
      int 21h
      call newline
      call newline
      mov ah, 09h
      mov dx, offset q8_str
      int 21h
      call newline
      call newline
      mov ah, 09h
      mov dx, offset q8_choices1
      int 21h
      call newline
      mov ah, 09h
      mov dx, offset q8_choices2
      int 21h
      
      ;Answer input and checking
      call answer_prompt  
      cmp [bx], cl
              
      jne gameover_screen     
      call correct
      call nextquestion_prompt 
      call question9

question9:
      call clear_screen
      mov ah, 09h
      mov dx, offset q9
      int 21h
      call newline
      call newline
      mov ah, 09h
      mov dx, offset q9_str
      int 21h
      call newline
      call newline
      mov ah, 09h
      mov dx, offset q9_choices1
      int 21h
      call newline
      mov ah, 09h
      mov dx, offset q9_choices2
      int 21h
      
      ;Answer input and checking
      call answer_prompt  
      cmp [bx], cl
              
      jne gameover_screen     
      call gamewin_screen ;win!

answer_prompt:
      call newline
      call newline
      
      mov ah, 09h
      mov dx, offset answer_str
      int 21h
      
      mov ah, 01h
      int 21h
      mov cl, al
      call validation
      ret

validation:
      ; Validate the input
      cmp cl, 'a'
      je valid_input
      cmp cl, 'b'
      je valid_input
      cmp cl, 'c'
      je valid_input
      cmp cl, 'd'
      je valid_input
      
	; if upper case go to set_lowercase to add 20h 
      cmp cl, 'A'
      je set_lowercase
      cmp cl, 'B'
      je set_lowercase
      cmp cl, 'C'
      je set_lowercase
      cmp cl, 'D'
      je set_lowercase  
      
      ; Invalid input, display an error message and prompt again
      call newline
      mov ah, 09h
      mov dx, offset invalid_input_str
      int 21h
      jmp answer_prompt  ;Jump back to answer_prompt for input
      
valid_input:
      ret


set_lowercase:
      add cl, 20h
      ret

;If the answer to the question is correct
correct:
      call clear_screen
      inc bx
      mov ah, 09h
      mov dx, offset correct_str
      int 21h
      
      call question_current_prize       
      ret

user_checkpoint:
      cmp bx, 800h
      je prize0_str      
      cmp bx, 801h
      je prize0_str 
      cmp bx, 802h
      je prize0_str
      
      cmp bx, 803h
      je prize3_str
      cmp bx, 804h
      je prize3_str
      
      cmp bx, 805h
      je prize5_str
      cmp bx, 806h
      je prize5_str
      
      cmp bx, 807h
      je prize7_str
      cmp bx, 808h
      je prize7_str
      cmp bx, 809h
      je prize9_str  
      ret
      
question_current_prize:
      cmp bx, 800h
      je prize0_str      
      cmp bx, 801h
      je prize1_str 
      cmp bx, 802h
      je prize2_str
      
      cmp bx, 803h
      je prize3_str
      cmp bx, 804h
      je prize4_str
      
      cmp bx, 805h
      je prize5_str
      cmp bx, 806h
      je prize6_str
      
      cmp bx, 807h
      je prize7_str
      cmp bx, 808h
      je prize8_str
      cmp bx, 809h
      je prize9_str  
      ret
      
      
nextquestion_prompt:
      call newline
      call newline
      mov ah, 09h
      mov dx, offset nextquestion_str
      int 21h  
      mov ah, 01h
      int 21h
      
      ret
      
checkpoint:
      call newline
      call newline
      mov bh, 08h
      mov ah, 09h
      mov dx, offset checkpoint_str1      
      int 21h
      call user_checkpoint
      
      mov ah, 09h
      mov dx, offset checkpoint_str2      
      int 21h
      call newline
     
      mov ah, 09h
      mov dx, offset checkpoint_str3      
      int 21h
      call newline 
      call newline
      
      mov ah, 09h
      mov dx, offset warn_str     
      int 21h
      checkpoint_input: 
      mov ah, 01h
      int 21h
      mov cl, al
      call checkpoint_validation
      ret

checkpoint_validation:      
      cmp cl, 'q'
      je forfeit
      cmp cl, 'y'
      je valid_input
      
      cmp cl, 'Q'
      je set_lowercase
      cmp cl, 'Y'
      je set_lowercase
      
      call newline
      mov ah, 09h
      mov dx, offset invalid_input_str
      int 21h
      jmp checkpoint_input

forfeit:
      call clear_screen
      
      mov ah, 02h
      mov bh, 00h
      mov dh, 0ch
      mov dl, 04h
      int 10h  
      
      mov bh, 08h
      mov ah, 09h
      mov dx, offset forfeit_str       
      int 21h
         
      call user_checkpoint
      
      mov ah, 01h
      int 21h
      
      int 20h

prize0_str:
      call dollar_sign
      mov ah, 09h
      mov dx, offset prize0
      int 21h
      ret 

prize1_str:
      call dollar_sign
      mov ah, 09h
      mov dx, offset prize1
      int 21h
      ret 

prize2_str:
      call dollar_sign
      mov ah, 09h
      mov dx, offset prize2
      int 21h
      ret

prize3_str:
      call dollar_sign
      mov ah, 09h
      mov dx, offset prize3
      int 21h
      ret

prize4_str:
      call dollar_sign
      mov ah, 09h
      mov dx, offset prize4
      int 21h
      ret

prize5_str:
      call dollar_sign
      mov ah, 09h
      mov dx, offset prize5
      int 21h
      ret

prize6_str:
      call dollar_sign
      mov ah, 09h
      mov dx, offset prize6
      int 21h
      ret

prize7_str:
      call dollar_sign
      mov ah, 09h
      mov dx, offset prize7
      int 21h
      ret

prize8_str:
      call dollar_sign
      mov ah, 09h
      mov dx, offset prize8
      int 21h
      ret

prize9_str:
      call dollar_sign
      mov ah, 09h
      mov dx, offset prize9
      int 21h
      ret

;If user fails to answer correctly once 
gameover_screen:
      call clear_screen
      mov ah, 02h
      mov bh, 00h
      mov dh, 04h
      mov dl, 04h
      int 10h  
      
      mov ah, 09h
      mov dx, offset gameover       
      int 21h 
      
      mov ah, 02h
      mov bh, 00h
      mov dh, 0ch
      mov dl, 04h
      int 10h 
      
      mov ah, 09h
      mov dx, offset try_again_str       
      int 21h
      
      mov ah, 01h
      int 21h
      
      cmp al, 'y'
      je load_data
      
      int 20h

;If user is able to answer Question 9      
gamewin_screen:
      call clear_screen
      mov ah, 02h
      mov bh, 00h
      mov dh, 0ch
      mov dl, 04h
      int 10h  
      
      mov ah, 09h
      mov dx, offset gamewin1       
      int 21h
      
      mov bx , 809h ;must use this before calling output_username
      call output_username
      
      mov ah, 09h
      mov dx, offset gamewin2
      int 21h 
      
      mov ah, 02h
      mov bh, 00h
      mov dh, 0eh
      mov dl, 04h
      int 10h        
      
      int 20h

;To display the scoreboard    
scoreboard:
      call newline
      call newline
      
      mov ah, 09h
      mov dx, offset scoreboard_str
      int 21h
      
      call newline
      call newline
      
      mov ah, 09h
      mov dx, offset prize_prompt1
      int 21h
      call prize1_str     
                               
      call newline
      
      mov ah, 09h
      mov dx, offset prize_prompt2
      int 21h      
      call prize2_str
      
      call newline
      
      mov ah, 09h
      mov dx, offset prize_prompt3
      int 21h                      
      call prize3_str
      
      call newline
      call newline
      
      mov ah, 09h
      mov dx, offset prize_prompt4
      int 21h            
      call prize4_str        
      
      call newline
      
      mov ah, 09h
      mov dx, offset prize_prompt5
      int 21h           
      call prize5_str
      
      call newline
      call newline
      
      mov ah, 09h
      mov dx, offset prize_prompt6
      int 21h         
      call prize6_str
      
      call newline
      
      mov ah, 09h
      mov dx, offset prize_prompt7
      int 21h           
      call prize7_str
      
      call newline
      call newline
      
      mov ah, 09h
      mov dx, offset prize_prompt8
      int 21h            
      call prize8_str   
      
      call newline
      
      mov ah, 09h
      mov dx, offset prize_prompt9
      int 21h           
      call prize9_str
            
      ret

newline: 
      mov ah, 02h
      mov dl, 0ah
      int 21h
      mov dl,0dh
      int 21h
      ret
      
clear_screen:
      mov ah, 0
      mov al, 3
      int 10h
      ret

;Print username  
output_username:
      ; Assuming [bx] is already set to 809h
      mov ah,02h
      mov dl, [bx]
      int 21h 
      inc bx
      cmp bx, 80ch
      jne output_username
      ret

;Print dollar sign
dollar_sign:
      mov ah, 02h
      mov dx, 24h
      int 21h
      ret


      
      
  

 


 
  