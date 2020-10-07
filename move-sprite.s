; write program location address
.word $0801
; set program counter
*= $0801
; write BASIC LINE "2012 SYS 2061"
                .byt $0b,$08,$20,$03,$9e,$32,$30,$36,$31,$00,$00,$00
; vars
sync            = $03
ship_x_inc      = $04
ship_y_inc      = $05
ship_y          = $06
ship_x_lo      = $07
ship_x_hi     = $08

; jump to main loop
                jmp main
; data
.dsb ( 2112 - * ),$00
sprite_ship:
                .byte %00000000, %10000000, %00000000
                .byte %00000000, %11000000, %00000000
                .byte %00000000, %11100000, %00000000
                .byte %00000000, %11110000, %00000000            
                .byte %00000000, %11111000, %00000000
                .byte %00000000, %00000000, %00000000
                .byte %00001110, %11111111, %00000000                
                .byte %00001110, %11000011, %11100111
                .byte %00001110, %10000001, %11100111
                .byte %00001110, %10011001, %11100000
                .byte %00001110, %10011001, %11100000
                .byte %00001110, %10000001, %11100111
                .byte %00001110, %11000011, %11100111                
                .byte %00001110, %11111111, %00000000
                .byte %00000000, %00000000, %00000000
                .byte %00000000, %11111000, %00000000
                .byte %00000000, %11110000, %00000000
                .byte %00000000, %11100000, %00000000
                .byte %00000000, %11000000, %00000000                
                .byte %00000000, %10000000, %00000000
                .byte %00000000, %00000000, %00000000
                .byte $00
sprite_ship2:
                .byte %00000000, %10000000, %00000000
                .byte %00000000, %11000000, %00000000
                .byte %00000000, %11100000, %00000000
                .byte %00000000, %11110000, %00000000
                .byte %00000000, %11111000, %00000000
                .byte %00000000, %11111100, %00000000
                .byte %00111111, %11111111, %00000000                
                .byte %00111111, %11000011, %11100111
                .byte %11001111, %10000001, %11100111
                .byte %11001111, %10011001, %11100000
                .byte %00111111, %10011001, %11100000
                .byte %00111111, %10000001, %11100111
                .byte %11001111, %11000011, %11100111                
                .byte %11001111, %11111111, %00000000
                .byte %00000000, %11111100, %00000000
                .byte %00000000, %11111000, %00000000
                .byte %00000000, %11110000, %00000000
                .byte %00000000, %11100000, %00000000
                .byte %00000000, %11000000, %00000000                
                .byte %00000000, %10000000, %00000000
                .byte %00000000, %00000000, %00000000
                .byte $00
; code
setup_irq:
.(
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

                lda #$18            ; trigger first interrupt at row zero
                sta $d012

                lda $d011           ; Bit#0 of $d011 is basically...
                and #$7f            ; ...the 9th Bit for $d012
                sta $d011           ; we need to make sure it is set to zero 

                cli                 ; clear interrupt disable flag
                rts
.)
irq:
.(
                dec $d019        ; acknowledge IRQ
                lda #$01
                sta sync                
                jmp $ea31        ; return to kernel interrupt routine
.)
init_ship:
 .(
                lda $D015
                ora #$01                ; ship is 1st sprite
                sta $D015
                lda #(sprite_ship / 64) ; setup sprite pointers
                sta $07F8
                lda #$50                ; setup x coord sprite 1
                sta $D000
                sta ship_x_lo
                lda #80                ; setup y coord sprite 1
                sta $D001
                sta ship_y
                
                lda #$00
                sta ship_x_inc
                sta ship_y_inc
                sta ship_x_hi
                rts
.)
joy_2:
.(                
                lda $dc00
                ldx #$00
                ldy #$00                
    joy_up
                lsr                     ;up
                bcs joy_down
                ldx #$FE
    joy_down
                lsr                     ;down
                bcs joy_left
                ldx #$02                         
    joy_left
                lsr                     ;left                
                bcs joy_right                
                ldy #$FE
    joy_right
                lsr                     ;right
                bcs end 
                ldy #$02       
    end
                stx ship_y_inc                
                sty ship_x_inc
                rts
.)
update_ship:
.(                
                lda $D001
                clc
                adc ship_y_inc
    check_y
                cmp #66                 ; limit upper
                bcc update_x        
                cmp #232                ; limit lower
                bcs update_x
                sta $D001
                
    update_x    
                lda $d010               ; if x > 255
                and #$01
                beq xlow                 
    xhigh
                lda ship_x_inc          ; if movement is right
                bpl xhigh_r
    xhigh_l                
                clc                     ; move left
                adc $d000
                tax                     
                bpl store_x             ; if x >= 0 store as is
                lda #$00                ; else x < 256 so clear high bit
                sta $d010
                jmp store_x
    xhigh_r
                clc                     ; move right
                adc $d000
                tax
                cmp #66                 ; check right screen limit
                bcs end
                jmp store_x
    xlow
                lda ship_x_inc          ; if movement is right
                bpl low_r
    low_l
                clc                     ; move left
                adc $d000
                tax
                cmp #20                 ; check left screen limit
                bcc end
                jmp store_x
    low_r                
                clc
                adc $d000               ; move right
                tax
                bcc store_x             ; if x > 255 set hight bit
                lda $d010
                ora #$01
                sta $d010
    store_x                
                stx $d000
    end                
                rts
.)

main:
.(
                lda #$00
                sta $d020
                sta $d021
                jsr init_ship
                jsr setup_irq
loop            lda #$00
                sta sync                
wait
                lda sync
                beq wait
                jsr joy_2
                jsr update_ship                
                jmp loop
.)
                
