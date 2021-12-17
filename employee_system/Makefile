var?=ser

ifeq ($(var),ser)
ser:ser.o
	@gcc ser.o -o ser -pthread -lsqlite3
ser.o:ser.s
	@gcc -c ser.s -o ser.o -pthread -lsqlite3
ser.s:ser.i
	@gcc -S ser.i -o ser.s -pthread -lsqlite3
ser.i:ser.c
	@gcc -E ser.c -o ser.i -pthread -lsqlite3
else
cli:cli.o
    @gcc -c cli -o cli.o
          
endif

clean:
	rm ${var} ${var}.o ${var}.s ${var}.i
