#' spec_prospect_full_range: optical constants defined for PROSPECT
#'
#' Corresponds to spectral bands, refractive index and specific absorption
#' coefficient for each chemica constituent, defined over the spectral domain
#' ranging from 400 nm to 2500 nm
#'
#' The specific absorption coefficients were calibrated using experimental data.
#' The details of the calibration should be found in the following publications:
#'  http://dx.doi.org/10.1016/j.rse.2017.03.004
#'  https://doi.org/10.1016/j.rse.2020.112173
#'
spec_prospect_full_range <- read.table(file = 'data-raw/dataSpec_PRO.txt',
                                     header = TRUE,
                                     sep = '\t')

#' calctav_90 & calctav_40: transmissivity of a dielectric plane surface,
#' averaged over all directions of incidence and over all polarizations for
#' solid angle of 90 and 40 degrees
#'
calctav_90 <- prospect::calctav(90, nr = spec_prospect_full_range$nrefrac)
calctav_40 <- prospect::calctav(40, nr = spec_prospect_full_range$nrefrac)
spec_prospect_full_range$calctav_90 <- calctav_90
spec_prospect_full_range$calctav_40 <- calctav_40

# read dataspec file and save it in a dataframe
dataSoil_Atm <- read.table(file = 'data-raw/dataSpec_SOIL_ATM.txt',
                           header = TRUE,
                           sep = '\t')

SpecSOIL <- data.frame('lambda' = dataSoil_Atm$lambda,
                       'Dry_Soil' = dataSoil_Atm$Dry_Soil,
                       'Wet_Soil' = dataSoil_Atm$Wet_Soil)
SpecATM <- data.frame('lambda' = dataSoil_Atm$lambda,
                      'Direct_Light' = dataSoil_Atm$Direct_Light,
                      'Diffuse_Light' = dataSoil_Atm$Diffuse_Light)

usethis::use_data(spec_prospect_full_range, SpecSOIL, SpecATM,
                  internal = FALSE,
                  overwrite = TRUE)
