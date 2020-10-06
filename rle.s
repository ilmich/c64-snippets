; write program location address
.word $0801
; set program counter
*= $0801
; write BASIC LINE "2012 SYS 2061"
                .byt $0b,$08,$20,$03,$9e,$32,$30,$36,$31,$00,$00,$00
; vars
rle_src_lo = $03
rle_src_hi = $04
rle_dst_lo = $05
rle_dst_hi = $06
rle_count  = $08

; jump to main loop
                jmp main
; data
rle_map         // run lenght encoding format 
                // $ff, byte, num occurence                
                .byte $ff, $01, 3
                .byte $ff, $02, 255
                // $fe is stop
                .byte $fe
/*
    run-lenght decode routine    
    this is a self modifiyng routine
    
    
    rle_src_lo |
    rle_src_hi | ----> pointer to compressed map
    
    rle_dst_lo |
    rle_dst_hi | ----> pointer to destination
    
    rle_count    ----> number of similar bytes
    
*/
rle_decode .(
                // prepare pointers
                lda rle_dst_hi              ; destination pointer
                sta ptr_dst + 2
                lda rle_dst_lo
                sta ptr_dst + 1
                
                
                lda rle_src_hi              ; source pointers
                sta ptr_src+2
                sta ptr_src2+2
                sta ptr_src3+2
                
                lda rle_src_lo              
                sta ptr_src+1
                sta ptr_src2+1
                sta ptr_src3+1
    loop                            
                // +1
                lda ptr_src+1               ; source pointer + 1 (is the compressed byte)
                clc
                adc #$01
                sta ptr_src2+1
                lda #$00
                adc ptr_src2+2
                sta ptr_src2+2
                
                // +1
                lda ptr_src2+1              ; source pointer +2 (is the nr of compressed byte)
                clc
                adc #$01
                sta ptr_src3+1
                lda #$00
                adc ptr_src3+2
                sta ptr_src3+2
    
    ptr_src
                lda $0801                   ; fake pointer
                cmp #$fe                    ; end of compressed map?
                beq end_loop                
    ptr_src2
                ldx $0802                   ; load byte
    ptr_src3
                ldy $0803                   ; load counter
                sty rle_count
                                
                ldy #$00                    ; start to explode bytes
    print_loop
    ptr_dst
                stx $0400                   ; store char
                iny
                cpy rle_count               ; y > counter
                beq next_rle                ; jump to next tuple
                lda ptr_dst + 1             ; self modify pointer
                clc
                adc #$01
                sta ptr_dst + 1                
                lda #$00
                adc ptr_dst + 2
                sta ptr_dst + 2
                jmp print_loop              ; explode another byte
    next_rle
                lda ptr_src3+1              ; increase src pointer
                clc
                adc #$01
                sta ptr_src+1
                lda #$00
                adc ptr_src+2
                sta ptr_src+2
                                
                lda ptr_dst + 1             ; increase dst pointer
                clc
                adc #$01
                sta ptr_dst + 1                
                lda #$00
                adc ptr_dst + 2
                sta ptr_dst + 2
                
                jmp loop                    ; scan another tuple
    end_loop                
                rts

.)
                
main
                // setup pointer
                lda #<rle_map
                sta rle_src_lo
                lda #>rle_map
                sta rle_src_hi
                lda #$04
                sta rle_dst_hi
                lda #$00
                sta rle_dst_lo
                
                jsr rle_decode
main_loop
                jmp main_loop
