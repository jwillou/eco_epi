setwd("/Users/jannawilloughby/GDrive/Willoughby lab/eco-epi reivew/eco epi analysis/eco_epi/")
data = read.table("supplementary table 2.csv", header=T, sep=",")
#note: for studies with duplicated rows, remove duplicated info prior to analysis to avoid double counts!

#unique studies
length(unique(data$Reference.number))

#####studies that...
####1.used particular epi technique####
table(data$epigenetic.methods.condensed)
#some used multiple methods so generate full list
ll = table(data$epigenetic.methods.condensed)
n  = names(ll)[2:length(ll)]
comp.list = NULL
for(nn in 1:length(n)){
  names.list = strsplit(n[nn], ";")[[1]]
  for(r in 1:length(names.list)){
    comp.list=c(comp.list, rep(names.list[r], ll[nn+1]))
  }
}
table(comp.list)
length(unique(data$Reference.number))


####2.compared epi with nuclear data####
table(data$compare.nuclear.with.epi.variation)
table(data$nuclear.marker[data$compare.nuclear.with.epi.variation=="y" & data$nuclear.epi.relationship!="correlated_env_trait"])
table(data$nuclear.epi.relationship.code[data$compare.nuclear.with.epi.variation=="y"])
sum(table(data$nuclear.epi.relationship.code[data$compare.nuclear.with.epi.variation=="y"]))

####3.had some focus or discussion on adaptation####
table(data$adaptation)
table(data$fittness.or.trait.for.adaptation)
table(data$adaptation.epi.related.[data$adaptation=="y"])

#4.compared multiple environments or conditions <- DID WE USE THIS? NOT IN ADAPTATION SECTION
table(data$comp.envs)

####5.considered heritability####
table(data$heritability)

####6.included a host/parasite/disease component####
table(data$host.parasite.disease)

####7.including aging considerations####
table(data$age)
table(data$ageconclusion)

####species/study site location breakdown
##taxonomy:
####1.number of different species and over represented species####
length(unique(data$Genus.species))
table(data$Genus.species)[table(data$Genus.species)>=5]

####2.taxonomic diversity####
sp = unique(data$Genus.species)
length(sp)
tt = NULL
for(s in 1:length(sp)){
  t = data[data$Genus.species==as.character(sp[s]),,drop=F]
  tt = rbind(tt, t[1,1:10])
}
table(tt$Kingdom, tt$Phylum.clade)
table(tt$Kingdom)
table(tt$Phylum.clade)/sum(table(tt$Phylum.clade))
table(tt$Order[tt$Kingdom=="Animalia"], tt$Phylum.clade[tt$Kingdom=="Animalia"])
table(tt$Order[tt$Kingdom=="Fungi"], tt$Phylum.clade[tt$Kingdom=="Fungi"])
table(tt$Order[tt$Kingdom=="Plantae"], tt$Phylum.clade[tt$Kingdom=="Plantae"])

table(tt$Order[tt$Phylum.clade=="Chordata"])

####3.conservation concern species####
table(tt$IUCNglobal)
sum(table(tt$IUCNglobal)[!names(table(tt$IUCNglobal))==""])

####4.focal location####
table(data$continent_ocean)
#some are combined so generate complete list
ll = table(data$continent_ocean)
n  = names(ll)[2:length(ll)]
comp.list = NULL
for(nn in 1:length(n)){
  names.list = strsplit(n[nn], ";")[[1]]
  for(r in 1:length(names.list)){
    comp.list=c(comp.list, rep(names.list[r], ll[nn+1]))
  }
}
table(comp.list)
sum(table(comp.list))
table(comp.list)[names(table(comp.list))=="Europe"]/sum(table(comp.list))
table(comp.list)[names(table(comp.list))=="North America"]/sum(table(comp.list))
1-(table(comp.list)[names(table(comp.list))=="Europe"]/sum(table(comp.list))+table(comp.list)[names(table(comp.list))=="North America"]/sum(table(comp.list)))
