* Encoding: UTF-8.

*create variables for partisan tv viewing, now that source variables have been imputed.

compute anyfoxtv = 0.
if (tvhannity=1 OR tvoreilly = 1 OR tvkellyfile = 1) anyfoxtv = 1.
fre anyfoxtv.

compute anymsnbctv = 0.
if (tvchrishayes=1 OR tvchrismatthews = 1 OR tvmaddow = 1) anymsnbctv = 1.
fre anymsnbctv.

fre moralshouldadj moralnewstylesbad moralshouldtolerate moralfamilyties.
compute moraltrad = mean(moralshouldadj, moralnewstylesbad, moralshouldtolerate, moralfamilyties).
fre moraltrad.

compute openness = 0.
compute openness = mean(open1, open2).
fre openness.

*------ MARK DATASET AS MULTIPLE IMPUTATION DATASET ----

SPLIT FILE
    LAYERED BY Imputation_.

fre age nonwhite female edu income openness religiosity evangelical moraltrad conservativism partyid govtknew911 obamamuslim trustwash trustpeople newsdaysaweek anyfoxtv anymsnbctv feelsci.


*------ ACCOUNT FOR COMPLEX SAMPLE DESIGN ----

*accounting for ANES complex sample design. 
    *Unfortunately, SPSS currently can't handle CS sample design AND multiple imputation...
    *See the IBM knowledge center explanation:
    https://www.ibm.com/support/knowledgecenter/SSLVMB_sub/statistics_mainhelp_ddita/spss/mva/multiple_imputation_intro.html
    Complex Samples. The Multiple Imputation procedure does not explicitly handle strata, 
    clusters, or other complex sampling structures, though it can accept final sampling weights in the form of the analysis weight variable
    Also note that Complex Sampling procedures currently do not automatically analyze multiply imputed datasets. 

*accounting for the complex sampling design without using the SPSS Complex Survey module, which uses Taylor Series estimation.
    *This document from ANES suggests that there are alternatives to Taylor Series estimation:
    https://electionstudies.org/wp-content/uploads/2018/04/nes012492.pdf
    see page 21. one of the proposed alternatives is described as follows:

*Alternatives to Taylor Series: Procedures to Obtain Approximate Standard Errors
A technique to obtain standard error statistics that are approximately correct, on average, is to adjust the
standard errors to reflect a study’s average design effect (DEFF). The DEFF is the variance obtained
with a complex sample divided by the variance that would be obtained with a simple random sample of
the same size. For a study with weights scaled to a mean of 1, DEFF may be calculated as the sum of
the squared weights divided by the sum of the weights. For area probability designs like the ANES, and
for most complex sample surveys, complex sample designs save money at a cost in statistical power, so
the DEFF is greater than 1 on average, and for most estimates. 
*There are two mathematically equivalent ways to adjust the standard errors to reflect the design effect
The multiplication method is to multiply standard errors by an adjustment factor, and the weight
adjustment method is to apply an analogous factor to the weights. The two methods produce the same
effects and the choice of one or the other is a matter of convenience.
*Multiplication method. The square root of the average design effect (DEFT) is the standard error
obtained with a complex sample divided by the standard error that would be obtained with a simple
random sample of the same size. This means that if a study’s average root design effect, DEFT, is 1.35,
the design-consistent standard errors from that study are, on average, 1.35 times larger than they would
be if the study had used a simple random sample. To obtain standard errors that are approximately
correct, on average, simply multiply the standard error obtained when calculated by simple-randomsample methods by the square root of the study’s design effect. This method can be used with standard
errors from percentages, means, regression coefficients, and other statistics.
*Weight adjustment method. Alternatively, the weight may be adjusted to reflect the average design
effect. Calculate a new weight variable equal to the analysis weight divided by the study’s average
design effect, and run analyses using the new weight.*
 Let the study’s design effect be represented by
DEFF, the analysis weight be represented by WEIGHT, and the new weight variable be represented by
DEFFWGT. The SPSS code to calculate and apply the adjustment would be as follows:
*compute DEFFWGT = WEIGHT / DEFF .
*weight by DEFFWGT.
*You can think of this adjustment as revealing the study’s effective sample size – that is, the size of the
simple random sample that would have the same statistical power as the actual ANES sample.
*After running the two lines of SPSS code above, subsequent commands such as regression will produce standard errors that incorporate weight adjustment
    
*That document was from 2010, however, so it didn't include the DEFF (design effect) estaimtes for the 2016 survey. I found those here, in the 2016 methodology report:
    https://electionstudies.org/wp-content/uploads/2016/02/anes_timeseries_2016_methodology_report.pdf, page 90. It says:
    Pre-election, combined sample 1.45
    Post-election, combined sample 1.46
   
*So, I'm not sure which one to use for this analysis since I have both pre and post election variables. I'm going with 1.46 because my dependent variable is post-election.
*I already computed the DEFFWGT variable in the missing variables syntax, so I'm just going to activate it here for analysis.

weight by DEFFWGT.

*------ Z-SCORE THE MODEL VARIABLES TO PRODUCE POOLED REGRESSION BETAS  ----
    The regression functions in SPSS don't yield pooled standardized betas for multiple imputation datasets
    To get standardized betas, we need to z-score the variables first:
    https://www.theanalysisfactor.com/how-to-get-standardized-regression-coefficients/

DESCRIPTIVES VARIABLES=
age
nonwhite
female
edu
income
open1
open2
openness
needevaluate
religiosity
evangelical
moraltrad
partyid
conservativism
govtknew911
obamamuslim
trustwash
trustpeople
newsdaysaweek
anyfoxtv
anymsnbctv
rural
feelsci
/SAVE.

desc religiosity.


*------ REGRESSIONS  ----
    The regression functions in SPSS don't yield pooled standardized betas for multiple imputation datasets
    To get standardized betas, we need to z-score the variables first:
    https://www.theanalysisfactor.com/how-to-get-standardized-regression-coefficients/
   

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA COLLIN TOL
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT Zfeelsci
  /METHOD=ENTER Zage Zfemale Znonwhite Zedu Zincome
  /METHOD=ENTER Zrural
  /METHOD=ENTER Zpartyid Zconservativism
  /METHOD=ENTER Zreligiosity Zevangelical Zmoraltrad
  /METHOD=ENTER Zopenness
  /METHOD=ENTER Ztrustpeople Ztrustwash
  /METHOD=ENTER Znewsdaysaweek Zanyfoxtv Zanymsnbctv
  /METHOD=ENTER Zgovtknew911 Zobamamuslim
  /SCATTERPLOT=(*ZRESID ,*ZPRED)
  /RESIDUALS NORMPROB(ZRESID).

*I included the assumption diagnostics, and it looks like the residuals for the dependent variable (feelsci)
    are not normally distributed, so I think we're supposed to resolve this using bootstrapping, right? 
    https://www.statisticssolutions.com/testing-assumptions-of-linear-regression-in-spss/

*unfortunately, bootstrapping is not an option with multiply imputed datasets - see page 4:
http://www.sussex.ac.uk/its/pdfs/SPSS_Bootstrapping_22.pdf
