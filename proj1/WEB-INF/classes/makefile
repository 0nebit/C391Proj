JCC = javac
CLASSPATH = -classpath ../lib/ojdbc6.jar:../lib/commons-fileupload-1.0.jar
SOURCEPATH = -sourcepath .:db

default: Database.class UploadImage.class

Database.class: db/Database.java
	$(JCC) $(CLASSPATH) $(SOURCEPATH) db/Database.java
	
UploadImage.class: UploadImage.java
	$(JCC) $(CLASSPATH) $(SOURCEPATH) UploadImage.java
	
clean:
	$(RM) *.class
	$(RM) db/*.class
