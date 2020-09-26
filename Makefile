main:
	glslViewer main.frag --nocursor -I./lib -p 8000

main-dbg:
	glslViewer main.frag --nocursor -I./lib

# timer:
#    while true; do echo -ne "`date`\r"; done


### SETS ###
hwset:
	glslViewer sets/hwset.frag --nocursor -I./lib -p 8000

hwset-dbg:
	glslViewer sets/hwset.frag -I./lib

ridge:
	glslViewer sets/ridge-set.frag --nocursor -I./lib -p 8000

ridge-dbg:
	glslViewer sets/ridge-set.frag -I./lib

sayin:
	glslViewer sets/sayin-set.frag --nocursor -I./lib -p 8000

sayin-dbg:
	glslViewer sets/sayin-set.frag -I./lib

x:
	glslViewer sets/x-set.frag --nocursor -I./lib -p 8000

x-dbg:
	glslViewer sets/x-set.frag -I./lib

circle:
	glslViewer sets/circle-set.frag --nocursor -I./lib -p 8000

circle-dbg:
	glslViewer sets/circle-set.frag -I./lib

doppler:
	glslViewer sets/doppler-set.frag --nocursor -I./lib -p 8000

doppler-dbg:
	glslViewer sets/doppler-set.frag -I./lib



### SONGS ###
kungs-i-feel-so-bad:
	glslViewer sets/songs/kungs-i-feel-so-bad.frag --nocursor -I./lib -p 8000

kungs-i-feel-so-bad-dbg:
	glslViewer sets/songs/kungs-i-feel-so-bad.frag -I./lib

adam-beyer-your-mind:
	glslViewer sets/songs/adam-beyer-your-mind.frag --nocursor -I./lib -p 8000

adam-beyer-your-mind-dbg:
	glslViewer sets/songs/adam-beyer-your-mind.frag -I./lib
