jar: compile
	cd bin && \
	jar cfe ../Robol.jar robol.Main **/*.class
	
compile:
	mkdir -p bin
	cd src && \
	javac -d ../bin robol/Main.java
	
run:
	java -jar Robol.jar

clean:
	-rm -rf bin
	-rm -f Robol.jar