library(datasets)
library(dplyr)
library(ggplot2)

# Load ToothGrowth Data
data("ToothGrowth")
str(ToothGrowth)

# Quick plot for discovery
qplot(supp,len, data = ToothGrowth, colour = dose)

# Gather plot by dose and see if there's any relevency
# As dose is numeric, we have to convert it to factors so that we can group them
ToothGrowth$dose <- as.factor(ToothGrowth$dose)

# Boxplot for better view
g <- ggplot(ToothGrowth, aes(x=dose, y=len, colour=supp)) + 
  geom_boxplot()
print(g)

# Is there a difference between dosage and tooth growth?
# compare dose between 0.5 & 1, 1 & 2
dose05 <- filter(ToothGrowth, dose == 0.5)
dose1 <- filter(ToothGrowth, dose == 1)
dose2 <- filter(ToothGrowth, dose == 2)

t.test(dose1$len, dose05$len, alternative = "greater")
t.test(dose2$len, dose1$len, alternative = "greater")

# Is OJ a more effective delivery method than VC?
OJdose05 <- filter(dose05, supp == "OJ")
VCdose05 <- filter(dose05, supp == "VC")
t.test(OJdose05$len, VCdose05$len, alternative = "greater")

OJdose1 <- filter(dose1, supp == "OJ")
VCdose1 <- filter(dose1, supp == "VC")
t.test(OJdose1$len, VCdose1$len, alternative = "greater")

OJdose2 <- filter(dose2, supp == "OJ")
VCdose2 <- filter(dose2, supp == "VC")
t.test(OJdose2$len, VCdose2$len, alternative = "greater")




