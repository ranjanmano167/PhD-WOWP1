library(zoo)

#washoff model#

# Model -1: Power
# W = calibration coefficient dependent on pollutant and location
# A = total catchment area (units of length2)
# t = duration of the time step (units of time)
# I = rainfall intensity in the time step (units of depth/time)
# b = constant dependant on the pollutant
# n = number of time steps over the period of interest

load.fun.pow=function(int.ts,A,a,b) {
  t=as.numeric(difftime(index(int.ts[2]), 
                        index(int.ts[1]), units="min"))
  rain.term=int.ts^b
  ins.load=a*A*t*rain.term
  rain.term.cum=cumsum(rain.term)
  cum.load=a*A*t*rain.term.cum
  load=list(ins.load, cum.load)
  return(load)
}


# Model -2: exponential

#P0 = mass of pollutant at the beginning of the storm (kg); and 
#R = *r dt, which is the cumulative runoff depth since the start of the storm (mm).


load.fun.exp=function(int.ts,P0,w,k){
  t=as.numeric(difftime(index(int.ts[2]), 
                        index(int.ts[1]), units="min"))
  rain.depth=int.ts*t/60
  rain.depth.cum=cumsum(rain.depth)
  rem.load=k*P0*exp(-w*rain.depth.cum)
  cum.load=k*P0-rem.load
  ins.load=diff(cum.load)
  load=list(ins.load, cum.load)
  return (load)
}

