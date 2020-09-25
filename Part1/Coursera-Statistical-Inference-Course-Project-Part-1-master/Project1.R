library(ggplot2)
# Set parameter for our sample
set.seed(123)
nSim <- 1000 # number of simulations
n <- 40 # sample size
lambda <- 0.2 # lambda for the exponential distribution

# generate n*nSim number of random number
data <- rexp(n*nSim, lambda)  
dataMatrix <- matrix(ncol = n, data) # put them in a matrix

# calculate the mean of each row and put them in data frame for ggplot
sampleMean <- data.frame(sampleMean = apply(dataMatrix, 1,mean))

# calculate the mean and variance
mean_sampleMean <- mean(sampleMean$sampleMean)
var_sampleMean <- var(sampleMean$sampleMean)


# for the theoretical mean, std and variance
meanTheo <- 1/lambda
stdTheo <- (1/lambda)/sqrt(n)
varTheo <- stdTheo^2

#Companring sample and theoretical mean, variance
cat("Sample Mean:", mean_sampleMean, "\nTheoretical Mean:",meanTheo)
cat("Sample Variance:", var_sampleMean, "\nTheoretical Variance:", varTheo )

# Plot.  aes(y=..) must be in geom_hist
# to use legend, colour must in be in aes()

cols <- c("Sample Distribution" ="blue","Normal Distribution" ="red", "Bar"="grey")
g <- ggplot(sampleMean) + aes(x=sampleMean) + 
  geom_histogram(aes(y = ..density..),binwidth = 0.2, colour = "grey", fill="white") +
  geom_density(alpha = 0.4, fill = "#0072B2", aes(colour = "Sample Distribution")) + 
  geom_vline(aes(xintercept = mean_sampleMean), colour = "blue", linetype = "dashed", size = 0.8) +
  stat_function(fun = dnorm, args = list(mean = meanTheo, sd = stdTheo), aes(colour = "Normal Distribution")) +
  geom_vline(aes(xintercept = meanTheo), colour = "red") +
  labs(title = "Sample Means vs Normal Distribution", x = "Means", y = "Density") +
  scale_colour_manual(name = "Legend", values = cols) +
  theme(legend.key = element_rect(linetype = 0, colour = "grey", fill = 0)) +
  theme(legend.position = c(0.9, 0.8), legend.background = element_rect(color = "black", fill = "grey90", size = 1, linetype = "solid"))
  
print(g)