* Encoding: UTF-8.

*READ ME FIRST: THIS FILE ASSSUMES YOU HAVE A MERGED DATASET.
*This syntax assumes that the 2016 ANES survey data have already been merged with RUC codes based on respondents' counties of residence.
*See the "Read me" instructions on the GitHub repository! This code will not work unless the datasets have been merged.
*Here is the GitHub link: https://github.com/nicolemkrause/placing-trust-in-science-2016/edit/main/README.md

*from the ANES 2016 codebook:
Missing data are coded to indicate the reason they are missing, using the following codes and
categories:
‐1.Inapplicable
‐2.Text responses available in separate file or coded version will be included in future release
‐3.Restricted
‐4.Error
‐5.Breakoff, sufficient partial IW
‐6.No post‐election interview
‐7.No post data, deleted due to incomplete IW
‐8.Don’t know
‐9.Refused

RENAME VARIABLES (V160102 = weight) (V161267 = age) (V161270 = edu) (V161361x = income) (V161310x = race) (V161319x = hispanic) (V161342 = gender).

RENAME VARIABLE (V161267 = age).

*-------------nonwhite----------------
    
*race variable - V161310x = self-identified race 
see ANES 2016 Codebook - Version 20190904 - page 512:
asked pre-election
I am going to read you a list of five race categories. Please choose one
or more races that you consider yourself to be: - white, - black or African-
American, - American Indian or Alaska Native, - Asian, or - Native Hawaiian
or other Pacific Islander? PROBE FOR RACE IF R SAYS HISPANIC OR A
HISPANIC ORIGIN ENTER ALL THAT APPLY For Web administration,
the question txt was: Please choose one or more races that you consider
yourself to be (Mark all that apply)
1 - White, non-Hispanic
2 - Black, non-Hispanic
3 - Asian, native Hawaiian or
other Pacif Islr,non-Hispanic
4 - Native American or Alaska
Native, non-Hispanic
5 - Hispanic
6 - Other non-Hispanic incl
multiple races <WEB: blank
’Other’ counted as a race> 
-2 - Missing

*compute nonwhite variable and code missing data that should be imputed as -11.
compute nonwhite = 0.
if (race = 2 OR race = 3 OR race = 4 OR race = 5 OR race = 6) nonwhite = 1.
if (race = -2) nonwhite = -11.
fre nonwhite.
*0.8% missing for nonwhite.

*relabel nonwhite variable.
VALUE LABELS
nonwhite
1 '1 - nonwhite or Hispanic'
0 '0 - white, non-Hispanic'
-11 '-11 - missing nonresponse'.
fre nonwhite.

*-------------female----------------.

*sex variable = V161342, R self-identified gender
ANES 2016 Codebook - Version 20190904 - page 556
1. Male
2. Female
3. Other 
-9. Refused

fre gender.
*compute female variable and code missing data that should be imputed as -11.
compute female = 0.
if (gender = 2) female = 1.
if (gender = -9 OR gender =3) female = -11.
execute.
fre female.
*1.2% missing for female.

*relabel female variable.
VALUE LABELS
female
1 '1 - female'
0 '0 - male'
-11 '-11 - missing or other'.
fre female.

*-------------edu----------------
    
*education variable - V161270, highest level of Education, asked pre-election
see ANES 2016 Codebook - Version 20190904 - page 434:
What is the highest level of school you have completed or the highest degree
you have received?
1 - Less than 1st grade
2 - 1st, 2nd, 3rd or 4th grade
3 - 5th or 6th grade
4 - 7th or 8th grade
5 - 9th grade
6 - 10th grade
7 - 11th grade
8 - 12th grade no diploma
9 - High school graduate- high
school diploma or equivalent
(for example: GED)
10 - Some college but no
degree
11 - Associate degree in
college -
occupational/vocational
program 
12 - Associate degree in
college – academic program
13 - Bachelor’s degree (for
example: BA, AB, BS) 
14 - Master’s degree (for
example: MA, MS, MENG,
MED, MSW, MBA) 
15 - Professional school degree
(for example: MD, DDS,
DVM, LLB, JD) 
16 - Doctorate degree (for
example: PHD, EDD) 
90 - Other specify given as:
high school graduate 
95 - Other SPECIFY 
-9 - Refused

compute edu2 = edu.
if (edu=90) edu2 = 9.
fre edu2.
*education was recoded such that anyone who said "other" but then said high school grad was coded as high school grad. 
*education still has 24 (0.6%) of values listed as "other specify," but i can't see what the respondent specified without requesting open-ends, I believe, so I will impute them. 

*collapse missing values for edu.
recode edu2 (-9 = -11)(95=-11) into edu2.
fre edu2.

compute edu = edu2.
fre edu.
*0.9% missing data for edu.

*------income--------------.
*income variable - V161361x, income, asked pre-election
see ANES 2016 Codebook - Version 20190904 - page 579:
-9 is refused
-5 is insufficient, partial breakoff
-9 = 4.4% of sample
-5 =0.3% of sampe
can impute these.


fre income.
*income has missing values for refusal and breakoff.
*collapse missing values.
recode income (-9 = -11) (-5=-11) into income.
fre income.
*4.7% missing for income.

*------age--------------

*age variable - V161267 = respondent age
asked pre-election, variable derived by ANES
-9 = refused
-8 = don't know.

fre age.

*collpse missing values for age.
recode age (-9 = -11) (-8=-11) into age.
fre age.
*2.8% missing for age.

*------rural--------------
    
*Rural-Urban Continuum Codes
The 2013 Rural-Urban Continuum Codes form a classification scheme that distinguishes 
    metropolitan counties by the population size of their metro area, and nonmetropolitan counties 
    by degree of urbanization and adjacency to a metro area. The official Office of Management and Budget (OMB) metro and nonmetro categories
    have been subdivided into three metro and six nonmetro categories. Each county in the U.S., municipio in Puerto Rico, and Census Bureau-designated 
    county-equivalent area of the Virgin Islands/other inhabited island territories of the U.S. is assigned one of the 9 codes. 
    *This scheme allows researchers to break county data into finer residential groups, beyond metro and nonmetro, particularly for the analysis of trends in 
    nonmetro areas that are related to population density and metro influence. The Rural-Urban Continuum Codes were originally developed in 1974. 
   *They have been updated each decennial since (1983, 1993, 2003, 2013), and slightly revised in 1988. Note that the 2013 Rural-Urban 
    Continuum Codes are not directly comparable with the codes prior to 2000 because of the new methodology used in developing the 2000 metropolitan areas. 
    *See the Documentation for details and a map of the codes.
    *An update of the Rural-Urban Continuum Codes is planned for mid-2023.

*usda rural-urban continuum codes, scored 1-9:
    1	Metro - Counties in metro areas of 1 million population or more
    2	Metro - Counties in metro areas of 250,000 to 1 million population
    3	Metro - Counties in metro areas of fewer than 250,000 population
    4	Nonmetro - Urban population of 20,000 or more, adjacent to a metro area
    5	Nonmetro - Urban population of 20,000 or more, not adjacent to a metro area
    6	Nonmetro - Urban population of 2,500 to 19,999, adjacent to a metro area
    7	Nonmetro - Urban population of 2,500 to 19,999, not adjacent to a metro area
    8	Nonmetro - Completely rural or less than 2,500 urban population, adjacent to a metro area
    9	Nonmetro - Completely rural or less than 2,500 urban population, not adjacent to a metro area

RENAME VARIABLES (usda_RUCC_2013 = rural).
fre rural.
*0.0% missing data for rural.

*----- evangelical ----------
    
*Variable = V161265x. PRE: SUMMARY - Major group religion summary
ANES 2016 Codebook - Version 20190904 - page 412
1. Mainline Protestant
2. Evangelical Protestant
3. Black Protestant
4. Roman Catholic
5. Undifferentiated Christian
6. Jewish
7. Other religion
8. Not religious
-2. Missing, item nonresponse

RENAME VARIABLE (V161265x = religid).
recode religid (2=1)(-2=-11)(else=0) into evangelical.


VALUE LABELS
evangelical
1 '1 - evangelical'
0 '0 - not evangelical'
-11 '-11 - missing'.
fre evangelical.

*1.1% missing for evangelical.


*----- religiosity ----------
    
*Variable = V161241. PRE: Is religion important part of R life
ANES 2016 Codebook - Version 20190904 - page 382
Now on another topic.... Do you consider religion to be an important part
of your life, or not?
1. Important
2. Not important
-8. Don’t know
-9. Refused.

*Variable = V161242. PRE: Religion provides guidance in day-to-day living
ANES 2016 Codebook - Version 20190904 - page 383
IF R SAYS THAT RELIGION IS IMPORTANT: Would you say your religion
provides [some guidance in your day-to-day living, quite a bit of guidance,
or a great deal of guidance / a great deal of guidance in your day-to-day
living, quite a bit of guidance, or some guidance] ?
1. Some
2. Quite a bit
3. A great deal
-1. INAP, 2,-8,-9 in V161241
-8. Don’t know (FTF only) 
-9. Refused.

RENAME VARIABLE (V161241 = religimportant).
RENAME VARIABLE (V161242 = religguidance).
fre religimportant religguidance.

compute religguidance2 = 0.
if (religimportant = -9) religguidance2 = -11.
if (religimportant = -8) religguidance2 = -11.
if (religimportant = 1 AND religguidance = 1) religguidance2 = 1.
if (religimportant = 1 AND religguidance = 2) religguidance2 = 2.
if (religimportant = 1 AND religguidance = 3) religguidance2 = 3.
if (religimportant = 1 AND religguidance = -9) religguidance2 = -11.
if (religimportant = 1 AND religguidance = -8) religguidance2 = -11.
fre religguidance2.

compute religiosity = religguidance2.
fre religiosity.
*0.9% missing for religiosity.

*----- political views ----------
    
*V161158x - PRE: SUMMARY - Party ID
ANES 2016 Codebook - Version 20190904 - page 256
derived by ANES from a series of questions
1. Strong Democrat
2. Not very strong Democrat
3. Independent-Democrat
4. Independent
5. Independent-Republican
6. Not very strong Republican
7. Strong Republican 
-8. DK (-8) in V161156 or V161157 (FTF only)
-9. RF (-9) in V161155 (FTF only)/-9 in V161156 or V161157

*V161126 PRE: 7pt scale Liberal conservative self-placement
ANES 2016 Codebook - Version 20190904 - page 203
1. Extremely liberal
2. Liberal
3. Slightly liberal
4. Moderate, middle of the road
5. Slightly conservative
6. Conservative
7. Extremely conservative
99. Haven’t thought much about this (FTF ONLY: DO NOT PROBE)
-8. Don’t know (FTF only)
-9. Refused.

*V161127 PRE: If R had to choose liberal or conservative self-placemt
    IF LIBERAL-CONSERVATIVE SELF-PLACEMENT IS MODERATE,
DK, OR HAVEN’T THOUGHT: If you had to choose, would you consider
yourself a liberal or a conservative? 
1. Liberal
2. Conservative
3. Moderate
-1. INAP, 1,2,3,5,6,7 in V161126
-8. Don’t know (FTF only)
-9. Refused
    
RENAME VARIABLE (V161158x = partyid).
RENAME VARIABLE (V161126 = poliviews).
RENAME VARIABLE (V161127 = poliforcechoice).
fre partyid poliviews poliforcechoice.

compute poliviews2 = 0.
if ((poliviews=-8 OR poliviews = 99) AND poliforcechoice = 1) poliviews2 = 3.
if ((poliviews=-8 OR poliviews = 99) AND poliforcechoice = 2) poliviews2 = 5.
if ((poliviews=-8 OR poliviews = 99) AND poliforcechoice = 3) poliviews2 = 4.
if ((poliviews=-8 OR poliviews = 99) AND poliforcechoice = -8) poliviews2 = -11.
if ((poliviews=-8 OR poliviews = 99) AND poliforcechoice = -9) poliviews2 = -11.
if (poliviews = 1) poliviews2 = 1.
if (poliviews = 2) poliviews2 = 2.
if (poliviews = 3) poliviews2 = 3.
if (poliviews = 4) poliviews2 = 4.
if (poliviews = 5) poliviews2 = 5.
if (poliviews = 6) poliviews2 = 6.
if (poliviews = 7) poliviews2 = 7.
if (poliviews = -9) poliviews2 = -11.
fre poliviews2.

VALUE LABELS
poliviews2
1 '1 - Extremely liberal'
2 '2 - Liberal'
3 '3 - Slightly liberal or forced'
4 '4 - Moderate'
5 '5 - Slightly conservative or forced'
6 '6 - Conservative'
7 '7 - Extremely conservative'
-11 '-11 - Missing'
fre poliviews2.

recode partyid (-9=-11)(-8=-11).
VALUE LABELS
partyid
1 '1 - Strong Democrat'
2 '2 - Not very strong Democrat'
3 '3 - Independent-Democrat'
4 '4 - Independent'
5 '5 - Independent-Republican'
6 '6 - Not very strong Republican'
7 '7 - Strong Republican'
-11 '-11 - Missing'.
fre partyid.

compute conservativism = poliviews2.
fre conservativism.

*1.8% missing for conservativism
*0.5% missing for partyid.

*-----conspiracism-----
    
*V162254 asked after election: POST: Did the U.S. government know about 9/11 in advance
    Next for some other questions. Please turn to page [PRELOAD: page] of
the booklet. Did senior federal government officials [definitely know about
the terrorist attacks on September 11, 2001 before they happened, probably
know about the terrorist attacks on September 11, 2001 before they
happened, probably not know about the terrorist attacks on September 11,
2001 before they happened, or definitely not know about the terrorist attacks
on September 11, 2001 before they happened]?
1. Definitely knew 
2. Probably knew
3. Probably did not know
4. Definitely did not know 
-6. No post-election interview
-7. No post data, deleted due to incomplete IW
-8. Don’t know
-9. Refused

RENAME VARIABLE (V162254 = knew911).
recode knew911(1=4)(2=3)(3=2)(4=1)(-9=-11)(-8=-11)(-7=-11)(-6=-6) into knew911rev.
compute govtknew911 = knew911rev.
fre govtknew911.
*3.2% missing govtknew911.


*V162255x - asked after election - POST: SUMMARY- Barack Obama is/isn’t Muslim
variable derived by ANES from a series of questions
ANES 2016 Codebook - Version 20190904 - page 1217
1. Extremely sure Obama is a Muslim
2. Very sure Obama is a Muslim
3. Moderately sure Obama is a Muslim
4. A little sure Obama is a Muslim 
5. Not sure at all sure Obama is a Muslim
6. Not sure at all sure Obama not a Muslim
7. A lttle sure Obama not a Muslim
8. Moderately sure Obama not a Muslim
9. Very sure Obama not a Muslim
10. Extremely sure Obama not a Muslim
-6. No post-election interview
-7. No post data, deleted due to incomplete
-8. Don’t know
-9. Refused

RENAME VARIABLE (V162255x = obamamus).
recode obamamus(1=10)(2=9)(3=8)(4=7)(5=6)(6=5)(7=4)(8=3)(9=2)(10=1)(-9=-11)(-8=-11)(-7=-11)(-6=-6) into obamamusrev.
compute obamamuslim = obamamusrev.
fre obamamuslim.
fre obamamus.
*6.8% missing obamamuslim.

*-----trust in washington-----
    
*V161215 asked before election REV How often trust govt in Wash to do what is right
    How often can you trust the federal government in Washington to do what
is right? [Always, most of the time, about half the time, some of the time,
or never / Never, some of the time, about half the time, most of the time,
or always]?
1. Always
2. Most of the time
3. About half the time
4. Some of the time
5. Never
-8. Don’t know (FTF only)
-9. Refused
    
RENAME VARIABLE (V161215 = trustwashington).
recode trustwashington(1=5)(2=4)(3=3)(4=2)(5=1)(-9=-11)(-8=-11)(-7=-11)(-6=-6) into trustwashingtonrev.
compute trustwash = trustwashingtonrev.
execute.
fre trustwashington.
fre trustwash.

*0.5% missing for trustwash.


*----trust in people-----

*V161219 - PRE: How often can people be trusted
ANES 2016 Codebook - Version 20190904 - page 340
Question: Generally speaking, how often can you trust other people? [Always, most of
the time, about half the time, some of the time, or never / Never, some of
the time, about half the time, most of the time, or always]?
Forward/reverse response option order
1. Always 
2. Most of the time 
3. About half the time 
4. Some of the time 
5. Never 
-8. Don’t know (FTF only)
-9. Refused

recode V161219(1=5)(2=4)(3=3)(4=2)(5=1)(-9=-11)(-8=-11) into trustpeople.
fre trustpeople.


*----- news attn-----
*V161008 - PRE: Days in week watch/listen/read news on any media
    ANES 2016 Codebook - Version 20190904 - page 33
    During a typical week, how many days do you watch, read, or listen to news
on TV, radio, printed newspapers, or the Internet, not including sports?
PROBE: IF ‘every day’ ASK FOR NUMBER
0. None
1. One day
2. Two days
3. Three days 
4. Four days 
5. Five days 
6. Six days
7. Seven days 
-8. Don’t know (FTF only) 
-9. Refused 

RENAME VARIABLE (V161008 = newsdaysaweek).
fre newsdaysaweek.

RENAME VARIABLE (V161009 = newsattn).
fre newsattn.

compute polinewsattn = 0.
if (newsattn = -1 OR newsattn = 5) polinewsattn = 1.
if (newsattn = 4) polinewsattn = 2.
if (newsattn = 3) polinewsattn = 3.
if (newsattn = 2) polinewsattn = 4.
if (newsattn = 1) polinewsattn = 5.
if (newsattn =-9) polinewsattn = -11.
fre polinewsattn.

recode newsdaysaweek (-8=-11) (-9=-11) into newsdaysaweek.
fre newsdaysaweek.
*0.1% missing for newsdaysaweek.

*-----partisan media-----
   
*partisan tv viewing variables come specifically from people who said yes to:
HEARD ABOUT PRES CAMPAIGN ON TV NEWS/TALK/PUBLIC AFFAIRS/ NEWS ANALYSIS PROG(S)
follow-up was: if that's true, then which of the following television programs do you watch regularly? 
Please check any that you watch at least once a month. (Mark all that apply) Randomized response option order
0 - not selected
1 - selected.
    
RENAME VARIABLE (V161370 = tvhannity).
RENAME VARIABLE (V161409 = tvoreilly).
RENAME VARIABLE (V161365 = tvchrishayes).
RENAME VARIABLE (V161393 = tvmaddow).
RENAME VARIABLE (V161386 = tvchrismatthews).
RENAME VARIABLE (V161372 = tvkellyfile).

recode tvhannity (-9=-11)(-5=-11) into tvhannity.
recode tvoreilly (-9=-11)(-5=-11) into tvoreilly.
recode tvchrishayes (-9=-11)(-5=-11) into tvchrishayes.
recode tvmaddow (-9=-11)(-5=-11) into tvmaddow.
recode tvchrismatthews (-9=-11)(-5=-11) into tvchrismatthews.
recode tvkellyfile (-9=-11)(-5=-11) into tvkellyfile.
execute.
*1.8% missing for all partisan TV viewing.

fre tvhannity tvoreilly tvchrishayes tvmaddow tvchrismatthews tvkellyfile.


compute anyfoxtv = 0.
if (tvhannity=1 OR tvoreilly = 1 OR tvkellyfile = 1) anyfoxtv = 1.
fre anyfoxtv.

compute anymsnbctv = 0.
if (tvchrishayes=1 OR tvchrismatthews = 1 OR tvmaddow = 1) anymsnbctv = 1.
fre anymsnbctv.


*-----feelsci------
    
RENAME VARIABLE (V162112 = feelsci).
fre feelsci.
recode feelsci (998=-11)(999=-11)(-9=-11)(-7=-11) into feelsci.
fre feelsci.
*2.8% missing for feelsci.

*---envjobs tradeoff----

RENAME VARIABLE (V161201 = envreg). 
fre envreg.
compute regcostsjobs = envreg.
recode regcostsjobs (-9=-11)(-8=-11)(99=-11) into regcostsjobs.
execute.
fre regcostsjobs.


*---------- PERSONALITY-----------
*V162253x -POST: SUMMARY- Need to Evaluate score
ANES 2016 Codebook - Version 20190904 - page 1212
derived variable
*See the ANES metholodgy report for use of the need to evaluate measure:
https://electionstudies.org/wp-content/uploads/2016/02/anes_timeseries_2016_methodology_report.pdf
*NTE reflects a tendency to judge objects or experiences as good or bad. (Strictly speaking, it appears to be a propensity, not a
“need.”) People higher in NTE form more evaluations of this kind.
*The adaptive battery for measuring NTE administered 4 questions from a maximum of six available. The
specific set of questions asked of each respondent was conditional on the respondent’s answers to the 
initial questions. Summary scores for the NTE items, measuring each respondent’s need to evaluate, are
shown in the variable V162253x. These scores were calculated by Jacob Montgomery and Erin Rossiter
using the R package catSurv,3 which provides methods of computerized adaptive testing.

RENAME VARIABLE (V162253x = needevaluate).
fre needevaluate.
recode needevaluate (-7=-11) into needevaluate.
fre needevaluate.

*---- Big 5 - Openness to experience ---
*https://gosling.psy.utexas.edu/wp-content/uploads/2014/09/tipi.pdf

*V162337 - POST: FTF CASI/WEB: TIPI open to new experiences
ANES 2016 Codebook - Version 20190904 - page 1346
*V162342 - POST: FTF CASI/WEB: TIPI conventional, uncreative
ANES 2016 Codebook - Version 20190904 - page 1356
Please mark how well the following pair of words describes you, even if one
word describes you better than the other. ‘open to new experiences, complex’
describes me
1. Extremely poorly
2. Somewhat poorly
3. A little poorly
4. Neither poorly nor well
5. A little well
6. Somewhat well
7. Extremely well
-5. Breakoff, sufficient partial IW
-6. No post-election interview
-7. No post data, deleted due to incomplete IW
-9. Refused

RENAME VARIABLE (V162337 = open1).
RENAME VARIABLE (V162342 = open2).

recode open2 (-9=-11)(-7=-11)(-5=-11)(-6=-6)(1=7)(2=6)(3=5)(4=4)(5=3)(6=2)(7=1) into open2.
recode open1 (-9=-11)(-7=-11)(-5=-11) into open1.
execute.
fre open1 open2.

*----------- MORAL TRADITIONALISM ----------------
*Variables
ANES 2016 Codebook - Version 20190904 - page 1125-1131
V162207 - POST: Agree/disagree: world is changing and we should adjust
V162208 - POST: Agree/disagree: newer lifestyles breaking down society
V162209 - POST: Agree/disagree: be more tolerant of other moral standards
V162210 - POST: Agree/disagree: more emphasis on traditional family values

fre V162207 V162208 V162209 V162210.

*V162207. ‘The world is always
changing and we should adjust our view of moral behavior to those
changes.’ Do you [agree strongly, agree somewhat, neither agree nor disagree,
disagree somewhat, or disagree strongly / disagree strongly, disagree
somewhat, neither agree nor disagree, agree somewhat, or agree strongly]
with this statement?
*V162208.The newer lifestyles are contributing to the breakdown of our society.’
*V162209.‘We should be more tolerant of people who choose to live according to their own moral
standards, even if they are very different from our own.’
*V162210. This country would have many fewer problems if there were more emphasis on traditional family ties.’
1. Agree strongly
2. Agree somewhat
3. Neither agree nor disagree
4. Disagree somewhat
5. Disagree strongly
-6. No post-election interview 
-7. No post data, deleted due to incomplete IW
-8. Don’t know
-9. Refused

RENAME VARIABLE (V162207 = moralshouldadj).
recode moralshouldadj (-7=-11)(-8=-11)(-9=-11) into moralshouldadj.
RENAME VARIABLE (V162208 = moralnewstylesbad).
recode moralnewstylesbad (5=1)(4=2)(3=3)(2=4)(1=5)(-6=-6)(-7=-11)(-8=-11)(-9=-11) into moralnewstylesbad.
RENAME VARIABLE (V162209 = moralshouldtolerate).
recode moralshouldtolerate (-7=-11)(-8=-11)(-9=-11) into moralshouldtolerate.
RENAME VARIABLE (V162210 = moralfamilyties).
recode moralfamilyties (5=1)(4=2)(3=3)(2=4)(1=5)(-6=-6)(-7=-11)(-8=-11)(-9=-11) into moralfamilyties.
execute.

fre moralshouldadj moralnewstylesbad moralshouldtolerate moralfamilyties.

missing values
moralshouldadj moralnewstylesbad moralshouldtolerate moralfamilyties (-11, -6).

RELIABILITY
  /VARIABLES=moralshouldadj moralnewstylesbad moralshouldtolerate moralfamilyties
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE SCALE CORR
  /SUMMARY=TOTAL MEANS.
*cronbach's alpa = 0.712.


missing values
moralshouldadj moralnewstylesbad moralshouldtolerate moralfamilyties ().

fre age nonwhite female edu income needevaluate open1 open2 conservativism partyid religiosity evangelical moralshouldadj moralnewstylesbad moralshouldtolerate moralfamilyties 
     govtknew911 obamamuslim trustwash trustpeople newsdaysaweek tvhannity tvoreilly tvchrishayes tvmaddow tvchrismatthews tvkellyfile feelsci.
