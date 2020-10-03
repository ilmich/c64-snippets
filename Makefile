pong.prg: pong/pong.s pong/data.s pong/vars.s
	xa -v -Ipong/ -O PETSCREEN pong/pong.s -o pong.prg
double_buffer.prg: double_buffer/double_buffer.s
	xa -v -Idouble_buffer/ -O PETSCREEN double_buffer/double_buffer.s -o double_buffer.prg
low-res.prg: low-res/low-res.s
	xa -v -Ilow-res/ -O PETSCREEN low-res/low-res.s -o low-res.prg
test_pong: pong.prg
	x64 +warp pong.prg
test_double_buffer: double_buffer.prg
	x64 +warp double_buffer.prg
test_low_res: low-res.prg
	x64 +warp low-res.prg