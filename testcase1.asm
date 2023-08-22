; EE306 Lab6 Testcase 1
; Same as lab document. 
;   3 elements in main room(XY123, AB789, PQ567), 1 element in waiting room(MN483)
;     - Check for MN483, HI654, XY123


; Main list 
    ;   Nodes

    ; Head node pointer - address of head
    .ORIG x4000
        .FILL x4002 ; pointer to first node
    .END 

    ; First node 
    .ORIG x4002
        .FILL x4004 ; pointer to second node
        .FILL x4800 ; XY123
    .END 

    ; Second node 
    .ORIG x4004
        .FILL x4006 ; pointer to third node
        .FILL x4806 ; AB789
    .END 

    ; Third node 
    .ORIG x4006
        .FILL x0000 ; null 
        .FILL x480C ; PQ567
    .END 


    ; Strings 

    ; String 1 : XY123
    .ORIG x4800
        .STRINGZ "XY123"
    .END 

    ; String 2 : AB789
    .ORIG x4806
        .STRINGZ "AB789"
    .END

    ; String 3 : PQ567 
    .ORIG x480C
        .STRINGZ "PQ567"
    .END


; Waiting List 
    ;   Nodes

    ; Head node pointer - address of head
    .ORIG x4001
        .FILL x5000 ; pointer to first node
    .END 

    ; First node 
    .ORIG x5000
        .FILL x0000 ; null 
        .FILL x5002 ; MN483
    .END 


    ; Strings 

    ; String 1 : MN483
    .ORIG x5002
        .STRINGZ "MN483"
    .END 



; Output Expectation

; Example 1:
; Console:
;   Type EID and press Enter: MN483
;   MN483 is added to the main room.
;
;   -----Halting the processor -----
; Note: The node containing MN483 should be deleted from the waiting room linked list and inserted in the main room linked list

; Example 2: 
; Console:
;   Type EID and press Enter: HI567
;   The entered EID does not match.
;
;   -----Halting the processor ----
; Note: The main room and waiting linked list should be unchanged after this input

; Example 3:
; Console:
;   Type EID and press Enter: XY123
;   XY123 is already in the main room.
;
;   -----Halting the processor ----
; Note: The main room and waiting linked list should be unchanged after this input

