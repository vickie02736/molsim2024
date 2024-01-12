FCOMPFLAGS    = -O2 -Wall -ffixed-line-length-132 -g
CCOMPFLAGS    = -O2 -Wall -g

FFLAGS        =	$(FCOMPFLAGS) -fsecond-underscore
CFLAGS        = $(CCOMPFLAGS)
LDFLAGS       =	$(FCOMPFLAGS)

LD            =	gfortran
FC            =	gfortran
CC            =	cc

MAKEFILE      =	Makefile
PROG1         =	hard1

INCS	      =	system.inc

OBJ1	      =	hard1.o writepdb.o ran_uniform.o sample.o sstmm.o

EXECS         =	hard1.exe

all:		$(PROG1)

$(PROG1)::	$(INCS)
		@/bin/rm -f $(OBJS) core

$(PROG1)::	$(OBJ1) $(OBJS) $(MAKEFILE)
		@$(LD) $(LDFLAGS) $(OBJ1) -o $(EXECS)

clean:;		@rm -f $(OBJ1) core $(EXECS)
