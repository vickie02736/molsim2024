C	Variables overview

C     Maxpart   = Maximum Number Of Particles
C     Beta      = 1/Temperature
C     Etotal    = Total Energy Of A Box
C     Lambda    = Lambda In Cfcmc


C	Init.f CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C   Npbox     = Number Of Particles In A Box Including The Fractional One
C   Npart     = Number Of Particles
C   Ibox()    = In Which Box Is A Particle ? Either 1 or 2
C	Ib        =	To which box does this particle belong? 1 or 2
C   Box()     = Box (1 or 2) length 
C	Ipart     =	Randomly selected particle
C   Rx/Ry/Rz  = Coordinates
C   Rnx/Rny/Rnz  = new Coordinates after mc moves
C	Xi, Yi, Zi	= Actual (unmirrored) coordinates of the particle

C   epart.f CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C   Upot	Sum of potential energy 
C	Ecutlambda fractional cut off energy (ref to CFCMC Shi & Maginn 2007 section 4. Simulation details, eq.s 18 & 20 )
C	Bx  	 = Box(Ib) length
C	HBx  	 = Half a box(Ib) length
C	Rcutsq    = Cut-Off Radius Squared 
C	R2=Rcutsq	= Cut-Off Radius Squared 
C	Xi, Yi, Zi	= Actual (unmirrored) coordinates of the particle
C   Nth-part is the fractional molecule


C	etot.f CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C	Bx  	 = Box(Ib) length
C	HBx  	 = Half a box(Ib) length
C               Nth-part is the fractional molecule
C	Ecutlambda fractional cut off energy (ref to CFCMC Shi & Maginn 2007...
C   section 4. Simulation details, eq.s 18 & 20 )
C	Ecut       whole particle cut off energy  

C	move.f CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C   Av1  counts accepted moves (move.f)
C	Av2  Counts ALL the trial moves (move.f)
C   Etotal

C	movelambda.f CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C   Maxbl     = In How Many Bins Do We Divide Lambda Space?
C	Lnew = 1 + Int(Dble(Maxbl)*Lambdanew): Lamda is continuous, this line...
C   determines in which disretized bin the lambda value ends up.
C   Weight(Ib,Lnew) = Weight function is a matrix, Weight specific to each bin is located in the
C   in the matrix in arrays [Ib(box number), Lambda bin(discretized lambda)]
C	Av1	accepted trials
C	Av2	sum of all trials


C	change_fractional.f CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C	Ic	Check In Which Bin Is Lambda
C   Av_Change = Acceptance Probability Of Changing The Fractional Molecule
C   As A Function Of Lambda
C	Ibold	= Ibox(Npart): 1 or 2
C	Ibnew	= 3-Ibox(Npart): 1 or 2
C   Ibox()  = In Which Box Is A Particle ? Either 1 or 2
C   Lambda    = Lambda In Cfcmc
C   Etotal    = Total Energy Of A Box

C   Swap_fractional CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C	Ic	Check In Which Bin Is Lambda
C   Av_Swap   = Acceptance Probability Of Swapping The Fractional Molecule
C   As A Function Of Lambda
C   Weight    = Weightfunction
C   Lambda    = Lambda In Cfcmc
C   Etotal    = Total Energy Of A Box

C	Volume Gibbs CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C	Avv1, Avv2: Volume Change
C	Avd1, Avd2: Particle displacement
C	Avl1, Avl2: change value of lambda (position and box unchanged)
C	Avc1, Avc2: change fractional, change the fractional molecule into a real mol.
C	and a real molecule in the other box into the fractinal one. 
C	Avs1, Avs2: Swap fractional, move the fractional molecule to the other box
C	J =	bin index
C	k =	box index






