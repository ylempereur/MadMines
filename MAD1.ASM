RANDOM  MACRO   #MIN,#MAX
        LD      B,#MAX-#MIN+1
        CALL    RAND
        ADD     A,#MIN
        ENDM
EXIR    MACRO
XI#$YM  LD      A,(HL)
        EX      AF,AF'
        LD      A,(DE)
        LD      (HL),A
        EX      AF,AF'
        LD      (DE),A
        INC     HL
        INC     DE
        DEC     BC
        LD      A,B
        OR      C
        JR      NZ,XI#$YM
        ENDM
DINT    MACRO
        LD      A,0F0H
        OR      3
        LD      (IT#$YM),A
IT#$YM  NOP
        XOR     A
        LD      (IT#$YM),A
        ENDM
;--------------------------------------------------------
VIDEO   EQU     3C00H
STACK   EQU     $
SCR     DEFS    1024
        DEFS    64
SCRTIR  DEFS    1024
DCB     DEFS    64
DEMO    DEFS    1
NPLAY   DEFS    1
HSCORE  EQU     $+10
TSCOR   DEFS    10*(10+6)
        COND    TYPE=PROT
        DEFS    96
        ENDC
TEXP    DEFS    32*6
TALIEN  DEFS    10*6
SCORE1  DEFM    '000000'
SCORE2  DEFM    '000000'
SHP1    DEFB    0
SHP2    DEFB    0
LAST1   DEFB    '0'
LAST2   DEFB    '0'
PLAY    DEFB    0
VLAS0   DEFB    0
PHASE   DEFB    0
VAR2    DEFS    2
TBAS    DEFS    2*4
BLINK   DEFB    0
BASE    DEFB    0
POINT   DEFB    0
POI0    DEFB    0
NBRE    DEFB    0
WAIT    DEFB    0
FLASER  DEFB    0
VLASER  DEFB    0
HLASER  DEFB    0
CLASER  DEFB    0
FLAS0   DEFB    0
CMOVE   DEFB    0
BOFL    DEFB    0
BOCAL   DEFB    0
BOPOS   DEFW    0
BOWT    DEFB    0
HEAT    DEFB    0
WHEAT   DEFB    0
FHEAT   DEFB    0
OBUS    DEFB    0
TOBUS   DEFS    2*4
ATTC    DEFB    0
FLBAS   DEFB    0
TINIT   DEFM    '000000'
        DEFM    '000000'
        DEFB    3
        DEFB    3
        DEFB    '0'
        DEFB    '0'
        DEFB    1
        DEFB    20
        DEFB    0
        DEFB    20
        DEFB    0
TINIT0  DEFB    0
        DEFB    0
        DEFW    0
        DEFB    0
        DEFB    0
        DEFW    0
        DEFB    0
        DEFB    0
        DEFB    0
        DEFB    1
        DEFB    10
        DEFB    16
        DEFB    0
        DEFB    0
        DEFB    1
        DEFB    0
        DEFB    0
        DEFB    0
        DEFB    0
        DEFB    0
        DEFW    0
        DEFB    100
        DEFB    0
        DEFB    1
        DEFB    0
        DEFB    0
        DEFB    0
        DEFB    0
        DEFW    0
        DEFB    0
        DEFB    0
        DEFW    0
        DEFB    DUREE
        DEFB    0
MADMIN  DEFM    'By  Y. Lempereur'
        DEFM    'Copyright (C) 1982 by  Funsoft, Inc.'
        DEFM    '28611 Canwood, Agoura, CA 91301 (213) 991-6540'
EXP3    DEFW    0A291H
        DEFW    9180H
        DEFW    8080H
        DEFW    8080H
        DEFW    80A2H
        DEFW    0A291H
        DEFW    8080H
        DEFW    8080H
        DEFW    8884H
        DEFW    8480H
        DEFW    8281H
        DEFW    8180H
        DEFW    8088H
        DEFW    8884H
        DEFW    8082H
        DEFW    8281H
        DEFW    0A090H
        DEFW    9080H
        DEFW    8884H
        DEFW    8480H
        DEFW    80A0H
        DEFW    0A090H
        DEFW    8088H
        DEFW    8884H
EXP2    DEFW    9999H
        DEFW    9199H
        DEFW    8080H
        DEFW    8080H
        DEFW    0A6A2H
        DEFW    0A6A6H
        DEFW    8080H
        DEFW    8080H
        DEFW    0A4A4H
        DEFW    84A4H
        DEFW    8181H
        DEFW    8181H
        DEFW    9888H
        DEFW    9898H
        DEFW    8282H
        DEFW    8282H
        DEFW    9090H
        DEFW    9090H
        DEFW    8686H
        DEFW    8486H
        DEFW    0A0A0H
        DEFW    0A0A0H
        DEFW    8988H
        DEFW    8989H
EXP1    DEFW    0B3BFH
        DEFW    95BBH
        DEFW    8080H
        DEFW    8080H
        DEFW    0B7AAH
        DEFW    0BFB3H
        DEFW    8080H
        DEFW    8080H
        DEFW    8CBCH
        DEFW    94ACH
        DEFW    8383H
        DEFW    8183H
        DEFW    9CA8H
        DEFW    0BC8CH
        DEFW    8382H
        DEFW    8383H
        DEFW    0B0B0H
        DEFW    90B0H
        DEFW    8C8FH
        DEFW    858EH
        DEFW    0B0A0H
        DEFW    0B0B0H
        DEFW    8D8AH
        DEFW    8F8CH
EGG     DEFW    0BFAEH
        DEFW    84BFH
        DEFW    8080H
        DEFW    8080H
        DEFW    0BF88H
        DEFW    9DBFH
        DEFW    8080H
        DEFW    8080H
        DEFW    0BCB8H
        DEFW    90BCH
        DEFW    8382H
        DEFW    8083H
        DEFW    0BCA0H
        DEFW    0B4BCH
        DEFW    8380H
        DEFW    8183H
        DEFW    0B0A0H
        DEFW    80B0H
        DEFW    8F8BH
        DEFW    818FH
        DEFW    0B080H
        DEFW    90B0H
        DEFW    8F82H
        DEFW    878FH
EGG1    DEFW    0BF88H
        DEFW    809DH
        DEFW    8080H
        DEFW    8080H
        DEFW    0AE80H
        DEFW    84BFH
        DEFW    8080H
        DEFW    8080H
        DEFW    0BCA0H
        DEFW    80B4H
        DEFW    8380H
        DEFW    8081H
        DEFW    0B880H
        DEFW    90BCH
        DEFW    8280H
        DEFW    8083H
        DEFW    0B080H
        DEFW    8090H
        DEFW    8F82H
        DEFW    8087H
        DEFW    0A080H
        DEFW    80B0H
        DEFW    8B80H
        DEFW    818FH
EGG2    DEFW    0AE80H
        DEFW    8084H
        DEFW    8080H
        DEFW    8080H
        DEFW    8880H
        DEFW    809DH
        DEFW    8080H
        DEFW    8080H
        DEFW    0B880H
        DEFW    8090H
        DEFW    8280H
        DEFW    8080H
        DEFW    0A080H
        DEFW    80B4H
        DEFW    8080H
        DEFW    8081H
        DEFW    0A080H
        DEFW    8080H
        DEFW    8B80H
        DEFW    8081H
        DEFW    8080H
        DEFW    8090H
        DEFW    8280H
        DEFW    8087H
EGG3    DEFW    8880H
        DEFW    8080H
        DEFW    8080H
        DEFW    8080H
        DEFW    8080H
        DEFW    8084H
        DEFW    8080H
        DEFW    8080H
        DEFW    0A080H
        DEFW    8080H
        DEFW    8080H
        DEFW    8080H
        DEFW    8080H
        DEFW    8090H
        DEFW    8080H
        DEFW    8080H
        DEFW    8080H
        DEFW    8080H
        DEFW    8280H
        DEFW    8080H
        DEFW    8080H
        DEFW    8080H
        DEFW    8080H
        DEFW    8081H
EGG4    DEFW    95AEH
        DEFW    84BFH
        DEFW    8080H
        DEFW    8080H
        DEFW    0BF88H
        DEFW    9DAAH
        DEFW    8080H
        DEFW    8080H
        DEFW    94B8H
        DEFW    90BCH
        DEFW    8182H
        DEFW    8083H
        DEFW    0BCA0H
        DEFW    0B4A8H
        DEFW    8380H
        DEFW    8182H
        DEFW    90A0H
        DEFW    80B0H
        DEFW    858BH
        DEFW    818FH
        DEFW    0B080H
        DEFW    90A0H
        DEFW    8F82H
        DEFW    878AH
EGG5    DEFW    80AEH
        DEFW    84AAH
        DEFW    8080H
        DEFW    8080H
        DEFW    9588H
        DEFW    9D80H
        DEFW    8080H
        DEFW    8080H
        DEFW    80B8H
        DEFW    90A8H
        DEFW    8082H
        DEFW    8082H
        DEFW    94A0H
        DEFW    0B480H
        DEFW    8180H
        DEFW    8180H
        DEFW    80A0H
        DEFW    80A0H
        DEFW    808BH
        DEFW    818AH
        DEFW    9080H
        DEFW    9080H
        DEFW    8582H
        DEFW    8780H
EGG6    DEFW    8084H
        DEFW    8480H
        DEFW    8080H
        DEFW    8080H
        DEFW    8088H
        DEFW    8880H
        DEFW    8080H
        DEFW    8080H
        DEFW    8090H
        DEFW    9080H
        DEFW    8080H
        DEFW    8080H
        DEFW    80A0H
        DEFW    0A080H
        DEFW    8080H
        DEFW    8080H
        DEFW    8080H
        DEFW    8080H
        DEFW    8081H
        DEFW    8180H
        DEFW    8080H
        DEFW    8080H
        DEFW    8082H
        DEFW    8280H
ALI1    DEFW    9BA7H
        DEFW    85B3H
        DEFW    8080H
        DEFW    8080H
        DEFW    0B38AH
        DEFW    9BA7H
        DEFW    8080H
        DEFW    8080H
        DEFW    0AC9CH
        DEFW    948CH
        DEFW    8182H
        DEFW    8083H
        DEFW    8CA8H
        DEFW    0AC9CH
        DEFW    8380H
        DEFW    8182H
        DEFW    0B0B0H
        DEFW    90B0H
        DEFW    8689H
        DEFW    818CH
        DEFW    0B0A0H
        DEFW    0B0B0H
        DEFW    8C82H
        DEFW    8689H
ALI1C   DEFW    0BBA7H
        DEFW    85B3H
        DEFW    8080H
        DEFW    8080H
        DEFW    0B38AH
        DEFW    9BB7H
        DEFW    8080H
        DEFW    8080H
        DEFW    0AC9CH
        DEFW    948CH
        DEFW    8382H
        DEFW    8083H
        DEFW    8CA8H
        DEFW    0AC9CH
        DEFW    8380H
        DEFW    8183H
        DEFW    0B0B0H
        DEFW    90B0H
        DEFW    8E89H
        DEFW    818CH
        DEFW    0B0A0H
        DEFW    0B0B0H
        DEFW    8C82H
        DEFW    868DH
ALI2    DEFW    0B389H
        DEFW    8199H
        DEFW    8080H
        DEFW    8080H
        DEFW    0A682H
        DEFW    86B3H
        DEFW    8080H
        DEFW    8080H
        DEFW    8CA4H
        DEFW    84A4H
        DEFW    8380H
        DEFW    8081H
        DEFW    9888H
        DEFW    988CH
        DEFW    8280H
        DEFW    8083H
        DEFW    0B090H
        DEFW    9090H
        DEFW    8C82H
        DEFW    8086H
        DEFW    0A0A0H
        DEFW    0A0B0H
        DEFW    8980H
        DEFW    818CH
ALI2C   DEFW    0B398H
        DEFW    9099H
        DEFW    8080H
        DEFW    8080H
        DEFW    0A6A0H
        DEFW    0A4B3H
        DEFW    8080H
        DEFW    8080H
        DEFW    8CA0H
        DEFW    80A4H
        DEFW    8381H
        DEFW    8181H
        DEFW    9880H
        DEFW    908CH
        DEFW    8282H
        DEFW    8283H
        DEFW    0B080H
        DEFW    8090H
        DEFW    8C86H
        DEFW    8486H
        DEFW    0A080H
        DEFW    80B0H
        DEFW    8988H
        DEFW    898CH
ALI3    DEFW    0B38DH
        DEFW    8599H
        DEFW    8080H
        DEFW    8080H
        DEFW    0A68AH
        DEFW    8EB3H
        DEFW    8080H
        DEFW    8080H
        DEFW    8CB4H
        DEFW    94A4H
        DEFW    8380H
        DEFW    8081H
        DEFW    98A8H
        DEFW    0B88CH
        DEFW    8280H
        DEFW    8083H
        DEFW    0B090H
        DEFW    9090H
        DEFW    8C83H
        DEFW    8186H
        DEFW    0A0A0H
        DEFW    0A0B0H
        DEFW    8982H
        DEFW    838CH
ALI3C   DEFW    0B39CH
        DEFW    9499H
        DEFW    8080H
        DEFW    8080H
        DEFW    0A6A8H
        DEFW    0ACB3H
        DEFW    8080H
        DEFW    8080H
        DEFW    8CB0H
        DEFW    90A4H
        DEFW    8381H
        DEFW    8181H
        DEFW    98A0H
        DEFW    0B08CH
        DEFW    8282H
        DEFW    8283H
        DEFW    0B080H
        DEFW    8090H
        DEFW    8C87H
        DEFW    8586H
        DEFW    0A080H
        DEFW    80B0H
        DEFW    898AH
        DEFW    8B8CH
ALI4    DEFW    0BB99H
        DEFW    9199H
        DEFW    8080H
        DEFW    8080H
        DEFW    0A6A2H
        DEFW    0A6B7H
        DEFW    8080H
        DEFW    8080H
        DEFW    0ACA4H
        DEFW    84A4H
        DEFW    8381H
        DEFW    8181H
        DEFW    9888H
        DEFW    989CH
        DEFW    8282H
        DEFW    8283H
        DEFW    0B090H
        DEFW    9090H
        DEFW    8E86H
        DEFW    8486H
        DEFW    0A0A0H
        DEFW    0A0B0H
        DEFW    8988H
        DEFW    898DH
ALI4C   DEFW    0B799H
        DEFW    919DH
        DEFW    8080H
        DEFW    8080H
        DEFW    0AEA2H
        DEFW    0A6BBH
        DEFW    8080H
        DEFW    8080H
        DEFW    9CA4H
        DEFW    84B4H
        DEFW    8381H
        DEFW    8181H
        DEFW    0B888H
        DEFW    98ACH
        DEFW    8282H
        DEFW    8283H
        DEFW    0B090H
        DEFW    9090H
        DEFW    8D86H
        DEFW    8487H
        DEFW    0A0A0H
        DEFW    0A0B0H
        DEFW    8B88H
        DEFW    898EH
TADD    DEFW    EXP3
        DEFW    EXP2
        DEFW    EXP1
        DEFW    0
        DEFW    EGG6
        DEFW    EGG5
        DEFW    EGG4
        DEFW    0
        DEFW    EGG
        DEFW    EGG
        DEFW    EGG1
        DEFW    EGG2
        DEFW    EGG3
        DEFW    ALI1
        DEFW    ALI1C
        DEFW    ALI2
        DEFW    ALI2C
        DEFW    ALI3
        DEFW    ALI3C
        DEFW    ALI4
        DEFW    ALI4C
TCAL    DEFB    0*8
        DEFB    1*8
        DEFB    2*8
        DEFB    3*8
        DEFB    4*8
        DEFB    5*8
TPOI    DEFW    0BBB7H
        DEFW    0AF9FH
        DEFW    0BEBDH
TLASER  DEFW    0BEBDH
        DEFW    8281H
        DEFW    0B8B4H
        DEFW    8B87H
        DEFW    0A090H
        DEFW    0AF9FH
TVIT    DEFB    3
        DEFB    1
        DEFB    0
        DEFB    0
TBASE   DEFW    0AFBEH
        DEFW    8094H
        DEFW    8080H
        DEFW    9FA8H
        DEFW    80BDH
        DEFW    8080H
        DEFW    0BCB8H
        DEFW    8390H
        DEFW    8182H
        DEFW    0BCA0H
        DEFW    82B4H
        DEFW    8381H
        DEFW    0B0A0H
        DEFW    8F80H
        DEFW    858BH
        DEFW    0B080H
        DEFW    8A90H
        DEFW    8F87H
TCAB    DEFB    0*6
        DEFB    1*6
        DEFB    2*6
        DEFB    3*6
        DEFB    4*6
        DEFB    5*6
DATA1   DEFW    309H
        DEFW    308H
        DEFW    30AH
        DEFW    318H
        DEFW    322H
        DEFW    30FH
        DEFW    30BH
        DEFW    30AH
        DEFW    30CH
        DEFW    0
DATA2   DEFW    5001H
        DEFW    402H
        DEFW    203H
        DEFW    204H
        DEFW    205H
        DEFW    206H
        DEFW    207H
        DEFW    0C02H
        DEFW    0
DATA3   DEFW    9001H
        DEFW    4002H
        DEFW    9001H
        DEFW    4002H
        DEFW    9001H
        DEFW    4002H
        DEFW    9001H
        DEFW    4002H
        DEFW    9001H
        DEFW    4002H
        DEFW    9001H
        DEFW    4002H
        DEFW    9001H
        DEFW    0
DATA5   DEFW    0A01H
        DEFW    0A07H
        DEFW    0A06H
        DEFW    0A05H
        DEFW    0A04H
        DEFW    0A03H
        DEFW    0A02H
        DEFW    1401H
        DEFW    0
DATA6   DEFW    2706H
        DEFW    5082H
        DEFW    2706H
        DEFW    5082H
        DEFW    3005H
        DEFW    5082H
        DEFW    3005H
        DEFW    5082H
        DEFW    4004H
        DEFW    5082H
        DEFW    4004H
        DEFW    5082H
        DEFW    6003H
        DEFW    5082H
        DEFW    6003H
        DEFW    5082H
        DEFW    0C002H
        DEFW    5082H
        DEFW    0FF02H
        DEFW    0
DATA8   DEFW    306H
        DEFW    408H
        DEFW    409H
        DEFW    40AH
        DEFW    418H
        DEFW    422H
        DEFW    418H
        DEFW    40AH
        DEFW    409H
        DEFW    408H
        DEFW    40CH
        DEFW    0
SCR191  LD      HL,SCR
        LD      DE,SCR+1
        LD      (HL),0BFH
SCR0    LD      B,15
SCR1    PUSH    BC
        LD      BC,64
        LDIR
        CALL    SOUND
        POP     BC
        DJNZ    SCR1
        LD      BC,63
        LDIR
        CALL    SOUND
        RET
CLSVID  LD      HL,VIDEO
        LD      DE,VIDEO+1
CLS0    LD      (HL),80H
        JR      SCR0
CLSSCR  LD      DE,SCR+1
        LD      HL,SCR
        JR      CLS0
CLSTIR  LD      HL,SCRTIR
        LD      DE,SCRTIR+1
        LD      BC,1024+64-1
        LD      (HL),80H
        LDIR
        RET
AFF     LD      HL,SCR
        LD      DE,VIDEO
        LD      B,16
AFF0    PUSH    BC
        LD      BC,64
        LDIR
        CALL    SOUND
        POP     BC
        DJNZ    AFF0
        RET
RESET   LD      A,86H
        JR      TEST10
TEST    LD      A,46H
        JR      TEST10
SET     LD      A,0C6H
TEST10  LD      (INST0+1),A
        LD      A,D
        LD      B,0FFH
LOOP    INC     B
        SUB     3
        JP      P,LOOP
        ADD     A,3
        SLA     A
        LD      C,A
        LD      L,B
        LD      H,0
        LD      B,6
LOOP1   ADD     HL,HL
        DJNZ    LOOP1
        LD      D,0
        SRL     E
        JR      NC,CONT
        INC     C
CONT    ADD     HL,DE
BUFFER  LD      DE,VIDEO
        ADD     HL,DE
        SLA     C
        SLA     C
        SLA     C
INST0   LD      A,0
        ADD     A,C
        LD      (INST1+1),A
INST1   DEFB    0CBH
        DEFB    0
        RET
PAUSE   DEC     BC
        LD      A,B
        OR      C
        JR      NZ,PAUSE
        RET
AFF1L   CALL    AFF1C
        DEC     BC
        INC     HL
        INC     DE
        LD      A,B
        OR      C
        JR      NZ,AFF1L
        RET
AFF1C   LD      A,(HL)
        CP      60H
        JR      C,AFF1C2
        CP      80H
        JR      NC,AFF1C2
        PUSH    HL
        LD      HL,LOWER1
        DEC     (HL)
        POP     HL
        JR      NZ,AFF1C1
        LD      A,(VIDEO)
        PUSH    AF
        LD      A,0C0H
        LD      (VIDEO),A
        LD      A,(VIDEO)
        CP      0C0H
        LD      A,0E0H
        JR      NZ,AFF1C0
        XOR     A
AFF1C0  LD      (LOWER0),A
        POP     AF
        LD      (VIDEO),A
        LD      A,(HL)
AFF1C1  PUSH    HL
        LD      HL,LOWER0
        ADD     A,(HL)
        POP     HL
AFF1C2  LD      (DE),A
        RET
LOWER0  DEFB    0
LOWER1  DEFB    1
AFFLIN  LD      HL,SCR
        LD      DE,SCR+1
        LD      BC,3FH
        LD      (HL),8CH
        LDIR
        LD      HL,SCR+896
        LD      DE,SCR+897
        LD      BC,3FH
        LD      (HL),0B0H
        LDIR
        LD      HL,SCR
        LD      DE,SCR+3FH
        LD      B,0FH
        LD      A,0BCH
EFF1    LD      (HL),A
        LD      (DE),A
        PUSH    BC
        LD      BC,64
        ADD     HL,BC
        EX      DE,HL
        ADD     HL,BC
        EX      DE,HL
        POP     BC
        LD      A,0BFH
        DJNZ    EFF1
        RET
EFFPOI  LD      HL,3C00H
        LD      DE,3C01H
        LD      BC,3FH
        LD      (HL),8CH
        LDIR
        LD      HL,3F80H
        LD      DE,3F81H
        LD      BC,3FH
        LD      (HL),0B0H
        LDIR
        LD      HL,3C00H
        LD      DE,3C3FH
        LD      B,0FH
        LD      A,0BCH
EFF0    LD      (HL),A
        LD      (DE),A
        PUSH    BC
        LD      BC,64
        ADD     HL,BC
        EX      DE,HL
        ADD     HL,BC
        EX      DE,HL
        POP     BC
        LD      A,0BFH
        DJNZ    EFF0
        RET
AFFPOI  LD      A,(COPOI)
        INC     A
        AND     3
        CALL    SOUND
        LD      (COPOI),A
        LD      HL,3F80H
        LD      DE,-64
        LD      B,14
FPO0    OR      A
        JR      Z,FPO3
        CP      1
        JR      Z,FPO2
        CP      2
        JR      Z,FPO1
        LD      (HL),0BCH
        JR      FPO4
FPO1    LD      (HL),0B3H
        JR      FPO4
FPO2    LD      (HL),8FH
        JR      FPO4
FPO3    LD      (HL),0BFH
FPO4    INC     A
        CALL    SOUND
        AND     3
        ADD     HL,DE
        DJNZ    FPO0
        LD      A,(COPOI)
        LD      B,64
        CP      3
        JR      Z,FPO5
        OR      A
        CALL    SOUND
        JR      Z,FOP0
        LD      (HL),0BCH
        JR      FPO7
FOP0    LD      (HL),0B0H
        JR      FPO7
FPO5    OR      A
        JR      NZ,FPO6
        LD      (HL),80H
        JR      FPO7
FPO6    LD      (HL),8CH
FPO7    INC     HL
        CALL    SOUND
        DEC     A
        AND     3
        DJNZ    FPO5
        LD      A,(COPOI)
        OR      A
        JR      Z,FPO8
        CP      3
        JR      NC,FOP1
        DEC     HL
        LD      (HL),0BCH
        JR      FPO8
FOP1    DEC     HL
        LD      (HL),0B0H
FPO8    LD      HL,3C7FH
        CALL    SOUND
        LD      B,14
        LD      DE,64
FPO9    OR      A
        JR      Z,FPO12
        CP      1
        JR      Z,FPO11
        CP      2
        JR      Z,FPO10
        LD      (HL),8FH
        JR      FPO13
FPO10   LD      (HL),0B3H
        JR      FPO13
FPO11   LD      (HL),0BCH
        JR      FPO13
FPO12   LD      (HL),0BFH
        CALL    SOUND
FPO13   INC     A
        CALL    SOUND
        AND     3
        ADD     HL,DE
        DJNZ    FPO9
        LD      A,(COPOI)
        INC     A
        AND     3
        LD      B,62
        LD      HL,3FBEH
FPO14   OR      A
        JR      NZ,FPO15
        LD      (HL),80H
        JR      FPO16
FPO15   LD      (HL),0B0H
FPO16   DEC     HL
        CALL    SOUND
        DEC     A
        AND     3
        DJNZ    FPO14
        LD      BC,1000
        CALL    PAUSE
        RET
COPOI   DEFB    0
DISPL   LD      A,(CMODE)
        OR      A
        JP      Z,SWEEP
        DEC     A
        JP      Z,ESSGLA
        DEC     A
        JP      Z,GRILL
        DEC     A
        JP      Z,ALEA
        DEC     A
        JP      Z,HGRILL
        DEC     A
        JP      Z,RADAR
        JP      SPIRE
CMODE   DEFB    1
COMMOD  LD      HL,CMODE
        LD      A,(HL)
        INC     A
        AND     7
        CP      7
        JR      NZ,COM0
        XOR     A
COM0    LD      (HL),A
        RET
        COND    TYPE=TAPE
EHS     EQU     EHA
        ENDC
        COND    TYPE=DISK
FILES   DEFM    'MADMINES/HSC'
        DEFB    0DH
EHS     LD      HL,FILES
        LD      DE,DCB
        LD      BC,13
        LDIR
        INIT    DCB,ERROR,SCR,10*(10+6)
        JR      NC,EHS0
        POSN    DCB,ERROR,0
        CALL    EHA
        WRITLR  DCB,ERROR,TSCOR
        JR      EHS1
EHS0    POSN    DCB,ERROR,0
        READLR  DCB,ERROR,TSCOR
        LD      A,0C9H
        LD      (EHS),A
EHS1    CLOSE   DCB,ERROR
        DINT
        RET
ERROR   JP      0
        ENDC
        COND    TYPE=PROT
EHS     CALL    READ
        LD      A,(TSCOR)
        OR      A
        JR      Z,EHS0
        LD      A,0C9H
        LD      (EHS),A
EHS1    DINT
        RET
EHS0    CALL    EHA
        CALL    WRITE
        JR      EHS1
READ    LD      HL,TSCOR
        JP      4402H
WRITE   LD      HL,TSCOR
        JP      4405H
        ENDC
EHA     LD      HL,TSCOR
        LD      DE,TSCOR+1
        LD      BC,10*(10+6)-1
        LD      (HL),0
        LDIR
        LD      HL,THS
        LD      DE,TSCOR
        LD      BC,16
        LDIR
        LD      A,0C9H
        LD      (EHS),A
        RET
THS     DEFM    'Yves L.   004560'
TADHS   DEFM    'HIGH  SCORES'
AFFHS   LD      HL,TADHS
        LD      DE,SCR+64+46
        LD      BC,12
        CALL    AFF1L
        LD      HL,SCR+128+42
        LD      B,20
AFH0    LD      (HL),8CH
        INC     HL
        DJNZ    AFH0
        LD      HL,SCR+64+41
        LD      DE,SCR+64+62
        LD      A,0BFH
        LD      B,12
AFH1    LD      (HL),A
        LD      (DE),A
        PUSH    BC
        LD      BC,64
        ADD     HL,BC
        EX      DE,HL
        ADD     HL,BC
        EX      DE,HL
        POP     BC
        DJNZ    AFH1
        LD      B,22
        LD      HL,SCR+832+41
AFH2    LD      (HL),83H
        INC     HL
        DJNZ    AFH2
        LD      DE,SCR+192+43
        LD      HL,TSCOR
        LD      B,10
AFH3    LD      A,(HL)
        OR      A
        RET     Z
        PUSH    BC
        LD      B,10
AFH4    CALL    AFF1C
        INC     DE
        INC     HL
        DJNZ    AFH4
        LD      A,' '
        LD      (DE),A
        INC     DE
        XOR     A
        LD      (FL00),A
        CALL    AFF3C
        DEC     DE
        LD      A,(DE)
        INC     DE
        CP      80H
        JR      Z,AFH5
        LD      A,','
        LD      (DE),A
AFH5    INC     DE
        CALL    AFF3C
        POP     BC
        PUSH    HL
        LD      HL,46
        ADD     HL,DE
        EX      DE,HL
        POP     HL
        DJNZ    AFH3
        RET
FL00    DEFB    0
AFF3C   LD      B,3
AHK0    LD      A,(HL)
        CP      '0'
        JR      Z,AHK3
AHK1    LD      (DE),A
        LD      A,1
        LD      (FL00),A
AHK2    INC     DE
        INC     HL
        DJNZ    AHK0
        RET
AHK3    LD      A,(FL00)
        OR      A
        JR      Z,AHK2
        LD      A,'0'
        JR      AHK1
BLK1    DEFW    VIDEO+192+43
BLK2    DEFW    0
BLKC    DEFB    0
BLKHS   LD      A,(BLKC)
        INC     A
        AND     0FH
        LD      (BLKC),A
        JR      Z,BLH0
        CP      4
        JR      Z,BLH3
        LD      BC,9
        JP      PAUSE
BLH0    LD      HL,(BLK1)
        CALL    BLH1
        LD      HL,(BLK2)
BLH1    LD      B,18
BLH2    LD      (HL),' '
        INC     HL
        DJNZ    BLH2
        RET
BLH3    LD      DE,(BLK1)
        CALL    BLH4
        LD      DE,(BLK2)
BLH4    LD      A,D
        OR      E
        RET     Z
        LD      HL,SCR-VIDEO
        ADD     HL,DE
        LD      BC,18
        LDIR
        RET
TSP12   DEFM    'Press <1> or <2> to start game'
TSP     DEFM    ', Press <SPACE> for Instructions'
TSPK    DEFM    ', Press <K> to redefine keys'
ALEA    LD      BC,100H
ALE0    CALL    RND
        AND     0FCH
        LD      E,A
        CALL    RND
        AND     3
        LD      D,A
ALE1    LD      HL,SCR
        ADD     HL,DE
        LD      A,(HL)
        OR      A
        JR      Z,ALE2
        CALL    ASQU
        DEC     BC
        LD      A,B
        OR      C
        JR      NZ,ALE0
        LD      HL,VIDEO
        LD      DE,SCR
        LD      BC,400H
        LDIR
        RET
ALE2    LD      HL,12
        ADD     HL,DE
        EX      DE,HL
        LD      A,D
        AND     3
        LD      D,A
        JR      ALE1
ASQU    PUSH    DE
        POP     HL
        ADD     HL,HL
        ADD     HL,HL
        LD      D,H
        LD      A,E
        RRCA
        RRCA
        AND     0FH
        LD      E,A
        CALL    SQUARE
        RET
SPIRE   LD      L,1
        LD      DE,0FFH
        LD      C,10H
SPIR1   LD      B,C
SPIR2   LD      A,E
        ADD     A,L
        LD      E,A
        CALL    SQUARE
        DJNZ    SPIR2
        DEC     C
        JR      Z,SPIR4
        LD      B,C
SPIR3   LD      A,D
        ADD     A,L
        LD      D,A
        CALL    SQUARE
        DJNZ    SPIR3
        LD      A,L
        NEG
        LD      L,A
        JR      SPIR1
SPIR4   LD      HL,VIDEO
        LD      DE,SCR
        LD      BC,400H
        LDIR
        RET
SQUARE  PUSH    DE
        EXX
        POP     DE
        LD      L,D
        LD      H,0
        LD      B,6
SQU0    ADD     HL,HL
        DJNZ    SQU0
        SLA     E
        SLA     E
        LD      D,0
        ADD     HL,DE
        PUSH    HL
        POP     BC
        LD      HL,VIDEO
        ADD     HL,BC
        EX      DE,HL
        LD      HL,SCR
        ADD     HL,BC
        LD      B,4
SQU1    LD      A,(HL)
        LD      (DE),A
        LD      (HL),0
        INC     HL
        INC     DE
        DJNZ    SQU1
        EXX
        CALL    SON1
        RET
SON1    PUSH    DE
        EXX
        POP     DE
        SRL     E
        INC     E
        SLA     D
        INC     D
        LD      C,10H
SOS     LD      A,1
        OUT     (255),A
        LD      B,E
        DJNZ    $
        LD      A,0
        OUT     (255),A
        LD      B,D
        DJNZ    $
        DEC     C
        JR      NZ,SOS
        EXX
        RET
DLINE   LD      HL,(YA)
        LD      DE,(YB)
        CALL    LINE
        LD      A,(RX)
        LD      E,A
        LD      A,(RY)
        LD      D,A
        CALL    SON1
        RET
SRT     LD      A,D
        SUB     E
        ADD     A,64
        LD      E,A
        LD      C,35
SRT0    LD      A,1
        OUT     (255),A
        LD      B,E
        DJNZ    $
        XOR     A
        OUT     (255),A
        LD      B,40
        DJNZ    $
        DEC     C
        JR      NZ,SRT0
        RET
SWEEP   LD      DE,700H
SWP0    CALL    SWP1
        PUSH    DE
        CALL    SRT
        POP     DE
        LD      A,D
        OR      A
        JR      NZ,SWP2
        INC     E
        JR      SWP3
SWP2    DEC     D
SWP3    LD      A,E
        CP      32
        JR      C,SWP0
        CALL    AFF
        RET
SWP1    PUSH    DE
SWP4    CALL    SWP5
        INC     D
        INC     E
        LD      A,D
        CP      8
        JR      NC,SWP6
        LD      A,E
        CP      32
        JR      NC,SWP6
        JR      SWP4
SWP6    POP     DE
        RET
SWP5    PUSH    DE
        CALL    SWP8
        POP     DE
        PUSH    DE
        LD      A,63
        SUB     E
        LD      E,A
        CALL    SWP8
        POP     DE
        PUSH    DE
        LD      A,15
        SUB     D
        LD      D,A
        CALL    SWP8
        POP     DE
        PUSH    DE
        LD      A,15
        SUB     D
        LD      D,A
        LD      A,63
        SUB     E
        LD      E,A
        CALL    SWP8
        POP     DE
        RET
SWP8    LD      L,D
        LD      H,0
        LD      B,6
SWP7    ADD     HL,HL
        DJNZ    SWP7
        LD      D,0
        ADD     HL,DE
        LD      DE,VIDEO
        ADD     HL,DE
        EX      DE,HL
        LD      HL,SCR-VIDEO
        ADD     HL,DE
        LD      A,(HL)
        LD      (DE),A
        RET
ESSGLA  LD      HL,1F0FH
        LD      (YA),HL
        LD      HL,0FH
        LD      (YB),HL
ESG0    CALL    DLINE
        LD      A,(YB)
        OR      A
        JR      Z,ESG1
        DEC     A
        LD      (YB),A
        JR      ESG0
ESG1    CALL    DLINE
        LD      A,(XB)
        CP      63
        JR      Z,ESG2
        INC     A
        LD      (XB),A
        JR      ESG1
ESG2    CALL    DLINE
        LD      A,(YB)
        CP      15
        RET     Z
        INC     A
        LD      (YB),A
        JR      ESG2
HGRILL  LD      HL,0
        LD      (YA),HL
        LD      HL,3FCH
        LD      (YB),HL
        LD      B,16
HGR0    PUSH    BC
        LD      B,8
HGR1    PUSH    BC
        LD      DE,(YA)
        CALL    ASQU
        LD      DE,(YB)
        CALL    ASQU
        LD      HL,(YA)
        LD      DE,128
        ADD     HL,DE
        LD      (YA),HL
        LD      HL,(YB)
        LD      DE,-128
        ADD     HL,DE
        LD      (YB),HL
        POP     BC
        DJNZ    HGR1
        LD      HL,(YA)
        LD      DE,-1020
        ADD     HL,DE
        LD      (YA),HL
        LD      HL,(YB)
        LD      DE,1020
        ADD     HL,DE
        LD      (YB),HL
        POP     BC
        DJNZ    HGR0
        LD      HL,VIDEO
        LD      DE,SCR
        LD      BC,400H
        LDIR
        RET
GRILL   LD      HL,0
        LD      (YA),HL
        LD      HL,3FCH
        LD      (YB),HL
        LD      B,128
GRI0    PUSH    BC
        LD      DE,(YA)
        CALL    ASQU
        LD      DE,(YB)
        CALL    ASQU
        LD      HL,(YA)
        LD      DE,8
        ADD     HL,DE
        LD      (YA),HL
        LD      HL,(YB)
        LD      DE,-8
        ADD     HL,DE
        LD      (YB),HL
        POP     BC
        DJNZ    GRI0
        LD      HL,VIDEO
        LD      DE,SCR
        LD      BC,400H
        LDIR
        RET
RADAR   LD      HL,1F07H
        LD      (YA),HL
        LD      HL,1F00H
        LD      (YB),HL
RAD0    CALL    DLINE
        LD      A,(XB)
        CP      63
        JR      Z,RAD1
        INC     A
        LD      (XB),A
        JR      RAD0
RAD1    CALL    DLINE
        LD      A,(YB)
        CP      15
        JR      Z,RAD2
        INC     A
        LD      (YB),A
        JR      RAD1
RAD2    CALL    DLINE
        LD      A,(XB)
        OR      A
        JR      Z,RAD3
        DEC     A
        LD      (XB),A
        JR      RAD2
RAD3    CALL    DLINE
        LD      A,(YB)
        OR      A
        JR      Z,RAD4
        DEC     A
        LD      (YB),A
        JR      RAD3
RAD4    CALL    DLINE
        LD      A,(XB)
        CP      31
        RET     Z
        INC     A
        LD      (XB),A
        JR      RAD4
YA      DEFB    0
XA      DEFB    0
YB      DEFB    0
XB      DEFB    0
LINE    LD      (RY),HL
        CALL    PLOT
        PUSH    DE
        LD      A,H
        CP      D
        JR      NC,LIN0
        LD      D,1
        JR      LIN1
LIN0    LD      D,0FFH
LIN1    LD      A,L
        CP      E
        JR      NC,LIN2
        LD      E,1
        JR      LIN3
LIN2    LD      E,0FFH
LIN3    POP     BC
        LD      A,H
        SUB     B
        JP      P,LIN4
        NEG
LIN4    LD      H,A
        LD      A,L
        SUB     C
        JP      P,LIN5
        NEG
LIN5    LD      L,A
        LD      A,H
        CP      L
        JR      C,LIN6
        JR      Z,LIN6
        SRL     A
        LD      C,A
        LD      B,H
LIN7    LD      A,(RX)
        ADD     A,D
        LD      (RX),A
        LD      A,C
        ADD     A,L
        LD      C,A
        CP      H
        JR      C,LIN8
        SUB     H
        LD      C,A
        LD      A,(RY)
        ADD     A,E
        LD      (RY),A
LIN8    CALL    PLOT
        DJNZ    LIN7
        RET
LIN6    LD      A,L
        SRL     A
        LD      C,A
        LD      B,L
LIN9    LD      A,(RY)
        ADD     A,E
        LD      (RY),A
        LD      A,C
        ADD     A,H
        LD      C,A
        CP      L
        JR      C,LIN10
        SUB     L
        LD      C,A
        LD      A,(RX)
        ADD     A,D
        LD      (RX),A
LIN10   CALL    PLOT
        DJNZ    LIN9
        RET
RY      DEFB    0
RX      DEFB    0
PLOT    EXX
        LD      A,(RY)
        LD      L,A
        LD      H,0
        LD      B,6
PLO0    ADD     HL,HL
        DJNZ    PLO0
        LD      A,(RX)
        LD      E,A
        LD      D,0
        ADD     HL,DE
        PUSH    HL
        POP     BC
        LD      HL,VIDEO
        ADD     HL,BC
        EX      DE,HL
        LD      HL,SCR
        ADD     HL,BC
        LD      A,(HL)
        LD      (DE),A
        EXX
        RET
PROAPP  CALL    IPRO
        XOR     A
        LD      (INP1+1),A
        LD      HL,MADMIN
        LD      DE,SCR+704+24
        LD      BC,16
        CALL    AFF1L
        LD      DE,SCR+768+14
        LD      BC,36
        CALL    AFF1L
        LD      DE,SCR+832+9
        LD      BC,46
        CALL    AFF1L
        LD      HL,TSP12
        LD      DE,SCR+960+1
        LD      BC,62
        CALL    AFF1L
        CALL    AFFLIN
        CALL    DISPL
        LD      HL,TALIEN
        LD      DE,TALIEN+1
        LD      BC,8*4-1
        LD      (HL),0
        LDIR
        XOR     A
        LD      (DEL0),A
        LD      (EYE),A
        LD      (FLAGB),A
        LD      A,DUREE/2
        LD      (DEL),A
        LD      A,1
        LD      (EYE0),A
        LD      A,10
        LD      (WDEM),A
        CALL    AFFPOI
PRB0    CALL    INP12
        CALL    INPSP
        CALL    TRPOI
PRB1    LD      A,0
        INC     A
        CP      6
        JR      NZ,PRB2
        XOR     A
PRB2    LD      (PRB1+1),A
        OR      A
        JR      NZ,PRB0
        CALL    DBOMB
        CALL    DEMAR
        CALL    DELAY
        JR      PRB0
PROEXP  CALL    IPRO
        LD      A,1
        LD      (INP1+1),A
        CALL    AFFHS
        LD      HL,TAEXP
        LD      DE,SCR+128+4
        LD      B,12
PRE1    PUSH    DE
PRE2    LD      A,(HL)
        INC     HL
        CP      '%'
        JR      Z,PRE3
        DEC     HL
        CALL    AFF1C
        INC     HL
        INC     DE
        JR      PRE2
PRE3    POP     DE
        PUSH    HL
        LD      HL,64
        ADD     HL,DE
        EX      DE,HL
        POP     HL
        DJNZ    PRE1
        LD      HL,SCR+64+14
        LD      DE,SCR+192+14
        LD      B,14
        LD      A,83H
PRE4    LD      (HL),8CH
        LD      (DE),A
        INC     HL
        INC     DE
        DJNZ    PRE4
        LD      A,0BCH
        LD      (SCR+64+14),A
        LD      (SCR+64+27),A
        LD      A,0BFH
        LD      (SCR+128+14),A
        LD      (SCR+128+27),A
        LD      HL,TSHP1
        LD      DE,SCR+320+6
        LD      BC,28
        LDIR
        LD      A,0C9H
        LD      (CLINE),A
        LD      DE,SCR+448+26
        LD      A,(NUML)
        LD      C,A
        CALL    DISKEY
        LD      DE,SCR+512+26
        LD      A,(NUMR)
        LD      C,A
        CALL    DISKEY
        LD      DE,SCR+576+26
        LD      A,(NUMF)
        LD      C,A
        CALL    DISKEY
        LD      A,3EH
        LD      (CLINE),A
        LD      HL,TSP12
        LD      DE,SCR+960+3
        LD      BC,30
        CALL    AFF1L
        LD      HL,TSPK
        LD      BC,28
        CALL    AFF1L
        CALL    AFFLIN
        CALL    DISPL
        CALL    AFFPOI
PRE0    CALL    INP12
        CALL    INPK
        CALL    TRPOI
        JR      PRE0
TAEXP   DEFM    '            MAD  MINES%'
        DEFM    '%'
        DEFM    ' Explode mines and destroy aliens%'
        DEFM    '      20      40      60      80%'
        DEFM    '%'
        DEFM    'Move the ship left  : %'
        DEFM    'Move the ship right : %'
        DEFM    'Fire missiles       : %'
        DEFM    '%'
        DEFM    'An  extra ship  is awarded at each%'
        DEFM    '2000 pts.  Good luck...%'
        DEFM    '%'
TSHP1   DEFW    9BA7H
        DEFW    85B3H
        DEFM    '20  '
        DEFW    0B398H
        DEFW    9099H
        DEFM    '40  '
        DEFW    0B39CH
        DEFW    9499H
        DEFM    '60  '
        DEFW    0BB99H
        DEFW    9199H
TSHP2   DEFW    0BBA7H
        DEFW    85B3H
        DEFM    '20  '
        DEFW    0B389H
        DEFW    8199H
        DEFM    '40  '
        DEFW    0B38DH
        DEFW    8599H
        DEFM    '60  '
        DEFW    0B799H
        DEFW    919DH
CSHP    DEFB    9
AFFSHP  LD      HL,CSHP
        DEC     (HL)
        JR      NZ,AFS1
        LD      (HL),9
        LD      HL,TSHP1
        JR      AFS2
AFS1    LD      A,(HL)
        CP      5
        RET     NZ
        LD      HL,TSHP2
AFS2    LD      DE,VIDEO+320+6
        LD      BC,28
        LDIR
        CALL    SOUND
        RET
INP12   LD      A,(3810H)
        CALL    SOUND
        AND     6
        JR      Z,INP1
        SRL     A
        CP      1
        JR      Z,INP0
        LD      A,2
INP0    LD      (NPLAY),A
        LD      HL,10000
        LD      (IPRO+1),HL
        POP     HL
        POP     HL
        CALL    EFFPOI
        XOR     A
        JP      STRT0
INP1    LD      A,0
        OR      A
        JR      Z,INP4
INP2    LD      A,6
        DEC     A
        JR      NZ,INP3
        LD      A,6
INP3    LD      (INP2+1),A
        JR      NZ,INP4
        CALL    AFFSHP
        CALL    BLKHS
        JR      INP5
INP4    LD      B,200
        DJNZ    $
INP5    LD      HL,0
        CALL    SOUND
        DEC     HL
        LD      (INP5+1),HL
        LD      A,H
        OR      L
        JR      NZ,BLINKR
        POP     HL
        CALL    EFFPOI
        RET
BLINKR  LD      A,50
        DEC     A
        JR      NZ,BKR0
        LD      A,50
BKR0    LD      (BLINKR+1),A
        JR      NZ,BKR6
BKR7    LD      A,1
        NEG
        LD      (BKR7+1),A
        LD      A,79H
        JP      P,BKR1
        XOR     A
BKR1    LD      (BKR8),A
        LD      HL,SCR+960
        LD      DE,VIDEO+960
        LD      BC,64*256+' '
BKR2    LD      A,(HL)
        CP      '<'
        JR      Z,BKR5
BKR3    INC     HL
        INC     DE
        DJNZ    BKR2
        RET
BKR4    LD      A,(HL)
        CP      '>'
        JR      Z,BKR3
BKR8    NOP
        LD      (DE),A
BKR5    INC     HL
        INC     DE
        DJNZ    BKR4
        RET
BKR6    LD      B,0
        DJNZ    $
        RET
INPSP   LD      A,(3840H)
        CALL    SOUND
        AND     80H
        RET     Z
        LD      HL,10000
        LD      (IPRO+1),HL
        POP     HL
        POP     HL
        CALL    EFFPOI
        JP      STRT1
INPK    LD      A,(3802H)
        AND     8
        RET     Z
        LD      HL,10000
        LD      (IPRO+1),HL
REDEF   CALL    EFFPOI
        CALL    IPRO
        LD      HL,TAB1
        CALL    PRINT
        LD      A,(NUML)
        LD      C,A
        PUSH    DE
        CALL    DISKEY
        CALL    DISPL
        POP     DE
        LD      HL,VIDEO-SCR
        ADD     HL,DE
        EX      DE,HL
        CALL    INKEY
        JR      NZ,RED0
        LD      A,C
        LD      (NUML),A
        LD      A,B
        LD      (KEYL+1),A
        LD      (ADDL+1),HL
        CALL    DISKEY
        LD      HL,TAB2
        CALL    PRINT
        LD      A,(NUMR)
        LD      C,A
        PUSH    DE
        CALL    DISKEY
        POP     DE
RED1    CALL    INKEY
        JR      NZ,RED0
        LD      A,(NUML)
        CP      C
        JR      Z,RED1
        LD      A,C
        LD      (NUMR),A
        LD      A,B
        LD      (KEYR+1),A
        LD      (ADDR+1),HL
        CALL    DISKEY
        LD      HL,TAB3
        CALL    PRINT
        LD      A,(NUMF)
        LD      C,A
        PUSH    DE
        CALL    DISKEY
        POP     DE
RED2    CALL    INKEY
        JR      NZ,RED0
        LD      A,(NUML)
        CP      C
        JR      Z,RED2
        LD      A,(NUMR)
        CP      C
        JR      Z,RED2
        LD      A,C
        LD      (NUMF),A
        LD      A,B
        LD      (KEYF+1),A
        LD      (ADDF+1),HL
        CALL    DISKEY
        LD      HL,TAB4
        CALL    PRINT
        CALL    INKEY
RED0    POP     HL
        JP      PROEXP
NUML    DEFB    53
NUMR    DEFB    54
NUMF    DEFB    55
TAB1    DEFW    SCR+64
        DEFM    '-Redefinition key routine-'
        DEFB    0
        DEFW    SCR+192
        DEFM    'To move left     : '
        DEFB    1
TAB2    DEFW    VIDEO+256
        DEFM    'To move right    : '
        DEFB    1
TAB3    DEFW    VIDEO+320
        DEFM    'To fire missiles : '
        DEFB    1
TAB4    DEFW    VIDEO+384
        DEFM    'Press any key to continue.'
        DEFB    1
DISKEY  LD      A,C
        CP      27
        JR      NC,DIK0
        ADD     A,40H
DIK5    LD      (DE),A
        INC     DE
        JR      CLINE
DIK0    CP      32
        JR      NC,DIK2
DIK1    LD      HL,USRK
        JR      DIK8
DIK2    CP      44
        JR      NC,DIK4
        ADD     A,16
        JR      DIK5
DIK4    CP      48
        JR      C,DIK5
        CP      57
        JR      NC,DIK1
        SUB     47
        LD      B,A
        LD      HL,TKEY
DIK6    DJNZ    DIK7
DIK8    LD      A,(HL)
        CP      '$'
        JR      Z,CLINE
        LD      (DE),A
        INC     HL
        INC     DE
        JR      DIK8
DIK7    LD      A,(HL)
        INC     HL
        CP      '$'
        JR      NZ,DIK7
        JR      DIK6
USRK    DEFM    'USER KEY$'
TKEY    DEFM    'ENTER$CLEAR$BREAK$UP ARROW$DOWN ARROW$'
        DEFM    '<--$-->$SPACEBAR$SHIFT$'
CLINE   LD      A,' '
        LD      (DE),A
        INC     DE
        LD      A,E
        AND     1FH
        JR      NZ,CLINE
        RET
INKEY   PUSH    DE
INY0    LD      A,(38FFH)
        OR      A
        JR      NZ,INY0
        LD      B,0
        DJNZ    $
        LD      DE,5000
INY1    LD      HL,3801H
        LD      C,0
INY2    LD      B,1
INY3    LD      A,(HL)
        AND     B
        JR      NZ,INY4
        INC     C
        SLA     B
        JR      NC,INY3
        SLA     L
        JR      NC,INY2
        DEC     DE
        LD      A,D
        OR      E
        JR      NZ,INY1
        POP     DE
        LD      A,1
        OR      A
        RET
INY4    POP     DE
        XOR     A
        RET
IPRO    LD      HL,10000
        LD      (INP5+1),HL
        CALL    SCR191
        CALL    DISPL
        CALL    CLSSCR
        RET
TRPOI   LD      A,4
        CALL    SOUND
        DEC     A
        JR      NZ,TPO0
        LD      A,4
TPO0    LD      (TRPOI+1),A
        RET     NZ
        JP      AFFPOI
START   DINT
        LD      HL,STACK
        LD      SP,HL
        LD      H,37H
        LD      L,0E4H
        LD      (HL),1
        XOR     A
        LD      (COUNTS),A
        CALL    EHS
        CALL    PROAPP
STRT1   CALL    PROEXP
        LD      HL,2000
        LD      (IPRO+1),HL
        LD      A,2
        LD      (NPLAY),A
STRT0   LD      (DEMO),A
        CALL    COMMOD
        JP      BEGIN
SOUND   PUSH    HL
        PUSH    AF
        LD      A,(COUNTS)
        OR      A
        JR      Z,SOUND3
        LD      HL,STATE
        LD      A,(HL)
        OR      A
        INC     HL
        JR      NZ,SOUND1
        DEC     (HL)
        JR      NZ,SOUND4
        LD      A,2
        LD      (STATE),A
SOUND0  OUT     (255),A
        JR      SOUND4
SOUND1  INC     HL
        DEC     (HL)
        JR      NZ,SOUND4
        XOR     A
        LD      (STATE),A
        INC     A
SOUND2  OUT     (255),A
        INC     HL
        DEC     (HL)
        JR      Z,SOUND5
        LD      HL,(ADDSON)
        LD      A,(HL)
        AND     3FH
        LD      (LOCOU),A
        LD      (HICOU),A
        JR      SOUND4
SOUND3  PUSH    BC
        LD      B,6
        DJNZ    $
        POP     BC
SOUND4  POP     AF
        POP     HL
        RET
SOUND5  LD      HL,(ADDSON)
        INC     HL
        INC     HL
SOUND6  LD      (ADDSON),HL
        LD      A,(HL)
        OR      A
        JP      P,SOUND7
        LD      HL,0
        LD      (SOUND0),HL
        LD      (SOUND2),HL
        JR      SOUND8
SOUND7  LD      HL,0FFD3H
        LD      (SOUND0),HL
        LD      (SOUND2),HL
SOUND8  AND     3FH
        LD      (LOCOU),A
        LD      (HICOU),A
        LD      HL,(ADDSON)
        INC     HL
        LD      A,(HL)
        LD      (COUNTS),A
        JR      SOUND4
CSOUND  LD      DE,SOUND9
        PUSH    DE
        PUSH    DE
        PUSH    DE
        JR      SOUND6
SOUND9  LD      A,1
        OUT     (255),A
        RET
STATE   DEFB    0
LOCOU   DEFB    0
HICOU   DEFB    0
COUNTS  DEFB    0
ADDSON  DEFW    0
