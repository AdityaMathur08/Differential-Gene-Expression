# Differential-Gene-Expression
Shiny Application to Plot Differential Gene Expression.



The current project presents gene expression data (Real-Time PCR) from published manuscript entitled An Unbiased Systems Genetics Approach to Mapping Genetic Loci Modulating Susceptibility to Severe Streptococcal Sepsis by Abdeltawab, N.F. et al. 2008.
Abdeltawab et al. studied the differential host response to sepsis using different strains (groups) of inbred BXD mice. BXD mice strains were used to mimic the diversity of human differential response to sepsis. BXD strains displayed variable response to sepsis; from being susceptible and succumbing to infection within 48 hours to resistant and overcoming sepsis. The authors performed genome-wide association studies and linked the differential response to sepsis to mouse chromosome 2 quantitative trait loci (QTL). Here I show their results from supplementary table two entitled "Relative expression levels of candidate gene list expressed as mean fold difference sbetween pre- and post-infection ± standard deviation (SD) in selected resistant and susceptible strains."

The plots represent genes selected by Abdeltawab et al. from their mapped QTLs that were differentially expressed in susceptible and resistant groups. This is shown as either up or down regulated in either both groups or one of the groups. For ease of visualization, I transformed expression values to Log10.

The current project created as shiny app using two packages: shiny and ggplot2. The app include two main files (as usual) ui.R and server.R in addition to global.R which include calling for shiny package and the gene names dataset. The app designed with fluid layout the page consists of a sidebar and main area. Sidebar include three select list input control and the main panel include three outputs. Two folder was add to the project, the first one "www" for the picture and the second "inc" for dataset and documentation files.
