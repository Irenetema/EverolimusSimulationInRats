$PROB
Everolinus Model

$GLOBAL
//#define B1_rbc (Crbc-NSrbc*Kdrbc-NPrbc)
#define B1_lun (Clun-NSlun*Kdlun-NPlun)
#define B1_mus (Cmus-NSmus*Kdmus-NPmus)
#define B1_skin (Cskin-NSskin*Kdskin-NPskin)
#define B1_fat (Cfat-NSfat*Kdfat-NPfat)
#define B1_thy (Cthy-NSthy*Kdthy-NPthy)
#define B1_kid (Ckid-NSkid*Kdkid-NPkid)
#define B1_pan (Cpan-NSpan*Kdpan-NPpan)
#define B1_spl (Cspl-NSspl*Kdspl-NPspl)
#define B1_git (Cgit-NSgit*Kdgit-NPgit)
#define B1_liv (Cliv-NSliv*Kdliv-NPliv)
#define B1_oth (Coth-NSoth*Kdoth-NPoth)

//#define Cu_rbc ((B1_rbc+pow((pow(B1_rbc,2)+4*NSrbc*Kdrbc*Crbc),0.5))/2*NSrbc)
#define Cu_lun ((B1_lun+pow((pow(B1_lun,2)+4*NSlun*Kdlun*Clun),0.5))/2*NSlun)
#define Cu_mus ((B1_mus+pow((pow(B1_mus,2)+4*NSmus*Kdmus*Cmus),0.5))/2*NSmus)
#define Cu_skin ((B1_skin+pow((pow(B1_skin,2)+4*NSskin*Kdskin*Cskin),0.5))/2*NSskin)
#define Cu_fat ((B1_fat+pow((pow(B1_fat,2)+4*NSfat*Kdfat*Cfat),0.5))/2*NSfat)
#define Cu_thy ((B1_thy+pow((pow(B1_thy,2)+4*NSthy*Kdthy*Cthy),0.5))/2*NSthy)
#define Cu_kid ((B1_kid+pow((pow(B1_kid,2)+4*NSkid*Kdkid*Ckid),0.5))/2*NSkid)
#define Cu_pan ((B1_pan+pow((pow(B1_pan,2)+4*NSpan*Kdpan*Cpan),0.5))/2*NSpan)
#define Cu_spl ((B1_spl+pow((pow(B1_spl,2)+4*NSspl*Kdspl*Cspl),0.5))/2*NSspl)
#define Cu_git ((B1_git+pow((pow(B1_git,2)+4*NSgit*Kdgit*Cgit),0.5))/2*NSgit)
#define Cu_liv ((B1_liv+pow((pow(B1_liv,2)+4*NSliv*Kdliv*Cliv),0.5))/2*NSliv)
#define Cu_oth ((B1_oth+pow((pow(B1_oth,2)+4*NSoth*Kdoth*Coth),0.5))/2*NSoth)

//#define Cb_rbc (Cu_rbc*((1-H)/fu + H*NSbc + H*NPbc/(Kdbc+Cu_rbc)))
#define Cb_lun (Cu_lun*((1-H)/fu + H*NSbc + H*NPbc/(Kdbc+Cu_lun)))
#define Cb_mus (Cu_mus*((1-H)/fu + H*NSbc + H*NPbc/(Kdbc+Cu_mus)))
#define Cb_skin (Cu_skin*((1-H)/fu + H*NSbc + H*NPbc/(Kdbc+Cu_skin)))
#define Cb_fat (Cu_fat*((1-H)/fu + H*NSbc + H*NPbc/(Kdbc+Cu_fat)))
#define Cb_thy (Cu_thy*((1-H)/fu + H*NSbc + H*NPbc/(Kdbc+Cu_thy)))
#define Cb_kid (Cu_kid*((1-H)/fu + H*NSbc + H*NPbc/(Kdbc+Cu_kid)))
#define Cb_pan (Cu_pan*((1-H)/fu + H*NSbc + H*NPbc/(Kdbc+Cu_pan)))
#define Cb_spl (Cu_spl*((1-H)/fu + H*NSbc + H*NPbc/(Kdbc+Cu_spl)))
#define Cb_git (Cu_git*((1-H)/fu + H*NSbc + H*NPbc/(Kdbc+Cu_git)))
#define Cb_liv (Cu_liv*((1-H)/fu + H*NSbc + H*NPbc/(Kdbc+Cu_liv)))
#define Cb_oth (Cu_oth*((1-H)/fu + H*NSbc + H*NPbc/(Kdbc+Cu_oth)))

#define Cba_liv ((Qpan*Cb_pan+Qspl*Cb_spl+Qgit*Cb_git+Qliv*Cba)/Qhepatic)
#define Cb_organ ((Qmus*Cb_mus+Qskin*Cb_skin+Qfat*Cb_fat+Qthy*Cb_thy+Qkid*Cb_kid+Qhepatic*Cb_liv+Qoth*Cb_oth)/Qlun)

#define A ((1-H)/fu + H*NSbc)
#define B2bv (Cbv - (1-H)*Kdbc/fu - H*NSbc*Kdbc - H*NPbc)
#define C2bv (Cbv*Kdbc)

#define B2ba (Cba - (1-H)*Kdbc/fu - H*NSbc*Kdbc - H*NPbc)
#define C2ba (Cba*Kdbc)

#define Cubv ((B2bv+pow((pow(B2bv,2)+4*A*C2bv),0.5))/2*A)
#define Cuba ((B2ba+pow((pow(B2ba,2)+4*A*C2ba),0.5))/2*A)

//Dabs=1000*Fdose*Dose*BW + 1000*Fabs*Podose*BW //DABS: amount of drug absorbed in microgram
#define Adum 1000*(Adinf+Adepot) //ADUM: amount of drug at administration sites
#define Pdrm  (Adum  + Cbv*Vbv + Cba*Vba+ Clun*Vlun + Cmus*Vmus + Cskin*Vskin + Cfat*Vfat + Cthy*Vthy + Ckid*Vkid + Cpan*Vpan + Cspl*Vspl + Cgit*Vgit + Cliv*Vliv + Coth*Voth)*100/Dabs  //PDRM: fraction of drug remaining in the body

//#define CrbcToCbv (Crbc/Cbv)
#define CmusToCbv (Cmus/Cbv)
#define CskinToCbv (Cskin/Cbv)
#define CfatToCbv (Cfat/Cbv)
#define CthyToCbv (Cthy/Cbv)
#define CkidToCbv (Ckid/Cbv)
#define CpanToCbv (Cpan/Cbv)
#define CsplToCbv (Cspl/Cbv)
#define CgitToCbv (Cgit/Cbv)
#define ClivToCbv (Cliv/Cbv)
#define ClunToCbv (Clun/Cbv)

$PARAM
dose = 1, //intravenous DOSE in mg/kg
Fdose = 1, //Fdose: availability of DOSE
Podose = 1.5, //Podose: oral dose in mg/kg
TADM = 0.01, //TADM: duration of infusion/injection in hour
KTrn = 100, //transfer rate constant from injection point to lungs

H = 0.45, //H: hematocrit
fu = 0.079086, //Fu: fraction unbound in plasma

NSbc = 3.592, //NSBC: non-saturable fraction in blood cells
NPbc = 0.056, //NPBC: binding capacity of blood cells
Kdbc = 0.00134, //KDBC: dissociation constant in blood cells
Kdeg = 0.546, //Kdeg: rate constant of degradation in plasma
//Rinf = 1,
BW = 0.300, //BW: actual body weight in kg
BWS=0.250, //BWS: standard body weight

Fabs = 0.39,
Kabs = 19.4,
//CLint_liv = 589, // [ml/min/kg]
//CLint_liv = 0.00003534, // [ml/h/ug]
CLint_liv = 36655, // [ml/hr/kg]
//CLinpk = 36655, // [ml/hr/kg]

V1ba = 5.6, //V1ba: volume of arterial blood for the BWS in mL
V1bv = 11.3, //V1bv: volume of venous blood for the BWS in mL
//V1rbc = 20.3,
V1lun = 1,
V1mus = 122,
V1skin = 40.0,
V1fat = 10.0,
V1thy = 0.7,
V1kid = 2.3,
V1pan = 1.3,
V1spl = 0.8,
V1git = 11.1,
V1liv = 10.3,
//V1oth = 20.6,


//Q1rbc = 3096,
Q1lun = 2580,
Q1mus = 450,
Q1skin = 350,
Q1fat = 24,
Q1thy = 18,
Q1kid = 554,
Q1pan = 31,
Q1spl = 38,
Q1git = 519,
Q1liv = 120,

//NSrbc = 3.59,
NSlun = 1.0,
NSmus = 1.0,
NSskin = 1.0,
NSfat = 1.0,
NSthy = 1.3,
NSkid = 1.1,
NSpan = 1.0,
NSspl = 1.0,
NSgit = 1.0,
NSliv = 3.0,
NSoth = 1.0,

//NPrbc = 0.056,
NPlun = 4.15,
NPmus = 0.987,
NPskin = 0.389,
NPfat = 0.460,
NPthy = 1.51,
NPkid = 3.95,
NPpan = 5.42,
NPspl = 3.61,
NPgit = 1.08,
NPliv = 5.03,
NPoth = 0.723,

//Kdrbc = 0.001340,
Kdlun = 0.00230,
Kdmus = 0.001650,
Kdskin = 0.000362,
Kdfat = 0.002010,
Kdthy = 0.000492,
Kdkid = 0.00509,
Kdpan = 0.006150,
Kdspl = 0.002290,
Kdgit = 0.000359,
Kdliv = 0.0037700,
Kdoth = 0.000991,



$CMT
Adinf Adepot Cskin Cmus Cfat Cthy Ckid Cpan Cspl Cgit Coth Clun Cliv Cba Cbv Deg //ClivAfterOralAdmin Deg 


$MAIN


double BWF=BW/BWS;
double Kinf=Fdose*dose*BW/TADM; //Kinf: intravenous infusion rate mg/hr
double Xabs=Fabs*Podose*BW; //Xabs: amount of drug absorbed in mg

double Dabs=1000*Fdose*dose*BW + 1000*Fabs*Podose*BW; //DABS: amount of drug absorbed in microgram

double Kin=Xabs/TADM; //Kin: rate constant of absorption mg/hr
double CLint=CLint_liv*BW; //CLint: intrinsic clearance mL/hr

double Vba=V1ba*BWF; //Vba: volume of arterial blood
double Vbv=V1bv*BWF; //Vbv: volume of venous blood

//Vi: volume of tissue/organ i 
//double Vrbc = V1rbc*BWF;
double Vlun = V1lun*BWF;
double Vmus = V1mus*BWF;
double Vskin = V1skin*BWF;
double Vfat = V1fat*BWF;
double Vthy = V1thy*BWF;
double Vkid = V1kid*BWF;
double Vpan = V1pan*BWF;
double Vspl = V1spl*BWF;
double Vgit = V1git*BWF;
double Vliv = V1liv*BWF;
double Voth=BW*1000-(Vlun+Vmus+Vskin+Vfat+Vthy+Vkid+Vpan+Vspl+Vgit+Vliv);

//double Qrbc = Q1rbc*BWF;
double Qlun = Q1lun*BWF;
double Qmus = Q1mus*BWF;
double Qskin = Q1skin*BWF;
double Qfat = Q1fat*BWF;
double Qthy = Q1thy*BWF;
double Qkid = Q1kid*BWF;
double Qpan = Q1pan*BWF;
double Qspl = Q1spl*BWF;
double Qgit = Q1git*BWF;
double Qliv = Q1liv*BWF;

//double Cint=Tstop/points; //Cint: Time interval between 2 time points

double Qhepatic = Qpan+Qspl+Qliv+Qgit;
double Qtotal = Qhepatic+Qkid+Qmus+Qskin+Qfat+Qthy;
double Qoth = Qlun - Qtotal;



$ODE
//dxdt_Crbc = Qrbc*(Cba-Cb_rbc)/Vrbc;
dxdt_Cmus = Qmus*(Cba-Cb_mus)/Vmus;
dxdt_Cskin = Qskin*(Cba-Cb_skin)/Vskin;
dxdt_Cfat = Qfat*(Cba-Cb_fat)/Vfat;
dxdt_Cthy = Qthy*(Cba-Cb_thy)/Vthy;
dxdt_Ckid = Qkid*(Cba-Cb_kid)/Vkid;
dxdt_Cpan = Qpan*(Cba-Cb_pan)/Vpan;
dxdt_Cspl = Qspl*(Cba-Cb_spl)/Vspl;
dxdt_Cgit = Qgit*(Cba-Cb_git)/Vgit;
dxdt_Coth = Qoth*(Cba-Cb_oth)/Voth;

dxdt_Deg=((1-H)/fu + H*NSbc + H*NPbc*Kdbc/pow((Kdbc+Cubv),2))*Kdeg*Cubv*Vbv + ((1-H)/fu + H*NSbc + H*NPbc*Kdbc/pow((Kdbc+Cuba),2))*Kdeg*Cuba*Vba; //DEG: amount degraded in blood

//dxdt_Adinf=Kinf*(1-TADM)-KTrn*Adinf; //Adinf: amount of drug at infusion point in mg
dxdt_Adinf=-KTrn*Adinf; //Adinf: amount of drug at infusion point in mg

dxdt_Clun = KTrn*Adinf*1000/Vlun + Qlun*(Cbv-Cb_lun)/Vlun;
dxdt_Cliv = Qhepatic*(Cba_liv-Cb_liv)/Vliv - CLint*Cu_liv/Vliv + Kabs*Adepot*1000/Vliv;

//This is normally how the equation is written in the article
//dxdt_Cba = Qlun*(Cb_lun-Cba)/Vba - ((1-H)/fu + H*NSbc + H*NPbc*Kdbc/pow((Kdbc+Cuba),2))*Kdeg*Cuba;
//dxdt_Cbv = Qlun*(Cb_organ-Cbv)/Vbv - ((1-H)/fu + H*NSbc + H*NPbc*Kdbc/pow((Kdbc+Cubv),2))*Kdeg*Cubv;

//This is actually what is implemented
dxdt_Cba = Qlun*(Cb_lun-Cba)/Vba - ((1-H)/fu + H*NSbc + H*NPbc*Kdbc/pow((Kdbc+Cuba),2))*Kdeg*Cuba;
dxdt_Cbv = Qlun*(Cb_organ-Cbv)/Vbv - ((1-H)/fu + H*NSbc + H*NPbc*Kdbc/pow((Kdbc+Cubv),2))*Kdeg*Cubv;

//dxdt_Adepot = Kin*(1-TADM)-Kabs*Adepot; //Adepot: amount of drug in the depot compartment in mg
dxdt_Adepot = -Kabs*Adepot; //Adepot: amount of drug in the depot compartment in mg


$OMEGA 


$TABLE


$CAPTURE
Cba_liv
Cb_organ
//Cu_rbc
Cu_lun
Cu_mus
Cu_skin
Cu_fat
Cu_thy
Cu_kid
Cu_pan
Cu_spl
Cu_git
Cu_liv
Cu_oth
//CrbcToCbv
CmusToCbv
CskinToCbv
CfatToCbv
CthyToCbv
CkidToCbv
CpanToCbv
CsplToCbv
CgitToCbv
ClivToCbv
ClunToCbv
Pdrm
Adum
