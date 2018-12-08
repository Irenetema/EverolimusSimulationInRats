library(mrgsolve)
library(grid)
library(ggplot2)
library(dplyr)
library(gridExtra)
system('g++ -v')

mod <- mread_cache("Everolimus")

shinyServer(function(input,output,session) {

  #set end time, time step, and number of subjects
  end=25
  delta=0.001
  n=1
  
  #Choose species
  species_change <- reactive({
    chosen_species <- switch(input$SelectSpecies, "Mouse [30g]"=1, "Rats [300g]"=2, "Rabbit [2.5kg]"=3, "Rhesus Monkey [5kg]"=4, "Dog [10kg]"=5, "Human [70kg]"=6)
    
    if(chosen_species == 1) { #Physiological parameters for Mouse
      param(
        BW = 0.03, #BW: actual body weight in kg
        BWS=0.03, #BWS: standard body weight
        
#        V1ba = 5.6,
        V1bv = 1.47,
        V1rbc = 1.7,
        V1lun = 0.22,
        V1mus = 11.5,
        V1skin = 4.95,
        V1fat = 2.59,
#        V1thy = 0.7,
        V1kid = 0.5,
#        V1pan = 1.3,
        V1spl = 0.11,
#        V1git = 11.1,
        V1liv = 1.65,
        
        #Blood flow rate in [mL/h]
        #Q1rbc = 3096,
        Q1lun = 12*60,
        Q1mus = 0.91*60,
        Q1skin = 0.41*60,
        Q1fat = 0.84*60,
        #Q1thy = 18,
        Q1kid = 1.3*60,
        #Q1pan = 31,
        Q1spl = 0.09*60,
        #Q1git = 519,
        Q1liv = 1.8*60
      )
    } else if (chosen_species == 2){ #Physiological parameters for Rats
      param(
        BW = 0.300, #BW: actual body weight in kg
        BWS=0.250, #BWS: standard body weight
        
        V1ba = 5.6,
        V1bv = 11.3,
        V1rbc = 20.3,
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
        
        #Blood flow rate in [mL/h]
        Q1rbc = 3096, 
        Q1lun = 2580,
        Q1mus = 450,
        Q1skin = 350,
        Q1fat = 24,
        Q1thy = 18,
        Q1kid = 554,
        Q1pan = 31,
        Q1spl = 38,
        Q1git = 519,
        Q1liv = 120
      )
    } else if(chosen_species == 3) { #Physiological parameters for Rabbit
      param(
        BW = 2.5, #BW: actual body weight in kg
        BWS= 2.5, #BWS: standard body weight
        
#        V1ba = 5.6,
#        V1bv = 11.3,
        V1rbc = 165,
        V1lun = 17,
        V1mus = 1350,
        V1skin = 110,
#        V1fat = 10.0,
#        V1thy = 0.7,
        V1kid = 15,
#        V1pan = 1.3,
        V1spl = 1,
#        V1git = 11.1,
        V1liv = 100,
        
        #Blood flow rate in [mL/h]
        #Q1rbc = 3096,
        Q1lun = 2580,
        Q1mus = 155*60,
#        Q1skin = 350,
        #Q1fat = 24,
        #Q1thy = 18,
        Q1kid = 80*60,
        #Q1pan = 31,
        Q1spl = 9*60,
        #Q1git = 519,
        Q1liv = 177*60
      )
    } else if(chosen_species == 4) { #Physiological parameters for Monkey
      param(
        BW = 5, #BW: actual body weight in kg
        BWS = 5, #BWS: standard body weight
        
#        V1ba = 5.6,
#        V1bv = 11.3,
        V1rbc = 367,
        #V1lun = 17,
        V1mus = 2500,
        V1skin = 500,
#        V1fat = 10.0,
#        V1thy = 0.7,
        V1kid = 30,
#        V1pan = 1.3,
        #V1spl = 1,
#        V1git = 11.1,
        V1liv = 135,
        
        #Blood flow rate in [mL/h]
        #Q1rbc = 3096,
        Q1lun = 2580,
        Q1mus = 90*60,
        Q1skin = 54*60,
        #Q1fat = 24,
        #Q1thy = 18,
        Q1kid = 138*60,
        #Q1pan = 31,
        Q1spl = 21*60,
        #Q1git = 519,
        Q1liv = 218*60
      )
    } else if(chosen_species == 5) { #Physiological parameters for Dog
      param(
        BW =10, #BW: actual body weight in kg
        BWS=10, #BWS: standard body weight
        
#        V1ba = 5.6,
#        V1bv = 11.3,
        V1rbc = 900,
        V1lun = 120,
        V1mus = 5530,
        #V1skin = 2.9,
#        V1fat = 10.0,
#        V1thy = 0.7,
        V1kid = 60,
#        V1pan = 1.3,
        V1spl = 36,
#        V1git = 11.1,
        V1liv = 480,
        
        #Blood flow rate in [mL/h]  
        #Q1rbc = 3096,
        Q1lun = 2580,
        Q1mus = 250*60,
        Q1skin = 100*60,
        #Q1fat = 24,
        #Q1thy = 18,
        Q1kid = 216*60,
        #Q1pan = 31,
        Q1spl = 25*60,
        #Q1git = 519,
        Q1liv = 309*60
      )
    } else if(chosen_species == 6) { #Physiological parameters for Human
      param(
        BW = 70, #BW: actual body weight in kg
        BWS=70, #BWS: standard body weight
        
#        V1ba = 5.6,
        V1bv = 5600,
        V1rbc = 5200,
        V1lun = 1170,
        V1mus = 35000,
        V1skin = 2600,
        V1fat = 11600,
#        V1thy = 0.7,
        V1kid = 280,
#        V1pan = 1.3,
        V1spl = 192,
#        V1git = 11.1,
        V1liv = 1690,
        
        #Blood flow rate in [mL/h]
        #Q1rbc = 3096,
        Q1lun = 336000,
        Q1mus = 750*60,
        Q1skin = 300*60,
        Q1fat = 26.2*60,
        #Q1thy = 18,
        Q1kid = 1240*60,
        #Q1pan = 31,
        Q1spl = 77*60,
        #Q1git = 519,
        Q1liv = 1450*60
      )
    }
  })
  
  # Reactive parameter value
  par <- reactive({
    param(Kabs = as.numeric(input[["Kabs"]]), CLint_liv = as.numeric(60*input[["CLint"]]), dose = as.numeric(input[["bol_dose"]]))
  })
  
  
  # Reactive event object for Bolus dosing
  e_bolus <- reactive({
    #ev(time = input[["bol_time"]], amt=floor(1000*0.3*input[["bol_dose"]]), cmt="Cba", ii=input[["bol_ii"]],addl=as.numeric(input[["bol_addl"]]))
    ev(time = input[["bol_time"]], amt=as.numeric(input[["bol_dose"]]), cmt="Cba", ii=input[["bol_ii"]],addl=as.numeric(input[["bol_addl"]]))
  })
  
  # Reactive event object for infusion dosing
  e_inf <- reactive({
    #ev(time = input[["inf_time"]], amt=floor(1000*0.3*input[["inf_dose"]]), rate=input[["inf_rate"]], cmt="Cba", ii=input[["inf_ii"]],addl=as.numeric(input[["inf_addl"]]))
    ev(time = input[["inf_time"]], amt=as.numeric(input[["inf_dose"]]), rate=input[["inf_rate"]], cmt="Cliv", ii=input[["inf_ii"]],addl=as.numeric(input[["inf_addl"]]))
  })


  # Reactive event object
  sim <- reactive({

    #Run model
    out<- mod %>%
      init(Cba=0) %>%  #Initialize compartment with first dose at time 0
      param(par())%>%
      param(species_change())%>%
      ev(e_bolus()+e_inf()) %>% #time=time of first dose, ii=dosing frequency (days), addl=additional doses
      mrgsim(end=end, delta=delta, n=n) #, set.seed(514)

    return(as.data.frame(out))
  })

  #************
  output$gmplot <-renderPlot({
    
    #Coerce simulation to R data.frame
    df <- sim()
    
    theme_set(theme_bw())
    theme_update(
      axis.title.x = element_text(face="bold", size=9, vjust=0),
      axis.title.y = element_text(face="bold",angle=90, size=9, vjust=0.25),
      axis.text.x = element_text(face="bold",size=9),
      axis.text.y = element_text(face="bold",size=9),
      plot.title = element_text(size=10))
    
    display <- input[["showme"]]
    
    if(display == "Ci=f(Cu,i)"){
      #Y1<-ggplot(data=df)+geom_line(aes(x=Cu_rbc,y=Crbc))+ylab('Concentr. Blood (ug/ml)')+xlab('[Cu_rbc] (ug/ml)')+ggtitle("RBC") + theme(legend.position="none") 
      Y2<-ggplot(data=df)+geom_line(aes(x=Cu_pan,y=Cpan))+ylab('Concentr. Pancreas (ug/ml)')+xlab('[Cu_panreas] (ug/ml)')+ggtitle("Pancreas") + theme(legend.position="none")
      Y3<-ggplot(data=df)+geom_line(aes(x=Cu_spl,y=Cspl))+ylab('Concentr. Spleen (ug/ml)')+xlab('[Cu_spleen] (ug/ml)')+ggtitle("Spleen") + theme(legend.position="none") 
      Y4<-ggplot(data=df)+geom_line(aes(x=Cu_git,y=Cgit))+ylab('Concentr. GIT (ug/ml)')+xlab('[Cu_git] (ug/ml)')+ggtitle("GIT") + theme(legend.position="none") 
      Y5<-ggplot(data=df)+geom_line(aes(x=Cu_liv,y=Cliv))+ylab('Concentr. Liver (ug/ml)')+xlab('[Cu_liver] (ug/ml)')+ggtitle("Liver")+ theme(legend.position="none") 
      Y6<-ggplot(data=df)+geom_line(aes(x=Cu_lun,y=Clun))+ylab('Concentr. Lung (ug/ml)')+xlab('[Cu_lung] (ug/ml)')+ggtitle("Lung") + theme(legend.position="none") 
      Y7<-ggplot(data=df)+geom_line(aes(x=Cu_mus,y=Cmus))+ylab('Concentr. Muscle (ug/ml)')+xlab('[Cu_muscle] (ug/ml)')+ggtitle("Muscle") + theme(legend.position="none") 
      Y8<-ggplot(data=df)+geom_line(aes(x=Cu_skin,y=Cskin))+ylab('Concentr. Skin (ug/ml)')+xlab('[Cu_skin] (ug/ml)')+ggtitle("Skin") + theme(legend.position="none") 
      Y9<-ggplot(data=df)+geom_line(aes(x=Cu_fat,y=Cfat))+ylab('Concentr. Fat (ug/ml)')+xlab('[Cu_fat] (ug/ml)')+ggtitle("Fat") + theme(legend.position="none") 
      Y10<-ggplot(data=df)+geom_line(aes(x=Cu_thy,y=Cthy))+ylab('Concentr. Thymus (ug/ml)')+xlab('[Cu_thymus] (ug/ml)')+ggtitle("Thymus") + theme(legend.position="none") 
      Y11<-ggplot(data=df)+geom_line(aes(x=Cu_kid,y=Ckid))+ylab('Concentr. Kidney (ug/ml)')+xlab('[Cu_kidney] (ug/ml)')+ggtitle("Kidney") + theme(legend.position="none") 
      
      #grid.arrange(Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9,Y10,Y11, ncol=3)
      grid.arrange(Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9,Y10,Y11, ncol=3)
    }
    else if(display == "(Ci/CBv)=f(CBv)"){
      #Y12<-ggplot(data=df)+geom_line(aes(x=Cbv,y=CrbcToCbv))+ylab('Tissue/Blood conc ratio')+xlab('Venous blood concentr (ug/ml)')+ggtitle("RBC") + theme(legend.position="none") 
      Y13<-ggplot(data=df)+geom_line(aes(x=Cbv,y=CpanToCbv))+ylab('Tissue/Blood conc ratio')+xlab('Venous blood concentr (ug/ml)')+ggtitle("Pancreas") + theme(legend.position="none")
      Y14<-ggplot(data=df)+geom_line(aes(x=Cbv,y=CsplToCbv))+ylab('Tissue/Blood conc ratio')+xlab('Venous blood concentr (ug/ml)')+ggtitle("Spleen") + theme(legend.position="none") 
      Y15<-ggplot(data=df)+geom_line(aes(x=Cbv,y=CgitToCbv))+ylab('Tissue/Blood conc ratio')+xlab('Venous blood concentr (ug/ml)')+ggtitle("GIT") + theme(legend.position="none") 
      Y16<-ggplot(data=df)+geom_line(aes(x=Cbv,y=ClunToCbv))+ylab('Tissue/Blood conc ratio')+xlab('Venous blood concentr (ug/ml)')+ggtitle("Lung") + theme(legend.position="none") 
      Y17<-ggplot(data=df)+geom_line(aes(x=Cbv,y=CmusToCbv))+ylab('Tissue/Blood conc ratio')+xlab('Venous blood concentr (ug/ml)')+ggtitle("Muscle") + theme(legend.position="none") 
      Y18<-ggplot(data=df)+geom_line(aes(x=Cbv,y=CskinToCbv))+ylab('Tissue/Blood conc ratio')+xlab('Venous blood concentr (ug/ml)')+ggtitle("Skin") + theme(legend.position="none") 
      Y19<-ggplot(data=df)+geom_line(aes(x=Cbv,y=CfatToCbv))+ylab('Tissue/Blood conc ratio')+xlab('Venous blood concentr (ug/ml)')+ggtitle("Fat") + theme(legend.position="none") 
      Y20<-ggplot(data=df)+geom_line(aes(x=Cbv,y=CthyToCbv))+ylab('Tissue/Blood conc ratio')+xlab('Venous blood concentr (ug/ml)')+ggtitle("Thymus") + theme(legend.position="none") 
      Y21<-ggplot(data=df)+geom_line(aes(x=Cbv,y=CkidToCbv))+ylab('Tissue/Blood conc ratio')+xlab('Venous blood concentr (ug/ml)')+ggtitle("Kidney") + theme(legend.position="none") 
      Y22<-ggplot(data=df)+geom_line(aes(x=Cbv,y=ClivToCbv))+ylab('Tissue/Blood conc ratio')+xlab('Venous blood concentr (ug/ml)')+ggtitle("Liver")+ theme(legend.position="none") 
      
      #grid.arrange(Y12,Y13,Y14,Y15,Y16,Y17,Y18,Y19,Y20,Y21,Y22, ncol=3)
      grid.arrange(Y13,Y14,Y15,Y16,Y17,Y18,Y19,Y20,Y21,Y22, ncol=3)
    }
    else if(display == "Ci=f(t)"){
      Y23<-ggplot(data=df)+geom_line(aes(x=time,y=Cspl))+ylab('Concentr. Spleen (ug/ml)')+xlab('time (hr)')+ggtitle("Spleen") + theme(legend.position="none") 
      #Y24<-ggplot(data=df)+geom_line(aes(x=time,y=Cgit))+ylab('Concentr. GIT (ug/ml)')+xlab('time (hr)')+ggtitle("GIT") + theme(legend.position="none") 
      Y25<-ggplot(data=df)+geom_line(aes(x=time,y=Cliv))+ylab('Concentr. Liver (ug/ml)')+xlab('time (hr)')+ggtitle("Liver")+ theme(legend.position="none") 
      Y26<-ggplot(data=df)+geom_line(aes(x=time,y=Clun))+ylab('Concentr. Lung (ug/ml)')+xlab('time (hr)')+ggtitle("Lung") + theme(legend.position="none") 
      Y27<-ggplot(data=df)+geom_line(aes(x=time,y=Cmus))+ylab('Concentr. Muscle (ug/ml)')+xlab('time (hr)')+ggtitle("Muscle") + theme(legend.position="none") 
      Y28<-ggplot(data=df)+geom_line(aes(x=time,y=Cskin))+ylab('Concentr. Skin (ug/ml)')+xlab('time (hr)')+ggtitle("Skin") + theme(legend.position="none") 
      Y29<-ggplot(data=df)+geom_line(aes(x=time,y=Cfat))+ylab('Concentr. Fat (ug/ml)')+xlab('time (hr)')+ggtitle("Fat") + theme(legend.position="none") 
      Y30<-ggplot(data=df)+geom_line(aes(x=time,y=Cthy))+ylab('Concentr. Thymus (ug/ml)')+xlab('time (hr)')+ggtitle("Thymus") + theme(legend.position="none") 
      Y31<-ggplot(data=df)+geom_line(aes(x=time,y=Ckid))+ylab('Concentr. Kidney (ug/ml)')+xlab('time (hr)')+ggtitle("Kidney") + theme(legend.position="none") 
      #Y32<-ggplot(data=df)+geom_line(aes(x=time,y=Crbc))+ylab('Concentr. Blood (ug/ml)')+xlab('time (hr)')+ggtitle("RBC") + theme(legend.position="none") 
      Y33<-ggplot(data=df)+geom_line(aes(x=time,y=Cpan))+ylab('Concentr. Pancreas (ug/ml)')+xlab('time (hr)')+ggtitle("Pancreas") + theme(legend.position="none")
      
      Y34<-ggplot(data=df)+geom_line(aes(x=time,y=Cba))+ylab('CBA (ug/ml)')+xlab('time (hr)')+ggtitle("Concentration in Arterial Blood") + theme(legend.position="none") 
      Y35<-ggplot(data=df)+geom_line(aes(x=time,y=Cbv))+ylab('CBV (ug/ml)')+xlab('time (hr)')+ggtitle("Concentration in Venous Blood") + theme(legend.position="none")
      
      #grid.arrange(Y34,Y35,Y32,Y33,Y23,Y24,Y25,Y26,Y27,Y28,Y29,Y30,Y31, ncol=3)
      grid.arrange(Y34,Y35,Y33,Y23,Y25,Y26,Y27,Y28,Y29,Y30,Y31, ncol=3)
    }
    else if(display == "Drug Abs & Rem"){
      Y36<-ggplot(data=df)+geom_line(aes(x=time,y=Adum))+ylab('Concentration (ug/ml)')+xlab('time (hr)')+ggtitle("Amount of drug at administration sites") + theme(legend.position="none")
      Y37<-ggplot(data=df)+geom_line(aes(x=time,y=Pdrm))+ylab('Concentration (ug/ml)')+xlab('time (hr)')+ggtitle("Fraction of drug remaining in the body") + theme(legend.position="none")
      
      grid.arrange(Y36, Y37, ncol=1)
    }

  }, width="auto", height=800)
  observeEvent(input$SelectAnimal, ({
    updateCollapse(session, "collapseExample", style = list("Panel 1" = input$SelectSpecies))
  }))
  
})
