###### MODEL INPUT DATA ###### 

###### Parameters varying during the year with values provided for each month (t) ###### 

#Phyto_P_Pool light limitation (no unit)
PhytoLightLimitation <- data.frame(t = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12),
                                   PhytoLightLimitation = c(0.135, 0.13, 0.155, 0.215, 0.505, 0.97, 0.995, 0.905, 0.56, 0.32, 0.16, 0.1))

#Phyto_P_Pool quality (no unit)
PhytoQuality <- data.frame(t = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12),
                           PhytoQuality = c(1, 1, 1, 1, 0.995, 1, 1, 0.21, 0.22, 0.41, 0.985, 1))

#Water temperature (degrees celcius)
WaterTemperature <- data.frame(t = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12),
                               WaterTemperature = c(4, 4, 4.5, 8, 13.5, 17, 18.5, 18, 15.5, 11, 7, 3.5))

#Incoming light (no unit)
Light <- data.frame(t = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12),
                    Light = c(0.1, 0.28, 0.52, 0.76, 0.93, 0.99, 0.93, 0.75, 0.51, 0.27, 0.1, 0.042))

#Inlet discharge (m3 per month)
InletDischarge <- data.frame(t = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12),
                             InletDischarge = c(1200000, 1700000, 1700000, 703500, 481700, 496500, 953900, 530200, 323300, 620600, 815800, 708000))

#Inlet P-concentration (ug P per L)
Inlet_P_Concentration <- data.frame(t = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12),
                                    Inlet_P_Concentration = c(45.5, 50.9, 34.7, 9.7, 11.7, 18.5, 46.9, 29.9, 13, 20.9, 23.8, 20.9))

###### Parameters dependent on water temperature ###### 

#Phyto_P_Pool temperature effect (no unit)
PhytoTempEffect <- data.frame(WaterTemperature = c(0, 2.5, 5, 7.5, 10, 12.5, 15, 17.5, 20, 22.5, 25),
                              PhytoTempEffect = c(0.17, 0.18, 0.195, 0.27, 0.4, 0.85, 0.995, 0.985, 0.915, 0.8, 0.63))

#Lake sediment P release rate (per month)
SedimentReleaseRate <- data.frame(WaterTemperature = c(1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25),
                                  SedimentReleaseRate = c(0.004, 0.003, 0.004, 0.002, 0.005, 0.025, 0.104, 0.147, 0.168, 0.181, 0.18, 0.18, 0.181))

#Zoo plankton temperature effect (no unit)
ZooTempEffect <- data.frame(WaterTemperature = c(0, 2.27, 4.55, 6.82, 9.09, 11.4, 13.6, 15.9, 18.2, 20.5, 22.7, 25),
                            ZooTempEffect = c(0.07, 0.105, 0.18, 0.41, 0.7, 0.95, 0.995, 1, 0.925, 0.825, 0.72, 0.615))
