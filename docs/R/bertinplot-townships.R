#install.packages("seriation") # Omit if package is already installed
library("seriation") # Load the seriate package
data(Townships) # Load the Bertin townships dataset

bertinplot(Townships) 

BEA <- seriate(x = Townships, method = "BEA") # Apply the BEA algorithm
bertinplot(Townships, order = BEA) # Plot the sorted matrix
