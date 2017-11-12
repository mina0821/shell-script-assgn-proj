all: test1 test2

test2: test1
	./s2 test1 test2 "0,test" "1,test"
test1: .FORCE
	./s1 test1 test1 300
.FORCE:

f1: f1.py f2.py
	python f1.py
	rm f2.py*
f2.py: .FORCE
	echo '# module f2.py' > f2.py
	echo 'def day():' >> f2.py
	echo '	x="' `date` '"' >> f2.py
	echo '	x=x[1:4]' >> f2.py
	echo '	print x' >> f2.py
