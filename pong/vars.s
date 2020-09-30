; some useful labels
char_addr=$0400
; zero page $02 - $08 usable (8 bytes)
; zero page $0a - $1D usable (19 bytes)
; zero page $30 - $36 usable (7 bytes)
; zero page $37-38 not usable
; zero page $39-$70 usabble   (55 bytes)

sprite1_y=      $02
sprite1_row =   $03
sprite2_y=      $04
sprite2_row =   $05
sync=           $06
char_ptr =      $07
tmp_var =       $08
score_1 =       $0a
score_2 =       $0b
ball_x_col =    $15
ball_y_col =    $16
ball_fract =    $17
