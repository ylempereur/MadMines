        COND    TYPE=DISK
WRITHS  LD      HL,FILES
        LD      DE,DCB
        LD      BC,13
        LDIR
        OPEN    DCB,ERROR,SCR,10*(10+6)
        POSN    DCB,ERROR,0
        WRITLR  DCB,ERROR,TSCOR
        CLOSE   DCB,ERROR
        DINT
        RET
        ENDC
        COND    TYPE=PROT
WRITHS  CALL    WRITE
        RET
        ENDC
SCHST   LD      IY,TSCOR
        CALL    SCOR12
        LD      B,5
        XOR     A
SCH0    OR      (HL)
        INC     HL
        DJNZ    SCH0
        CP      '0'
        RET     Z
        LD      B,10
SCH1    LD      C,10
        CALL    SCOR12
SCH2    LD      A,C
        LD      (SCH3+2),A
SCH3    LD      A,(IY+0)
        CP      (HL)
        JR      C,SCH5
        JR      NZ,SCH4
        INC     HL
        INC     C
        LD      A,C
        CP      16
        JR      NZ,SCH2
SCH4    LD      DE,16
        ADD     IY,DE
        DJNZ    SCH1
        RET
SCH5    PUSH    IY
        LD      A,B
        LD      (SVPL+1),A
        CP      1
        JR      Z,SCH7
        LD      HL,0
        LD      DE,16
        DEC     B
SCH6    ADD     HL,DE
        DJNZ    SCH6
        PUSH    HL
        POP     BC
        LD      HL,TSCOR+9*(10+6)-1
        LD      DE,TSCOR+10*(10+6)-1
        LDDR
SCH7    CALL    SCOR12
        POP     DE
        PUSH    DE
        LD      BC,10
        EX      DE,HL
        ADD     HL,BC
        EX      DE,HL
        LD      BC,6
        LDIR
SVPL    LD      B,0
        LD      HL,VIDEO+832+43
        LD      DE,-64
SCH8    ADD     HL,DE
        DJNZ    SCH8
        LD      IX,BLK1
        LD      A,(PLAY)
        CP      1
        JR      NZ,SCH9
        LD      IX,BLK2
SCH9    LD      (IX),L
        LD      (IX+1),H
        POP     HL
        LD      A,(PLAY)
        LD      B,A
        JP      INGS
SVHL    DEFW    0
SVBC    DEFW    0
WAITER  DEFW    0
INGS    PUSH    HL
        PUSH    BC
        LD      (SVBC),BC
        LD      (SVHL),HL
        LD      B,10
ING5    LD      (HL),' '
        INC     HL
        DJNZ    ING5
        LD      A,1
        LD      (EDIS),A
        LD      HL,15000
        LD      (WAITER),HL
        CALL    CLSSCR
        XOR     A
        LD      (BLINK),A
        CALL    DSCORE
        CALL    DHSCOR
        CALL    AFFHS
        LD      A,' '
        LD      (SCR+20),A
        LD      (SCR+21),A
        CALL    SCRVID
        LD      HL,TAGS
        LD      DE,VIDEO+192+14
ING0    LD      A,(HL)
        INC     HL
        OR      A
        JR      Z,ING1
        DEC     HL
        CALL    AFF1C
        INC     HL
        INC     DE
        JR      ING0
ING1    LD      A,(HL)
        CP      0FFH
        JR      Z,ING2
        LD      C,A
        LD      B,0
        EX      DE,HL
        ADD     HL,BC
        EX      DE,HL
        INC     HL
        JR      ING0
ING2    POP     BC
        LD      A,B
        LD      HL,VIDEO+10
        LD      B,'<'
        CP      1
        JR      Z,ING3
        LD      A,'2'
        LD      B,'>'
        LD      HL,VIDEO+42
        LD      (VIDEO+192+24),A
ING3    LD      A,10
ING4    LD      (HL),B
        INC     HL
        DEC     A
        JR      NZ,ING4
        POP     IX
        LD      B,0
        LD      HL,(BLK1)
        LD      A,(PLAY)
        CP      1
        JR      NZ,INGH
        LD      HL,(BLK2)
INGH    DEC     HL
        LD      (HL),'>'
        INC     HL
        CALL    2BH
ING6    LD      (HL),8FH
ING7    CALL    2BH
        OR      A
        JR      NZ,INGI
INGI0   DEC     A
        JR      NZ,INGI0
        LD      DE,(WAITER)
        DEC     DE
        LD      (WAITER),DE
        LD      A,E
        OR      D
        JR      Z,INGI1
        LD      A,E
        OR      A
        JR      Z,INGI2
        CP      80H
        JR      NZ,INGI3
        LD      A,' '
        LD      (VIDEO+192+24),A
INGI3   LD      A,E
        AND     7FH
        CP      10
        JR      Z,INGI4
        CP      74
        JR      NZ,ING7
        LD      A,8FH
        JR      INGI5
INGI4   LD      A,' '
INGI5   LD      (HL),A
        JR      ING7
INGI2   LD      A,(PLAY)
        ADD     A,'0'
        LD      (VIDEO+192+24),A
        JR      INGI3
INGI    CP      24
        JR      Z,ING9
        CP      0DH
        JR      NZ,INGL
INGI1   LD      (HL),' '
        RET
INGL    CP      8
        JR      Z,ING8
        CP      ' '
        JR      C,ING6
        EX      AF,AF'
        LD      A,B
        CP      10
        JR      Z,ING6
        EX      AF,AF'
        LD      (IX),A
        LD      (HL),A
        INC     HL
        INC     B
        INC     IX
        JR      ING6
ING8    LD      A,B
        OR      A
        JR      Z,ING6
        LD      (HL),' '
        DEC     IX
        DEC     HL
        LD      (IX),' '
        DEC     B
        JR      ING6
ING9    LD      HL,(SVHL)
        LD      BC,(SVBC)
        JP      INGS
TAGS    DEFM    '** Player 1 **'
        DEFB    0
        DEFB    114
        DEFW    0A3B7H
        DEFW    0B791H
        DEFW    90BBH
        DEFW    0B3B7H
        DEFW    0BA81H
        DEFW    95B3H
        DEFW    0B783H
        DEFB    81H
        DEFB    0
        DEFB    49
        DEFW    8C8FH
        DEFW    8F85H
        DEFW    8580H
        DEFW    8C8FH
        DEFW    8F84H
        DEFW    8580H
        DEFW    8F80H
        DEFB    80H
        DEFB    0
        DEFB    49
        DEFW    0B3B7H
        DEFW    0B791H
        DEFW    8583H
        DEFW    0A397H
        DEFW    0B795H
        DEFW    90BBH
        DEFW    0B3B7H
        DEFB    81H
        DEFB    0
        DEFB    49
        DEFW    8E8CH
        DEFW    8F85H
        DEFW    858CH
        DEFW    8E8DH
        DEFW    8F85H
        DEFW    8580H
        DEFW    8C8FH
        DEFB    84H
        DEFB    0
        DEFB    113
        DEFM    'Please   enter'
        DEFB    0
        DEFB    50
        DEFM    'your  name  or'
        DEFB    0
        DEFB    50
        DEFM    '   initials   '
        DEFB    0
        DEFB    0FFH
PRINT   LD      E,(HL)
        INC     HL
        LD      D,(HL)
PRI0    INC     HL
        LD      A,(HL)
        INC     HL
        DEC     A
        RET     Z
        INC     A
        JR      Z,PRINT
        DEC     HL
        CALL    AFF1C
        INC     DE
        JR      PRI0
TABFUN  DEFW    0BFBFH  ; "F"
        DEFW    0BFBFH
        DEFW    8F8FH
        DEFW    8F8FH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0B0B0H
        DEFW    0B0B0H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    8383H
        DEFW    8383H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    8080H
        DEFW    8080H
        DEFW    0BFBFH  ; "U"
        DEFW    0BFBFH
        DEFW    8080H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    8080H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    8080H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BCBCH
        DEFW    0BFBFH
        DEFW    0BFBFH  ; "N"
        DEFW    8F8FH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    8080H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    8080H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    8080H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH  ; "S"
        DEFW    0BFBFH
        DEFW    8F8FH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0B0B0H
        DEFW    0B3B3H
        DEFW    0B3B3H
        DEFW    8383H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BCBCH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH  ; "O"
        DEFW    0BFBFH
        DEFW    8F8FH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    8080H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    8080H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BCBCH
        DEFW    0BFBFH
        DEFW    0BFBFH  ; "F"
        DEFW    0BFBFH
        DEFW    8F8FH
        DEFW    8F8FH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0B0B0H
        DEFW    0B0B0H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    8383H
        DEFW    8383H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    8080H
        DEFW    8080H
        DEFW    8F8FH   ; "T"
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    8F8FH
        DEFW    8080H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    8080H
        DEFW    8080H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    8080H
        DEFW    8080H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    8080H
TABPF   DEFW    100H
        DEFW    402H
        DEFW    1008H
        DEFW    4020H
        DEFW    4241H
        DEFW    4844H
        DEFW    6050H
        DEFW    6261H
        DEFW    6864H
        DEFW    7170H
        DEFW    7472H
        DEFW    7978H
        DEFW    7C7AH
        DEFW    7E7DH
        DEFW    7F7FH
        DEFW    7F7FH
        DEFW    7F7FH
        DEFW    7F7FH
        DEFW    7F7FH
        DEFW    7F7FH
        DEFW    0
        DEFW    7F7FH
        DEFW    0
        DEFW    7F7FH
        DEFW    0
        DEFW    7F7FH
        DEFW    1F3FH
        DEFW    70FH
        DEFW    103H
        DEFW    100H
        DEFW    402H
        DEFW    1008H
        DEFW    4020H
        DEFW    1020H
        DEFW    408H
        DEFW    102H
        DEFW    402H
        DEFW    1008H
        DEFW    4020H
        DEFW    7060H
        DEFW    7C78H
        DEFW    7F7EH
        DEFW    7F7FH
        DEFW    7F7FH
        DEFW    7F7FH
        DEFW    7F7FH
        DEFW    7F7FH
        DEFW    7F7FH
        DEFW    7F7FH
        DEFW    7F7FH
        DEFB    80H
TABDIS  DEFM    'Published by'
        DEFM    'Funsoft, Inc.'
        DEFM    '28611 Canwood'
        DEFM    'Agoura, CA 91301'
        DEFM    '(213) 991-6540'
PLETR   PUSH    AF
        PUSH    HL
        PUSH    DE
        PUSH    BC
        LD      B,4
PLE0    PUSH    BC
        LD      B,8
PLE1    LD      A,(HL)
        LD      (DE),A
        INC     HL
        INC     DE
        DJNZ    PLE1
        EX      DE,HL
        LD      BC,56
        ADD     HL,BC
        EX      DE,HL
        POP     BC
        DJNZ    PLE0
PLE2    POP     BC
        POP     DE
        POP     HL
        POP     AF
        RET
CLETR   PUSH    AF
        PUSH    HL
        PUSH    DE
        PUSH    BC
        EX      DE,HL
        LD      B,4
CLE0    LD      C,8
CLE1    LD      (HL),80H
        INC     HL
        DEC     C
        JR      NZ,CLE1
        LD      DE,56
        ADD     HL,DE
        DJNZ    CLE0
        JR      PLE2
PFUN    PUSH    AF
        PUSH    HL
        PUSH    DE
        PUSH    BC
        SLA     A
        LD      HL,TABFUN
        LD      B,7
PFU0    PUSH    BC
        SLA     A
        CALL    C,PLETR
        CALL    NC,CLETR
        EX      DE,HL
        LD      BC,9
        ADD     HL,BC
        EX      DE,HL
        LD      BC,4*8
        ADD     HL,BC
        POP     BC
        DJNZ    PFU0
        JR      PLE2
PROFUN  LD      HL,TABPF
        LD      DE,VIDEO+192+1
PRF0    LD      A,(HL)
        INC     HL
        BIT     7,A
        RET     NZ
        CALL    PFUN
        CALL    GLIFUN
        CALL    GLIFUN
        JR      PRF0
CADRE   LD      HL,SCR+960+1
        EXX
        LD      HL,SCR+512+1
        LD      DE,SCR+640+1
        LD      B,62
        LD      A,83H
CAD0    EXX
        LD      (HL),8CH
        INC     HL
        EXX
        LD      (HL),8CH
        LD      (DE),A
        INC     HL
        INC     DE
        DJNZ    CAD0
        LD      HL,SCR+576
        LD      DE,63
        LD      B,6
CAD1    LD      (HL),0BFH
        ADD     HL,DE
        LD      (HL),0BFH
        INC     HL
        DJNZ    CAD1
        LD      A,0BCH
        LD      (SCR+512),A
        LD      (SCR+512+63),A
        LD      A,8FH
        LD      (SCR+960),A
        LD      (SCR+960+63),A
        RET
TGFUN   DEFM    'FUNSOFT '
CGLI    DEFB    0
GLIFUN  EXX
        LD      A,(CGLI)
        INC     A
        AND     7
        LD      (CGLI),A
        LD      (GLI0+2),A
        LD      IX,TGFUN
        LD      HL,VIDEO+576+1
        LD      B,62
GLI0    LD      A,(IX+0)
        LD      (HL),A
        INC     HL
        LD      A,(GLI0+2)
        INC     A
        AND     7
        LD      (GLI0+2),A
        DJNZ    GLI0
        LD      BC,800H
GLI1    LD      A,(38FFH)
        OR      A
        JR      Z,GLI2
        POP     HL
        RET
GLI2    DEC     BC
        LD      A,B
        OR      C
        JR      NZ,GLI1
        EXX
        RET
DEBUT   DINT
        LD      HL,STACK
        LD      SP,HL
        LD      H,37H
        LD      L,0E4H
        LD      (HL),1
        LD      A,38H
        OUT     (0ECH),A
        COND    TYPE=PROT
        CALL    CHECKS
        ENDC
        CALL    EHS
        COND    TYPE=PROT
        CALL    CHECKR
        ENDC
        CALL    SCR191
        CALL    DISPL
        CALL    CLSSCR
        LD      HL,TABDIS
        LD      DE,SCR+64+26
        LD      BC,12
        CALL    AFF1L
        LD      DE,SCR+704+25
        LD      BC,13
        CALL    AFF1L
        LD      DE,SCR+768+25
        LD      BC,13
        CALL    AFF1L
        LD      DE,SCR+832+24
        LD      BC,16
        CALL    AFF1L
        LD      DE,SCR+896+25
        LD      BC,14
        CALL    AFF1L
        CALL    CADRE
        CALL    DISPL
        CALL    PROFUN
        JP      START
EDIS    DEFB    0
PROC    LD      A,(BASE)
        CP      3
        RET     NZ
        CALL    SOUND
        LD      A,(SHP1)
        LD      B,A
        LD      A,(NPLAY)
        CP      1
        LD      A,0
        JR      Z,PROC0
        LD      A,(SHP2)
PROC0   OR      B
        JR      NZ,PROC1
        LD      A,(DEMO)
        OR      A
        JP      NZ,START
        LD      A,(NPLAY)
        CP      1
        JR      NZ,PROC2
        XOR     A
        LD      (EDIS),A
        CALL    SCHST
        COND    0!(TYPE=DISK)!(TYPE=PROT)
        LD      A,(EDIS)
        OR      A
        CALL    NZ,WRITHS
        ENDC
        JP      START
PROC2   LD      HL,SCORE1
        LD      DE,SCORE2
        LD      B,5
PROC3   LD      A,(DE)
        CP      (HL)
        JR      C,PROC4
        JR      NZ,PROC5
        INC     HL
        INC     DE
        DJNZ    PROC3
PROC4   LD      A,1
        JR      PROC6
PROC5   LD      A,2
PROC6   LD      (PLAY),A
        XOR     A
        LD      (EDIS),A
        CALL    SCHST
        LD      A,(PLAY)
        NEG
        ADD     A,3
        LD      (PLAY),A
        CALL    SCHST
        COND    0!(TYPE=DISK)!(TYPE=PROT)
        LD      A,(EDIS)
        OR      A
        CALL    NZ,WRITHS
        ENDC
        JP      START
PROC1   LD      A,(VLASER)
        LD      (VLAS0),A
        LD      HL,PHASE
        DEC     (HL)
        CALL    INIT0
        LD      A,(NPLAY)
        CP      1
        JR      NZ,PROC7
        CALL    SOUND
        XOR     A
        LD      (COUNTS),A
        RET
PROC7   LD      A,(PLAY)
        CP      1
        JR      Z,PROC8
        LD      A,(SHP1)
        JR      PROC9
PROC8   LD      A,(SHP2)
PROC9   OR      A
        RET     Z
        LD      HL,PLAY
        LD      A,3
        SUB     (HL)
        LD      (HL),A
        LD      HL,VLAS0
        LD      DE,VAR2
        LD      BC,VAR2-VLAS0
        EXIR
        CALL    INIT0
        CALL    SOUND
        XOR     A
        LD      (COUNTS),A
        RET
        COND    TYPE=PROT
CHECKS  JR      CHES
CHES0   LD      A,(CHKS)
        LD      H,44H
        LD      L,8
        CP      (HL)
        RET     Z
        JR      CLEANP
CHES    LD      HL,3C00H
        LD      BC,1024
        CALL    CHECK
        LD      (CHKS),A
        XOR     A
        LD      (CHECKS+1),A
        JR      CHES0
CHKS    DEFB    0
CLEANP  LD      HL,8000H
        LD      DE,4000H
        LD      BC,8000H
        LDIR
        RET
CHECK   XOR     A
CHE0    ADD     A,(HL)
        LD      E,A
        INC     HL
        DEC     BC
        LD      A,B
        OR      C
        LD      A,E
        JR      NZ,CHE0
        RET
CHECKR  JR      CHER
CHER0   LD      A,(CHKR)
        LD      H,44H
        LD      L,0AH
        CP      (HL)
        RET     Z
        JR      CLEANP
CHER    LD      HL,0A000H
        LD      BC,6000H
        CALL    CHECK
        LD      (CHKR),A
        XOR     A
        LD      (CHECKR+1),A
        JR      CHER0
CHKR    DEFB    0
        ENDC
SCOR12  LD      A,(PLAY)
        CP      1
        JR      Z,SC12
        LD      HL,SCORE2
        RET
SC12    LD      HL,SCORE1
        RET
BRKCLR  LD      A,(3840H)
        AND     6
        CP      6
        JP      Z,DEBUT
        LD      A,(DEMO)
        OR      A
        CALL    SOUND
        JR      Z,BRK2
        LD      A,(38FFH)
        OR      A
        RET     Z
        LD      HL,20000
        LD      (IPRO+1),HL
        JP      START
BRK2    LD      A,(3801H)
        AND     1
        RET     Z
        LD      A,(3880H)
        AND     1
        RET     Z
BRK0    LD      A,(38FFH)
        OR      A
        JR      NZ,BRK0
        LD      B,0
        DJNZ    $
BRK1    LD      A,(38FFH)
        OR      A
        JR      Z,BRK1
        LD      B,0
        DJNZ    $
        RET
SCRVID  LD      A,(DEMO)
        OR      A
        JR      Z,SCRV0
        LD      HL,CEI0
        LD      DE,SCR+24
        LD      B,15
SCRV1   LD      A,(HL)
        CALL    DISA
        INC     HL
        INC     DE
        DJNZ    SCRV1
SCRV0   CALL    AFF
        CALL    SOUND
        COND    0!(TYPE=TAPE)!(TYPE=PROT)
        CALL    TRCLN
        ENDC
        RET
CEI0    DEFM    '** MAD MINES **'
DIALOG  LD      A,(BASE)
        CP      1
        RET     Z
        OR      A
        JR      NZ,DIA0
        LD      HL,TPLAY
        LD      DE,SCR+448+28
        LD      BC,7
        CALL    AFF1L
        LD      A,(PLAY)
        OR      '0'
        LD      (DE),A
        CALL    SOUND
        RET
DIA0    CP      2
        RET     NZ
        LD      A,(PLAY)
        CP      1
        JR      NZ,DIA1
        LD      A,'1'
        EX      AF,AF'
        LD      A,(SHP1)
        JR      DIA2
DIA1    LD      A,'2'
        EX      AF,AF'
        LD      A,(SHP2)
DIA2    OR      A
        RET     NZ
        LD      HL,TGAM
        LD      DE,SCR+448+23
        LD      BC,17
        CALL    AFF1L
        CALL    SOUND
        EX      AF,AF'
        LD      (DE),A
        RET
TGAM    DEFM    'Game Over '
TPLAY   DEFM    'Player '
SCBAS   LD      A,1
        LD      (FLBAS),A
        RET
DSCORE  LD      A,(BLINK)
        INC     A
        AND     7
        LD      (BLINK),A
        LD      HL,LAST1
        LD      A,(SCORE1+2)
        AND     0FEH
        CP      (HL)
        CALL    SOUND
        JR      Z,DSC0
        LD      (HL),A
        LD      HL,SHP1
        INC     (HL)
        CALL    EXTRA
        CALL    SCBAS
DSC0    LD      HL,LAST2
        LD      A,(SCORE2+2)
        AND     0FEH
        CP      (HL)
        JR      Z,DSC1
        LD      (HL),A
        LD      HL,SHP2
        INC     (HL)
        CALL    EXTRA
        CALL    SCBAS
DSC1    LD      A,(PLAY)
        CP      1
        JR      NZ,DSC2
        LD      A,(BLINK)
        CP      4
        JR      NC,DSC3
DSC2    LD      HL,SCORE1
        LD      DE,SCR+3
        LD      BC,600H
DSC4    LD      A,(HL)
        CP      '0'
        JR      NZ,DSC5
        LD      A,C
        OR      A
        JR      Z,DSC6
        LD      A,'0'
DSC5    CALL    DISA
        CALL    SOUND
        LD      C,1
DSC6    INC     HL
        INC     DE
        DJNZ    DSC4
        DEC     DE
        LD      A,'0'
        CALL    DISA
        LD      A,(SHP1)
        OR      A
        JR      Z,DSC3
        CP      16H
        JR      C,DSC7
        LD      A,16H
DSC7    LD      DE,SCR+10
        LD      B,A
        LD      A,'+'
DSC8    CALL    DISA
        INC     DE
        DJNZ    DSC8
DSC3    LD      A,(NPLAY)
        CP      1
        JR      Z,DSC20
        LD      A,(PLAY)
        CP      2
        JR      NZ,DSC12
        LD      A,(BLINK)
        CP      4
        JR      NC,DSC20
DSC12   LD      HL,SCORE2
        LD      DE,SCR+37H
        LD      BC,600H
DSC14   LD      A,(HL)
        CP      '0'
        JR      NZ,DSC15
        LD      A,C
        OR      A
        DEC     DE
        JR      Z,DSC16
        INC     DE
        LD      A,'0'
DSC15   CALL    DISA
        CALL    SOUND
        LD      C,1
DSC16   INC     DE
        INC     HL
        DJNZ    DSC14
        LD      A,C
        OR      A
        JR      NZ,DSCOP
        LD      A,'0'
        CALL    DISA
DSCOP   LD      A,(SHP2)
        OR      A
        JR      Z,DSC20
        CP      16H
        JR      C,DSC17
        LD      A,16H
DSC17   LD      DE,SCR+35H
        LD      B,A
        LD      A,'+'
DSC18   CALL    DISA
        DEC     DE
        DJNZ    DSC18
        CALL    SOUND
DSC20   RET
EXTRA   LD      E,5
EXT0    LD      C,150
EXT1    LD      A,1
        OUT     (255),A
        LD      B,40
        DJNZ    $
        XOR     A
        OUT     (255),A
        LD      B,40
        DJNZ    $
        DEC     C
        JR      NZ,EXT1
        DEC     E
        RET     Z
        LD      C,100
EXT2    LD      A,1
        OUT     (255),A
        LD      B,60
        DJNZ    $
        XOR     A
        OUT     (255),A
        LD      B,60
        DJNZ    $
        DEC     C
        JR      NZ,EXT2
        JR      EXT0
DHSCOR  LD      A,(DEMO)
        OR      A
        RET     NZ
        LD      A,(NPLAY)
        CP      1
        JR      Z,DHS0
        LD      HL,SCORE1
        LD      DE,SCORE2
        LD      B,5
        CALL    SOUND
DHS1    LD      A,(DE)
        CP      (HL)
        JR      C,DHS0
        JR      NZ,DHS2
        INC     HL
        INC     DE
        DJNZ    DHS1
DHS0    LD      HL,SCORE1
        LD      A,1
        EX      AF,AF'
        JR      DHS3
DHS2    LD      HL,SCORE2
        LD      A,2
        EX      AF,AF'
DHS3    LD      DE,HSCORE
        PUSH    DE
        PUSH    HL
        CALL    SOUND
        LD      B,5
DHS4    LD      A,(DE)
        CP      (HL)
        JR      C,DHS5
        JR      NZ,DHS6
        INC     HL
        INC     DE
        DJNZ    DHS4
        XOR     A
        EX      AF,AF'
DHS5    POP     HL
        POP     DE
        EX      AF,AF'
        LD      B,A
        LD      A,(PLAY)
        CP      B
        JR      NZ,DHS7
        LD      A,(BLINK)
        CP      4
        RET     NC
        JR      DHS7
DHS6    POP     DE
        POP     HL
DHS7    CALL    SOUND
        LD      DE,SCR+1DH
        LD      B,6
DHS8    LD      A,(HL)
        CP      '0'
        JR      NZ,DHS9
        INC     HL
        INC     DE
        DJNZ    DHS8
        CALL    SOUND
        RET
DHS9    CALL    DISA
        INC     DE
        INC     HL
        LD      A,(HL)
        DJNZ    DHS9
        CALL    SOUND
        RET
DISA    PUSH    BC
        LD      C,A
        LD      A,(DE)
        CP      80H
        LD      A,C
        POP     BC
        RET     NZ
        LD      (DE),A
        RET
RAND    CALL    RND
        LD      E,A
        LD      D,0
        CALL    MUL16
        LD      A,H
        RET
RND     LD      A,R
        ADD     A,C
        RRCA
        LD      L,A
        AND     2
        SRL     A
        LD      H,A
        ADD     A,(HL)
        RRCA
        ADD     A,(HL)
        SRL     A
        SUB     (HL)
        ADD     A,E
        RRCA
        ADD     A,C
RND0    XOR     0
        LD      (RND0+1),A
        RET
DIV16   LD      A,L
        LD      L,H
        LD      H,0
        LD      E,0
        LD      B,16
        LD      IX,0
LOOPD   ADD     HL,HL
        RLA
        JR      NC,LOOPD1
        INC     L
LOOPD1  ADD     IX,IX
        INC     IX
        OR      A
        SBC     HL,DE
        JR      NC,CONTD
        ADD     HL,DE
        DEC     IX
CONTD   DJNZ    LOOPD
        RET
MUL16   LD      HL,0
MUL0    SRL     B
        JR      NC,MUL1
        ADD     HL,DE
MUL1    RET     Z
        EX      DE,HL
        ADD     HL,HL
        EX      DE,HL
        JR      MUL0
BOMB1   DEFW    8080H
        DEFW    8080H
        DEFW    8080H
        DEFW    8080H
        DEFW    8080H
        DEFW    8080H
        DEFW    8080H
        DEFW    0AA80H
        DEFW    80BFH
        DEFW    8080H
        DEFW    8080H
        DEFW    8080H
        DEFW    8080H
        DEFW    8080H
        DEFW    8080H
        DEFW    8080H
        DEFB    80H
BOMB2   DEFW    8080H
        DEFW    8080H
        DEFW    0BFAAH
        DEFW    8080H
        DEFW    8080H
        DEFW    8080H
        DEFW    8080H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    8095H
        DEFW    8080H
        DEFW    8080H
        DEFW    8080H
        DEFW    0BFAAH
        DEFW    8080H
        DEFW    8080H
        DEFB    80H
BOMB3   DEFW    8080H
        DEFW    0BF80H
        DEFW    0BFBFH
        DEFW    95BFH
        DEFW    8080H
        DEFW    8080H
        DEFW    0BFAAH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    8080H
        DEFW    8080H
        DEFW    0BF80H
        DEFW    0BFBFH
        DEFW    95BFH
        DEFW    8080H
        DEFB    80H
BOMB4   DEFW    0AA80H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    80BFH
        DEFW    0BF80H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    95BFH
        DEFW    0AA80H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    80BFH
        DEFB    80H
BOMB5   DEFW    0AA80H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    80BFH
        DEFW    0BF80H
        DEFW    8095H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    95BFH
        DEFW    0AA80H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    80BFH
        DEFB    80H
BOMB6   DEFW    0AA80H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    80BFH
        DEFW    0BF80H
        DEFW    0BFBFH
        DEFW    0AA80H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    95BFH
        DEFW    0AA80H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    80BFH
        DEFB    80H
BOMB7   DEFW    0AA80H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    80BFH
        DEFW    0BF80H
        DEFW    0BFBFH
        DEFW    95BFH
        DEFW    0BF80H
        DEFW    0BFBFH
        DEFW    95BFH
        DEFW    0AA80H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    80BFH
        DEFB    80H
BOMB8   DEFW    0AA80H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    80BFH
        DEFW    0BF80H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    80BFH
        DEFW    0BFAAH
        DEFW    95BFH
        DEFW    0AA80H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    80BFH
        DEFB    80H
BOMB9   DEFW    0AA80H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    80BFH
        DEFW    0BF80H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    8095H
        DEFW    95BFH
        DEFW    0AA80H
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    0BFBFH
        DEFW    80BFH
        DEFB    80H
BOMB10  DEFW    0AA80H
        DEFW    0BFBFH
        DEFW    8095H
        DEFW    0BFBFH
        DEFW    80BFH
        DEFW    0BF80H
        DEFW    0BFBFH
        DEFW    95BFH
        DEFW    0BF80H
        DEFW    0BFBFH
        DEFW    95BFH
        DEFW    0AA80H
        DEFW    0BFBFH
        DEFW    8095H
        DEFW    0BFBFH
        DEFW    80BFH
        DEFB    80H
BOMB11  DEFW    0AA80H
        DEFW    80BFH
        DEFW    8080H
        DEFW    0AA80H
        DEFW    80BFH
        DEFW    0BF80H
        DEFW    0BFBFH
        DEFW    8080H
        DEFW    8080H
        DEFW    0BFAAH
        DEFW    95BFH
        DEFW    0AA80H
        DEFW    80BFH
        DEFW    8080H
        DEFW    0AA80H
        DEFW    80BFH
        DEFB    80H
BOMB12  DEFW    8080H
        DEFW    8080H
        DEFW    8080H
        DEFW    8080H
        DEFW    8080H
        DEFW    0BF80H
        DEFW    8095H
        DEFW    8080H
        DEFW    8080H
        DEFW    8080H
        DEFW    95BFH
        DEFW    8080H
        DEFW    8080H
        DEFW    8080H
        DEFW    8080H
        DEFW    8080H
        DEFB    80H
BOMB13  DEFW    0AA80H
        DEFW    0BCBFH
        DEFW    8094H
        DEFW    0BEBCH
        DEFW    80BFH
        DEFW    8080H
        DEFW    0BFAAH
        DEFW    8A80H
        DEFW    808FH
        DEFW    0BFAAH
        DEFW    8080H
        DEFW    0AA80H
        DEFW    80BFH
        DEFW    8080H
        DEFW    0AA80H
        DEFW    80BFH
        DEFB    80H
BOMB14  DEFW    0A080H
        DEFW    8CB0H
        DEFW    8386H
        DEFW    0A48CH
        DEFW    80B0H
        DEFW    8080H
        DEFW    0BFAAH
        DEFW    8C8CH
        DEFW    8C8CH
        DEFW    0BFAEH
        DEFW    8080H
        DEFW    0AA80H
        DEFW    80BFH
        DEFW    8080H
        DEFW    0AA80H
        DEFW    80BFH
        DEFB    80H
BOMB15  DEFW    8280H
        DEFW    0BF83H
        DEFW    8397H
        DEFW    8383H
        DEFW    94BDH
        DEFW    8080H
        DEFW    8080H
        DEFW    95BFH
        DEFW    8080H
        DEFW    0BF80H
        DEFW    8095H
        DEFW    0A080H
        DEFW    0BFB0H
        DEFW    0B0B5H
        DEFW    0B0B0H
        DEFW    859FH
        DEFB    80H
BOMB16  DEFW    8080H
        DEFW    8380H
        DEFW    0BFABH
        DEFW    8183H
        DEFW    8080H
        DEFW    8080H
        DEFW    8080H
        DEFW    0AA80H
        DEFW    80BFH
        DEFW    8080H
        DEFW    8080H
        DEFW    8080H
        DEFW    0B080H
        DEFW    0BFBAH
        DEFW    90B0H
        DEFW    8080H
        DEFB    80H
BOMB17  DEFW    0AA80H
        DEFW    0BCBFH
        DEFW    8094H
        DEFW    0AA80H
        DEFW    80BFH
        DEFW    8080H
        DEFW    0BFAAH
        DEFW    8280H
        DEFW    0BC83H
        DEFW    0BFBEH
        DEFW    8080H
        DEFW    0AA80H
        DEFW    80BFH
        DEFW    8080H
        DEFW    0AA80H
        DEFW    80BFH
        DEFB    80H
BOMB18  DEFW    0AA80H
        DEFW    83BFH
        DEFW    8383H
        DEFW    8383H
        DEFW    8083H
        DEFW    8080H
        DEFW    0BFAAH
        DEFW    8C8CH
        DEFW    8C8CH
        DEFW    8084H
        DEFW    8080H
        DEFW    0AA80H
        DEFW    0B0BFH
        DEFW    0B0B0H
        DEFW    0B0B0H
        DEFW    80B0H
        DEFB    80H
BOMB19  DEFW    0A880H
        DEFW    83BCH
        DEFW    8383H
        DEFW    0A983H
        DEFW    80BCH
        DEFW    8080H
        DEFW    8382H
        DEFW    8C8CH
        DEFW    8C8CH
        DEFW    0B0A4H
        DEFW    8080H
        DEFW    8A80H
        DEFW    0B08FH
        DEFW    0B0B0H
        DEFW    9AB0H
        DEFW    808FH
        DEFB    80H
TABBOM  DEFW    BOMB1
        DEFW    BOMB2
        DEFW    BOMB3
        DEFW    BOMB4
        DEFW    BOMB5
        DEFW    BOMB6
        DEFW    BOMB7
        DEFW    BOMB8
        DEFW    BOMB9
        DEFW    BOMB10
        DEFW    BOMB11
        DEFW    BOMB12
        DEFW    BOMB13
        DEFW    BOMB14
        DEFW    BOMB15
        DEFW    BOMB16
        DEFW    BOMB17
        DEFW    BOMB18
        DEFW    BOMB19
EYE     DEFB    0
EYE0    DEFB    1
DBOMB   LD      HL,EYE
        LD      A,(EYE0)
        ADD     A,(HL)
        LD      (HL),A
        JR      Z,DBM0
        CP      4
        JR      NZ,DBM1
DBM0    LD      A,(EYE0)
        NEG
        LD      (EYE0),A
DBM1    LD      B,8
        LD      HL,TALIEN
        CALL    SOUND
DBM2    PUSH    BC
        PUSH    HL
        LD      A,(HL)
        OR      A
        JP      Z,DBM7
        CP      5
        JR      NZ,DBM3
        LD      B,A
        LD      A,(EYE)
        ADD     A,B
DBM3    DEC     A
        ADD     A,A
        LD      E,A
        LD      D,0
        PUSH    HL
        LD      HL,TABBOM
        ADD     HL,DE
        LD      E,(HL)
        INC     HL
        LD      D,(HL)
        POP     HL
        INC     HL
        LD      C,(HL)
        INC     HL
        LD      B,(HL)
        PUSH    BC
        POP     HL
        LD      B,3
DBM4    LD      C,11
DBM5    LD      A,(DE)
        LD      (HL),A
        INC     DE
        INC     HL
        DEC     C
        JR      NZ,DBM5
        DJNZ    DBM6
        JR      DBM7
DBM6    PUSH    DE
        LD      DE,64-11
        ADD     HL,DE
        POP     DE
        JR      DBM4
DBM7    POP     HL
        CALL    SOUND
        POP     BC
        LD      A,(HL)
        OR      A
        JR      Z,DBM8
        CP      5
        JR      C,DBM9
        CP      10
        JR      C,DBM8
        CP      13
        JR      NC,DBM10
        INC     (HL)
        LD      A,(HL)
        CP      13
        JR      NZ,DBM8
        PUSH    HL
        POP     IX
        LD      A,(IX+3)
        LD      (IX),A
        JR      DBM8
DBM10   LD      (HL),0FFH
DBM9    INC     (HL)
DBM8    CALL    SOUND
        LD      DE,4
        ADD     HL,DE
        DEC     B
        JP      NZ,DBM2
        RET
DEL     DEFB    DUREE
DEL0    DEFB    0
DELAY   LD      A,(DEL)
        OR      A
        JR      Z,DEL1
        DEC     A
        LD      (DEL),A
        RET
DEL1    LD      A,(DEL0)
        CALL    SOUND
        INC     A
        AND     3
        LD      (DEL0),A
        RET     NZ
        LD      IX,TALIEN
        LD      B,8
DEL2    LD      A,(IX)
        CP      5
        JR      Z,DEL3
        LD      DE,4
        ADD     IX,DE
        DJNZ    DEL2
        RET
DEL3    LD      (IX),10
        LD      HL,DATA5
        CALL    CSOUND
        RET
WDEM    DEFB    16
FLAGB   DEFB    0
DEMAR   LD      A,(FLAGB)
        OR      A
        RET     NZ
        LD      A,(WDEM)
        DEC     A
        LD      (WDEM),A
        RET     NZ
        LD      HL,TAL
        LD      DE,TALIEN
        LD      BC,8*4
        LDIR
        LD      A,1
        LD      (FLAGB),A
        RET
TAL     DEFB    1
        DEFW    VIDEO+128+15
        DEFB    13
        DEFB    1
        DEFW    VIDEO+128+27
        DEFB    14
        DEFB    1
        DEFW    VIDEO+128+39
        DEFB    15
        DEFB    1
        DEFW    VIDEO+384+3
        DEFB    13
        DEFB    1
        DEFW    VIDEO+384+15
        DEFB    16
        DEFB    1
        DEFW    VIDEO+384+27
        DEFB    17
        DEFB    1
        DEFW    VIDEO+384+39
        DEFB    18
        DEFB    1
        DEFW    VIDEO+384+51
        DEFB    19
BEGIN   LD      HL,STACK
        LD      SP,HL
        XOR     A
        LD      (COUNTS),A
        LD      A,(DEMO)
        OR      A
        JR      Z,BEG0
        LD      A,2
        LD      (NPLAY),A
        JR      BEG1
BEG0    LD      HL,0
        LD      (BLK1),HL
        LD      (BLK2),HL
BEG1    LD      A,1
        LD      (PLAY),A
        CALL    SCR191
        CALL    DISPL
        CALL    INITS
        CALL    CLSSCR
        CALL    CLSTIR
        CALL    DOBUS
        CALL    DALIEN
        CALL    DBOM
        CALL    DBASE
        CALL    AOBUS
        CALL    DLASER
        CALL    DSCORE
        CALL    DHSCOR
        CALL    DHEAT
        CALL    DIALOG
        CALL    DSTAR
        CALL    DISPL
MAIN    CALL    CLSSCR
        CALL    BRKCLR
        CALL    DOBUS
        CALL    DALIEN
        CALL    DBOM
        CALL    DBASE
        CALL    AOBUS
        CALL    DLASER
        CALL    DSCORE
        CALL    DHSCOR
        CALL    DHEAT
        CALL    DIALOG
        CALL    DSTAR
        CALL    SCRVID
        CALL    PROC
        CALL    MOVBSE
        CALL    MALIEN
        CALL    MOVBAS
        CALL    MBOM
        CALL    MLASER
        CALL    MHEAT
        JR      MAIN
INITS   LD      HL,TINIT
        LD      DE,SCORE1
        LD      BC,TINIT-SCORE1
        LDIR
INIT1   CALL    INITB
        XOR     A
        LD      (NBRE),A
        LD      HL,TALIEN
        LD      DE,TALIEN+1
        LD      BC,10*6-1
        LD      (HL),0
        LDIR
        RET
INIT0   LD      HL,TINIT0
        LD      DE,TBAS
        LD      BC,TINIT-TBAS
        LDIR
        JR      INIT1
INITB   LD      A,(PLAY)
        CP      1
        JR      NZ,INB0
        LD      A,(SHP1)
        JR      INB1
INB0    LD      A,(SHP2)
INB1    OR      A
        JR      NZ,INB2
        LD      A,3
        LD      (BASE),A
        RET
INB2    LD      IX,TBAS
        LD      A,1
        LD      (IX),A
        LD      (IX+1),A
        LD      HL,SCR+960+30
        LD      (IX+2),L
        LD      (IX+3),H
        RET
