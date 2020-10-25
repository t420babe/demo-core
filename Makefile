main:
	glslViewer main.frag rsc/img/graf.jpeg rsc/img/mel-sprinkles.jpeg --nocursor -I./lib -p 8000

main-dbg:
	glslViewer main.frag --nocursor -I./lib

main-8001:
	glslViewer main.frag --nocursor -I./lib -p 8001


### SETS ###
hw-set:
	glslViewer sets/hwset.frag --nocursor -I./lib -p 8000

hw-set-8001:
	glslViewer sets/hwset.frag --nocursor -I./lib -p 8001

hw-set-dbg:
	glslViewer sets/hwset.frag -I./lib

ridge-set:
	glslViewer sets/ridge-set.frag --nocursor -I./lib -p 8000

ridge-set-8001:
	glslViewer sets/ridge-set.frag --nocursor -I./lib -p 8001

ridge-dbg:
	glslViewer sets/ridge-set.frag -I./lib

sayin-set:
	glslViewer sets/sayin-set.frag --nocursor -I./lib -p 8000

sayin-set-8001:
	glslViewer sets/sayin-set.frag --nocursor -I./lib -p 8001

sayin-set-dbg:
	glslViewer sets/sayin-set.frag -I./lib

x-set:
	glslViewer sets/x-set.frag --nocursor -I./lib -p 8000

x-set-8001:
	glslViewer sets/x-set.frag --nocursor -I./lib -p 8001

x-set-dbg:
	glslViewer sets/x-set.frag -I./lib

circle-set:
	glslViewer sets/circle-set.frag --nocursor -I./lib -p 8000

circle-set-8001:
	glslViewer sets/circle-set.frag --nocursor -I./lib -p 8001

circle-set-dbg:
	glslViewer sets/circle-set.frag -I./lib

doppler-set:
	glslViewer sets/doppler-set.frag --nocursor -I./lib -p 8000

doppler-set-dbg:
	glslViewer sets/doppler-set.frag -I./lib

wood-set:
	glslViewer sets/wood-set.frag --nocursor -I./lib -p 8000

wood-set-dbg:
	glslViewer sets/wood-set.frag -I./lib

couch-set:
	glslViewer sets/couch-set.frag --nocursor -I./lib -p 8000

couch-set-dbg:
	glslViewer sets/couch-set.frag -I./lib

### SONGS ###
kungs:
	glslViewer sets/songs/kungs-i-feel-so-bad.frag --nocursor -I./lib -p 8000

kungs-8001:
	glslViewer sets/songs/kungs-i-feel-so-bad.frag --nocursor -I./lib -p 8001

kungs-dbg:
	glslViewer sets/songs/kungs-i-feel-so-bad.frag -I./lib

your-mind:
	glslViewer sets/songs/adam-beyer-your-mind.frag --nocursor -I./lib -p 8000

your-mind-8001:
	glslViewer sets/songs/adam-beyer-your-mind.frag --nocursor -I./lib -p 8001

your-mind-dbg:
	glslViewer sets/songs/adam-beyer-your-mind.frag --nocursor -I./lib

no-nighttime:
	glslViewer sets/songs/no-nighttime.frag --nocursor -I./lib -p 8000

no-nighttime-8001:
	glslViewer sets/songs/no-nighttime.frag --nocursor -I./lib -p 8001

no-nighttime-dbg:
	glslViewer sets/songs/no-nighttime.frag --nocursor -I./lib

brother-louie:
	glslViewer sets/songs/imanbek-brother-louie.frag --nocursor -I./lib -p 8000

brother-louie-8001:
	glslViewer sets/songs/imanbek-brother-louie.frag --nocursor -I./lib -p 8001

brother-louie-dbg:
	glslViewer sets/songs/imanbek-brother-louie.frag -I./lib

if:
	glslViewer sets/songs/imaginary-friends-ov-deadmau5-morgan-page.frag --nocursor -I./lib -p 8000

if-8001:
	glslViewer sets/songs/imaginary-friends-ov-deadmau5-morgan-page.frag --nocursor -I./lib -p 8001

if-dbg:
	glslViewer sets/songs/imaginary-friends-ov-deadmau5-morgan-page.frag --nocursor -I./lib

# Techno Prank by Dubdogz
dyka:
	glslViewer sets/dyka.frag --nocursor -I./lib -p 8000

dyka-8001:
	glslViewer sets/dyka.frag --nocursor -I./lib -p 8001

dyka-dbg:
	glslViewer sets/dyka.frag --nocursor -I./lib

zonnestral:
	glslViewer sets/songs/zonnestral.frag --nocursor -I./lib -p 8000 rsc/img/arch.jpeg

zonnestral-8001:
	glslViewer sets/songs/zonnestral.frag --nocursor -I./lib -p 8000 rsc/img/arch.jpe1

zonnestral-dbg:
	glslViewer sets/songs/zonnestral.frag --nocursor -I./lib rsc/img/arch.jpeg

rabbit-hole:
	glslViewer sets/songs/camel-phat-rabbit-hole.frag --nocursor -I./lib -p 8000

rabbit-hole-8001:
	glslViewer sets/songs/camel-phat-rabbit-hole.frag --nocursor -I./lib -p 8001

rabbit-hole-dbg:
	glslViewer sets/songs/camel-phat-rabbit-hole.frag --nocursor -I./lib

heart-attack:
	glslViewer sets/songs/camel-phat-rabbit-hole.frag --nocursor -I./lib -p 8000

heart-attack-8001:
	glslViewer sets/songs/camel-phat-rabbit-hole.frag --nocursor -I./lib -p 8001

heart-attack-dbg:
	glslViewer sets/songs/camel-phat-rabbit-hole.frag --nocursor -I./lib

# BROKEN :(
py2bk:
	glslViewer sets/songs/py2byk-bushwick-og.frag rsc/img/graf.jpeg --nocursor -I./lib -C rsc/models/tetrahedron.ply -p 8000

py2bk-8001:
	glslViewer sets/songs/py2byk-bushwick-og.frag rsc/img/graf.jpeg --nocursor -I./lib -C rsc/models/tetrahedron.ply -p 8001

py2bk-dbg:
	glslViewer sets/songs/p2bk-bushwick-og.frag rsc/img/graf.jpeg --nocursor -I./lib -C rsc/models/tetrahedron.ply

# Techno Prank by Dubdogz
techno-prank:
	glslViewer sets/songs/techno-prank.frag --nocursor -I./lib -p 8000

techno-prank-8001:
	glslViewer sets/songs/techno-prank.frag --nocursor -I./lib -p 8001

techno-prank-dbg:
	glslViewer sets/songs/techno-prank.frag --nocursor -I./lib

#  Run by Tourist
tourist-run:
	glslViewer sets/songs/tourist-run.frag --nocursor -I./lib -p 8000

tourist-run-8001:
	glslViewer sets/songs/tourist-run.frag --nocursor -I./lib -p 8001

tourist-run-dbg:
	glslViewer sets/songs/tourist-run.frag --nocursor -I./lib

#  Porto by Worakls
porto:
	glslViewer sets/songs/worakls-porto.frag --nocursor -I./lib -p 8000

porto-8001:
	glslViewer sets/songs/worakls-porto.frag --nocursor -I./lib -p 8001

porto-dbg:
	glslViewer sets/songs/worakls-porto.frag --nocursor -I./lib

turb-square:
	glslViewer sets/stretched-turb-square-spiral.frag --nocursor -I./lib -p 8000

turb-square-8001:
	glslViewer sets/stretched-turb-square-spiral.frag --nocursor -I./lib -p 8001

turb-square-dbg:
	glslViewer sets/stretched-turb-square-spiral.frag --nocursor -I./lib

soft-turbulence:
	glslViewer sets/soft-turbulence.frag --nocursor -I./lib -p 8000

soft-turbulence-8001:
	glslViewer sets/soft-turbulence.frag --nocursor -I./lib -p 8001

soft-turbulence-dbg:
	glslViewer sets/soft-turbulence.frag --nocursor -I./lib


# Take My Money - Christian
cash:
	glslViewer sets/songs/cash.frag  --nocursor -I./lib -p 8000

cash-8001:
	glslViewer sets/songs/cash.frag --nocursor -I./lib -p 8001

cash-dbg:
	glslViewer sets/songs/cash.frag --nocursor -I./lib

flora:
	glslViewer sets/flora.frag  --nocursor -I./lib -p 8000 rsc/img/flora.jpeg

flora-8001:
	glslViewer sets/flora.frag --nocursor -I./lib -p 8001 rsc/img/flora.jpeg

flora-dbg:
	glslViewer sets/flora.frag --nocursor -I./lib rsc/img/flora.jpeg

lux-ahh:
	glslViewer main.frag  --nocursor -I./lib -p 8000 rsc/img/mel-sprinkles.jpeg rsc/img/eyes.jpeg

lux-ahh-8001:
	glslViewer main.frag --nocursor -I./lib -p 8001 rsc/img/mel-sprinkles.jpeg rsc/img/eyes.jpeg

lux-ahh-dbg:
	glslViewer main.frag --nocursor -I./lib rsc/img/mel-sprinkles.jpeg rsc/img/eyes.jpeg

# Shempi by Ratatat
the-comedown:
	 glslViewer sets/the-comedown-2020-edition.frag rsc/img/isurvived.png --nocursor -p 8000 -I./lib

the-comedown-8001:
	 glslViewer sets/the-comedown-2020-edition.frag rsc/img/isurvived.png --nocursor -p 8001 -I./lib

the-comedown-dbg:
	 glslViewer sets/the-comedown-2020-edition.frag rsc/img/isurvived.png --nocursor -I./lib
	
# Strangers by Betical
strangers:
	 glslViewer sets/strangers.frag rsc/img/mel-sprinkles.jpeg --nocursor -p 8000 -I./lib

strangers-8001:
	 glslViewer sets/strangers.frag rsc/img/mel-sprinkles.jpeg --nocursor -p 8001 -I./lib

strangers-dbg:
	 glslViewer sets/strangers.frag rsc/img/mel-sprinkles.jpeg --nocursor -I./lib
	
lut-2:
	glslViewer lib/lut/lut-2.frag rsc/img/lot.jpeg rsc/img/streetart/tavern.jpeg -p 8000 --nocursor -I./lib

lut-2-8001:
	glslViewer lib/lut/lut-2.frag rsc/img/lot.jpeg rsc/img/streetart/tavern.jpeg -p 8001 --nocursor -I./lib

lut-2-dbg:
	glslViewer lib/lut/lut-2.frag rsc/img/lot.jpeg rsc/img/streetart/tavern.jpeg --nocursor -I./lib

goon-0:
	glslViewer lib/t420babe/goon/goon-0.frag  -p 8000 --nocursor -I./lib

goon-0-8001:
	glslViewer lib/t420babe/goon/goon-0.frag  -p 8001 --nocursor -I./lib

goon-0-dbg:
	glslViewer lib/t420babe/goon/goon-0.frag  --nocursor -I./lib

goon-1:
	glslViewer lib/t420babe/goon/goon-1.frag  -p 8000 --nocursor -I./lib

goon-1-8001:
	glslViewer lib/t420babe/goon/goon-1.frag  -p 8001 --nocursor -I./lib

goon-1-dbg:
	glslViewer lib/t420babe/goon/goon-1.frag  --nocursor -I./lib

# Pional - In Another Room
caterpillar:
	glslViewer sets/caterpillar.frag  -p 8000 --nocursor -I./lib

caterpillar-8001:
	glslViewer sets/caterpillar.frag  -p 8001 --nocursor -I./lib

caterpillar-dbg:
	glslViewer sets/caterpillar.frag  --nocursor -I./lib

# Fuego
fuego:
	glslViewer sets/fuego.frag  -p 8000 --nocursor -I./lib

fuego-8001:
	glslViewer sets/fuego.frag  -p 8001 --nocursor -I./lib

fuego-dbg:
	glslViewer sets/fuego.frag  --nocursor -I./lib

# 
gloss:
	glslViewer sets/gloss.frag  -p 8000 --nocursor -I./lib

gloss-8001:
	glslViewer sets/gloss.frag  -p 8001 --nocursor -I./lib

gloss-dbg:
	glslViewer sets/gloss.frag  --nocursor -I./lib

# 
gloss-0:
	glslViewer sets/gloss-0.frag  -p 8000 --nocursor -I./lib

gloss-0-8001:
	glslViewer sets/gloss-0.frag  -p 8001 --nocursor -I./lib

gloss-0-dbg:
	glslViewer sets/gloss-0.frag  --nocursor -I./lib

# 
gloss-1:
	glslViewer sets/gloss-1.frag  -p 8000 --nocursor -I./lib

gloss-1-8001:
	glslViewer sets/gloss-1.frag  -p 8001 --nocursor -I./lib

gloss-1-dbg:
	glslViewer sets/gloss-1.frag  --nocursor -I./lib

# Porto
rorschach:
	glslViewer sets/rorschach.frag  -p 8000 --nocursor -I./lib

rorschach-8001:
	glslViewer sets/rorschach.frag  -p 8001 --nocursor -I./lib

rorschach-dbg:
	glslViewer sets/rorschach.frag  --nocursor -I./lib
