; write program location address
            .word $0801
; set program counter
            *=$0801
; write BASIC LINE "2012 SYS 2061"
            .byt $0b,$08,$20,$03,$9e,$32,$30,$36,$31,$00,$00,$00

#include "vars.s"

; start code
            jmp init
.dsb ( 2112 - * ),$00

#include "data.s"

clear_scr .(
                ldx #$00
                lda #$20
    loop:       sta char_addr,x
                sta char_addr + $0100,x
                sta char_addr + $0200,x
                sta char_addr + $0300,x
                inx
                bne loop

                ldx #$00
                lda #$01
    loop2:      sta $d800,x
                sta $d800 + $0100,x
                sta $d800 + $0200,x
                sta $d800 + $0300,x
                inx
                bne loop2
                rts
.)
init_sprite .(
                lda #$03                ; enable first two sprites
                sta $D015
                lda #(sprite / 64)      ; setup sprite pointers
                sta $07F8
                lda #(sprite_2 / 64)
                sta $07F9
                lda #$18                ; setup x coord sprite 1
                sta $D000
                lda #$40                ; setup x coord sprite 2
                sta $D002
                lda #$02
                sta $D010
                lda #$01                ; setup color for sprites
                sta $D028
                sta $D027
                lda #$32 + (8*10)                ; setup coord y
                sta sprite1_y
                sta sprite2_y
                sta $D001
                sta $D003
                lsr
                lsr
                lsr
                sta sprite1_row
                sta sprite2_row
                lda #20
                sta ball_x_col
                lsr
                sta ball_y_col
                rts
.)

draw_board .(
                ldx #40
                lda #$a0
    loop:
                sta char_addr + (40*5) -1,x
                sta char_addr + (40*24) -1,x
                dex
                bne loop

                ; draw middle line
                lda #$61
                sta char_addr + (40*6) + 19
                sta char_addr + (40*8) + 19
                sta char_addr + (40*10) + 19
                sta char_addr + (40*12) + 19
                sta char_addr + (40*14) + 19
                sta char_addr + (40*16) + 19
                sta char_addr + (40*18) + 19
                sta char_addr + (40*20) + 19
                sta char_addr + (40*22) + 19
                rts
.)
setup_irq.(
                sei                 ; set interrupt disable flag
                lda #$7f            ; $7f = %01111111
                sta $dc0d           ; Turn off CIAs Timer interrupts
                sta $dd0d

                lda #$01            ; Set Interrupt Request Mask...
                sta $d01a           ; ...we want IRQ by Rasterbeam

                lda #<irq           ; point IRQ Vector to our custom irq routine
                ldx #>irq
                sta $314            ; store in $314/$315
                stx $315

                lda #$ff            ; trigger first interrupt at row zero
                sta $d012

                lda $d011           ; Bit#0 of $d011 is basically...
                and #$7f            ; ...the 9th Bit for $d012
                sta $d011           ; we need to make sure it is set to zero 

                cli                 ; clear interrupt disable flag
                rts
.)
irq.(
                dec $d019        ; acknowledge IRQ
                lda #$01
                sta sync
                jmp $ea31        ; return to kernel interrupt routine
.)
move_down_1 .(
                lda sprite1_y
                clc
                adc #04
                tax
                sbc #$32
                lsr
                lsr
                lsr

                tay
                iny
                iny
                lda scr_tbl_lo,y
                sta tmp_var
                lda scr_tbl_hi,y
                sta tmp_var+1
                ldy #$00
                lda (tmp_var),y
                cmp #$A0
                beq end
                stx sprite1_y
                stx $D001
    end
                rts
.)
move_up_1 .(
                lda sprite1_y
                sec
                sbc #04
                tax
                sbc #$32
                lsr
                lsr
                lsr

                tay
                lda scr_tbl_lo,y
                sta tmp_var
                lda scr_tbl_hi,y
                sta tmp_var+1
                ldy #$00
                lda (tmp_var),y
                cmp #$A0
                beq end
                stx sprite1_y
                stx $D001
    end
                rts
.)

move_up_2 .(
                lda sprite2_y
                sec
                sbc #04
                tax
                sbc #$32
                lsr
                lsr
                lsr

                tay
                lda scr_tbl_lo,y
                sta tmp_var
                lda scr_tbl_hi,y
                sta tmp_var+1
                ldy #39
                lda (tmp_var),y
                cmp #$A0
                beq end
                stx sprite2_y
                stx $D003
    end
                rts
.)
move_down_2 .(
                lda sprite2_y
                clc
                adc #04
                tax                
                sbc #$32
                lsr
                lsr
                lsr

                tay
                iny
                iny
                lda scr_tbl_lo,y
                sta tmp_var
                lda scr_tbl_hi,y
                sta tmp_var+1
                ldy #$00
                lda (tmp_var),y
                cmp #$A0
                beq end
                stx sprite2_y
                stx $D003
    end
                rts
.)

init:
            lda #$00
            sta $d020
            sta $d021
            sta score_1
            sta score_2
            jsr clear_scr
            jsr init_sprite
            jsr draw_board
            jsr setup_irq
loop:       lda #$00
            sta sync
wait:
            lda sync
            beq wait
            lda $dc00
            cmp #125
            bne p1_down
            jsr move_down_1
            jmp end_loop
p1_down:
            cmp #126
            bne end_loop
            jsr move_up_1
end_loop:
            jmp loop
