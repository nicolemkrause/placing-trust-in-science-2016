* Encoding: UTF-8.
*the cleaning syntax has already set all the missing values that need to be imputed to -11.

*fre age nonwhite female edu income needevaluate openness conservativism partyid religiosity evangelical moralshouldadj moralnewstylesbad moralshouldtolerate moralfamilyties 
     govtknew911 obamamuslim trustwash newsdaysaweek tvhannity tvoreilly tvchrishayes tvmaddow tvchrismatthews tvkellyfile feelsci.

weight off.

missing values 
    age(-11)
    nonwhite(-11) 
    female(-11)
    edu(-11) 
    income(-11) 
    conservativism(-11) 
    partyid(-11) 
    religiosity(-11) 
    evangelical(-11) 
    govtknew911(-11) 
    obamamuslim(-11) 
    trustwash(-11)
    trustpeople(-11)
    newsdaysaweek(-11) 
    tvhannity(-11)
    tvoreilly(-11)
    tvchrishayes(-11)
    tvmaddow(-11)
    tvchrismatthews(-11)
    tvkellyfile(-11)
    feelsci(-11)
    needevaluate(-11)
    open1(-11)
    open2(-11)
    moralshouldadj(-11)
    moralnewstylesbad(-11)
    moralshouldtolerate(-11)
    moralfamilyties(-11).

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
   
*So, I'm not sure which one to use for this analysis since I have both pre and post election variables. But, given that the dependent variable was post-election, I'll go with this:

compute DEFFWGT = weight / 1.46.
execute.

*I'm not actually going to weight the data because I believe the weights should be off globally but should be accounted for in the imputation syntax (below).
*Final note, accounting for the complex sample design is supposed to happen on the full sample, before any cases are removed for analysis, 
    so I have calculated the adjusted weight before removing the cases for people who did not have a post-election survey.


*----------MULTIPLE IMPUTATION-----------------
 
*only for variables I  actually use in the model.

*Impute Missing Data Values. 
    *Use the rural variables only as predictors because they have no missing data anyway.
    *Don't include partisan media attn yet because need to first impute missing tv

        *---------REMOVE INAPPLICABLE CASES-------
            *missing values that should NOT be imputed:
            -1, because it's inapplicable
            -6, because these people were never asked the question (no post-election interview)
        *note that frequencies reveal that none of the model variables retain -1 responses, so we only need to drop those with -6.
        *we can drop all the cases that had no post-election interview in our dependent variable (feelsci).

*put all the feelsci cases back in prior to the select if command.
missing values
feelsci().

*impute values using only on the portion of the sample used for analysis.
temporary.
select if (feelsci = -11 OR feelsci >-1).
MULTIPLE IMPUTATION 
    age nonwhite female edu income 
    open1 open2
    moralshouldadj moralnewstylesbad moralshouldtolerate moralfamilyties religiosity evangelical
    partyid conservativism 
    govtknew911 obamamuslim trustwash trustpeople
    newsdaysaweek tvhannity tvoreilly tvchrishayes tvmaddow tvchrismatthews tvkellyfile
    rural
    feelsci
  /IMPUTE METHOD=FCS MAXITER= 10 NIMPUTATIONS=20 SCALEMODEL=PMM INTERACTIONS=NONE SINGULAR=1E-012 
    MAXPCTMISSING=NONE 
  /MISSINGSUMMARIES NONE 
  /IMPUTATIONSUMMARIES MODELS 
  /OUTFILE IMPUTATIONS=
    'C:\Users\nicky\Dropbox\UW\ANES-Rural\PUS-paper\Data\21-09-21-pmm-dataset.sav' .
