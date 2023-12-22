FCOMPFLAGS    =	-O2 -g -ffixed-line-length-132
CCOMPFLAGS    =	-O2 -g

FFLAGS        =	$(FCOMPFLAGS)
CFLAGS        = $(CCOMPFLAGS)
LDFLAGS       =	$(FCOMPFLAGS)

LD            =	gfortran
FC            =	gfortran
CC            =	cc

MAKEFILE      =	Makefile
PROGRAM       =	cfcmc

INCS	      =	

OBJS	      =	WLupdate.o change_fractional.o etot.o mc.o movelambda.o selectint.o volume_gibbs.o accept.o epart.o init.o move.o ran_uniform.o swap_fractional.o
EXECS   = cfcmc.exe

all:		$(PROGRAM)

$(PROGRAM)::	$(INCS)
		@/bin/rm -f $(OBJS) core

$(PROGRAM)::	$(OBJS) $(MAKEFILE)
		@$(LD) $(LDFLAGS) $(OBJS) -o $(EXECS)

clean:;		@rm -f $(OBJS) core $(EXECS)
