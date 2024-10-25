# Quantifying-MC
This is a MATLAB code that quantifies morphological computation. 
the main code is 'MCtest_real_b2_3.m'  and it has the following functions:
   - 'discretiseMatrix' to discretise the data
   - 'combineAndRelabelBinnedMatrix; to create the univariate variable
   - 'MC_W1_dynamic' to calculate the dynamic MC. This MC captures the value in the entire gait
   - 'MC_W1' to calculate the total MC
The main code is segmented and you should run the segments one by one.
The first step is to create a 'struct' file from the time-series data of actuator. I create the file 'real_files_b2'. a 'struct' file creates a name for every array within the structure. for example, realfiles_b2.Hposition is the Hip position, which I pull out from the first column of my time-series data 'plot2blade(:,1)'. The time-series data was captured by running the walking gait. You can see from the first segment that each column represents time-series  of a paramater, which i am putting it in the 'struct' file.
next step is to discretise. I only take the velocity, position and actuator (current). Number of bins = 100, because any higher number makes the processing slow. I had used 300 earlier.
next to create a univariate variable, i have used position and velocity. this is my 'w', followed by creating w1 and w2. w2 is the next time-step
I then compute both the MCs by using a, w1 and w2.
after that it is plotting.
there are other plotting files that I have added specific to my paper.
