sprite:
            .byte $ff,$00,$00
            .byte $ff,$00,$00
            .byte $ff,$00,$00
            .byte $ff,$00,$00
            .byte $ff,$00,$00
            .byte $ff,$00,$00
            .byte $00,$00,$00
            .byte $ff,$00,$00
            .byte $ff,$00,$00
            .byte $ff,$00,$00
            .byte $ff,$00,$00
            .byte $ff,$00,$00
            .byte $ff,$00,$00
            .byte $00,$00,$00
            .byte $ff,$00,$00
            .byte $ff,$00,$00
            .byte $ff,$00,$00
            .byte $ff,$00,$00
            .byte $ff,$00,$00
            .byte $ff,$00,$00
            .byte $00,$00,$00
            .byte $00
sprite_2
            .byte $00,$00,$ff
            .byte $00,$00,$ff
            .byte $00,$00,$ff
            .byte $00,$00,$ff
            .byte $00,$00,$ff
            .byte $00,$00,$ff
            .byte $00,$00,$00
            .byte $00,$00,$ff
            .byte $00,$00,$ff
            .byte $00,$00,$ff
            .byte $00,$00,$ff
            .byte $00,$00,$ff
            .byte $00,$00,$ff
            .byte $00,$00,$00
            .byte $00,$00,$ff
            .byte $00,$00,$ff
            .byte $00,$00,$ff
            .byte $00,$00,$ff
            .byte $00,$00,$ff
            .byte $00,$00,$ff
            .byte $00,$00,$00
            .byte $00
scr_tbl_lo
            .byte <char_addr
            .byte <char_addr+40
            .byte <char_addr+40 * 2
            .byte <char_addr+40 * 3
            .byte <char_addr+40 * 4
            .byte <char_addr+40 * 5
            .byte <char_addr+40 * 6
            .byte <char_addr+40 * 7
            .byte <char_addr+40 * 8
            .byte <char_addr+40 * 9
            .byte <char_addr+40 * 10
            .byte <char_addr+40 * 11
            .byte <char_addr+40 * 12
            .byte <char_addr+40 * 13
            .byte <char_addr+40 * 14
            .byte <char_addr+40 * 15
            .byte <char_addr+40 * 16
            .byte <char_addr+40 * 17
            .byte <char_addr+40 * 18
            .byte <char_addr+40 * 19
            .byte <char_addr+40 * 20
            .byte <char_addr+40 * 21
            .byte <char_addr+40 * 22
            .byte <char_addr+40 * 23
            .byte <char_addr+40 * 24
scr_tbl_hi
            .byte >char_addr
            .byte >char_addr+40
            .byte >char_addr+40 * 2
            .byte >char_addr+40 * 3
            .byte >char_addr+40 * 4
            .byte >char_addr+40 * 5
            .byte >char_addr+40 * 6
            .byte >char_addr+40 * 7
            .byte >char_addr+40 * 8
            .byte >char_addr+40 * 9
            .byte >char_addr+40 * 10
            .byte >char_addr+40 * 11
            .byte >char_addr+40 * 12
            .byte >char_addr+40 * 13
            .byte >char_addr+40 * 14
            .byte >char_addr+40 * 15
            .byte >char_addr+40 * 16
            .byte >char_addr+40 * 17
            .byte >char_addr+40 * 18
            .byte >char_addr+40 * 19
            .byte >char_addr+40 * 20
            .byte >char_addr+40 * 21
            .byte >char_addr+40 * 22
            .byte >char_addr+40 * 23
            .byte >char_addr+40 * 24
solid_table
            .byte $00,$00,$00,$00 ; 0000
            .byte $00,$00,$00,$a0 ; 0001
            .byte $00,$00,$a0,$00 ; 0010
            .byte $00,$00,$a0,$A0 ; 0011
            .byte $00,$a0,$00,$00 ; 0100
            .byte $00,$a0,$00,$a0 ; 0101
            .byte $00,$a0,$a0,$00 ; 0110
            .byte $00,$a0,$a0,$a0 ; 0111
            .byte $a0,$00,$00,$00 ; 1000            
            .byte $a0,$00,$00,$a0 ; 1001
            .byte $a0,$00,$a0,$00 ; 1010
            .byte $a0,$00,$a0,$A0 ; 1011
            .byte $a0,$a0,$00,$00 ; 1100
            .byte $a0,$a0,$00,$a0 ; 1101
            .byte $a0,$a0,$a0,$00 ; 1110
            .byte $a0,$a0,$a0,$a0 ; 1111
char_0
            .byte %1111
            .byte %1001
            .byte %1001
            .byte %1001
            .byte %1111
char_1
            .byte %0110
            .byte %1110
            .byte %0110
            .byte %0110
            .byte %1111
char_2
            .byte %1111
            .byte %0011
            .byte %1111
            .byte %1100
            .byte %1111
char_3
            .byte %1111
            .byte %0011
            .byte %1111
            .byte %0011
            .byte %1111
char_4
            .byte %0111
            .byte %1011
            .byte %1111
            .byte %0011
            .byte %0011
char_5
            .byte %1111
            .byte %1100
            .byte %1111
            .byte %0011
            .byte %1111
