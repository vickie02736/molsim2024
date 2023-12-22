CC          = gcc
CLINKER     = gcc

CFLAGS      = -Wall -O2 -g 
LIBS        = -lm
DEPEND= makedepend
EXECS = ising.exe

SRC        = ran_uniform.c ising.c
OBJS        = ran_uniform.o ising.o

default: ising

all: ising

ising:$(OBJS)
	$(CLINKER) $(OPTFLAGS) -o $(EXECS) $(OBJS) $(LIBS)

clean:
	/bin/rm -f *.o *~ $(EXECS)

.c.o:
	$(CC) $(CFLAGS) -c $*.c
