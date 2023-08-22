; Name: Alymuhammad Maknojia
; EE 306: Lab 6
; This program determines if a student EID matches a list of student EIDs

.ORIG x3000
; Prompt the user for EID with the message, "Type EID and press Enter:"
; ------------------------------------------------------------------
LEA R0, prompt ; Load R0 with starting address of string
PUTS ; Call TRAP routine, PUTS

; Read the characters that user types. Then store each character in a reserved block of memory below the program. When the user types enter, store null instead. 
; ------------------------------------------------------------------
LEA R1, userEID ; Initialize R1 to point to a reserved block of memory where the user’s EID will be stored
LOOP1
GETC ; Read character that user types.
OUT ; displaying characters
LD R2, ASCIIENTER ; loading x0A
NOT R2, R2
ADD R2, R2, #1 ; two's complement 
ADD R2, R0, R2 ; is the value is R0 x0A?
BRNP x3
; yes
LD R5, NULL
STR R5, R1, #0 ; mem[R1] <- Null, memory of R1 will get value of R1
BRNZP NEXT ; ?
; no
STR R0, R1, #0 ; mem[R1] <- R0 
ADD R1, R1, #1
BRNZP LOOP1

; Search the linked list to see if there is a match. Head pointer is at x4000
; ------------------------------------------------------------------
NEXT
LDI R0, HEADPTR ; R0 <- mem[x4000]
LOOP2
BRNP x1 ; is R0 = null?
; yes
BRNZP NULLJUMP
;LEA R0, notmain 
;PUTS
;BRNZP FINISH
; no 
LDR R1, R0, #1 ; R1 <- mem[R0+1] - EID stored in R1, R0 is the address of the first node
LEA R2, userEID ; ptr to user EID array
JSR MATCH
ADD R4, R4, #0
BRNZ x5
; yes
LEA R0, userEID
PUTS
LEA R0, mainroom
PUTS
BRNZP FINISH
; no 
LDR R0, R0, #0
BRNZP LOOP2


NULLJUMP
; Search the waiting room linked list to see if there is a match. 
LDI R0, HEADPTR2 ; R0 <- mem[x4001]
LOOP4
BRNP x3 ; is R0 = null?
; yes
LEA R0, notmain 
PUTS
BRNZP FINISH
; no 
LDR R1, R0, #1 ; R1 <- mem[R0+1]
LEA R2, userEID ; ptr to user EID array
; is there a match? 
JSR MATCH ; jump to match subroutine 
ADD R4, R4, #0 
BRNZ NOMATCH
; yes: delete node from waiting list. Insert node to the front of the main room list. Display the message "<EID> is added to the main room."
LDR R5, R0, #0
ADD R3, R3, #0
BRZ x2
STR R5, R3, #0
BRNZP INSERT
; first node match
LD R6, HEADPTR2
STR R5, R6, #0

; insert node
INSERT
LDI R6, HEADPTR ; R6  <- mem[x4000]
STR R6, R0, #0
LD R2, HEADPTR
STR R0, R2, #0
LEA R0, userEID
PUTS
LEA R0, addedroom
PUTS
BRNZP FINISH
; no - display the message "The entered EID does not match."
NOMATCH
AND R3, R3, #0
ADD R3, R0, R3
LDR R0, R0, #0
BRNZP LOOP4
;LEA R0, notmain
;PUTS
;BRNZP FINISH

FINISH
HALT


; Subroutine Match
MATCH 
ST R1, DRC1 ; Perform callee save of registers that the subroutine will use
ST R2, DRC2
AND R4, R4, #0 ; clear R4
LOOP3
LDR R5, R1, #0 ; R5 <- mem[R1]
LDR R6, R2, #0 ; R6 <- mem[R2]
BRNP x2
; yes
ADD R4, R4, #1
BRNZP COMPLETE
; no
NOT R6, R6
ADD R6, R6, #1
ADD R5, R6, R5 ; R5 <- R5- R6
BRZ x2 
; no
AND R4, R4, #0 ; R4 <- 0
BRNZP COMPLETE
; yes
ADD R1, R1, #1
ADD R2, R2, #1 
BRNZP LOOP3

COMPLETE 
LD R1, DRC1 ; Perform calle restore
LD R2, DRC2
RET ; return


prompt .STRINGZ "Type EID and press Enter: "
userEID .BLKW x6 ; 5 characters + null
notmain .STRINGZ "The entered EID does not match."
mainroom .STRINGZ " is already in the main room."
addedroom .STRINGZ " is added to the main room."

ASCIIENTER .FILL x0A
NULL .FILL x0
HEADPTR .FILL x4000
HEADPTR2 .FILL x4001
DRC1 .FILL x0
DRC2 .FILL x0

.END 