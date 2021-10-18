# Placing trust in science, 2016
This GitHub repository contains the instructions and files needed to replicate analysis contained in the paper titled "Placing trust in science: The urban-rural divide and Americans’ feelings of warmth toward scientists," by Nicole M. Krause.

## Instructions for how to reproduce the analysis

This study involves secondary analysis of public opinion data that has been supplemented with data from the US department of agriculture (USDA) which describes the "ruralness" of each county in the US. In order to reproduce the analyses, researchers need access to each of the dataset components: (1) The public opinion survey data, (2) the USDA rural codes, and (3) the “key” variable, which, in this case, is the survey respondents’ counties of residence. The procedure for accessing each component is described below.

1. **The public opinion data** used for this project comes from a nationally-representative survey conducted in 2016 by the American National Election Studies (ANES). It can be freely downloaded at this URL: [https://electionstudies.org/data-center/2016-time-series-study/](https://electionstudies.org/data-center/2016-time-series-study/). 

2. **The ruralness data** used for this project comes from the US department of agriculture. Specifically, these are the "rural-urban continuum" (RUC) codes. The RUC codes used for this analysis were the 2013 set, which is freely available on the USDA website: [https://www.ers.usda.gov/data-products/rural-urban-continuum-codes.aspx] (https://www.ers.usda.gov/data-products/rural-urban-continuum-codes.aspx).

3. **The “key” to merge the public opinion data and the climate data**. In order to merge the first two components together, researchers will need access to the ANES “2016 restricted geocodes” file, which is available by application: [https://www.icpsr.umich.edu/web/ICPSR/studies/38087](https://www.icpsr.umich.edu/web/ICPSR/studies/38087). Note that gaining access to these data will require IRB approval and a Data Use Agreement with ICPSR. The existence of these restrictions pertaining to the survey respondents’ geocode data means that I have neither the right nor the desire to publicly disclose these data on GitHub.

Once researchers have access all the necessary data components from their public repositories, the public opinion data can be imported into a statistical software program of the researchers’ choice and then merged with the RUC codes, using the county IDs “key” as the common identifier. 

After the data merge is complete, researchers can proceed to reproduce my analyses—in the statistical analysis program SPSS—using the syntax files I provide in this repository.  The files you need can be found in the Data Disclosure folder on this repository. The procedure is as follows:

1. Load the merged dataset (see above) into SPSS.
2. Run the cleanin syntax: 21-09-21-cleaning-syntax-final
3. Run the imputation syntax to handle missing data: 21-09-21-imputation-syntax-final
4. Run the analysis syntax over the newly-created multiple imputation dataset (mids): 21-09-21-analysis-syntax-final

