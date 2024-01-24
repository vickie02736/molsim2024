" Vim syntax file
" Language: PLUMED

if exists("b:current_syntax")
  finish
endif

let b:current_syntax="plumed"

if exists("g:plumed_shortcuts")
  noremap  <buffer> <F2> :PHelp<CR>
  inoremap <buffer> <F2> <Esc>:PHelp<CR>
endif

" path for plumed plugin
let s:path=expand('<sfile>:p:h:h')

" All except space and hash are in word
setlocal iskeyword=33,34,36-126

" Matching dots, possibly followed by a comment
" Only dots are part of the match
syntax match plumedDots /\v\.\.\.(\s*(#.*)*$)@=/ contained
highlight link plumedDots Type

let b:plumedActions=[]
let b:plumedDictionary={}

let b:plumedDictionary["ABMD"]=[{"word":"ARG","menu":"(numbered)"},{"word":"KAPPA=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"MIN=","menu":"(option)"},{"word":"NOISE=","menu":"(option)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"SEED=","menu":"(option)"},{"word":"STRIDE=","menu":"(option)"},{"word":"TO=","menu":"(option)"}]
let b:plumedDictionary["ALPHABETA"]=[{"word":"ATOMS","menu":"(numbered)"},{"word":"LABEL=","menu":"(label)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"NL_STRIDE=","menu":"(option)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"REFERENCE","menu":"(numbered)"},{"word":"SERIAL","menu":"(flag)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"}]
let b:plumedDictionary["ALPHARMSD"]=[{"word":"ALT_MIN","menu":"(numbered)"},{"word":"D_0=","menu":"(option)"},{"word":"HIGHEST","menu":"(numbered)"},{"word":"LABEL=","menu":"(label)"},{"word":"LESS_THAN","menu":"(numbered)"},{"word":"LOWEST","menu":"(numbered)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"MIN","menu":"(numbered)"},{"word":"MM=","menu":"(option)"},{"word":"NL_STRIDE=","menu":"(option)"},{"word":"NN=","menu":"(option)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"RESIDUES=","menu":"(option)"},{"word":"R_0=","menu":"(option)"},{"word":"SERIAL","menu":"(flag)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"},{"word":"TYPE=","menu":"(option)"},{"word":"VERBOSE","menu":"(flag)"}]
let b:plumedDictionary["ANGLE"]=[{"word":"ATOMS=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"}]
let b:plumedDictionary["ANGLES"]=[{"word":"ATOMS","menu":"(numbered)"},{"word":"BETWEEN","menu":"(numbered)"},{"word":"GROUP=","menu":"(option)"},{"word":"GROUPA=","menu":"(option)"},{"word":"GROUPB=","menu":"(option)"},{"word":"GROUPC=","menu":"(option)"},{"word":"HISTOGRAM","menu":"(numbered)"},{"word":"LABEL=","menu":"(label)"},{"word":"LESS_THAN","menu":"(numbered)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"MEAN","menu":"(numbered)"},{"word":"MORE_THAN","menu":"(numbered)"},{"word":"NL_STRIDE=","menu":"(option)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"SERIAL","menu":"(flag)"},{"word":"SWITCH=","menu":"(option)"},{"word":"SWITCHA=","menu":"(option)"},{"word":"SWITCHB=","menu":"(option)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"}]
let b:plumedDictionary["ANTIBETARMSD"]=[{"word":"ALT_MIN","menu":"(numbered)"},{"word":"D_0=","menu":"(option)"},{"word":"HIGHEST","menu":"(numbered)"},{"word":"LABEL=","menu":"(label)"},{"word":"LESS_THAN","menu":"(numbered)"},{"word":"LOWEST","menu":"(numbered)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"MIN","menu":"(numbered)"},{"word":"MM=","menu":"(option)"},{"word":"NL_STRIDE=","menu":"(option)"},{"word":"NN=","menu":"(option)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"RESIDUES=","menu":"(option)"},{"word":"R_0=","menu":"(option)"},{"word":"SERIAL","menu":"(flag)"},{"word":"STRANDS_CUTOFF=","menu":"(option)"},{"word":"STYLE=","menu":"(option)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"},{"word":"TYPE=","menu":"(option)"},{"word":"VERBOSE","menu":"(flag)"}]
let b:plumedDictionary["AROUND"]=[{"word":"ATOM=","menu":"(option)"},{"word":"BETWEEN","menu":"(numbered)"},{"word":"DATA=","menu":"(option)"},{"word":"HISTOGRAM","menu":"(numbered)"},{"word":"KERNEL=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"LESS_THAN","menu":"(numbered)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"MEAN","menu":"(numbered)"},{"word":"MORE_THAN","menu":"(numbered)"},{"word":"NL_STRIDE=","menu":"(option)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"OUTSIDE","menu":"(flag)"},{"word":"SERIAL","menu":"(flag)"},{"word":"SIGMA=","menu":"(option)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"},{"word":"XLOWER=","menu":"(option)"},{"word":"XUPPER=","menu":"(option)"},{"word":"YLOWER=","menu":"(option)"},{"word":"YUPPER=","menu":"(option)"},{"word":"ZLOWER=","menu":"(option)"},{"word":"ZUPPER=","menu":"(option)"}]
let b:plumedDictionary["AVERAGE"]=[{"word":"ARG","menu":"(numbered)"},{"word":"CLEAR=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"LOGWEIGHTS=","menu":"(option)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"STRIDE=","menu":"(option)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"},{"word":"UNORMALIZED","menu":"(flag)"}]
let b:plumedDictionary["BIASVALUE"]=[{"word":"ARG","menu":"(numbered)"},{"word":"LABEL=","menu":"(label)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"STRIDE=","menu":"(option)"}]
let b:plumedDictionary["BRIDGE"]=[{"word":"ATOMS","menu":"(numbered)"},{"word":"BRIDGING_ATOMS=","menu":"(option)"},{"word":"GROUPA=","menu":"(option)"},{"word":"GROUPB=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"NL_STRIDE=","menu":"(option)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"SERIAL","menu":"(flag)"},{"word":"SWITCH=","menu":"(option)"},{"word":"SWITCHA=","menu":"(option)"},{"word":"SWITCHB=","menu":"(option)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"}]
let b:plumedDictionary["CAVITY"]=[{"word":"ATOMS=","menu":"(option)"},{"word":"BETWEEN","menu":"(numbered)"},{"word":"DATA=","menu":"(option)"},{"word":"FILE=","menu":"(option)"},{"word":"HISTOGRAM","menu":"(numbered)"},{"word":"KERNEL=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"LESS_THAN","menu":"(numbered)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"MEAN","menu":"(numbered)"},{"word":"MORE_THAN","menu":"(numbered)"},{"word":"NL_STRIDE=","menu":"(option)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"OUTSIDE","menu":"(flag)"},{"word":"PRINT_BOX","menu":"(flag)"},{"word":"SERIAL","menu":"(flag)"},{"word":"SIGMA=","menu":"(option)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"},{"word":"UNITS=","menu":"(option)"}]
let b:plumedDictionary["CELL"]=[{"word":"LABEL=","menu":"(label)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"}]
let b:plumedDictionary["CENTER"]=[{"word":"ATOMS=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"MASS","menu":"(flag)"},{"word":"NOPBC","menu":"(flag)"},{"word":"WEIGHTS=","menu":"(option)"}]
let b:plumedDictionary["CENTER_OF_MULTICOLVAR"]=[{"word":"ATOMS=","menu":"(option)"},{"word":"COMPONENT=","menu":"(option)"},{"word":"DATA=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"}]
let b:plumedDictionary["CLASSICAL_MDS"]=[{"word":"ARG","menu":"(numbered)"},{"word":"ATOMS=","menu":"(option)"},{"word":"CLEAR=","menu":"(option)"},{"word":"EMBEDDING_OFILE=","menu":"(option)"},{"word":"FMT=","menu":"(option)"},{"word":"IGNORE_REWEIGHTING=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"LANDMARKS=","menu":"(option)"},{"word":"LOGWEIGHTS=","menu":"(option)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"METRIC=","menu":"(option)"},{"word":"NLOW_DIM=","menu":"(option)"},{"word":"OUTPUT_FILE=","menu":"(option)"},{"word":"RESTART=","menu":"(option)"},{"word":"REUSE_DATA_FROM=","menu":"(option)"},{"word":"RUN=","menu":"(option)"},{"word":"SERIAL","menu":"(flag)"},{"word":"STRIDE=","menu":"(option)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"UNORMALIZED","menu":"(flag)"},{"word":"UPDATE_FROM=","menu":"(option)"},{"word":"UPDATE_UNTIL=","menu":"(option)"},{"word":"WRITE_CHECKPOINT","menu":"(flag)"}]
let b:plumedDictionary["COM"]=[{"word":"ATOMS=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"NOPBC","menu":"(flag)"}]
let b:plumedDictionary["COMBINE"]=[{"word":"ARG","menu":"(numbered)"},{"word":"COEFFICIENTS=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"NORMALIZE","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"PARAMETERS=","menu":"(option)"},{"word":"PERIODIC=","menu":"(option)"},{"word":"POWERS=","menu":"(option)"}]
let b:plumedDictionary["COMMITTOR"]=[{"word":"ARG","menu":"(numbered)"},{"word":"BASIN_LL","menu":"(numbered)"},{"word":"BASIN_UL","menu":"(numbered)"},{"word":"FILE=","menu":"(option)"},{"word":"FMT=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"STRIDE=","menu":"(option)"}]
let b:plumedDictionary["CONSTANT"]=[{"word":"LABEL=","menu":"(label)"},{"word":"NODERIV","menu":"(flag)"},{"word":"NOPBC","menu":"(flag)"},{"word":"VALUE=","menu":"(option)"},{"word":"VALUES=","menu":"(option)"}]
let b:plumedDictionary["CONTACTMAP"]=[{"word":"ATOMS","menu":"(numbered)"},{"word":"CMDIST","menu":"(flag)"},{"word":"LABEL=","menu":"(label)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"REFERENCE","menu":"(numbered)"},{"word":"SERIAL","menu":"(flag)"},{"word":"SUM","menu":"(flag)"},{"word":"SWITCH","menu":"(numbered)"},{"word":"WEIGHT","menu":"(numbered)"}]
let b:plumedDictionary["CONVERT_TO_FES"]=[{"word":"COMPONENT=","menu":"(option)"},{"word":"GRID=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"SERIAL","menu":"(flag)"},{"word":"TEMP=","menu":"(option)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"}]
let b:plumedDictionary["COORDINATION"]=[{"word":"D_0=","menu":"(option)"},{"word":"GROUPA=","menu":"(option)"},{"word":"GROUPB=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"MM=","menu":"(option)"},{"word":"NLIST","menu":"(flag)"},{"word":"NL_CUTOFF=","menu":"(option)"},{"word":"NL_STRIDE=","menu":"(option)"},{"word":"NN=","menu":"(option)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"PAIR","menu":"(flag)"},{"word":"R_0=","menu":"(option)"},{"word":"SERIAL","menu":"(flag)"},{"word":"SWITCH=","menu":"(option)"}]
let b:plumedDictionary["COORDINATIONNUMBER"]=[{"word":"ALT_MIN","menu":"(numbered)"},{"word":"BETWEEN","menu":"(numbered)"},{"word":"D_0=","menu":"(option)"},{"word":"HIGHEST","menu":"(numbered)"},{"word":"HISTOGRAM","menu":"(numbered)"},{"word":"LABEL=","menu":"(label)"},{"word":"LESS_THAN","menu":"(numbered)"},{"word":"LOWEST","menu":"(numbered)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAX","menu":"(numbered)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"MEAN","menu":"(numbered)"},{"word":"MIN","menu":"(numbered)"},{"word":"MM=","menu":"(option)"},{"word":"MOMENTS","menu":"(numbered)"},{"word":"MORE_THAN","menu":"(numbered)"},{"word":"NL_STRIDE=","menu":"(option)"},{"word":"NN=","menu":"(option)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"R_0=","menu":"(option)"},{"word":"SERIAL","menu":"(flag)"},{"word":"SPECIES=","menu":"(option)"},{"word":"SPECIESA=","menu":"(option)"},{"word":"SPECIESB=","menu":"(option)"},{"word":"SWITCH=","menu":"(option)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"}]
let b:plumedDictionary["CS2BACKBONE"]=[{"word":"ATOMS=","menu":"(option)"},{"word":"CAMSHIFT","menu":"(flag)"},{"word":"DATA=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"NEIGH_FREQ=","menu":"(option)"},{"word":"NOEXP","menu":"(flag)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NRES=","menu":"(option)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"TEMPLATE=","menu":"(option)"}]
let b:plumedDictionary["DEBUG"]=[{"word":"DETAILED_TIMERS","menu":"(flag)"},{"word":"FILE=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"NOVIRIAL","menu":"(flag)"},{"word":"STRIDE=","menu":"(option)"},{"word":"logActivity","menu":"(flag)"},{"word":"logRequestedAtoms","menu":"(flag)"}]
let b:plumedDictionary["DENSITY"]=[{"word":"LABEL=","menu":"(label)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"NL_STRIDE=","menu":"(option)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"SERIAL","menu":"(flag)"},{"word":"SPECIES=","menu":"(option)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"}]
let b:plumedDictionary["DHENERGY"]=[{"word":"EPSILON=","menu":"(option)"},{"word":"GROUPA=","menu":"(option)"},{"word":"GROUPB=","menu":"(option)"},{"word":"I=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"NLIST","menu":"(flag)"},{"word":"NL_CUTOFF=","menu":"(option)"},{"word":"NL_STRIDE=","menu":"(option)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"PAIR","menu":"(flag)"},{"word":"SERIAL","menu":"(flag)"},{"word":"TEMP=","menu":"(option)"}]
let b:plumedDictionary["DIHCOR"]=[{"word":"ATOMS","menu":"(numbered)"},{"word":"LABEL=","menu":"(label)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"NL_STRIDE=","menu":"(option)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"SERIAL","menu":"(flag)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"}]
let b:plumedDictionary["DIPOLE"]=[{"word":"COMPONENTS","menu":"(flag)"},{"word":"GROUP=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"}]
let b:plumedDictionary["DISTANCE"]=[{"word":"ATOMS=","menu":"(option)"},{"word":"COMPONENTS","menu":"(flag)"},{"word":"LABEL=","menu":"(label)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"SCALED_COMPONENTS","menu":"(flag)"}]
let b:plumedDictionary["DISTANCES"]=[{"word":"ALT_MIN","menu":"(numbered)"},{"word":"ATOMS","menu":"(numbered)"},{"word":"BETWEEN","menu":"(numbered)"},{"word":"GROUP=","menu":"(option)"},{"word":"GROUPA=","menu":"(option)"},{"word":"GROUPB=","menu":"(option)"},{"word":"HIGHEST","menu":"(numbered)"},{"word":"HISTOGRAM","menu":"(numbered)"},{"word":"LABEL=","menu":"(label)"},{"word":"LESS_THAN","menu":"(numbered)"},{"word":"LOWEST","menu":"(numbered)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAX","menu":"(numbered)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"MEAN","menu":"(numbered)"},{"word":"MIN","menu":"(numbered)"},{"word":"MOMENTS","menu":"(numbered)"},{"word":"MORE_THAN","menu":"(numbered)"},{"word":"NL_STRIDE=","menu":"(option)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"SERIAL","menu":"(flag)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"}]
let b:plumedDictionary["DISTANCE_FROM_CONTOUR"]=[{"word":"ATOM=","menu":"(option)"},{"word":"BANDWIDTH=","menu":"(option)"},{"word":"CONTOUR=","menu":"(option)"},{"word":"DATA=","menu":"(option)"},{"word":"DIR=","menu":"(option)"},{"word":"KERNEL=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"NL_STRIDE=","menu":"(option)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"SERIAL","menu":"(flag)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"}]
let b:plumedDictionary["DRMSD"]=[{"word":"LABEL=","menu":"(label)"},{"word":"LOWER_CUTOFF=","menu":"(option)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"REFERENCE=","menu":"(option)"},{"word":"TYPE=","menu":"(option)"},{"word":"UPPER_CUTOFF=","menu":"(option)"}]
let b:plumedDictionary["DUMPATOMS"]=[{"word":"ATOMS=","menu":"(option)"},{"word":"FILE=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"PRECISION=","menu":"(option)"},{"word":"RESTART=","menu":"(option)"},{"word":"STRIDE=","menu":"(option)"},{"word":"TYPE=","menu":"(option)"},{"word":"UNITS=","menu":"(option)"},{"word":"UPDATE_FROM=","menu":"(option)"},{"word":"UPDATE_UNTIL=","menu":"(option)"}]
let b:plumedDictionary["DUMPCUBE"]=[{"word":"COMPONENT=","menu":"(option)"},{"word":"FILE=","menu":"(option)"},{"word":"FMT=","menu":"(option)"},{"word":"GRID=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"STRIDE=","menu":"(option)"}]
let b:plumedDictionary["DUMPDERIVATIVES"]=[{"word":"ARG","menu":"(numbered)"},{"word":"FILE=","menu":"(option)"},{"word":"FMT=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"RESTART=","menu":"(option)"},{"word":"STRIDE=","menu":"(option)"},{"word":"UPDATE_FROM=","menu":"(option)"},{"word":"UPDATE_UNTIL=","menu":"(option)"}]
let b:plumedDictionary["DUMPFORCES"]=[{"word":"ARG","menu":"(numbered)"},{"word":"FILE=","menu":"(option)"},{"word":"FMT=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"RESTART=","menu":"(option)"},{"word":"STRIDE=","menu":"(option)"},{"word":"UPDATE_FROM=","menu":"(option)"},{"word":"UPDATE_UNTIL=","menu":"(option)"}]
let b:plumedDictionary["DUMPGRID"]=[{"word":"FILE=","menu":"(option)"},{"word":"FMT=","menu":"(option)"},{"word":"GRID=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"STRIDE=","menu":"(option)"}]
let b:plumedDictionary["DUMPMASSCHARGE"]=[{"word":"ATOMS=","menu":"(option)"},{"word":"FILE=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"STRIDE=","menu":"(option)"}]
let b:plumedDictionary["DUMPMULTICOLVAR"]=[{"word":"DATA=","menu":"(option)"},{"word":"FILE=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"ORIGIN=","menu":"(option)"},{"word":"PRECISION=","menu":"(option)"},{"word":"STRIDE=","menu":"(option)"},{"word":"UNITS=","menu":"(option)"}]
let b:plumedDictionary["DUMPPROJECTIONS"]=[{"word":"ARG","menu":"(numbered)"},{"word":"FILE=","menu":"(option)"},{"word":"FMT=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"RESTART=","menu":"(option)"},{"word":"STRIDE=","menu":"(option)"},{"word":"UPDATE_FROM=","menu":"(option)"},{"word":"UPDATE_UNTIL=","menu":"(option)"}]
let b:plumedDictionary["EFFECTIVE_ENERGY_DRIFT"]=[{"word":"ENSEMBLE","menu":"(flag)"},{"word":"FILE=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"PRINT_STRIDE=","menu":"(option)"},{"word":"RESTART=","menu":"(option)"},{"word":"STRIDE=","menu":"(option)"},{"word":"UPDATE_FROM=","menu":"(option)"},{"word":"UPDATE_UNTIL=","menu":"(option)"}]
let b:plumedDictionary["ENERGY"]=[{"word":"LABEL=","menu":"(label)"}]
let b:plumedDictionary["ENSEMBLE"]=[{"word":"ARG","menu":"(numbered)"},{"word":"CENTRAL","menu":"(flag)"},{"word":"LABEL=","menu":"(label)"},{"word":"MOMENT=","menu":"(option)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"POWER=","menu":"(option)"},{"word":"REWEIGHT","menu":"(flag)"},{"word":"TEMP=","menu":"(option)"}]
let b:plumedDictionary["ERMSD"]=[{"word":"ATOMS=","menu":"(option)"},{"word":"CUTOFF=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"PAIRS=","menu":"(option)"},{"word":"REFERENCE=","menu":"(option)"}]
let b:plumedDictionary["EXTENDED_LAGRANGIAN"]=[{"word":"ARG","menu":"(numbered)"},{"word":"FRICTION=","menu":"(option)"},{"word":"KAPPA=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"STRIDE=","menu":"(option)"},{"word":"TAU=","menu":"(option)"},{"word":"TEMP=","menu":"(option)"}]
let b:plumedDictionary["EXTERNAL"]=[{"word":"ARG","menu":"(numbered)"},{"word":"FILE=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"NOSPLINE","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"SPARSE","menu":"(flag)"},{"word":"STRIDE=","menu":"(option)"}]
let b:plumedDictionary["FAKE"]=[{"word":"ATOMS=","menu":"(option)"},{"word":"COMPONENTS=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"PERIODIC=","menu":"(option)"}]
let b:plumedDictionary["FIND_CONTOUR"]=[{"word":"BUFFER=","menu":"(option)"},{"word":"CLEAR=","menu":"(option)"},{"word":"COMPONENT=","menu":"(option)"},{"word":"CONTOUR=","menu":"(option)"},{"word":"FILE=","menu":"(option)"},{"word":"GRID=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"LOGWEIGHTS=","menu":"(option)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"PRECISION=","menu":"(option)"},{"word":"SERIAL","menu":"(flag)"},{"word":"STRIDE=","menu":"(option)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"},{"word":"UNITS=","menu":"(option)"},{"word":"UNORMALIZED","menu":"(flag)"}]
let b:plumedDictionary["FIND_CONTOUR_SURFACE"]=[{"word":"BUFFER=","menu":"(option)"},{"word":"CLEAR=","menu":"(option)"},{"word":"COMPONENT=","menu":"(option)"},{"word":"CONTOUR=","menu":"(option)"},{"word":"GRID=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"LOGWEIGHTS=","menu":"(option)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"SEARCHDIR=","menu":"(option)"},{"word":"SERIAL","menu":"(flag)"},{"word":"STRIDE=","menu":"(option)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"},{"word":"UNORMALIZED","menu":"(flag)"}]
let b:plumedDictionary["FIND_SPHERICAL_CONTOUR"]=[{"word":"COMPONENT=","menu":"(option)"},{"word":"CONTOUR=","menu":"(option)"},{"word":"FILE=","menu":"(option)"},{"word":"GRID=","menu":"(option)"},{"word":"INNER_RADIUS=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"LOGWEIGHTS=","menu":"(option)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"NBINS=","menu":"(option)"},{"word":"NPOINTS=","menu":"(option)"},{"word":"OUTER_RADIUS=","menu":"(option)"},{"word":"PRECISION=","menu":"(option)"},{"word":"SERIAL","menu":"(flag)"},{"word":"STRIDE=","menu":"(option)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"},{"word":"UNITS=","menu":"(option)"},{"word":"UNORMALIZED","menu":"(flag)"}]
let b:plumedDictionary["FIT_TO_TEMPLATE"]=[{"word":"LABEL=","menu":"(label)"},{"word":"REFERENCE=","menu":"(option)"},{"word":"STRIDE=","menu":"(option)"},{"word":"TYPE=","menu":"(option)"}]
let b:plumedDictionary["FIXEDATOM"]=[{"word":"AT=","menu":"(option)"},{"word":"ATOMS=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"SCALED_COMPONENTS","menu":"(flag)"},{"word":"SET_CHARGE=","menu":"(option)"},{"word":"SET_MASS=","menu":"(option)"}]
let b:plumedDictionary["FLUSH"]=[{"word":"LABEL=","menu":"(label)"},{"word":"STRIDE=","menu":"(option)"}]
let b:plumedDictionary["FOURIER_TRANSFORM"]=[{"word":"CLEAR=","menu":"(option)"},{"word":"COMPONENT=","menu":"(option)"},{"word":"FOURIER_PARAMETERS=","menu":"(option)"},{"word":"FT_TYPE=","menu":"(option)"},{"word":"GRID=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"LOGWEIGHTS=","menu":"(option)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"SERIAL","menu":"(flag)"},{"word":"STRIDE=","menu":"(option)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"},{"word":"UNORMALIZED","menu":"(flag)"}]
let b:plumedDictionary["FRET"]=[{"word":"ATOMS=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"R0=","menu":"(option)"}]
let b:plumedDictionary["FUNCPATHMSD"]=[{"word":"ARG","menu":"(numbered)"},{"word":"LABEL=","menu":"(label)"},{"word":"LAMBDA=","menu":"(option)"},{"word":"NEIGH_SIZE=","menu":"(option)"},{"word":"NEIGH_STRIDE=","menu":"(option)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"}]
let b:plumedDictionary["FUNCSUMHILLS"]=[{"word":"ARG","menu":"(numbered)"},{"word":"FMT=","menu":"(option)"},{"word":"GRID_BIN=","menu":"(option)"},{"word":"GRID_MAX=","menu":"(option)"},{"word":"GRID_MIN=","menu":"(option)"},{"word":"GRID_SPACING=","menu":"(option)"},{"word":"HILLSFILES=","menu":"(option)"},{"word":"HISTOFILES=","menu":"(option)"},{"word":"HISTOSIGMA=","menu":"(option)"},{"word":"INITSTRIDE=","menu":"(option)"},{"word":"INTERVAL=","menu":"(option)"},{"word":"ISCLTOOL","menu":"(flag)"},{"word":"KT=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"MINTOZERO","menu":"(flag)"},{"word":"NEGBIAS","menu":"(flag)"},{"word":"NOHISTORY","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"OUTHILLS=","menu":"(option)"},{"word":"OUTHISTO=","menu":"(option)"},{"word":"PARALLELREAD","menu":"(flag)"},{"word":"PROJ=","menu":"(option)"},{"word":"STRIDE=","menu":"(option)"}]
let b:plumedDictionary["GHOST"]=[{"word":"ATOMS=","menu":"(option)"},{"word":"COORDINATES=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"}]
let b:plumedDictionary["GPROPERTYMAP"]=[{"word":"DISABLE_CHECKS","menu":"(flag)"},{"word":"LABEL=","menu":"(label)"},{"word":"LAMBDA=","menu":"(option)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"NOMAPPING","menu":"(flag)"},{"word":"NOZPATH","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"PROPERTY=","menu":"(option)"},{"word":"REFERENCE=","menu":"(option)"},{"word":"SERIAL","menu":"(flag)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"},{"word":"TYPE=","menu":"(option)"}]
let b:plumedDictionary["GROUP"]=[{"word":"ATOMS=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"NDX_FILE=","menu":"(option)"},{"word":"NDX_GROUP=","menu":"(option)"},{"word":"REMOVE=","menu":"(option)"},{"word":"SORT","menu":"(flag)"},{"word":"UNIQUE","menu":"(flag)"}]
let b:plumedDictionary["GYRATION"]=[{"word":"ATOMS=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"MASS_WEIGHTED","menu":"(flag)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"TYPE=","menu":"(option)"}]
let b:plumedDictionary["HISTOGRAM"]=[{"word":"ARG","menu":"(numbered)"},{"word":"BANDWIDTH=","menu":"(option)"},{"word":"CLEAR=","menu":"(option)"},{"word":"DATA=","menu":"(option)"},{"word":"GRID_BIN=","menu":"(option)"},{"word":"GRID_MAX=","menu":"(option)"},{"word":"GRID_MIN=","menu":"(option)"},{"word":"GRID_SPACING=","menu":"(option)"},{"word":"KERNEL=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"LOGWEIGHTS=","menu":"(option)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"SERIAL","menu":"(flag)"},{"word":"STRIDE=","menu":"(option)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"},{"word":"UNORMALIZED","menu":"(flag)"},{"word":"UPDATE_FROM=","menu":"(option)"},{"word":"UPDATE_UNTIL=","menu":"(option)"}]
let b:plumedDictionary["INCLUDE"]=[{"word":"FILE=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"}]
let b:plumedDictionary["INCYLINDER"]=[{"word":"ATOM=","menu":"(option)"},{"word":"BETWEEN","menu":"(numbered)"},{"word":"DATA=","menu":"(option)"},{"word":"DIRECTION=","menu":"(option)"},{"word":"HISTOGRAM","menu":"(numbered)"},{"word":"KERNEL=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"LESS_THAN","menu":"(numbered)"},{"word":"LOWER=","menu":"(option)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"MEAN","menu":"(numbered)"},{"word":"MORE_THAN","menu":"(numbered)"},{"word":"NL_STRIDE=","menu":"(option)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"OUTSIDE","menu":"(flag)"},{"word":"RADIUS=","menu":"(option)"},{"word":"SERIAL","menu":"(flag)"},{"word":"SIGMA=","menu":"(option)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"},{"word":"UPPER=","menu":"(option)"}]
let b:plumedDictionary["INPLANEDISTANCES"]=[{"word":"ALT_MIN","menu":"(numbered)"},{"word":"BETWEEN","menu":"(numbered)"},{"word":"GROUP=","menu":"(option)"},{"word":"HIGHEST","menu":"(numbered)"},{"word":"HISTOGRAM","menu":"(numbered)"},{"word":"LABEL=","menu":"(label)"},{"word":"LESS_THAN","menu":"(numbered)"},{"word":"LOWEST","menu":"(numbered)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAX","menu":"(numbered)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"MEAN","menu":"(numbered)"},{"word":"MIN","menu":"(numbered)"},{"word":"MOMENTS","menu":"(numbered)"},{"word":"MORE_THAN","menu":"(numbered)"},{"word":"NL_STRIDE=","menu":"(option)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"SERIAL","menu":"(flag)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"},{"word":"VECTOREND=","menu":"(option)"},{"word":"VECTORSTART=","menu":"(option)"}]
let b:plumedDictionary["INSPHERE"]=[{"word":"ATOM=","menu":"(option)"},{"word":"BETWEEN","menu":"(numbered)"},{"word":"DATA=","menu":"(option)"},{"word":"HISTOGRAM","menu":"(numbered)"},{"word":"KERNEL=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"LESS_THAN","menu":"(numbered)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"MEAN","menu":"(numbered)"},{"word":"MORE_THAN","menu":"(numbered)"},{"word":"NL_STRIDE=","menu":"(option)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"OUTSIDE","menu":"(flag)"},{"word":"RADIUS=","menu":"(option)"},{"word":"SERIAL","menu":"(flag)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"}]
let b:plumedDictionary["INTERPOLATE_GRID"]=[{"word":"CLEAR=","menu":"(option)"},{"word":"COMPONENT=","menu":"(option)"},{"word":"GRID=","menu":"(option)"},{"word":"GRID_BIN=","menu":"(option)"},{"word":"GRID_SPACING=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"LOGWEIGHTS=","menu":"(option)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"SERIAL","menu":"(flag)"},{"word":"STRIDE=","menu":"(option)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"},{"word":"UNORMALIZED","menu":"(flag)"}]
let b:plumedDictionary["JCOUPLING"]=[{"word":"A=","menu":"(option)"},{"word":"ADDCOUPLINGS","menu":"(flag)"},{"word":"ATOMS","menu":"(numbered)"},{"word":"B=","menu":"(option)"},{"word":"C=","menu":"(option)"},{"word":"COUPLING","menu":"(numbered)"},{"word":"LABEL=","menu":"(label)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"SHIFT=","menu":"(option)"},{"word":"TYPE=","menu":"(option)"}]
let b:plumedDictionary["LOAD"]=[{"word":"FILE=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"}]
let b:plumedDictionary["LOCALENSEMBLE"]=[{"word":"ARG","menu":"(numbered)"},{"word":"LABEL=","menu":"(label)"},{"word":"NUM=","menu":"(option)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"}]
let b:plumedDictionary["LOCAL_AVERAGE"]=[{"word":"BETWEEN","menu":"(numbered)"},{"word":"D_0=","menu":"(option)"},{"word":"HISTOGRAM","menu":"(numbered)"},{"word":"LABEL=","menu":"(label)"},{"word":"LESS_THAN","menu":"(numbered)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"MEAN","menu":"(numbered)"},{"word":"MM=","menu":"(option)"},{"word":"MOMENTS","menu":"(numbered)"},{"word":"MORE_THAN","menu":"(numbered)"},{"word":"NL_STRIDE=","menu":"(option)"},{"word":"NN=","menu":"(option)"},{"word":"NOPBC","menu":"(flag)"},{"word":"R_0=","menu":"(option)"},{"word":"SERIAL","menu":"(flag)"},{"word":"SPECIES=","menu":"(option)"},{"word":"SPECIESA=","menu":"(option)"},{"word":"SPECIESB=","menu":"(option)"},{"word":"SWITCH=","menu":"(option)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"}]
let b:plumedDictionary["LOWER_WALLS"]=[{"word":"ARG","menu":"(numbered)"},{"word":"AT=","menu":"(option)"},{"word":"EPS=","menu":"(option)"},{"word":"EXP=","menu":"(option)"},{"word":"KAPPA=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"OFFSET=","menu":"(option)"},{"word":"STRIDE=","menu":"(option)"}]
let b:plumedDictionary["METAD"]=[{"word":"ACCELERATION","menu":"(flag)"},{"word":"ADAPTIVE=","menu":"(option)"},{"word":"ARG","menu":"(numbered)"},{"word":"BIASFACTOR=","menu":"(option)"},{"word":"DAMPFACTOR=","menu":"(option)"},{"word":"FILE=","menu":"(option)"},{"word":"FMT=","menu":"(option)"},{"word":"GRID_BIN=","menu":"(option)"},{"word":"GRID_MAX=","menu":"(option)"},{"word":"GRID_MIN=","menu":"(option)"},{"word":"GRID_NOSPLINE","menu":"(flag)"},{"word":"GRID_RFILE=","menu":"(option)"},{"word":"GRID_SPACING=","menu":"(option)"},{"word":"GRID_SPARSE","menu":"(flag)"},{"word":"GRID_WFILE=","menu":"(option)"},{"word":"GRID_WSTRIDE=","menu":"(option)"},{"word":"HEIGHT=","menu":"(option)"},{"word":"INTERVAL=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"PACE=","menu":"(option)"},{"word":"RESTART=","menu":"(option)"},{"word":"REWEIGHTING_NGRID=","menu":"(option)"},{"word":"REWEIGHTING_NHILLS=","menu":"(option)"},{"word":"SIGMA=","menu":"(option)"},{"word":"SIGMA_MAX=","menu":"(option)"},{"word":"SIGMA_MIN=","menu":"(option)"},{"word":"STORE_GRIDS","menu":"(flag)"},{"word":"STRIDE=","menu":"(option)"},{"word":"TARGET=","menu":"(option)"},{"word":"TAU=","menu":"(option)"},{"word":"TEMP=","menu":"(option)"},{"word":"UPDATE_FROM=","menu":"(option)"},{"word":"UPDATE_UNTIL=","menu":"(option)"},{"word":"WALKERS_DIR=","menu":"(option)"},{"word":"WALKERS_ID=","menu":"(option)"},{"word":"WALKERS_MPI","menu":"(flag)"},{"word":"WALKERS_N=","menu":"(option)"},{"word":"WALKERS_RSTRIDE=","menu":"(option)"}]
let b:plumedDictionary["METAINFERENCE"]=[{"word":"ARG","menu":"(numbered)"},{"word":"DSCALE=","menu":"(option)"},{"word":"DSIGMA=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"MC_STEPS=","menu":"(option)"},{"word":"MC_STRIDE=","menu":"(option)"},{"word":"NOISETYPE=","menu":"(option)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"PARAMETERS=","menu":"(option)"},{"word":"PARARG=","menu":"(option)"},{"word":"SCALE0=","menu":"(option)"},{"word":"SCALEDATA","menu":"(flag)"},{"word":"SCALE_MAX=","menu":"(option)"},{"word":"SCALE_MIN=","menu":"(option)"},{"word":"SIGMA0=","menu":"(option)"},{"word":"SIGMA_MAX=","menu":"(option)"},{"word":"SIGMA_MEAN=","menu":"(option)"},{"word":"SIGMA_MIN=","menu":"(option)"},{"word":"STRIDE=","menu":"(option)"},{"word":"TEMP=","menu":"(option)"}]
let b:plumedDictionary["MFILTER_BETWEEN"]=[{"word":"ALT_MIN","menu":"(numbered)"},{"word":"BEAD=","menu":"(option)"},{"word":"DATA=","menu":"(option)"},{"word":"HIGHEST","menu":"(numbered)"},{"word":"LABEL=","menu":"(label)"},{"word":"LOWER=","menu":"(option)"},{"word":"LOWEST","menu":"(numbered)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAX","menu":"(numbered)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"MEAN","menu":"(numbered)"},{"word":"MIN","menu":"(numbered)"},{"word":"MOMENTS","menu":"(numbered)"},{"word":"NL_STRIDE=","menu":"(option)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"SERIAL","menu":"(flag)"},{"word":"SMEAR=","menu":"(option)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"},{"word":"UPPER=","menu":"(option)"}]
let b:plumedDictionary["MFILTER_LESS"]=[{"word":"ALT_MIN","menu":"(numbered)"},{"word":"DATA=","menu":"(option)"},{"word":"D_0=","menu":"(option)"},{"word":"HIGHEST","menu":"(numbered)"},{"word":"LABEL=","menu":"(label)"},{"word":"LOWEST","menu":"(numbered)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAX","menu":"(numbered)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"MEAN","menu":"(numbered)"},{"word":"MIN","menu":"(numbered)"},{"word":"MM=","menu":"(option)"},{"word":"MOMENTS","menu":"(numbered)"},{"word":"NL_STRIDE=","menu":"(option)"},{"word":"NN=","menu":"(option)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"R_0=","menu":"(option)"},{"word":"SERIAL","menu":"(flag)"},{"word":"SWITCH=","menu":"(option)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"}]
let b:plumedDictionary["MFILTER_MORE"]=[{"word":"ALT_MIN","menu":"(numbered)"},{"word":"DATA=","menu":"(option)"},{"word":"D_0=","menu":"(option)"},{"word":"HIGHEST","menu":"(numbered)"},{"word":"LABEL=","menu":"(label)"},{"word":"LOWEST","menu":"(numbered)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAX","menu":"(numbered)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"MEAN","menu":"(numbered)"},{"word":"MIN","menu":"(numbered)"},{"word":"MM=","menu":"(option)"},{"word":"MOMENTS","menu":"(numbered)"},{"word":"NL_STRIDE=","menu":"(option)"},{"word":"NN=","menu":"(option)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"R_0=","menu":"(option)"},{"word":"SERIAL","menu":"(flag)"},{"word":"SWITCH=","menu":"(option)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"}]
let b:plumedDictionary["MOLINFO"]=[{"word":"CHAIN=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"MOLTYPE=","menu":"(option)"},{"word":"STRUCTURE=","menu":"(option)"}]
let b:plumedDictionary["MOVINGRESTRAINT"]=[{"word":"ARG","menu":"(numbered)"},{"word":"AT","menu":"(numbered)"},{"word":"KAPPA","menu":"(numbered)"},{"word":"LABEL=","menu":"(label)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"STEP","menu":"(numbered)"},{"word":"STRIDE=","menu":"(option)"},{"word":"VERSE=","menu":"(option)"}]
let b:plumedDictionary["MTRANSFORM_BETWEEN"]=[{"word":"ALT_MIN","menu":"(numbered)"},{"word":"BEAD=","menu":"(option)"},{"word":"DATA=","menu":"(option)"},{"word":"HIGHEST","menu":"(numbered)"},{"word":"LABEL=","menu":"(label)"},{"word":"LOWER=","menu":"(option)"},{"word":"LOWEST","menu":"(numbered)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAX","menu":"(numbered)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"MEAN","menu":"(numbered)"},{"word":"MIN","menu":"(numbered)"},{"word":"MOMENTS","menu":"(numbered)"},{"word":"NL_STRIDE=","menu":"(option)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"SERIAL","menu":"(flag)"},{"word":"SMEAR=","menu":"(option)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"},{"word":"UPPER=","menu":"(option)"}]
let b:plumedDictionary["MTRANSFORM_LESS"]=[{"word":"ALT_MIN","menu":"(numbered)"},{"word":"DATA=","menu":"(option)"},{"word":"D_0=","menu":"(option)"},{"word":"HIGHEST","menu":"(numbered)"},{"word":"LABEL=","menu":"(label)"},{"word":"LOWEST","menu":"(numbered)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAX","menu":"(numbered)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"MEAN","menu":"(numbered)"},{"word":"MIN","menu":"(numbered)"},{"word":"MM=","menu":"(option)"},{"word":"MOMENTS","menu":"(numbered)"},{"word":"NL_STRIDE=","menu":"(option)"},{"word":"NN=","menu":"(option)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"R_0=","menu":"(option)"},{"word":"SERIAL","menu":"(flag)"},{"word":"SWITCH=","menu":"(option)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"}]
let b:plumedDictionary["MTRANSFORM_MORE"]=[{"word":"ALT_MIN","menu":"(numbered)"},{"word":"DATA=","menu":"(option)"},{"word":"D_0=","menu":"(option)"},{"word":"HIGHEST","menu":"(numbered)"},{"word":"LABEL=","menu":"(label)"},{"word":"LOWEST","menu":"(numbered)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAX","menu":"(numbered)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"MEAN","menu":"(numbered)"},{"word":"MIN","menu":"(numbered)"},{"word":"MM=","menu":"(option)"},{"word":"MOMENTS","menu":"(numbered)"},{"word":"NL_STRIDE=","menu":"(option)"},{"word":"NN=","menu":"(option)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"R_0=","menu":"(option)"},{"word":"SERIAL","menu":"(flag)"},{"word":"SWITCH=","menu":"(option)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"}]
let b:plumedDictionary["MULTI-RMSD"]=[{"word":"LABEL=","menu":"(label)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"REFERENCE=","menu":"(option)"},{"word":"SQUARED","menu":"(flag)"},{"word":"TYPE=","menu":"(option)"}]
let b:plumedDictionary["MULTICOLVARDENS"]=[{"word":"BANDWIDTH=","menu":"(option)"},{"word":"CLEAR=","menu":"(option)"},{"word":"DATA=","menu":"(option)"},{"word":"DIR=","menu":"(option)"},{"word":"FRACTIONAL","menu":"(flag)"},{"word":"KERNEL=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"LOGWEIGHTS=","menu":"(option)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"NBINS=","menu":"(option)"},{"word":"ORIGIN=","menu":"(option)"},{"word":"SERIAL","menu":"(flag)"},{"word":"SPACING=","menu":"(option)"},{"word":"STRIDE=","menu":"(option)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"},{"word":"UNORMALIZED","menu":"(flag)"},{"word":"XLOWER=","menu":"(option)"},{"word":"XREDUCED","menu":"(flag)"},{"word":"XUPPER=","menu":"(option)"},{"word":"YLOWER=","menu":"(option)"},{"word":"YREDUCED","menu":"(flag)"},{"word":"YUPPER=","menu":"(option)"},{"word":"ZLOWER=","menu":"(option)"},{"word":"ZREDUCED","menu":"(flag)"},{"word":"ZUPPER=","menu":"(option)"}]
let b:plumedDictionary["NLINKS"]=[{"word":"D_0=","menu":"(option)"},{"word":"GROUP=","menu":"(option)"},{"word":"GROUPA=","menu":"(option)"},{"word":"GROUPB=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"MM=","menu":"(option)"},{"word":"NL_STRIDE=","menu":"(option)"},{"word":"NN=","menu":"(option)"},{"word":"NOPBC","menu":"(flag)"},{"word":"R_0=","menu":"(option)"},{"word":"SERIAL","menu":"(flag)"},{"word":"SWITCH=","menu":"(option)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"}]
let b:plumedDictionary["NOE"]=[{"word":"ADDEXP","menu":"(flag)"},{"word":"GROUPA","menu":"(numbered)"},{"word":"GROUPB","menu":"(numbered)"},{"word":"LABEL=","menu":"(label)"},{"word":"NOEDIST","menu":"(numbered)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"}]
let b:plumedDictionary["PARABETARMSD"]=[{"word":"ALT_MIN","menu":"(numbered)"},{"word":"D_0=","menu":"(option)"},{"word":"HIGHEST","menu":"(numbered)"},{"word":"LABEL=","menu":"(label)"},{"word":"LESS_THAN","menu":"(numbered)"},{"word":"LOWEST","menu":"(numbered)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"MIN","menu":"(numbered)"},{"word":"MM=","menu":"(option)"},{"word":"NL_STRIDE=","menu":"(option)"},{"word":"NN=","menu":"(option)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"RESIDUES=","menu":"(option)"},{"word":"R_0=","menu":"(option)"},{"word":"SERIAL","menu":"(flag)"},{"word":"STRANDS_CUTOFF=","menu":"(option)"},{"word":"STYLE=","menu":"(option)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"},{"word":"TYPE=","menu":"(option)"},{"word":"VERBOSE","menu":"(flag)"}]
let b:plumedDictionary["PATH"]=[{"word":"DISABLE_CHECKS","menu":"(flag)"},{"word":"LABEL=","menu":"(label)"},{"word":"LAMBDA=","menu":"(option)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"NOSPATH","menu":"(flag)"},{"word":"NOZPATH","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"REFERENCE=","menu":"(option)"},{"word":"SERIAL","menu":"(flag)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"},{"word":"TYPE=","menu":"(option)"}]
let b:plumedDictionary["PATHCV"]=[{"word":"ARG","menu":"(numbered)"},{"word":"FIXED=","menu":"(option)"},{"word":"GENPATH=","menu":"(option)"},{"word":"HALFLIFE=","menu":"(option)"},{"word":"INFILE=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"OUTFILE=","menu":"(option)"},{"word":"PACE=","menu":"(option)"},{"word":"PERIODIC=","menu":"(option)"},{"word":"STRIDE=","menu":"(option)"},{"word":"WALKERS_DIR=","menu":"(option)"},{"word":"WALKERS_ID=","menu":"(option)"},{"word":"WALKERS_N=","menu":"(option)"},{"word":"WALKERS_RSTRIDE=","menu":"(option)"}]
let b:plumedDictionary["PATHMSD"]=[{"word":"LABEL=","menu":"(label)"},{"word":"LAMBDA=","menu":"(option)"},{"word":"NEIGH_SIZE=","menu":"(option)"},{"word":"NEIGH_STRIDE=","menu":"(option)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"REFERENCE=","menu":"(option)"}]
let b:plumedDictionary["PBMETAD"]=[{"word":"ARG","menu":"(numbered)"},{"word":"BIASFACTOR=","menu":"(option)"},{"word":"FILE=","menu":"(option)"},{"word":"FMT=","menu":"(option)"},{"word":"GRID_BIN=","menu":"(option)"},{"word":"GRID_MAX=","menu":"(option)"},{"word":"GRID_MIN=","menu":"(option)"},{"word":"GRID_NOSPLINE","menu":"(flag)"},{"word":"GRID_RFILES=","menu":"(option)"},{"word":"GRID_SPACING=","menu":"(option)"},{"word":"GRID_SPARSE","menu":"(flag)"},{"word":"GRID_WFILES=","menu":"(option)"},{"word":"GRID_WSTRIDE=","menu":"(option)"},{"word":"HEIGHT=","menu":"(option)"},{"word":"INTERVAL_MAX=","menu":"(option)"},{"word":"INTERVAL_MIN=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"MULTIPLE_WALKERS","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"PACE=","menu":"(option)"},{"word":"RESTART=","menu":"(option)"},{"word":"SIGMA=","menu":"(option)"},{"word":"STRIDE=","menu":"(option)"},{"word":"TAU=","menu":"(option)"},{"word":"TEMP=","menu":"(option)"},{"word":"UPDATE_FROM=","menu":"(option)"},{"word":"UPDATE_UNTIL=","menu":"(option)"}]
let b:plumedDictionary["PCA"]=[{"word":"ARG","menu":"(numbered)"},{"word":"ATOMS=","menu":"(option)"},{"word":"CLEAR=","menu":"(option)"},{"word":"FMT=","menu":"(option)"},{"word":"IGNORE_REWEIGHTING=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"LOGWEIGHTS=","menu":"(option)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"METRIC=","menu":"(option)"},{"word":"NLOW_DIM=","menu":"(option)"},{"word":"OFILE=","menu":"(option)"},{"word":"RESTART=","menu":"(option)"},{"word":"REUSE_DATA_FROM=","menu":"(option)"},{"word":"RUN=","menu":"(option)"},{"word":"SERIAL","menu":"(flag)"},{"word":"STRIDE=","menu":"(option)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"UNORMALIZED","menu":"(flag)"},{"word":"UPDATE_FROM=","menu":"(option)"},{"word":"UPDATE_UNTIL=","menu":"(option)"},{"word":"WRITE_CHECKPOINT","menu":"(flag)"}]
let b:plumedDictionary["PCARMSD"]=[{"word":"AVERAGE=","menu":"(option)"},{"word":"EIGENVECTORS=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"SQUARED-ROOT","menu":"(flag)"}]
let b:plumedDictionary["PCAVARS"]=[{"word":"LABEL=","menu":"(label)"},{"word":"NORMALIZE","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"REFERENCE=","menu":"(option)"},{"word":"TYPE=","menu":"(option)"}]
let b:plumedDictionary["PIECEWISE"]=[{"word":"ARG","menu":"(numbered)"},{"word":"LABEL=","menu":"(label)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"POINT","menu":"(numbered)"}]
let b:plumedDictionary["POSITION"]=[{"word":"ATOM=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"SCALED_COMPONENTS","menu":"(flag)"}]
let b:plumedDictionary["PRE"]=[{"word":"ADDEXP","menu":"(flag)"},{"word":"GROUPA","menu":"(numbered)"},{"word":"INEPT=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"OMEGA=","menu":"(option)"},{"word":"PREINT","menu":"(numbered)"},{"word":"RTWO","menu":"(numbered)"},{"word":"SPINLABEL=","menu":"(option)"},{"word":"TAUC=","menu":"(option)"}]
let b:plumedDictionary["PRINT"]=[{"word":"ARG","menu":"(numbered)"},{"word":"FILE=","menu":"(option)"},{"word":"FMT=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"RESTART=","menu":"(option)"},{"word":"STRIDE=","menu":"(option)"},{"word":"UPDATE_FROM=","menu":"(option)"},{"word":"UPDATE_UNTIL=","menu":"(option)"},{"word":"_ROTATE=","menu":"(option)"}]
let b:plumedDictionary["PROPERTYMAP"]=[{"word":"LABEL=","menu":"(label)"},{"word":"LAMBDA=","menu":"(option)"},{"word":"NEIGH_SIZE=","menu":"(option)"},{"word":"NEIGH_STRIDE=","menu":"(option)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"PROPERTY=","menu":"(option)"},{"word":"REFERENCE=","menu":"(option)"}]
let b:plumedDictionary["PUCKERING"]=[{"word":"ATOMS=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"}]
let b:plumedDictionary["RANDOM_EXCHANGES"]=[{"word":"LABEL=","menu":"(label)"},{"word":"SEED=","menu":"(option)"}]
let b:plumedDictionary["RDC"]=[{"word":"ADDCOUPLINGS","menu":"(flag)"},{"word":"ATOMS","menu":"(numbered)"},{"word":"COUPLING","menu":"(numbered)"},{"word":"GYROM=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"SCALE=","menu":"(option)"},{"word":"SVD","menu":"(flag)"}]
let b:plumedDictionary["READ"]=[{"word":"EVERY=","menu":"(option)"},{"word":"FILE=","menu":"(option)"},{"word":"IGNORE_FORCES","menu":"(flag)"},{"word":"IGNORE_TIME","menu":"(flag)"},{"word":"LABEL=","menu":"(label)"},{"word":"STRIDE=","menu":"(option)"},{"word":"UPDATE_FROM=","menu":"(option)"},{"word":"UPDATE_UNTIL=","menu":"(option)"},{"word":"VALUES=","menu":"(option)"}]
let b:plumedDictionary["RESET_CELL"]=[{"word":"LABEL=","menu":"(label)"},{"word":"STRIDE=","menu":"(option)"},{"word":"TYPE=","menu":"(option)"}]
let b:plumedDictionary["RESTART"]=[{"word":"LABEL=","menu":"(label)"},{"word":"NO","menu":"(flag)"}]
let b:plumedDictionary["RESTRAINT"]=[{"word":"ARG","menu":"(numbered)"},{"word":"AT=","menu":"(option)"},{"word":"KAPPA=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"SLOPE=","menu":"(option)"},{"word":"STRIDE=","menu":"(option)"}]
let b:plumedDictionary["REWEIGHT_BIAS"]=[{"word":"ARG=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"TEMP=","menu":"(option)"}]
let b:plumedDictionary["REWEIGHT_METAD"]=[{"word":"ARG=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"TEMP=","menu":"(option)"}]
let b:plumedDictionary["REWEIGHT_TEMP"]=[{"word":"LABEL=","menu":"(label)"},{"word":"REWEIGHT_TEMP=","menu":"(option)"},{"word":"TEMP=","menu":"(option)"}]
let b:plumedDictionary["RMSD"]=[{"word":"LABEL=","menu":"(label)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"REFERENCE=","menu":"(option)"},{"word":"SQUARED","menu":"(flag)"},{"word":"TYPE=","menu":"(option)"}]
let b:plumedDictionary["SORT"]=[{"word":"ARG","menu":"(numbered)"},{"word":"LABEL=","menu":"(label)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"}]
let b:plumedDictionary["STATS"]=[{"word":"ARG","menu":"(numbered)"},{"word":"LABEL=","menu":"(label)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"PARAMETERS=","menu":"(option)"},{"word":"PARARG=","menu":"(option)"},{"word":"SQDEV","menu":"(flag)"},{"word":"SQDEVSUM","menu":"(flag)"},{"word":"UPPERDISTS","menu":"(flag)"}]
let b:plumedDictionary["TARGET"]=[{"word":"LABEL=","menu":"(label)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"REFERENCE=","menu":"(option)"},{"word":"TYPE=","menu":"(option)"}]
let b:plumedDictionary["TEMPLATE"]=[{"word":"ATOMS=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"TEMPLATE_COMPULSORY=","menu":"(option)"},{"word":"TEMPLATE_DEFAULT_OFF_FLAG","menu":"(flag)"},{"word":"TEMPLATE_DEFAULT_ON_FLAG","menu":"(flag)"},{"word":"TEMPLATE_OPTIONAL=","menu":"(option)"}]
let b:plumedDictionary["TETRAHEDRALPORE"]=[{"word":"ATOMS=","menu":"(option)"},{"word":"BETWEEN","menu":"(numbered)"},{"word":"DATA=","menu":"(option)"},{"word":"FILE=","menu":"(option)"},{"word":"HISTOGRAM","menu":"(numbered)"},{"word":"KERNEL=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"LESS_THAN","menu":"(numbered)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"MEAN","menu":"(numbered)"},{"word":"MORE_THAN","menu":"(numbered)"},{"word":"NL_STRIDE=","menu":"(option)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"OUTSIDE","menu":"(flag)"},{"word":"PRINT_BOX","menu":"(flag)"},{"word":"SERIAL","menu":"(flag)"},{"word":"SIGMA=","menu":"(option)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"},{"word":"UNITS=","menu":"(option)"}]
let b:plumedDictionary["TIME"]=[{"word":"LABEL=","menu":"(label)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"}]
let b:plumedDictionary["TORSION"]=[{"word":"ATOMS=","menu":"(option)"},{"word":"AXIS=","menu":"(option)"},{"word":"COSINE","menu":"(flag)"},{"word":"LABEL=","menu":"(label)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"VECTOR1=","menu":"(option)"},{"word":"VECTOR2=","menu":"(option)"}]
let b:plumedDictionary["TORSIONS"]=[{"word":"ATOMS","menu":"(numbered)"},{"word":"BETWEEN","menu":"(numbered)"},{"word":"HISTOGRAM","menu":"(numbered)"},{"word":"LABEL=","menu":"(label)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"NL_STRIDE=","menu":"(option)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"SERIAL","menu":"(flag)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"}]
let b:plumedDictionary["UNITS"]=[{"word":"CHARGE=","menu":"(option)"},{"word":"ENERGY=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"LENGTH=","menu":"(option)"},{"word":"MASS=","menu":"(option)"},{"word":"NATURAL","menu":"(flag)"},{"word":"TIME=","menu":"(option)"}]
let b:plumedDictionary["UPDATE_IF"]=[{"word":"ARG","menu":"(numbered)"},{"word":"END","menu":"(flag)"},{"word":"LABEL=","menu":"(label)"},{"word":"LESS_THAN=","menu":"(option)"},{"word":"MORE_THAN=","menu":"(option)"},{"word":"STRIDE=","menu":"(option)"}]
let b:plumedDictionary["UPPER_WALLS"]=[{"word":"ARG","menu":"(numbered)"},{"word":"AT=","menu":"(option)"},{"word":"EPS=","menu":"(option)"},{"word":"EXP=","menu":"(option)"},{"word":"KAPPA=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"OFFSET=","menu":"(option)"},{"word":"STRIDE=","menu":"(option)"}]
let b:plumedDictionary["VOLUME"]=[{"word":"LABEL=","menu":"(label)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"}]
let b:plumedDictionary["WHOLEMOLECULES"]=[{"word":"ENTITY","menu":"(numbered)"},{"word":"LABEL=","menu":"(label)"},{"word":"MOLTYPE=","menu":"(option)"},{"word":"RESIDUES=","menu":"(option)"},{"word":"STRIDE=","menu":"(option)"}]
let b:plumedDictionary["WRAPAROUND"]=[{"word":"AROUND=","menu":"(option)"},{"word":"ATOMS=","menu":"(option)"},{"word":"GROUPBY=","menu":"(option)"},{"word":"LABEL=","menu":"(label)"},{"word":"STRIDE=","menu":"(option)"}]
let b:plumedDictionary["XDISTANCES"]=[{"word":"ALT_MIN","menu":"(numbered)"},{"word":"ATOMS","menu":"(numbered)"},{"word":"BETWEEN","menu":"(numbered)"},{"word":"GROUP=","menu":"(option)"},{"word":"GROUPA=","menu":"(option)"},{"word":"GROUPB=","menu":"(option)"},{"word":"HIGHEST","menu":"(numbered)"},{"word":"HISTOGRAM","menu":"(numbered)"},{"word":"LABEL=","menu":"(label)"},{"word":"LESS_THAN","menu":"(numbered)"},{"word":"LOWEST","menu":"(numbered)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAX","menu":"(numbered)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"MEAN","menu":"(numbered)"},{"word":"MIN","menu":"(numbered)"},{"word":"MOMENTS","menu":"(numbered)"},{"word":"MORE_THAN","menu":"(numbered)"},{"word":"NL_STRIDE=","menu":"(option)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"SERIAL","menu":"(flag)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"}]
let b:plumedDictionary["XYDISTANCES"]=[{"word":"ALT_MIN","menu":"(numbered)"},{"word":"ATOMS","menu":"(numbered)"},{"word":"BETWEEN","menu":"(numbered)"},{"word":"GROUP=","menu":"(option)"},{"word":"GROUPA=","menu":"(option)"},{"word":"GROUPB=","menu":"(option)"},{"word":"HIGHEST","menu":"(numbered)"},{"word":"HISTOGRAM","menu":"(numbered)"},{"word":"LABEL=","menu":"(label)"},{"word":"LESS_THAN","menu":"(numbered)"},{"word":"LOWEST","menu":"(numbered)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAX","menu":"(numbered)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"MEAN","menu":"(numbered)"},{"word":"MIN","menu":"(numbered)"},{"word":"MOMENTS","menu":"(numbered)"},{"word":"MORE_THAN","menu":"(numbered)"},{"word":"NL_STRIDE=","menu":"(option)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"SERIAL","menu":"(flag)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"}]
let b:plumedDictionary["XZDISTANCES"]=[{"word":"ALT_MIN","menu":"(numbered)"},{"word":"ATOMS","menu":"(numbered)"},{"word":"BETWEEN","menu":"(numbered)"},{"word":"GROUP=","menu":"(option)"},{"word":"GROUPA=","menu":"(option)"},{"word":"GROUPB=","menu":"(option)"},{"word":"HIGHEST","menu":"(numbered)"},{"word":"HISTOGRAM","menu":"(numbered)"},{"word":"LABEL=","menu":"(label)"},{"word":"LESS_THAN","menu":"(numbered)"},{"word":"LOWEST","menu":"(numbered)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAX","menu":"(numbered)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"MEAN","menu":"(numbered)"},{"word":"MIN","menu":"(numbered)"},{"word":"MOMENTS","menu":"(numbered)"},{"word":"MORE_THAN","menu":"(numbered)"},{"word":"NL_STRIDE=","menu":"(option)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"SERIAL","menu":"(flag)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"}]
let b:plumedDictionary["YDISTANCES"]=[{"word":"ALT_MIN","menu":"(numbered)"},{"word":"ATOMS","menu":"(numbered)"},{"word":"BETWEEN","menu":"(numbered)"},{"word":"GROUP=","menu":"(option)"},{"word":"GROUPA=","menu":"(option)"},{"word":"GROUPB=","menu":"(option)"},{"word":"HIGHEST","menu":"(numbered)"},{"word":"HISTOGRAM","menu":"(numbered)"},{"word":"LABEL=","menu":"(label)"},{"word":"LESS_THAN","menu":"(numbered)"},{"word":"LOWEST","menu":"(numbered)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAX","menu":"(numbered)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"MEAN","menu":"(numbered)"},{"word":"MIN","menu":"(numbered)"},{"word":"MOMENTS","menu":"(numbered)"},{"word":"MORE_THAN","menu":"(numbered)"},{"word":"NL_STRIDE=","menu":"(option)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"SERIAL","menu":"(flag)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"}]
let b:plumedDictionary["YZDISTANCES"]=[{"word":"ALT_MIN","menu":"(numbered)"},{"word":"ATOMS","menu":"(numbered)"},{"word":"BETWEEN","menu":"(numbered)"},{"word":"GROUP=","menu":"(option)"},{"word":"GROUPA=","menu":"(option)"},{"word":"GROUPB=","menu":"(option)"},{"word":"HIGHEST","menu":"(numbered)"},{"word":"HISTOGRAM","menu":"(numbered)"},{"word":"LABEL=","menu":"(label)"},{"word":"LESS_THAN","menu":"(numbered)"},{"word":"LOWEST","menu":"(numbered)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAX","menu":"(numbered)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"MEAN","menu":"(numbered)"},{"word":"MIN","menu":"(numbered)"},{"word":"MOMENTS","menu":"(numbered)"},{"word":"MORE_THAN","menu":"(numbered)"},{"word":"NL_STRIDE=","menu":"(option)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"SERIAL","menu":"(flag)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"}]
let b:plumedDictionary["ZDISTANCES"]=[{"word":"ALT_MIN","menu":"(numbered)"},{"word":"ATOMS","menu":"(numbered)"},{"word":"BETWEEN","menu":"(numbered)"},{"word":"GROUP=","menu":"(option)"},{"word":"GROUPA=","menu":"(option)"},{"word":"GROUPB=","menu":"(option)"},{"word":"HIGHEST","menu":"(numbered)"},{"word":"HISTOGRAM","menu":"(numbered)"},{"word":"LABEL=","menu":"(label)"},{"word":"LESS_THAN","menu":"(numbered)"},{"word":"LOWEST","menu":"(numbered)"},{"word":"LOWMEM","menu":"(flag)"},{"word":"MAX","menu":"(numbered)"},{"word":"MAXDERIVATIVES=","menu":"(option)"},{"word":"MEAN","menu":"(numbered)"},{"word":"MIN","menu":"(numbered)"},{"word":"MOMENTS","menu":"(numbered)"},{"word":"MORE_THAN","menu":"(numbered)"},{"word":"NL_STRIDE=","menu":"(option)"},{"word":"NOPBC","menu":"(flag)"},{"word":"NUMERICAL_DERIVATIVES","menu":"(flag)"},{"word":"SERIAL","menu":"(flag)"},{"word":"TIMINGS","menu":"(flag)"},{"word":"TOL=","menu":"(option)"}]
function! PlumedDefineSyntax()

  for key in sort(keys(b:plumedDictionary))
    call add(b:plumedActions,{"word":key})
  endfor

for a in b:plumedActions
  let action=a["word"]
" vim variables cannot contain -
" we convert it to triple ___
  let action_=substitute(action,"-","___","g")

  for b in b:plumedDictionary[action]
    if(b["menu"]=="(numbered)")
      let string='"\v<' . b["word"] . '[0-9]*\=[^{ #]*"'
    elseif(b["menu"]=="(option)")
" this is necessary since word for option is e.g ."RESTART="
      let string='"\v<' . substitute(b["word"],"=","","") . '[0-9]*\=[^{ #]*"'
    elseif(b["menu"]=="(flag)")
      let string='"\v<' . b["word"] . '>"'
    endif
    execute 'syntax match   plumedKeywords' . action_ . ' ' . string . ' contained contains=plumedStringInKeyword'
  endfor

" single line, with explicit LABEL
" matching action at beginning of line, till the end of the line
" can contain all the keywords associated with this action, plus strings, label, and comments
execute 'syntax region plumedLine' . action_ . ' matchgroup=plumedAction' . action_ . ' start=/\v^\s*' . action . '>/ excludenl end=/$/ contains=plumedComment,plumedKeywords' . action_ . ',plumedLabel,plumedStringOneline fold'
" multiple line, with explicit LABEL
" first row might contain extra words before arriving at the dots
" thus continuation dots are matched by plumedDots
" matching action at beginning of line, followed by dots and possibly by a comment
" ends on dots, possibly followed by the same action name and possibly a comment
" comments and initial dots are not part of the match
" can contain all the keywords associated with this action, plus strings, label, and comments
execute 'syntax region plumedCLine' . action_ . ' matchgroup=plumedAction' . action_ . ' start=/\v^\s*' . action . '>(.+\.\.\.\s*(#.*)*$)@=/ end=/\v^\s*\.\.\.(\s+' . action . ')?\s*((#.*)*$)@=/ contains=plumedComment,plumedKeywords' . action_ . ',plumedLabel,plumedString,plumedDots fold'
" single line, with label: syntax
" matching label followed by action
" can contain all the keywords associated with this action, plus strings and comments
" labels are not allwed
execute 'syntax region plumedLLine' . action_ . ' matchgroup=plumedAction' . action_ . ' start=/\v^\s*[^ #@][^ #]*:\s+' . action . '/ excludenl end=/$/ contains=plumedComment,plumedKeywords' . action_ . ',plumedStringOneline fold'
" multiple line, with label: syntax
" first row might contain extra words before arriving at the dots
" thus continuation dots are matched by plumedDots
" matching label, action, dots, and possibly comment
" comments and dots are not part of the match
" ends on dots, possibly followed by the same label and possibly a comment
" comments and initial dots are not part of the match
execute 'syntax region plumedLCLine' . action_ . ' matchgroup=plumedAction' . action_ . ' start=/\v^\s*\z([^ #@][^ #]*\:)\s+' . action . '>(.+\.\.\.\s*(#.*)*$)@=/ end=/\v^\s*\.\.\.(\s+\z1)?\s*((#.*)*$)@=/ contains=plumedComment,plumedKeywords' . action_ . ',plumedString,plumedDots fold'
" this is a hack required to match the ACTION when it is in the second line
execute 'syntax match plumedSpecial' . action_ . ' /\v(\.\.\.\s*(#.*)*\_s*)@<=' . action . '>/ contained'
execute 'highlight link plumedSpecial' . action_ . ' Type'
" multiple line, with label: syntax
" here ACTION is on the second line
" matching label, dots, possibly comments, newline, then action name
" comments, dots, and action are not part of the match
" ends on dots possibly followed by the same label and possibly a comment
execute 'syntax region plumedLCLine' . action_ . ' matchgroup=plumedAction' . action_ . ' start=/\v^\s*\z([^ #@][^ #]*\:)\s+(\.\.\.\s*(#.*)*\_s*' . action . ')@=/ end=/\v^\s*\.\.\.(\s+\z1)?\s*((#.*)*$)@=/ contains=plumedComment,plumedKeywords' . action_ . ',plumedString,plumedSpecial' . action_ . ',plumedDots fold'
execute 'highlight link plumedAction' . action_ . ' Type'
execute 'highlight link plumedKeywords' . action_ . ' Statement'
endfor

" comments and strings last, with highest priority
syntax region  plumedString start=/\v\{/  end=/\v\}/ contained contains=plumedString fold
syntax region  plumedStringOneline start=/\v\{/  end=/\v\}/ oneline contained contains=plumedStringOneline fold
highlight link plumedString String
highlight link plumedStringOneline String
syntax match   plumedStringInKeyword /\v(<[^ #]+\=)@<=[^ #]+/ contained
highlight link plumedStringInKeyword String

" Matching label
syntax match   plumedLabel "\v<LABEL\=[^ #]*" contained contains=plumedLabelWrong
highlight link plumedLabel Type

" Errors
syntax match   plumedLabelWrong "\v<LABEL\=\@[^ #]*" contained
highlight link plumedLabelWrong Error

syntax region  plumedComment start="\v^\s*ENDPLUMED>" end="\%$" fold
syntax match   plumedComment excludenl "\v#.*$"
highlight link plumedComment Comment
endfunction

call PlumedDefineSyntax()


fun! PlumedGuessRegion()
" this is to find the match
" first, sync syntax
            syn sync fromstart
" find the syntactic attribute of the present region
            let col=col(".")
            let line=line(".")
            let key=""
            let stack=synstack(line,col)
            if(len(stack)>0)
              let key = synIDattr(stack[0], "name")
            endif
            if(key=~"^plumed[LC]*Line.*")
              return substitute(key,"^plumed[LC]*Line","","")
            endif
            return ""
endfunction

fun! PlumedContextManual()
  if(exists("b:plumed_helpfile"))
    quit
    return
  endif
  let m=PlumedGuessRegion()
  if(m=="")
    return
  else
    let name=s:path . "/help/" . m . ".txt"
    if(exists("b:plumed_helpfile_vertical"))
      execute 'rightbelow vsplit | view ' name
    else
      execute 'rightbelow split | view ' name
    endif
    let b:plumed_helpfile=1
" this is to allow closing the window with F2
    if exists("g:plumed_shortcuts")
      noremap  <buffer> <F2> :PHelp<CR>
    endif
  endif
endfunction

fun! PlumedManualV()
  let b:plumed_helpfile_vertical=1
endfunction

fun! PlumedManualH()
  unlet b:plumed_helpfile_vertical
endfunction

command! -nargs=0 PHelp call PlumedContextManual()

" autocomplete function
fun! PlumedComplete(findstart, base)
" this is to find the start of the word to be completed
          if a:findstart
            " locate the start of the word
            let line = getline('.')
            let start = col('.') - 1
            while start > 0 && line[start - 1] =~ '[a-zA-Z\_\=\-\.]'
              let start -= 1
            endwhile
            return start
          else
" this is to find the match
" first, sync syntax
            syn sync fromstart
" find the syntactic attribute of the present region
            let col=col(".")
            let line=line(".")
            let key=""
            if col!=1
              let key = synIDattr(synID(line, col-1, 1), "name")
            else
              let stack=synstack(line,col)
              if(len(stack)>0)
                let key = synIDattr(stack[0], "name")
              endif
            endif
            let comp=[]
" retrieve action name
" normalize ___ to -
            let key1=substitute(substitute(key,"^plumed[LC]*Line","",""),"___","-","g")
            if key ==""
" if outside of any region, complete with list of actions
              let comp=b:plumedActions
            elseif has_key(b:plumedDictionary,key1)
" if inside a region in the form "plumedLineXXX"
" complete with keywords associated to action XXX
              let comp=b:plumedDictionary[key1]
            endif
            " find months matching with "a:base"
            let res = []
            for m in comp
" this is to allow m to be a dictionary
" with a word and a one-liner
              if(type(m)==type({}))
                let n=m["word"]
              else
                let n=m
              endif
              if n =~ '^' . a:base
                if(n!="LABEL=" || key =~ "^plumedLine.*" || key =~ "^plumedCLine.*")
                call add(res, m)
                endif
              endif
" in principle comp could be a heterogeneous list
" so it should be unlet to iterate the loop
              unlet m
            endfor
"           if("..." =~ '^' . a:base && (key=~"^plumedLLine.*" || key=~"^plumedLine.*"))
"             call add(res,{"word":"...","menu":"(start multiline statement)"})
"           endif
"           if("..." =~ '^' . a:base && (key=~"^plumedLCLine.*" || key=~"^plumedCLine.*") && getline('.')=~'^\s*$')
"              call add(res,{"word":"...","menu":"(end multiline statement)"})
"           endif
            if("#" =~ '^' . a:base && key!="plumedComment") 
               call add(res,{"word":"#","menu":"(add comment)"})
            endif
            if("ENDPLUMED" =~ '^' . a:base && key =="")
               call add(res,{"word":"ENDPLUMED","menu":"(end input)"})
            endif
            return res
          endif
        endfun
setlocal omnifunc=PlumedComplete

" inspect the entire file to find lines containing
" non highlighted characters
fun! PlumedAnnotateSyntax()
" buffer where errors are written
  let buffer=[]
  let l=1
" loop over lines
  while l <= line("$")
    let line=getline(l)
    let p=0
" line is assumed right a priori
    let wrong=0
" position the cursor and redraw the screen
    call cursor(l,1)
    redraw! "! is required for some reason
    while p <len(line)
      let stack=synstack(l,p+1)
      if line[p] !~ "[ \t]"
        if(len(stack)==0)
          let wrong=1
        elseif(synIDattr(stack[len(stack)-1],"name")=~"^plumed[LC]*Line.*")
          let wrong=1
        endif
      endif
      let annotation=""
      for s in stack
        let annotation=annotation."+".synIDattr(s,"name")
      endfor
      call add(buffer,printf("ANNOTATION %5d %3d %s %s",l,p,line[p],annotation))
      let p=p+1
    endwhile
    
    if(wrong)
      call add(buffer,"ERROR AT LINE ".l." : ".line)
    endif
    let l=l+1
  endwhile
" dump the buffer on a new window
  new
  for l in buffer
    put=l
  endfor
endfun

