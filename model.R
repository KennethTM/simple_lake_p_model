#Load supporting scripts
source("data.R")
source("helper_functions.R")

###### LAKE P MODEL ###### 

model <- function(t, Y, parameters, ...) { 
  
  #P pool variables
  Zoo_P_Pool <- Y['Zoo_P_Pool']
  Water_P_Pool <- Y['Water_P_Pool']
  Phyto_P_Pool <- Y['Phyto_P_Pool']
  Sediment_P_Pool <- Y['Sediment_P_Pool']
  
  #Get month
  Month <- t %% 12
  
  #Get constants
  mg_to_kg <- parameters['mg_to_kg']
  Lake_Volume <- parameters['Lake_Volume'] 
  Phyto_Vmax <- parameters['Phyto_Vmax']
  Phyto_Constant <- parameters['Phyto_Constant']
  Phyto_CaryingCapacity <- parameters['Phyto_CaryingCapacity']
  Phyto_SedimentationRate <- parameters['Phyto_SedimentationRate']
  Zoo_FecalRate <- parameters['Zoo_FecalRate']
  Zoo_Mortality <- parameters['Zoo_Mortality']
  Zoo_Grazing <- parameters['Zoo_Grazing']
  Zoo_PhytoConstant <- parameters['Zoo_PhytoConstant']
  
  #Get input data
  PhytoLightLimitation <- GetData(Month, 'PhytoLightLimitation')
  WaterTemperature <- GetData(Month, 'WaterTemperature')
  PhytoTempEffect <- GetData(WaterTemperature, 'PhytoTempEffect')
  SedimentReleaseRate <- GetData(WaterTemperature, 'SedimentReleaseRate')
  Light <- GetData(Month, 'Light')
  ZooTempEffect <- GetData(WaterTemperature, 'ZooTempEffect')
  InletDischarge <- GetData(Month, 'InletDischarge')
  PhytoQuality <- GetData(Month, 'PhytoQuality')
  Inlet_P_Concentration <- GetData(Month, 'Inlet_P_Concentration')
  
  #Calculate model parameters
  Water_P_Concentration <- Water_P_Pool/Lake_Volume
  Phyto_Concentration <- Phyto_P_Pool/Lake_Volume
  Zoo_Concentration <- Zoo_P_Pool/Lake_Volume
  OutletDischarge <- InletDischarge
  ZooFoodLimitation <- Phyto_P_Pool/(Phyto_P_Pool+ Zoo_PhytoConstant)
  Phyto_FB <- (Phyto_CaryingCapacity-Phyto_Concentration)/Phyto_CaryingCapacity
  Phyto_PB <- Water_P_Concentration/( Water_P_Concentration + Phyto_Constant)
  Sediment_R_Release <- SedimentReleaseRate * Sediment_P_Pool
  Outlet_Zoo_P_Loss <- Zoo_Concentration * OutletDischarge
  Zoo_Grazing <- Zoo_Grazing * Zoo_P_Pool * ZooTempEffect * ZooFoodLimitation * PhytoQuality
  Zoo_Mortality <- Zoo_Mortality * Zoo_P_Pool
  Inlet_P_Discharge <- Inlet_P_Concentration * mg_to_kg * InletDischarge
  Phyto_Sedimentation <- Phyto_P_Pool * Phyto_SedimentationRate
  Zoo_Fecal <-  Zoo_FecalRate * Zoo_Grazing
  Phyto_Assimilation <- Phyto_P_Pool * Phyto_Vmax * PhytoLightLimitation * Phyto_PB * PhytoTempEffect * Phyto_FB
  Outlet_P_Discharge <- Water_P_Concentration * OutletDischarge
  Outlet_Phyto_Discharge <- Phyto_Concentration * OutletDischarge
  
  #Calculate changes in P pools
  dPhyto_P_Pool = Phyto_Assimilation - Phyto_Sedimentation  - Outlet_Phyto_Discharge  - Zoo_Grazing 
  dWater_P_Pool = Sediment_R_Release + Inlet_P_Discharge - Outlet_P_Discharge  - Phyto_Assimilation 
  dSediment_P_Pool = Phyto_Sedimentation + Zoo_Mortality + Zoo_Fecal - Sediment_R_Release 
  dZoo_P_Pool = Zoo_Grazing  - Zoo_Mortality - Zoo_Fecal - Outlet_Zoo_P_Loss 
  
  return(list(c(dPhyto_P_Pool, dWater_P_Pool, dSediment_P_Pool, dZoo_P_Pool)))
}
