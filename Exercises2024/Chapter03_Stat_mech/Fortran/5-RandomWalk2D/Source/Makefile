FCOMPFLAGS    = -O2 -Wall -ffixed-line-length-132 -g
CCOMPFLAGS    = -O2 -Wall -g

FFLAGS        =	$(FCOMPFLAGS) -fsecond-underscore
CFLAGS        = $(CCOMPFLAGS)
LDFLAGS       =	$(FCOMPFLAGS)

LD            =	gfortran
FC            =	gfortran
CC            =	cc

MAKEFILE      =	Makefile
PROGRAM       =	random2d

INCS	      =	system.inc

OBJS	      =	random2d.o       \
		ran_uniform.o    \
		sample.o         \
		sstmm.o

EXECS         =	random2d.exe

all:		$(PROGRAM)

$(PROGRAM)::	$(INCS)
		@/bin/rm -f $(OBJS) core

$(PROGRAM)::	$(OBJS) $(MAKEFILE)
		@$(LD) $(LDFLAGS) $(OBJS) -o $(EXECS)

clean:;		@rm -f $(OBJS) $(EXECS) core
