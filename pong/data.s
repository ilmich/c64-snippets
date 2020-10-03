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
low_res_num_1
            .byte $EC, $FB, $FE, $20, $E2, $FB, $E2, $FB, $61, $E1, $EC, $E2, $61, $20, $E2, $FB, $EC, $FB, $EC, $FB
low_res_num_2
            .byte $61, $E1, $E1, $20, $EC, $E2, $20, $FB, $E2, $FB, $E2, $FB, $EC, $FB, $20, $E1, $EC, $FB, $E2, $FB
low_res_num_3
            .byte $E2, $E2, $E2, $7E, $E2, $E2, $E2, $E2, $20, $7C, $E2, $E2, $E2, $E2, $20, $7C, $E2, $E2, $20, $7C