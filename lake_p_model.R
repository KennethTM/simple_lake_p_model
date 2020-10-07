#Load data and model definition saved in "model_and_data.R" script
source("model.R")

#Plot input data used in P model
PlotInputData(InputData)

#Input constants for model
#Check definition
constants <- c(mg_to_kg = 1e-06, #Unit conversion
               Phyto_Vmax = 50.0, #Maximum phytoplankton P uptake
               Zoo_Grazing = 40.0, #Zooplankton grazing of phytoplankton
               Phyto_CaryingCapacity = 5e-05, #Phytoplankton carying capacity
               Phyto_SedimentationRate = 0.1, #Phyto_Sedimentation rate of phytoplankton
               Zoo_FecalRate = 0.3, #Share of zooplankton food which is not assimilated
               Zoo_Mortality = 3.0, #Zooplankton mortality
               Zoo_PhytoConstant = 35.0, #Saturation constant
               Phyto_Constant = 1.5e-05, #Saturation constant
               Lake_Volume = 1720000.0 #Lake_Volume
               )


#Initial model values (unit kg P)
initial <- c(Phyto_P_Pool = 5, #Whole lake phytoplantion P pool
             Water_P_Pool = 68.8, #Lake water P pool
             Sediment_P_Pool = 1200, #Lake sediment P pool
             Zoo_P_Pool = 30) #Whole lake zooplantion P pool

#Time steps (unit month)
#Define model time step change (dt) and maximum number of time steps when running the model (tmax)
dt <- 0.5
tmax <- 100

#Sequence of timesteps
time <- seq(0, tmax, dt)

#Compute model at each timestep
#May take some time depending on the number of timesteps
output <- ode(func = model, y = initial, times = time, parms = constants, method = 'lsoda')

#Plot model output
#Lines show the four lake P pools (unit kg P) in the model
plot(output)

#Create data.frame
output_df <- data.frame(output)

#Plot time interval (first year) and select variables
output_df_zoom <- output_df[1:24, c("Phyto_P_Pool", "Water_P_Pool", "Sediment_P_Pool", "Zoo_P_Pool")]

dev.off()
matplot(output_df_zoom, lty = 1, type = "l")
legend("topright",
       names(output_df_zoom),
       col = 1:length(names(output_df_zoom)),
       lty = 1)

#Create interactive plot
dev.off()
interactive_plot(output)
