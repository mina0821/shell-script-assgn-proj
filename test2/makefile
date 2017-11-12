
proc2.cpp: proc1.cpp
	tr "1" "2" <proc1.cpp> proc2.cpp

proc3.cpp: proc1.cpp
	tr "1" "3" <proc1.cpp> proc3.cpp

proc.cpp: set1 set2 set3
	cat set1 > proc.cpp
	cat set2 >> proc.cpp
	cat set3 >> proc.cpp

proc: proc2.cpp proc3.cpp proc.cpp
	./comp proc

clean:
	rm proc2.cpp proc3.cpp proc.cpp proc
