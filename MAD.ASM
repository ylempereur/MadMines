        TITLE   ### MAD MINES ###
;               -----------------
PROT    EQU     2
DISK    EQU     1
TAPE    EQU     0
TYPE    EQU     DISK
;
DUREE   EQU     50H
        COND    0!(TYPE=TAPE)!(TYPE=DISK)
        ORG     3C00H+44
        DEFB    191
        DEFM    ' MAD MINES       **'
        ORG     3C40H+44
        DEFB    191
        DEFM    ' TRS-80 - MOD I/III'
        ORG     3C80H+44
        DEFW    8383H
        DEFW    8383H
        DEFW    8383H
        DEFW    8383H
        DEFW    8383H
        DEFW    8383H
        DEFW    8383H
        DEFW    8383H
        DEFW    8383H
        DEFW    8383H
        ENDC
        COND    TYPE=PROT
        ORG     4800H
        ENDC
        COND    TYPE=TAPE
        ORG     4300H
        ENDC
        COND    TYPE=DISK
        INCLUDE SYSMACRO
        ORG     8000H
        ENDC
        INCLUDE MAD1
        INCLUDE MAD2
DSTAR   LD      IX,TASTA
        LD      B,16
        LD      HL,SCR
DST0    PUSH    BC
        PUSH    HL
        LD      A,(IX)
        OR      A
        JR      Z,DST1
        LD      E,A
        LD      D,0
        ADD     HL,DE
        LD      A,(HL)
        CP      80H
        JR      NZ,DST1
        LD      (HL),'.'
DST1    POP     HL
        LD      DE,64
        ADD     HL,DE
        INC     IX
        POP     BC
        DJNZ    DST0
DST2    LD      A,0
        INC     A
        AND     1
        LD      (DST2+1),A
        RET     NZ
        LD      HL,TASTA+14
        LD      DE,TASTA+15
        LD      BC,15
        LDDR
        CALL    RND
        AND     3FH
        LD      (TASTA),A
        CALL    RND
        AND     0FH
        LD      E,A
        LD      D,0
        LD      HL,TASTA
        ADD     HL,DE
        PUSH    HL
        CALL    RND
        POP     HL
        AND     3FH
        LD      (HL),A
        RET
TASTA   DEFW    0
        DEFW    0
        DEFW    0
        DEFW    0
        DEFW    0
        DEFW    0
        DEFW    0
        DEFW    0
        COND    TYPE=TAPE
TRCLN   LD      A,(BASE)
        CP      1
        RET     NZ
        LD      H,40H
        LD      L,0E1H
        INC     H
        INC     L
        LD      A,(HL)
        DEC     A
        CP      79H
        JR      NZ,CLEAN
        INC     HL
        LD      A,(HL)
        DEC     A
        CP      7FH
        JR      NZ,CLEAN
        INC     HL
        LD      A,(HL)
        DEC     A
        CP      42H
        RET     Z
CLEAN   LD      HL,8000H
        LD      DE,4000H
        LD      BC,8000H
        LDIR
        RET
        ENDC
        COND    TYPE=PROT
TRCLN   LD      A,(BASE)
        CP      1
        RET     NZ
        LD      H,44H
        LD      L,10H
        LD      E,(HL)
        INC     HL
        LD      D,(HL)
        EX      DE,HL
        XOR     A
        LD      (HL),A
        CP      (HL)
        JP      Z,CLEANP
        DEC     HL
        LD      (HL),A
        CP      (HL)
        JP      NZ,CLEANP
        LD      A,(9000H)
        CP      0CDH
        JP      NZ,CLEANP
        RET
        ENDC
DALIEN  LD      A,(BASE)
        OR      A
        RET     Z
        CP      4
        RET     NC
        LD      A,(FORME+1)
        XOR     1
        LD      (FORME+1),A
        LD      HL,POINT
        LD      A,(POI0)
        ADD     A,(HL)
        LD      (HL),A
        JR      Z,DAL0
        CP      4
        JR      NZ,DAL1
DAL0    LD      A,(POI0)
        NEG
        LD      (POI0),A
DAL1    LD      B,10
        LD      HL,TALIEN
        CALL    SOUND
DAL2    PUSH    BC
        PUSH    HL
        LD      A,(HL)
        OR      A
        JP      Z,DAL10
        DEC     A
        ADD     A,A
        LD      E,A
        LD      D,0
        PUSH    HL
        LD      HL,TADD
        ADD     HL,DE
        EX      DE,HL
        POP     HL
        INC     HL
        PUSH    HL
        LD      C,(HL)
        LD      B,0
        LD      HL,TCAL
        ADD     HL,BC
        LD      L,(HL)
        LD      H,0
        LD      A,(DE)
        LD      C,A
        INC     DE
        LD      A,(DE)
        LD      B,A
        ADD     HL,BC
        CALL    SOUND
        EX      DE,HL
        POP     HL
        INC     HL
        LD      C,(HL)
        INC     HL
        LD      B,(HL)
        PUSH    BC
        POP     HL
        PUSH    DE
        PUSH    HL
        LD      DE,SCRTIR-SCR
        ADD     HL,DE
        PUSH    HL
        EXX
        POP     HL
        EXX
        POP     HL
        POP     DE
        LD      B,2
        EXX
        LD      E,0
        EXX
DAL3    LD      C,4
DAL4    LD      A,(DE)
        EXX
        AND     (HL)
        LD      B,A
        OR      E
        LD      E,A
        LD      A,B
        AND     3FH
        JR      Z,DALJ
        LD      (HL),80H
DALJ    INC     HL
        EXX
        LD      A,(DE)
        OR      (HL)
        LD      (HL),A
        INC     DE
        INC     HL
        DEC     C
        JR      NZ,DAL4
        DJNZ    DAL5
        JR      DAL6
DAL5    PUSH    DE
        LD      DE,3CH
        ADD     HL,DE
        POP     DE
        EXX
        PUSH    DE
        LD      DE,3CH
        ADD     HL,DE
        POP     DE
        EXX
        JR      DAL3
DAL6    POP     HL
        CALL    SOUND
        POP     BC
        EXX
        LD      A,E
        EXX
        AND     3FH
        JR      Z,DAL11
        LD      A,(HL)
        CP      9
        JP      C,DAL12
        CP      14
        PUSH    BC
        PUSH    HL
        JR      NC,DAL7
        LD      (HL),7
        LD      HL,DATA5
        CALL    CSOUND
        LD      A,DUREE
        LD      (ATTC),A
        JR      DAL10
DAL7    LD      HL,DATA1
        CALL    CSOUND
        LD      HL,0
        LD      (DATA2-2),HL
        LD      A,DUREE
        LD      (ATTC),A
        POP     HL
        POP     BC
        LD      A,(HL)
        PUSH    BC
        PUSH    HL
        PUSH    HL
        POP     IX
        CALL    ADDPO
        LD      A,(PHASE)
        CP      5
        JR      NZ,DALCC
        LD      A,22
        CALL    ADDPO
DALCC   LD      (IX),4
        LD      HL,NBRE
        DEC     (HL)
        JR      NZ,DAL10
        LD      A,1
        LD      (FLAS0),A
DAL10   POP     HL
        POP     BC
DAL11   LD      A,(HL)
        CP      9
        JR      NZ,DAL12
        CALL    SOUND
        PUSH    BC
        PUSH    HL
        INC     HL
        LD      A,(HL)
        INC     HL
        LD      E,(HL)
        INC     HL
        LD      D,(HL)
        LD      C,A
        RRCA
        LD      A,C
        JR      NC,DAL13
        INC     DE
DAL13   CP      4
        JR      C,DAL14
        LD      HL,64
        ADD     HL,DE
        EX      DE,HL
DAL14   LD      C,A
        LD      (POI1),A
        LD      A,(POINT)
        AND     1
        XOR     C
        LD      C,A
        LD      B,0
        LD      HL,TPOI
        ADD     HL,BC
        LD      C,(HL)
        LD      A,(POI1)
        CPL
        AND     1
        LD      HL,POINT
        ADD     A,(HL)
        SRL     A
        LD      L,A
        LD      H,0
        ADD     HL,DE
        LD      A,(HL)
        AND     C
        LD      (HL),A
        POP     HL
        POP     BC
DAL12   CALL    SOUND
        LD      A,(HL)
        OR      A
        JR      Z,DAL15
        CP      5
        JR      C,DAL16
        CP      9
        JR      NC,DAL17
        DEC     (HL)
        LD      A,(HL)
        CP      4
        JR      NZ,DAL15
        PUSH    HL
        POP     IX
        CALL    CALIEN
        JR      DAL15
DAL17   JR      Z,DAL15
        CP      14
        JR      C,DAL16
FORME   LD      A,0
        XOR     (HL)
        LD      (HL),A
        JR      DAL15
DAL16   DEC     (HL)
DAL15   CALL    SOUND
        LD      DE,6
        ADD     HL,DE
        DEC     B
        JP      NZ,DAL2
        RET
POI1    DEFB    0
CALIEN  PUSH    HL
        PUSH    DE
        PUSH    BC
        LD      A,(PHASE)
        CP      5
        JR      Z,CAL0
        CALL    SOUND
        ADD     A,A
        ADD     A,12
        JR      CALC1
CAL0    CALL    RND
        AND     3
        ADD     A,A
        ADD     A,14
CALC1   LD      (IX),A
        LD      A,(IX+5)
        OR      A
        JP      P,CALC2
        NEG
CALC2   LD      (IX+5),A
        LD      A,(IX)
        CP      20
        JR      C,CALC3
        LD      (IX+4),0
CALC3   POP     BC
        POP     DE
        POP     HL
        RET
ADDPO   SUB     14
        AND     0FEH
        LD      C,A
        LD      B,0
        LD      HL,TSCO
        ADD     HL,BC
        LD      D,(HL)
        INC     HL
        LD      C,(HL)
        LD      B,0
        CALL    SCOR12
        CALL    SOUND
        ADD     HL,BC
ADD3    LD      A,(HL)
        ADD     A,D
        CP      '9'+1
        JR      C,ADD2
        LD      D,1
        SUB     10
ADD0    CP      '9'+1
        JR      C,ADD1
        SUB     '9'+1
        INC     D
        JR      ADD0
ADD1    LD      (HL),A
        DEC     C
        DEC     HL
        JP      P,ADD3
        CALL    SOUND
        RET
ADD2    LD      (HL),A
        CALL    SOUND
        RET
TSCO    DEFB    2
        DEFB    4
        DEFB    4
        DEFB    4
        DEFB    6
        DEFB    4
        DEFB    8
        DEFB    4
        DEFB    6
        DEFB    4
ATTC0   DEFB    0
ATTEN   LD      A,(ATTC)
        OR      A
        JR      Z,ATT0
        DEC     A
        LD      (ATTC),A
        RET
ATT0    LD      A,(ATTC0)
        INC     A
        AND     3
        LD      (ATTC0),A
        RET     NZ
        LD      IX,TALIEN
        LD      B,10
ATT1    LD      A,(IX)
        CP      9
        JR      Z,ATT2
        LD      DE,6
        ADD     IX,DE
        DJNZ    ATT1
        RET
ATT2    LD      (IX),7
        LD      HL,DATA5
        CALL    CSOUND
        RET
DLASER  LD      A,(HLASER)
        OR      A
        RET     Z
        LD      A,(VLASER)
        LD      B,0FFH
DLA0    INC     B
        SUB     3
        JP      P,DLA0
        ADD     A,3
        LD      C,A
        LD      L,B
        LD      H,0
        LD      B,6
DLA1    ADD     HL,HL
        DJNZ    DLA1
        LD      DE,SCR-128
        ADD     HL,DE
        PUSH    HL
        POP     IX
        LD      A,C
        SLA     A
        SLA     A
        LD      E,A
        LD      D,0
        LD      HL,TLASER
        ADD     HL,DE
        LD      A,(VLASER)
        CP      6
        JR      NC,DLA3
        INC     HL
        INC     HL
        CP      3
        JR      NC,DLA4
        RET
DLA3    LD      A,(HL)
        INC     HL
        OR      (IX)
        LD      (IX),A
        LD      A,(HL)
        INC     HL
        OR      (IX+3FH)
        LD      (IX+3FH),A
DLA4    LD      A,(HL)
        INC     HL
        OR      (IX+40H)
        LD      (IX+40H),A
        LD      A,(HL)
        OR      (IX+7FH)
        LD      (IX+7FH),A
        LD      A,C
        CP      2
        RET     NZ
        LD      A,(HLASER)
        CP      1
        RET     Z
        LD      DE,64
        ADD     IX,DE
        LD      (IX+1),'('
        LD      (IX+3EH),')'
        LD      A,(HLASER)
        CP      2
        RET     Z
        PUSH    IX
        POP     DE
        INC     DE
        INC     DE
        LD      HL,3BH
        ADD     HL,DE
        EX      DE,HL
        LD      A,(HLASER)
        SUB     2
        LD      B,A
        LD      C,'-'
DLA2    LD      A,(HL)
        CP      80H
        JR      NZ,DLA5
        LD      (HL),C
DLA5    LD      A,(DE)
        CP      80H
        JR      NZ,DLA6
        LD      A,C
        LD      (DE),A
DLA6    INC     HL
        DEC     DE
        CALL    SOUND
        DJNZ    DLA2
        RET
MLASER  LD      A,(VLAS0)
        LD      B,A
        LD      A,(VLASER)
        CP      B
        JP      C,ILASER
        LD      A,(FLAS0)
        OR      A
        RET     Z
        DEC     A
        JR      Z,MLA0
        DEC     A
        JR      Z,MLA1
        LD      A,(HLASER)
        CP      32
        JR      Z,MLA2
        INC     A
        LD      (HLASER),A
        CALL    SON
        RET
MLA2    XOR     A
        LD      (FLAS0),A
        LD      A,1
        LD      (FLASER),A
        LD      A,(BASE)
        OR      A
        RET     NZ
        LD      A,1
        LD      (BASE),A
        RET
MLA0    LD      A,(HLASER)
        CP      1
        JR      Z,MLA3
        DEC     A
        LD      (HLASER),A
        CALL    SON
        RET
MLA3    LD      A,(FLAS0)
        INC     A
        LD      (FLAS0),A
        RET
MLA1    LD      A,(CLASER)
        INC     A
        AND     3
        LD      (CLASER),A
        CALL    SONI
        RET     NZ
        LD      A,(VLASER)
        CP      47
        JR      Z,MLA4
        INC     A
        LD      (VLASER),A
MLA4    SUB     3
        JP      P,MLA4
        ADD     A,3
        CP      2
        RET     NZ
        JR      MLA3
ILASER  LD      A,2
        LD      (FLAS0),A
        JR      MLA1
SON     PUSH    AF
        PUSH    BC
        LD      A,1
        OUT     (255),A
        LD      A,(HLASER)
        LD      B,A
        DJNZ    $
        XOR     A
        OUT     (255),A
        LD      A,(HLASER)
        LD      B,A
        DJNZ    $
        POP     BC
        POP     AF
        RET
SONI    PUSH    AF
        PUSH    BC
        LD      C,16
SOI1    LD      A,1
        OUT     (255),A
        LD      A,(VLASER)
        ADD     A,16
        LD      B,A
        DJNZ    $
        XOR     A
        OUT     (255),A
        LD      A,(VLASER)
        ADD     A,16
        LD      B,A
        DJNZ    $
        DEC     C
        JR      NZ,SOI1
        POP     BC
        POP     AF
        RET
DOCD    XOR     A
        LD      (FLBAS),A
        LD      A,(TBAS+4)
        OR      A
        JP      NZ,NPHR
        LD      A,4
        LD      (BASE),A
        LD      A,1
        LD      (TBAS+4),A
        LD      A,2
        LD      (TBAS+5),A
        LD      HL,SCR
        LD      (TBAS+6),HL
        RET
NPHASE  LD      A,(BASE)
        CP      1
        RET     NZ
        LD      A,(FLAS0)
        OR      A
        RET     NZ
        LD      A,(FLBAS)
        OR      A
        JP      NZ,DOCD
NPHR    LD      A,(WAIT)
        DEC     A
        LD      (WAIT),A
        RET     NZ
        LD      A,(PHASE)
        CP      5
        JR      Z,NPH0
        INC     A
NPH0    LD      (PHASE),A
        LD      A,DUREE
        LD      (ATTC),A
        LD      A,10
        LD      (NBRE),A
        LD      A,16
        LD      (WAIT),A
        LD      IX,TALIEN
        LD      B,10
NPH1    PUSH    BC
        LD      (IX),13
        LD      A,(VLASER)
        SUB     9
        LD      B,A
        CALL    RAND
        ADD     A,3
        LD      E,0FFH
NPH2    INC     E
        SUB     3
        JP      P,NPH2
        ADD     A,3
        LD      (IX+1),A
        LD      D,0
        EX      DE,HL
        LD      B,6
NPH3    ADD     HL,HL
        DJNZ    NPH3
        PUSH    HL
        RANDOM  0,121
        POP     HL
        SRL     A
        JR      NC,NPH4
        INC     (IX+1)
NPH4    LD      E,A
        LD      D,0
        ADD     HL,DE
        LD      DE,SCR
        ADD     HL,DE
        LD      (IX+2),L
        LD      (IX+3),H
        RANDOM  0,1
        SLA     A
        DEC     A
        LD      (IX+4),A
        RANDOM  0,1
        SLA     A
        DEC     A
        LD      (IX+5),A
        POP     BC
        LD      DE,6
        ADD     IX,DE
        DJNZ    NPH1
        RET
MOVE    LD      A,D
        CALL    SOUND
        OR      A
MOVE0   JR      Z,MOVE6
        LD      A,B
        JP      P,MOVE2
        DEC     A
        SRL     A
        JR      NC,MOVE1
        INC     B
        DEC     HL
        JR      MOVE4
MOVE1   DEC     B
        JR      MOVE4
MOVE2   INC     A
        SRL     A
        CALL    SOUND
        JR      C,MOVE3
        DEC     B
        INC     HL
        JR      MOVE4
MOVE3   INC     B
MOVE4   LD      A,D
        OR      A
        JP      P,MOVE5
        INC     D
        JR      MOVE0
MOVE5   DEC     D
        JR      MOVE0
MOVE6   LD      A,E
        OR      A
MOVE7   RET     Z
        PUSH    DE
        LD      A,B
        JP      P,MOVE11
        SUB     2
        JP      P,MOVE9
        ADD     A,6
        LD      DE,-64
MOVE8   ADD     HL,DE
MOVE9   LD      B,A
        POP     DE
        CALL    SOUND
        LD      A,E
        OR      A
        JP      P,MOVE10
        INC     E
        JR      MOVE7
MOVE10  DEC     E
        JR      MOVE7
MOVE11  ADD     A,2
        CP      6
        JR      C,MOVE9
        SUB     6
        LD      DE,64
        JR      MOVE8
MALIEN  LD      A,(NBRE)
        OR      A
        JP      Z,NPHASE
        CALL    ATTEN
        CALL    MALI
MALI    LD      A,(CMOVE)
        INC     A
        AND     3
        LD      (CMOVE),A
        LD      IX,TALIEN
        LD      B,10
MAL0    PUSH    BC
        LD      A,(IX)
        CP      9
        JP      C,MAL1
        JR      Z,MAL2
        CP      14
        JP      NC,MAL3
        JP      MAL1
MAL2    LD      A,(CMOVE)
        AND     3
        JP      NZ,MAL1
        LD      B,(IX+1)
        LD      L,(IX+2)
        LD      H,(IX+3)
        LD      A,(IX+5)
        OR      A
        JP      P,MAL4
        PUSH    HL
        LD      DE,SCR+128
        OR      A
        SBC     HL,DE
        POP     HL
        JP      P,MAL5
        LD      A,B
        AND     6
        JR      NZ,MAL5
        JR      MAL6
MAL4    LD      A,B
        AND     6
        CP      2
        JR      NZ,MAL5
        LD      A,(VLASER)
        SUB     8
        LD      E,0FFH
MAL7    INC     E
        SUB     3
        JP      P,MAL7
        LD      D,0
        EX      DE,HL
        PUSH    BC
        LD      B,6
MAL8    ADD     HL,HL
        DJNZ    MAL8
        POP     BC
        EX      DE,HL
        PUSH    HL
        LD      HL,SCR
        ADD     HL,DE
        EX      DE,HL
        POP     HL
        PUSH    HL
        OR      A
        SBC     HL,DE
        POP     HL
        JP      M,MAL5
MAL6    LD      A,(IX+5)
        NEG
        LD      (IX+5),A
MAL5    LD      A,(IX+4)
        OR      A
        JP      P,MAL9
        LD      A,L
        AND     3FH
        JR      NZ,MAL10
        LD      A,B
        AND     1
        JR      NZ,MAL10
        CALL    SOUND
        JR      MAL11
MAL9    LD      A,L
        AND     3FH
        CP      3CH
        JR      NZ,MAL10
        LD      A,B
        AND     1
        JR      Z,MAL10
MAL11   LD      A,(IX+4)
        NEG
        LD      (IX+4),A
MAL10   LD      D,(IX+4)
        LD      E,(IX+5)
        LD      A,(IX)
        AND     0FEH
        CP      18
        JR      NZ,MALTT
        LD      A,B
        AND     1
        JR      Z,MALTT
        LD      E,0
MALTT   CALL    MOVE
        LD      (IX+1),B
        LD      (IX+2),L
        LD      (IX+3),H
        CALL    SOUND
MAL1    LD      DE,6
        ADD     IX,DE
        POP     BC
        DEC     B
        JP      NZ,MAL0
        RET
MAL3    LD      A,(CMOVE)
        LD      B,A
        LD      IY,TVIT
        LD      A,(IX)
        SUB     14
        SRL     A
        LD      (MALX+2),A
MALX    LD      A,(IY+0)
        AND     B
        JR      NZ,MAL1
        LD      B,(IX+1)
        LD      L,(IX+2)
        LD      H,(IX+3)
        LD      A,(IX)
        CP      20
        JR      C,MALR
        LD      A,(IX+5)
        OR      A
        JR      NZ,MALB
MALR    LD      A,(IX+5)
        OR      A
        JP      M,MAL05
        PUSH    HL
        LD      DE,SCR+960
        OR      A
        SBC     HL,DE
        POP     HL
        JP      M,MAL07
        LD      A,B
        AND     6
        JR      NZ,MAL07
        JR      MAL06
MAL05   LD      A,B
        AND     6
        CP      4
        JR      NZ,MAL07
        LD      A,(VLASER)
        SUB     3
        LD      E,0
MAL08   INC     E
        SUB     3
        JP      P,MAL08
        LD      D,0
        EX      DE,HL
        PUSH    BC
        LD      B,6
MAL09   ADD     HL,HL
        DJNZ    MAL09
        POP     BC
        EX      DE,HL
        PUSH    HL
        LD      HL,SCR
        ADD     HL,DE
        EX      DE,HL
        POP     HL
        PUSH    HL
        OR      A
        SBC     HL,DE
        POP     HL
        JP      P,MAL07
MAL06   LD      A,(IX+5)
        NEG
        LD      (IX+5),A
MAL07   JP      MAL5
MALB    PUSH    HL
        LD      DE,SCR+960
        OR      A
        SBC     HL,DE
        POP     HL
        JP      M,MAL07
        LD      A,B
        AND     6
        JR      NZ,MAL07
        LD      (IX+5),0
        LD      A,L
        AND     3FH
        SLA     A
        LD      C,A
        LD      A,B
        AND     1
        ADD     A,C
        LD      C,A
        LD      A,(TBAS)
        OR      A
        JR      Z,MALB0
        LD      A,(TBAS+2)
        JR      MALB1
MALB0   LD      A,(TBAS+4)
        OR      A
        JP      Z,MAL1
        LD      A,(TBAS+6)
MALB1   AND     3FH
        SLA     A
        ADD     A,2
        SUB     C
        JP      M,MALB2
        LD      A,1
        JR      MALB3
MALB2   LD      A,0FFH
MALB3   LD      (IX+4),A
        JR      MAL07
DBOM    LD      A,(BOFL)
        OR      A
        RET     Z
        LD      HL,(BOPOS)
        LD      A,(BOCAL)
        CALL    DECAL
        LD      A,(HL)
        OR      B
        LD      (HL),A
        CALL    SOUND
        RET
DECAL   LD      B,1
        CALL    SOUND
DEC0    OR      A
        RET     Z
        SLA     B
        DEC     A
        JR      DEC0
MBOM    LD      A,(BOFL)
        OR      A
        JR      Z,CBOM
        LD      A,(BOCAL)
        LD      B,A
        LD      HL,(BOPOS)
        LD      DE,2
        CALL    MOVE
        LD      (BOPOS),HL
        LD      A,B
        LD      (BOCAL),A
        CALL    VERY
        JP      M,MBO0
        XOR     A
        LD      (BOFL),A
MBO0    RET
CBOM    LD      A,(BOWT)
        DEC     A
        JR      Z,CBO0
        LD      (BOWT),A
        RET
CBO0    LD      A,100
        LD      (BOWT),A
        LD      IX,TALIEN
        LD      B,10
CBO1    LD      A,(IX)
        CP      14
        JR      NC,CBO2
        LD      DE,6
        ADD     IX,DE
        DJNZ    CBO1
        RET
CBO2    LD      L,(IX+2)
        LD      H,(IX+3)
        LD      DE,65
        ADD     HL,DE
        LD      A,(IX+1)
        XOR     1
        BIT     0,A
        JR      NZ,CBO3
        INC     HL
CBO3    LD      (BOCAL),A
        LD      (BOPOS),HL
        LD      A,1
        LD      (BOFL),A
        RET
VERY    PUSH    HL
        PUSH    DE
        LD      DE,SCR+1024
        OR      A
        SBC     HL,DE
        POP     DE
        POP     HL
        CALL    SOUND
        RET
DHEAT   LD      A,(BASE)
        CP      1
        RET     NZ
        LD      A,(HEAT)
        SRL     A
        LD      HL,SCR+42
DHE0    CP      4
        JR      C,DHE1
        EX      AF,AF'
        LD      A,(HL)
        BIT     7,A
        JR      Z,DHE3
        OR      8FH
DHE3    LD      (HL),A
        EX      AF,AF'
        INC     HL
        SUB     4
        JR      DHE0
DHE1    LD      IX,THEAT
        LD      (DHE2+2),A
DHE2    LD      A,(IX+0)
        LD      B,A
        LD      A,(HL)
        BIT     7,A
        JR      Z,DHE4
        OR      B
DHE4    LD      (HL),A
        INC     HL
        LD      A,(FHEAT)
        OR      A
        RET     Z
        LD      A,(BLINK)
        CP      4
        RET     NC
        LD      A,(HL)
        CP      80H
        RET     NZ
        LD      (HL),'H'
        RET
THEAT   DEFB    81H
        DEFB    85H
        DEFB    8DH
        DEFB    8FH
MHEAT   LD      A,(BASE)
        CP      1
        JR      Z,MHE0
        XOR     A
        LD      (HEAT),A
        RET
MHE0    LD      HL,WHEAT
        DEC     (HL)
        JR      NZ,MHE1
        LD      (HL),32
        LD      A,(HEAT)
        OR      A
        JR      Z,MHE1
        DEC     A
        LD      (HEAT),A
MHE1    LD      A,(HEAT)
        CP      31
        JR      NZ,MHE2
        LD      A,1
        LD      (FHEAT),A
        RET
MHE2    CP      24
        RET     NC
        XOR     A
        LD      (FHEAT),A
        RET
DBASE   LD      A,(BASE)
        CP      1
        JR      Z,DBA2
        CP      4
        JP      C,DEXP
DBA2    CALL    SOUND
        LD      IX,TBAS
        LD      B,2
DBA0    PUSH    BC
        PUSH    IX
        LD      A,(IX)
        OR      A
        JR      Z,DBA1
        LD      DE,TBASE
        LD      B,(IX+1)
        LD      L,(IX+2)
        LD      H,(IX+3)
        CALL    DBAX
DBA1    POP     IX
        POP     BC
        LD      DE,4
        ADD     IX,DE
        CALL    SOUND
        DJNZ    DBA0
        RET
DBAX    LD      IY,TCAB
        LD      A,B
        LD      (DBAX0+2),A
DBAX0   LD      C,(IY+0)
        LD      B,0
        EX      DE,HL
        ADD     HL,BC
        EX      DE,HL
        EXX
        LD      B,0
        EXX
        LD      B,2
DBAX1   LD      C,3
        CALL    SOUND
DBAX3   LD      A,(DE)
        AND     (HL)
        EXX
        OR      B
        LD      B,A
        EXX
        LD      A,(DE)
        OR      (HL)
        LD      (HL),A
        INC     DE
        INC     HL
        DEC     C
        JR      NZ,DBAX3
        DJNZ    DBAX4
        CALL    SOUND
        JR      DBAX2
DBAX4   PUSH    DE
        LD      DE,61
        ADD     HL,DE
        POP     DE
        JR      DBAX1
DBAX2   CALL    SOUND
        EXX
        LD      A,B
        AND     3FH
        RET     Z
        LD      A,(BASE)
        CP      2
        RET     Z
        LD      A,2
        LD      (BASE),A
        LD      HL,DATA8
        CALL    CSOUND
        LD      HL,0
        LD      (DATA2-2),HL
        LD      A,(PLAY)
        CP      1
        JR      NZ,DFG
        LD      HL,SHP1
        JR      DFH
DFG     LD      HL,SHP2
DFH     DEC     (HL)
        CALL    IEXP
        RET
CEXP    DEFB    0
DEXP    LD      A,(BASE)
        CP      2
        RET     NZ
        LD      A,(CEXP)
        DEC     A
        LD      (CEXP),A
        JR      NZ,DEXP0
        LD      A,3
        LD      (BASE),A
        RET
DEXP0   LD      IX,TEXP
        LD      B,32
DEX0    PUSH    BC
        LD      A,(IX)
        OR      A
        JR      Z,DEX1
        CALL    SOUND
        LD      L,(IX+2)
        LD      H,(IX+3)
        LD      A,(IX+1)
        CALL    DECAL
        LD      A,(HL)
        OR      B
        LD      (HL),A
        LD      B,(IX+1)
        LD      D,(IX+4)
        LD      E,(IX+5)
        CALL    MOVE
        LD      (IX+1),B
        LD      (IX+2),L
        LD      (IX+3),H
        CALL    VERY
        JP      M,DEX2
        XOR     A
        LD      (IX),A
        JR      DEX1
DEX2    INC     (IX+5)
DEX1    LD      DE,6
        ADD     IX,DE
        POP     BC
        DJNZ    DEX0
        CALL    SOUND
        RET
IEXP    LD      A,(TBAS)
        OR      A
        JR      Z,IEX0
        LD      A,(TBAS+1)
        LD      HL,(TBAS+2)
        JR      IEXX
IEX0    LD      A,(TBAS+4)
        OR      A
        RET     Z
        LD      A,(TBAS+5)
        LD      HL,(TBAS+6)
IEXX    LD      DE,1
        ADD     HL,DE
        LD      C,A
        LD      B,32
        LD      IX,TEXP
        LD      DE,1F9H
IEX2    LD      (IX),1
        LD      (IX+1),C
        LD      (IX+2),L
        LD      (IX+3),H
        LD      (IX+4),E
        PUSH    HL
        PUSH    BC
        PUSH    DE
        CALL    RND
        POP     DE
        POP     BC
        POP     HL
        AND     7
        NEG
        LD      (IX+5),A
        LD      A,D
        XOR     1
        LD      D,A
        ADD     A,E
        LD      E,A
        PUSH    DE
        LD      DE,6
        ADD     IX,DE
        POP     DE
        DJNZ    IEX2
        CALL    SOUND
        LD      A,64
        LD      (CEXP),A
        RET
MOVBSE  LD      A,(BASE)
        CP      1
        RET     NZ
MOVBAS  LD      A,(BASE)
        CP      1
        JR      Z,MOVB
        CP      4
        RET     C
MOVB    CALL    SOUND
        LD      H,0
ADDL    LD      A,(3840H)
KEYL    AND     20H
        LD      C,A
        IN      A,(0)
        CPL
        AND     4
        OR      C
        JR      Z,ADDR
        DEC     H
ADDR    LD      A,(3840H)
KEYR    AND     40H
        LD      B,A
        IN      A,(0)
        CPL
        AND     8
        OR      B
        JR      Z,MOV1
        INC     H
MOV1    LD      A,(DEMO)
        OR      A
        JP      Z,MOV2
        LD      A,(TBAS)
        OR      A
        JR      Z,XM1
        LD      A,(TBAS+2)
        JR      XMK
XM1     LD      A,(TBAS+4)
        OR      A
        JP      Z,MOV2
        LD      A,(TBAS+6)
XMK     AND     3FH
        LD      C,A
        XOR     A
        LD      (TYM),A
        LD      E,0FFH
        LD      IX,TALIEN
        LD      B,10
YM0     LD      A,(IX)
        CP      5
        JR      C,YM1
        CP      14
        JR      NC,YM7
        LD      A,(TYM)
        CP      14
        JR      NC,YM1
        JR      YM2
YM7     LD      A,(TYM)
        CP      14
        JR      C,YM3
YM2     LD      A,(TYM)
        OR      A
        JR      Z,YM3
        LD      A,(IX+2)
        AND     3FH
        SUB     C
        JP      P,YM4
        NEG
YM4     CP      E
        JR      NC,YM1
YM3     LD      A,(IX+3)
        SUB     SCR<-8
        AND     3
        CP      3
        JR      NC,YM1
        LD      A,(IX+2)
        AND     3FH
        SUB     C
        JP      P,YM5
        NEG
YM5     LD      E,A
        LD      A,(IX+2)
        AND     3FH
        LD      (TYP),A
        LD      A,(IX)
        LD      (TYM),A
YM1     PUSH    DE
        LD      DE,6
        ADD     IX,DE
        POP     DE
        DJNZ    YM0
        LD      A,(TYM)
        OR      A
        JR      Z,MOV2
        LD      A,(TYP)
        SUB     C
        JP      M,YM6
        INC     H
        JR      MOV2
YM6     DEC     H
MOV2    CALL    SOUND
        LD      D,H
        LD      E,0
        LD      A,H
        OR      A
        JP      Z,IBASE
        LD      IX,TBAS
        CALL    GET0
        OR      A
        JR      Z,MOV6
        CALL    MBAS0
MOV6    CALL    PUT0
        CALL    SOUND
        CALL    GET0
        OR      A
        JP      Z,IBASE
        LD      A,(BASE)
        CP      4
        JP      NC,IBASE
        CALL    MBAS
        CALL    PUT0
        CALL    SOUND
        JP      IBASE
TYM     DEFB    0
TYP     DEFB    0
MBAS    LD      A,D
        OR      A
        JR      Z,MBA2
        JP      P,MBA1
        LD      A,L
        AND     3FH
        JR      NZ,MBA2
        LD      A,B
        AND     1
        JR      NZ,MBA2
        RET
MBA1    LD      A,L
        AND     3FH
        CP      3BH
        JR      NZ,MBA2
        RET
MBA2    PUSH    DE
        CALL    MOVE
        POP     DE
        RET
MBAS0   LD      A,D
        OR      A
        JR      Z,MBA2
        JP      P,MBA4
        LD      A,L
        AND     3FH
        CP      2
        JR      NZ,MBA2
        RET
MBA4    LD      A,L
        AND     3FH
        CP      3DH
        JR      NZ,MBA2
        LD      A,B
        AND     1
        RET     NZ
        JR      MBA2
GET0    LD      A,(IX)
        LD      B,(IX+1)
        LD      L,(IX+2)
        LD      H,(IX+3)
        RET
PUT0    LD      (IX+1),B
        LD      (IX+2),L
        LD      (IX+3),H
        PUSH    DE
        LD      DE,4
        ADD     IX,DE
        POP     DE
        RET
ALTB    DEFB    0
IBASE   LD      A,(ALTB)
        INC     A
        AND     1
        LD      (ALTB),A
        LD      A,(BASE)
        CP      4
        RET     NZ
        LD      IX,TBAS+4
        CALL    HIGH0
        CP      15
        JR      Z,DOCR
        LD      DE,1
        CALL    GET0
        OR      A
        RET     Z
        CALL    MBAS
        CALL    PUT0
        CALL    SOUND
        RET
DOCR    CALL    DOCK
        LD      DE,100H
        CALL    GET0
        OR      A
        RET     Z
        CALL    MBAS
        CALL    PUT0
        CALL    SOUND
        CALL    DOCK
        RET
DOCK    LD      A,(TBAS+6)
        AND     3FH
        SLA     A
        LD      B,A
        LD      A,(TBAS+5)
        AND     1
        ADD     A,B
        ADD     A,5
        LD      B,A
        LD      A,(TBAS+2)
        AND     3FH
        SLA     A
        LD      C,A
        LD      A,(TBAS+1)
        AND     1
        ADD     A,C
        CP      B
        RET     NZ
        LD      A,1
        LD      (BASE),A
        POP     HL
        RET
HIGH0   LD      L,(IX+2)
        LD      H,(IX+3)
        LD      DE,SCR
        OR      A
        SBC     HL,DE
        ADD     HL,HL
        ADD     HL,HL
        LD      A,H
        AND     1FH
        RET
DOBUS   LD      A,(OBUS)
        OR      A
        JR      Z,DOB0
        CALL    SOUND
        XOR     A
        LD      (OBUS),A
        LD      IX,TOBUS
        LD      B,2
DOB1    PUSH    BC
        LD      A,(IX)
        OR      A
        JR      Z,DOB2
        LD      L,(IX+2)
        LD      H,(IX+3)
        LD      DE,-64
        ADD     HL,DE
        LD      (IX+2),L
        LD      (IX+3),H
        LD      DE,SCRTIR
        OR      A
        SBC     HL,DE
        JR      NC,DOB3
        XOR     A
        LD      (IX),A
        JR      DOB2
DOB3    LD      A,1
        LD      (OBUS),A
DOB2    POP     BC
        LD      DE,4
        ADD     IX,DE
        DJNZ    DOB1
        CALL    SOUND
        LD      A,(OBUS)
        OR      A
        JP      NZ,DOB4
DOB0    LD      A,(DEMO)
        OR      A
        JR      Z,ADDF
        LD      A,(NBRE)
        OR      A
        JR      NZ,DOB6
        JR      DOB4
ADDF    LD      A,(3840H)
KEYF    AND     80H
        JR      NZ,DOB6
        IN      A,(0)
        CPL
        BIT     4,A
        JR      NZ,DOB6
        AND     3
        CP      3
        JP      NZ,DOB4
DOB6    LD      A,(BASE)
        CP      1
        JP      NZ,DOB4
        CALL    SOUND
        LD      A,(FHEAT)
        OR      A
        JR      NZ,DOB4
        LD      A,1
        LD      (OBUS),A
        LD      IX,TOBUS
        LD      IY,TBAS
        CALL    GET
        INC     HL
        LD      DE,SCRTIR-SCR
        ADD     HL,DE
        CALL    PUT
        CALL    GET
        INC     HL
        LD      DE,SCRTIR-SCR
        ADD     HL,DE
        CALL    PUT
        LD      HL,HEAT
        INC     (HL)
        LD      A,(COUNTS)
        OR      A
        JR      NZ,DOB8
        LD      HL,DATA2
        CALL    CSOUND
        JR      DOB4
DOB8    LD      HL,181H
        LD      (DATA2-2),HL
DOB4    LD      A,(OBUS)
        OR      A
        RET     Z
        CALL    SOUND
        LD      IX,TOBUS
        LD      B,2
DOB9    PUSH    BC
        LD      A,(IX)
        OR      A
        JR      Z,DOB11
        LD      L,(IX+2)
        LD      H,(IX+3)
        LD      C,95H
        LD      A,(IX+1)
        OR      A
        JR      Z,DOB10
        LD      C,0AAH
DOB10   LD      (HL),C
DOB11   LD      DE,4
        ADD     IX,DE
        POP     BC
        DJNZ    DOB9
        CALL    SOUND
        RET
GET     LD      B,(IY)
        LD      A,(IY+1)
        LD      L,(IY+2)
        LD      H,(IY+3)
        LD      DE,4
        ADD     IY,DE
        RET
PUT     LD      (IX),B
        LD      (IX+1),A
        LD      (IX+2),L
        LD      (IX+3),H
        LD      DE,4
        ADD     IX,DE
        RET
AOBUS   LD      A,(OBUS)
        OR      A
        JR      Z,AOB0
        CALL    SOUND
        LD      IX,TOBUS
        LD      B,2
AOB1    PUSH    BC
        LD      A,(IX)
        OR      A
        JR      Z,AOB2
        LD      L,(IX+2)
        LD      H,(IX+3)
        LD      A,(HL)
        CP      80H
        JR      NZ,AOB6
        LD      (IX),0
        JR      AOB2
AOB6    LD      (HL),80H
        LD      DE,SCR-SCRTIR
        ADD     HL,DE
        LD      A,(IX+1)
        CALL    DECAL
        LD      A,(HL)
        OR      B
        LD      (HL),A
AOB2    LD      DE,4
        ADD     IX,DE
        POP     BC
        DJNZ    AOB1
        CALL    SOUND
        RET
AOB0    LD      A,(BASE)
        CP      1
        JR      Z,AOB7
        CP      4
        RET     C
AOB7    CALL    SOUND
        LD      IX,TBAS
        LD      B,2
AOB8    PUSH    BC
        LD      A,(IX)
        OR      A
        JR      Z,AOB3
        LD      L,(IX+2)
        LD      H,(IX+3)
        LD      B,(IX+1)
        LD      DE,2FFH
        CALL    MOVE
        LD      A,B
        CALL    DECAL
        LD      A,(HL)
        OR      B
        LD      (HL),A
AOB3    POP     BC
        LD      DE,4
        ADD     IX,DE
        DJNZ    AOB8
        CALL    SOUND
        RET
        DEFM    '--( MAD MINES IS THE 6TH '
        DEFM    'PROGRAM OF Y. LEMPEREUR )--'
        COND    0!(TYPE=PROT)!(TYPE=DISK)
        END     DEBUT
        ENDC
        COND    TYPE=TAPE
        ORG     4321H
        JP      DEBUT
        END     CLEAN
        ENDC
