FCOMPFLAGS    = -O2 -Wall -ffixed-line-length-132 -g
CCOMPFLAGS    = -O2 -Wall -g

FFLAGS        =	$(FCOMPFLAGS) -fsecond-underscore
CFLAGS        = $(CCOMPFLAGS)
LDFLAGS       =	$(FCOMPFLAGS)

LD            =	gfortran
FC            =	gfortran
CC            = cc

MAKEFILE      =	Makefile
PROGRAM       =	photon

INCS	      =	

OBJS	      =	photon.o ran_uniform.o sstmm.o

EXECS         =	photon.exe

all:		$(PROGRAM)

$(PROGRAM)::	$(INCS)
		@/bin/rm -f $(OBJS) core

$(PROGRAM)::	$(OBJS) $(MAKEFILE)
		@$(LD) $(LDFLAGS) $(OBJS) -o $(EXECS)

clean:;		@rm -f $(OBJS) core $(EXECS)
