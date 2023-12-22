FCOMPFLAGS    = -O2 -Wall -ffixed-line-length-132 -g
CCOMPFLAGS    = -O2 -Wall -g

FFLAGS        =	$(FCOMPFLAGS) -fsecond-underscore
CFLAGS        = $(CCOMPFLAGS)
LDFLAGS       =	$(FCOMPFLAGS)

LD            =	gfortran
FC            =	gfortran
CC            =	cc

MAKEFILE      =	Makefile
PROGRAM       =	md_nve
EXECS         =	md_nve.exe

INCS	      =	system.inc

OBJS	      =	force.o             \
		init.o              \
		integrate.o         \
		md.o                \
		mdloop.o            \
		ran_uniform.o       \
		rangauss.o          \
		readdat.o           \
		sample_diff.o       \
		sample_gyra.o       \
		sstmm.o             \
		writepdb.o

all:		$(PROGRAM)

$(PROGRAM)::	$(INCS)
		@/bin/rm -f $(OBJS) core

$(PROGRAM)::	$(OBJS) $(MAKEFILE)
		@$(LD) $(LDFLAGS) $(OBJS) -o $(EXECS)

clean:;		@rm -f $(OBJS) core $(EXECS)
