main:
	glslViewer main.frag --nocursor -I./lib -p 8000

main-dbg:
	glslViewer main.frag --nocursor -I./lib

dyka:
	glslViewer final/dyka.frag --nocursor -I./lib -p 8000

dyka-dbg:
	glslViewer final/dyka.frag --nocursor -I./lib

zonnestral:
	glslViewer sets/singles/zonnestral.frag --nocursor -I./lib -p 8000

zonnestral-dbg:
	glslViewer sets/singles/zonnestral.frag --nocursor -I./lib

pauly:
	glslViewer pauly.vert pauly.frag rsc/tetrahedron.ply -C rsc/mel-sprinkles.jpeg -p 8000 --nocursor -I./lib

f:
	glslViewer final/final.frag --nocursor -I./lib -p 8000

f-dbg:
	glslViewer final/final.frag --nocursor -I./lib

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

wood:
	glslViewer sets/wood-set.frag --nocursor -I./lib -p 8000

wood-dbg:
	glslViewer sets/wood-set.frag -I./lib

couch:
	glslViewer sets/couch-set.frag --nocursor -I./lib -p 8000

couch-dbg:
	glslViewer sets/couch-set.frag -I./lib



### SONGS ###
kungs-i-feel-so-bad:
	glslViewer sets/songs/kungs-i-feel-so-bad.frag --nocursor -I./lib -p 8000

kungs-i-feel-so-bad-dbg:
	glslViewer sets/songs/kungs-i-feel-so-bad.frag -I./lib

adam-beyer-your-mind:
	glslViewer sets/songs/adam-beyer-your-mind.frag --nocursor -I./lib -p 8000

now:
	glslViewer sets/songs/now.frag --nocursor -I./lib -p 8000

adam-beyer-your-mind-dbg:
	glslViewer sets/songs/adam-beyer-your-mind.frag -I./lib

imanbek-brother-louie:
	glslViewer sets/songs/imanbek-brother-louie.frag --nocursor -I./lib -p 8000

imanbek-brother-louie-dbg:
	glslViewer sets/songs/imanbek-brother-louie.frag -I./lib
