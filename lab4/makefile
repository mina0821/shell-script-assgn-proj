all: prog prog1 prog2 prog3

s2: s1 
	tr "1" "2" < s1 > s2
	chmod u+x s2

prog.cpp: a1 a2 a3
	cat a1 > prog.cpp
	cat s2 >> prog.cpp
	cat s3 >> prog.cpp

p2.cpp: p1.cpp
	
