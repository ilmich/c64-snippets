pong.prg: pong/pong.s pong/data.s pong/vars.s
	xa -v -Ipong/ -O PETSCREEN pong/pong.s -o pong.prg
test_pong: pong.prg
	x64 +warp pong.prg