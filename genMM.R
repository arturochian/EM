
# Generate a sample from a mixture of 3 bivariate gaussians with different means but a common covariance

#INPUTS
#N = size of sample
# vis = option to visulize the generating process (=1 for yes, = 0 for no)

# OUTPUT
# y = generated sample

genMM<-function(N=200, vis=1){

library(MASS)
set.seed(10)

# INITIALIZATION
nstates <- 3
z<-mat.or.vec(N, nstates)
y<-mat.or.vec(N,2)

# mean and (common) covariance for the 3 multivariate normal kernels
mu <- matrix(c(0,0, 0,12, 6,6),3, byrow=T) # means
sigma <- diag(c(1,1))  #covariance
p<-c(0.2, 0.2, 0.6) # mixing proportions

# SIMULATION

# generate and plot 1st observation 
z[1,] <- t(rmultinom(1, size=1, prob = p ))
y[1,] <- mvrnorm(1, mu[z[1,]==1], sigma)
if (vis) {
  plot(y[1,1], y[1,2], xlim=c(-5,12), ylim=c(-5,15), col = which(z[1,]>0) + 1, pch=16, xlab='x', ylab='y')
}
for (i in 2:N){  
  z[i,] <- t(rmultinom(1, size=1, prob = p)) # generate (y,z)
  y[i,] <- mvrnorm(1, mu[z[i,]==1], sigma)
  if (vis){
    points(y[i,1], y[i,2], col=which(z[i,]>0) + 1, pch=16) #plot y
    segments(x0=y[i-1,1], y0=y[i-1,2], x1=y[i,1], y1=y[i,2], new=T) #plot line joining yn, yn-1
    Sys.sleep(.5)
  }
}
y
}