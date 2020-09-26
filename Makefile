main8000:
	glslViewer main.frag --nocursor -I./lib -p 8000

main:
	glslViewer main.frag --nocursor -I./lib

hwset:
	glslViewer sets/hwset.frag --nocursor -I./lib -p 8000

hwset-dbg:
	glslViewer sets/hwset.frag -I./lib

kungs-i-feel-so-bad:
	glslViewer sets/songs/kungs-i-feel-so-bad.frag --nocursor -I./lib -p 8000
