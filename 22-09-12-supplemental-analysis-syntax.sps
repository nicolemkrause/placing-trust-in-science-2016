* Encoding: UTF-8.
*The following syntax can be used to run the alternative analyses to produce the table that appears in the supplemental materials of the paper.

*In order to run the analyses, you will need to set the Complex Samples module to use the CSAPLAN file provided in the GitHub repository for this project.
*That file is titled 2022-09-12-complex-sample.csaplan.

*primary sampling unit variable is V160202.
*from ANES 2016 codebook:
The table below indicates the weight variable to use for different types of analysis
Weights:
V160102  use for analysis of full sample using post‐election survey only or both pre and post 
V160101   use for analysis of full sample using pre‐election survey data only 
V160102f   use for analysis of face‐to‐face mode alone, using the post‐election survey or both pre and post 
V160101f   use for analysis of face‐to‐face mode alone, using pre‐election survey data only 
V160102w   use for analysis of Internet mode alone, using data from both pre‐ and post‐election or post alone 
V160101w   use for analysis of Internet mode alone, using data from only the pre‐election survey 

*also from the codebook, about the complex sampling design:
V160201  Stratum – Full sample 
V160201f  Stratum – Face‐to‐face sample 
V160201w  Stratum – Web sample 
V160202  Variance PSU – full sample 
V160202f  Variance PSU – Face‐to‐face sample 
V160202w  Variance PSU – Web sample 


* Encoding: UTF-8.
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
    govtknew911(-11,-6) 
    obamamuslim(-11,-6) 
    trustwash(-11)
    trustpeople(-11)
    newsdaysaweek(-11) 
    tvhannity(-11)
    tvoreilly(-11)
    tvchrishayes(-11)
    tvmaddow(-11)
    tvchrismatthews(-11)
    tvkellyfile(-11)
    feelsci(-11,-6)
    needevaluate(-11,-6)
    open1(-11,-6)
    open2(-11,-6)
    moralshouldadj(-11,-6)
    moralnewstylesbad(-11,-6)
    moralshouldtolerate(-11,-6)
    moralfamilyties(-11,-6).

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

weight by weight.

desc feelsci age female nonwhite edu income rural partyid conservativism religiosity evangelical moraltrad openness trustpeople trustwash newsdaysaweek anyfoxtv anymsnbctv govtknew911 obamamuslim/save.

compute cons_moraltrad_ix = Zconservativism*Zmoraltrad.
compute cons_relig_ix = Zconservativism*Zreligiosity.
compute cons_anyfoxtv_ix = Zconservativism*Zanyfoxtv.
compute relig_moraltrad_ix = Zreligiosity*Zmoraltrad.
compute relig_anyfoxtv_ix = Zreligiosity*Zanyfoxtv.
compute moraltrad_anyfoxtv_ix = Zmoraltrad*Zanyfoxtv.
execute.

* Complex Samples General Linear Model.
CSGLM  Zfeelsci WITH Zage Zfemale Znonwhite Zedu Zincome
  /PLAN FILE=
    'C:\Users\nicky\Dropbox\UW\ANES-Rural\2016-Analysis-and-Paper\PUS-Research-Note\Revision1\Data\22'+
    '-09-12-complex-sample.csaplan'
  /MODEL Zage Zfemale Znonwhite Zedu Zincome
  /INTERCEPT INCLUDE=YES SHOW=YES
  /STATISTICS PARAMETER
  /PRINT SUMMARY VARIABLEINFO SAMPLEINFO
  /TEST TYPE=F PADJUST=LSD
  /MISSING CLASSMISSING=EXCLUDE
  /CRITERIA CILEVEL=95.

* Complex Samples General Linear Model.
CSGLM  Zfeelsci WITH Zage Zfemale Znonwhite Zedu Zincome Zrural
  /PLAN FILE=
    'C:\Users\nicky\Dropbox\UW\ANES-Rural\2016-Analysis-and-Paper\PUS-Research-Note\Revision1\Data\22'+
    '-09-12-complex-sample.csaplan'
  /MODEL Zage Zfemale Znonwhite Zedu Zincome Zrural
  /INTERCEPT INCLUDE=YES SHOW=YES
  /STATISTICS PARAMETER
  /PRINT SUMMARY VARIABLEINFO SAMPLEINFO
  /TEST TYPE=F PADJUST=LSD
  /MISSING CLASSMISSING=EXCLUDE
  /CRITERIA CILEVEL=95.

* Complex Samples General Linear Model.
CSGLM  Zfeelsci WITH Zage Zfemale Znonwhite Zedu Zincome Zrural Zpartyid Zconservativism
  /PLAN FILE=
    'C:\Users\nicky\Dropbox\UW\ANES-Rural\2016-Analysis-and-Paper\PUS-Research-Note\Revision1\Data\22'+
    '-09-12-complex-sample.csaplan'
  /MODEL Zage Zfemale Znonwhite Zedu Zincome Zrural Zpartyid Zconservativism
  /INTERCEPT INCLUDE=YES SHOW=YES
  /STATISTICS PARAMETER
  /PRINT SUMMARY VARIABLEINFO SAMPLEINFO
  /TEST TYPE=F PADJUST=LSD
  /MISSING CLASSMISSING=EXCLUDE
  /CRITERIA CILEVEL=95.

* Complex Samples General Linear Model.
CSGLM  Zfeelsci WITH Zage Zfemale Znonwhite Zedu Zincome Zrural Zpartyid Zconservativism Zreligiosity Zevangelical Zmoraltrad
  /PLAN FILE=
    'C:\Users\nicky\Dropbox\UW\ANES-Rural\2016-Analysis-and-Paper\PUS-Research-Note\Revision1\Data\22'+
    '-09-12-complex-sample.csaplan'
  /MODEL Zage Zfemale Znonwhite Zedu Zincome Zrural Zpartyid Zconservativism Zreligiosity Zevangelical Zmoraltrad
  /INTERCEPT INCLUDE=YES SHOW=YES
  /STATISTICS PARAMETER
  /PRINT SUMMARY VARIABLEINFO SAMPLEINFO
  /TEST TYPE=F PADJUST=LSD
  /MISSING CLASSMISSING=EXCLUDE
  /CRITERIA CILEVEL=95.

* Complex Samples General Linear Model.
CSGLM  Zfeelsci WITH Zage Zfemale Znonwhite Zedu Zincome Zrural Zpartyid Zconservativism Zreligiosity Zevangelical Zmoraltrad Zopenness
  /PLAN FILE=
    'C:\Users\nicky\Dropbox\UW\ANES-Rural\2016-Analysis-and-Paper\PUS-Research-Note\Revision1\Data\22'+
    '-09-12-complex-sample.csaplan'
  /MODEL Zage Zfemale Znonwhite Zedu Zincome Zrural Zpartyid Zconservativism Zreligiosity Zevangelical Zmoraltrad Zopenness
  /INTERCEPT INCLUDE=YES SHOW=YES
  /STATISTICS PARAMETER
  /PRINT SUMMARY VARIABLEINFO SAMPLEINFO
  /TEST TYPE=F PADJUST=LSD
  /MISSING CLASSMISSING=EXCLUDE
  /CRITERIA CILEVEL=95.

* Complex Samples General Linear Model.
CSGLM  Zfeelsci WITH Zage Zfemale Znonwhite Zedu Zincome Zrural Zpartyid Zconservativism Zreligiosity Zevangelical Zmoraltrad Zopenness Ztrustpeople Ztrustwash
  /PLAN FILE=
    'C:\Users\nicky\Dropbox\UW\ANES-Rural\2016-Analysis-and-Paper\PUS-Research-Note\Revision1\Data\22'+
    '-09-12-complex-sample.csaplan'
  /MODEL Zage Zfemale Znonwhite Zedu Zincome Zrural Zpartyid Zconservativism Zreligiosity Zevangelical Zmoraltrad Zopenness Ztrustpeople Ztrustwash
  /INTERCEPT INCLUDE=YES SHOW=YES
  /STATISTICS PARAMETER
  /PRINT SUMMARY VARIABLEINFO SAMPLEINFO
  /TEST TYPE=F PADJUST=LSD
  /MISSING CLASSMISSING=EXCLUDE
  /CRITERIA CILEVEL=95.

* Complex Samples General Linear Model.
CSGLM  Zfeelsci WITH Zage Zfemale Znonwhite Zedu Zincome Zrural Zpartyid Zconservativism Zreligiosity Zevangelical Zmoraltrad Zopenness Ztrustpeople Ztrustwash Znewsdaysaweek Zanyfoxtv Zanymsnbctv
  /PLAN FILE=
    'C:\Users\nicky\Dropbox\UW\ANES-Rural\2016-Analysis-and-Paper\PUS-Research-Note\Revision1\Data\22'+
    '-09-12-complex-sample.csaplan'
  /MODEL Zage Zfemale Znonwhite Zedu Zincome Zrural Zpartyid Zconservativism Zreligiosity Zevangelical Zmoraltrad Zopenness Ztrustpeople Ztrustwash Znewsdaysaweek Zanyfoxtv Zanymsnbctv
  /INTERCEPT INCLUDE=YES SHOW=YES
  /STATISTICS PARAMETER
  /PRINT SUMMARY VARIABLEINFO SAMPLEINFO
  /TEST TYPE=F PADJUST=LSD
  /MISSING CLASSMISSING=EXCLUDE
  /CRITERIA CILEVEL=95.

* Complex Samples General Linear Model.
CSGLM  Zfeelsci WITH Zage Zfemale Znonwhite Zedu Zincome Zrural Zpartyid Zconservativism Zreligiosity Zevangelical Zmoraltrad Zopenness Ztrustpeople Ztrustwash Znewsdaysaweek Zanyfoxtv Zanymsnbctv Zgovtknew911 Zobamamuslim
  /PLAN FILE=
    'C:\Users\nicky\Dropbox\UW\ANES-Rural\2016-Analysis-and-Paper\PUS-Research-Note\Revision1\Data\22'+
    '-09-12-complex-sample.csaplan'
  /MODEL Zage Zfemale Znonwhite Zedu Zincome Zrural Zpartyid Zconservativism Zreligiosity Zevangelical Zmoraltrad Zopenness Ztrustpeople Ztrustwash Znewsdaysaweek Zanyfoxtv Zanymsnbctv Zgovtknew911 Zobamamuslim
  /INTERCEPT INCLUDE=YES SHOW=YES
  /STATISTICS PARAMETER
  /PRINT SUMMARY VARIABLEINFO SAMPLEINFO
  /TEST TYPE=F PADJUST=LSD
  /MISSING CLASSMISSING=EXCLUDE
  /CRITERIA CILEVEL=95.

CSGLM  Zfeelsci WITH Zage Zfemale Znonwhite Zedu Zincome Zrural Zpartyid Zconservativism Zreligiosity Zevangelical Zmoraltrad Zopenness Ztrustpeople Ztrustwash Znewsdaysaweek 
    Zanyfoxtv Zanymsnbctv Zgovtknew911 Zobamamuslim cons_relig_ix cons_moraltrad_ix cons_anyfoxtv_ix relig_moraltrad_ix relig_anyfoxtv_ix moraltrad_anyfoxtv_ix
  /PLAN FILE=
    'C:\Users\nicky\Dropbox\UW\ANES-Rural\2016-Analysis-and-Paper\PUS-Research-Note\Revision1\Data\22'+
    '-09-12-complex-sample.csaplan'
  /MODEL Zage Zfemale Znonwhite Zedu Zincome Zrural Zpartyid Zconservativism Zreligiosity Zevangelical Zmoraltrad Zopenness Ztrustpeople Ztrustwash Znewsdaysaweek 
  Zanyfoxtv Zanymsnbctv Zgovtknew911 Zobamamuslim cons_relig_ix cons_moraltrad_ix cons_anyfoxtv_ix relig_moraltrad_ix relig_anyfoxtv_ix moraltrad_anyfoxtv_ix
  /INTERCEPT INCLUDE=YES SHOW=YES
  /STATISTICS PARAMETER
  /PRINT SUMMARY VARIABLEINFO SAMPLEINFO
  /TEST TYPE=F PADJUST=LSD
  /MISSING CLASSMISSING=EXCLUDE
  /CRITERIA CILEVEL=95.




