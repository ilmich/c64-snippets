; write program location address
.word $0801
; set program counter
*=$0801
; write BASIC LINE "2012 SYS 2061"
                .byt $0b,$08,$20,$03,$9e,$32,$30,$36,$31,$00,$00,$00
; vars

lowchar1 = $40
lowchar2 = $41
lowchar3 = $42
lowchar4 = $43

// pointer to line 1
line1_lo = $44
line1_hi = $45
// pointer to line 2
line2_lo = $46
line2_hi = $47
// pointer to current screen position
cur_char_lo = $50
cur_char_hi = $51
// some counter
count_col     = $52
count_row   = $53
; jump to main loop
                jmp main
low_char_table
                .byt $20, $6C, $7B, $62, 
                .byt $7C, $E1, $FF, $FE, 
                .byt $7E, $7F, $61, $FC, 
                .byt $E2, $FB, $EC, $A0

; screen character data
low_res_map
                .byt %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000
                .byt %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000
low_res_line
                .byt %10010011, %11001000, %00100000, %11110000, %00000000, %00000000, %00000000, %00000000
                .byt %10010010, %00001000, %00100000, %10010000, %00000000, %00000000, %00000000, %00000000
                .byt %11110011, %11001000, %00100000, %10010000, %00000000, %00000000, %00000000, %00000000
                .byt %10010010, %00001000, %00100000, %10010000, %00000000, %00000000, %00000000, %00000000
                .byt %10010011, %11001111, %00111100, %11110000, %00000000, %00000000, %00000000, %00000000
                .byt %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000
                
                .byt %00000000, %00000000, %10010011, %11001111, %00100000, %11100001, %10000000, %00000000
                .byt %00000000, %00000000, %10010010, %01001001, %00100000, %10010001, %10000000, %00000000
                .byt %00000000, %00000000, %10110010, %01001111, %00100000, %10010001, %10000000, %00000000
                .byt %00000000, %00000000, %11110010, %01001010, %00100000, %10010000, %00000000, %00000000
                .byt %00000000, %00000000, %11010011, %11001011, %00111100, %11100001, %10000000, %00000000
                .byt %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000
                
low_res_end
                
clear_scr .(
                ldx #$00
                lda #$20
    loop:       sta $0400,x
                sta $0400 + $0100,x
                sta $0400 + $0200,x
                sta $0400 + $0300,x
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

// print a sequence of 4 char
print_chars .(
                ldy #$00
                ldx lowchar1
                lda low_char_table,x                
                sta (cur_char_lo),y
                iny   
                ldx lowchar2
                lda low_char_table,x                    
                sta (cur_char_lo),y
                iny
                ldx lowchar3
                lda low_char_table,x                    
                sta (cur_char_lo),y
                iny
                ldx lowchar4
                lda low_char_table,x                    
                sta (cur_char_lo),y    
                rts
.)

low_res_conv.(
                ldy #$00
                sty count_col  
                sty count_row
    parse_col
                ldy count_col
                // 1st line    
                lda (line1_lo),y
                tax
                asl
                asl
                and #12                
                sta lowchar4
                txa
                and #12
                sta lowchar3
                txa
                lsr
                lsr
                tax
                and #12
                sta lowchar2
                txa
                lsr
                lsr
                and #12
                sta lowchar1
                
                
                lda (line2_lo),y
                tax
                and #03                
                ora lowchar4
                sta lowchar4
                txa
                lsr
                lsr
                tax
                and #03                
                ora lowchar3
                sta lowchar3
                txa
                lsr
                lsr
                tax
                and #03
                ora lowchar2
                sta lowchar2
                txa
                lsr
                lsr
                and #03
                ora lowchar1
                sta lowchar1
                // print 4 chars
                jsr print_chars
                // move pointer
                clc
                lda cur_char_lo
                adc #04
                sta cur_char_lo
                bcc next_col
                inc cur_char_hi
    next_col        
                ldy count_col
                iny
                sty count_col              
                cpy #(low_res_line - low_res_map)/2
                bne parse_col
                
                // count rows
                ldy count_row
                iny                
                cpy #((low_res_end - low_res_map) / (low_res_line - low_res_map))
                beq end
    next_row    // load next row
                sty count_row
                ldy #$00
                sty count_col                
                lda cur_char_lo
                clc        
                adc #(40 - ((low_res_line - low_res_map)/2 * 4))
                sta cur_char_lo
                bcc next_line1
                inc cur_char_hi
    next_line1
                lda line1_lo
                clc
                adc #(low_res_line - low_res_map)
                sta line1_lo
                bcc next_line2
                inc line1_hi
    next_line2
                lda line2_lo
                clc
                adc #(low_res_line - low_res_map)
                sta line2_lo
                bcc ret_loop
                inc line2_hi
    ret_loop
                jmp parse_col                
    end
                rts
.)

main
                lda #>low_res_map
                sta line1_hi
                sta line2_hi
                lda #<low_res_map
                sta line1_lo
                clc                
                adc #(low_res_line - low_res_map) / 2
                sta line2_lo

                lda #<$0400
                sta cur_char_lo
                lda #>$0400
                sta cur_char_hi
                
                jsr clear_scr
                jsr low_res_conv
loop_end
                jmp loop_end