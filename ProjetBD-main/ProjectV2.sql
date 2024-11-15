-- *********************************************
-- * SQL MySQL generation                      
-- *--------------------------------------------
-- * DB-MAIN version: 11.0.2              
-- * Generator date: Sep 14 2021              
-- * Generation date: Tue May  9 14:41:13 2023 
-- * LUN file: C:\Users\desti\Documents\Unif\BAC2\BD2\Projet\BASE_DONNEE_FINAL.lun 
-- * Schema: physique/1-2 
-- ********************************************* 


-- Database Section
-- ________________ 

create database physique;
use physique;


-- Tables Section
-- _____________ 

create table ARTICLE (
     NOM char(30) not null,
     PRIX float(5) not null,
     DESCRIPTION varchar(40) not null,
     NOURRITURE char(30),
     BOISSON char(30),
     constraint ID_ARTICLE_ID primary key (NOM));

create table AUTRE_DEPENSE (
     ID_DEPENSE bigint not null auto_increment,
     DATE_DEPENSE date not null,
     MONTANT_DEPENSE float(30),
     DESCRIPTION varchar(80) not null,
     STATUT_DEPENSE char,
     ID_TIERS int not null,
     constraint ID_AUTRE_DEPENSE_ID primary key (ID_DEPENSE));

create table BAR (
     ID_TIERS int not null,
     STATUT_ char(20) not null,
     constraint FKPER_BAR_ID primary key (ID_TIERS));

create table BOISSON (
     NOM char(30) not null,
     constraint FKART_BOI_ID primary key (NOM));

create table BON_COMMANDE (
     ID_COMMANDE int not null auto_increment,
     QTE float(8) not null,
     STATUT char not null,
     DATE date not null,
     constraint ID_BON_COMMANDE_ID primary key (ID_COMMANDE));

create table BON_LIVRAISON (
     ID_BON_LIV int not null auto_increment,
     QTE float(10) not null,
     DATE date not null,
     ID_FACTURE bigint not null,
     ID_COMMANDE int not null,
     constraint ID_BON_LIVRAISON_ID primary key (ID_BON_LIV));

create table commande (
     ID_COMMANDE int not null,
     ID_TIERS int not null,
     C_R_ID_TIERS int not null,
     constraint FKcom_BON_ID primary key (ID_COMMANDE));

create table concerne (
     ID_COMMANDE int not null,
     ID_BON_LIV int not null,
     ID_PRODUIT int not null,
     constraint ID_concerne_ID primary key (ID_BON_LIV, ID_PRODUIT, ID_COMMANDE));

create table CONGE (
     ID_TIERS int not null,
     DATE_DEBUT date not null,
     NOMBRE_JOUR int not null,
     TYPE char(20) not null,
     constraint ID_CONGE_ID primary key (DATE_DEBUT, ID_TIERS));

create table CONTRAT (
     ID_CONTRAT int not null auto_increment,
     DATE_DEBUT char(1) not null,
     DATE_FIN char(1) not null,
     TYPE char(1) not null,
     ID_TIERS int not null,
     constraint ID_CONTRAT_ID primary key (ID_CONTRAT));

create table CUISINE (
     ID_TIERS int not null,
     STATUT_ char(20) not null,
     constraint FKPER_CUI_ID primary key (ID_TIERS));

create table DESSERT (
     NOM char(30) not null,
     constraint FKNOU_DES_ID primary key (NOM));

create table ENTREE (
     NOM char(30) not null,
     constraint FKNOU_ENT_ID primary key (NOM));

create table etre_capable (
     DATE_DEBUT date not null,
     ID_TIERS int not null,
     NUM_FICHE_SALAIRE varchar(25) not null,
     constraint ID_etre_capable_ID primary key (DATE_DEBUT, ID_TIERS, NUM_FICHE_SALAIRE));

create table FACTURE (
     ID_FACTURE bigint not null auto_increment,
     DATE date not null,
     MONTANT float(20) not null,
     ID_TIERS int not null,
     constraint ID_FACTURE_ID primary key (ID_FACTURE));

create table FICHE_SALAIRE (
     NUM_FICHE_SALAIRE varchar(25) not null,
     PER_DATE_DEBUT date not null,
     PER_DATE_FIN date not null,
     TAXE float(10) not null,
     PRIME float(10) not null,
     DEDUCTION_PRIME float(10) not null,
     TARIF_HORAIRE float(20) not null,
     ID_TIERS int not null,
     constraint ID_FICHE_SALAIRE_ID primary key (NUM_FICHE_SALAIRE));

create table FOURNISSEUR (
     ID_TIERS int not null,
     NOM_ETABLISSEMENT varchar(25) not null,
     constraint FKPER_FOU_ID primary key (ID_TIERS));

create table HEURE_TRAVAIL (
     DATE date not null,
     ID_TIERS int not null,
     HEURE_DEBUT date not null,
     NOMBRE_HEURE_TRAVAILLER float(5) not null,
     NUM_FICHE_SALAIRE varchar(25) not null,
     constraint SID_HEURE_TRAVAIL_ID unique (DATE, ID_TIERS));

create table NOURRITURE (
     NOM char(30) not null,
     PLAT char(30),
     ENTREE char(30),
     DESSERT char(30),
     constraint FKART_NOU_ID primary key (NOM));

create table PERSONNE (
     ID_TIERS int not null auto_increment,
     NOM char(25) not null,
     PRENOM char(25) not null,
     DATE_NAISSANCE date not null,
     EMAIL varchar(35) not null,
     SEXE_ char(8) not null,
     PERSONNEL int,
     FOURNISSEUR int,
     constraint ID_PERSONNE_ID primary key (ID_TIERS));

create table PERSONNEL (
     ID_TIERS int not null,
     NUM_SECURITE_SOCIALE varchar(25),
     IND_NOM_ENTREPRISE varchar(25),
     IND_NUM_ENTREPRISE varchar(25),
     CUISINE int,
     BAR int,
     SALLE int,
     RESPONSABLE int,
     Dir_ID_TIERS int,
     constraint FKPER_PER_ID primary key (ID_TIERS));

create table peut_contenir_ (
     ID_RESERVATION int not null,
     ID_RECU int not null,
     NOM char(30) not null,
     constraint FKpeu_RES_ID primary key (ID_RESERVATION),
     constraint FKpeu_REC_ID unique (ID_RECU));

create table PLAT (
     NOM char(30) not null,
     constraint FKNOU_PLA_ID primary key (NOM));

create table PRODUIT (
     ID_PRODUIT int not null auto_increment,
     NOM char(25) not null,
     MARQUE char(25) not null,
     QTE float(5) not null,
     PRIX float(9) not null,
     TYPE varchar(25) not null,
     ID_STOCK varchar(20) not null,
     constraint ID_PRODUIT_ID primary key (ID_PRODUIT));

create table propose (
     ID_TIERS int not null,
     ID_PRODUIT int not null,
     constraint ID_propose_ID primary key (ID_PRODUIT, ID_TIERS));

create table RECU_PAIMENT (
     ID_RECU int not null auto_increment,
     DATE date not null,
     HEURE_RECU char(1) not null,
     TVA float(5) not null,
     constraint ID_RECU_PAIMENT_ID primary key (ID_RECU));

create table RESERVATION (
     ID_RESERVATION int not null auto_increment,
     DATE date not null,
     NOM_PERSONNE char(20) not null,
     NUM_TEL bigint not null,
     NOMBRE_PERSONNE int not null,
     ENFANT int not null,
     ANIMAUX int not null,
     HEURE_ARRIVE date not null,
     ANNIVERSAIRE char not null,
     ID_TIERS int not null,
     constraint ID_RESERVATION_ID primary key (ID_RESERVATION));

create table RESPONSABLE (
     ID_TIERS int not null,
     constraint FKPER_RES_ID primary key (ID_TIERS));

create table SALLE (
     ID_TIERS int not null,
     STATUT char(20) not null,
     constraint FKPER_SAL_ID primary key (ID_TIERS));

create table se_compose_de (
     NOM char(30) not null,
     ID_PRODUIT int not null,
     constraint ID_se_compose_de_ID primary key (ID_PRODUIT, NOM));

create table STOCK (
     ID_STOCK varchar(20) not null,
     ID_TIERS int not null,
     constraint ID_STOCK_ID primary key (ID_STOCK));


-- Constraints Section
-- ___________________ 

-- Not implemented
-- alter table ARTICLE add constraint ID_ARTICLE_CHK
--     check(exists(select * from se_compose_de
--                  where se_compose_de.NOM = NOM)); 

alter table ARTICLE add constraint EXTONE_ARTICLE
     check((NOURRITURE is not null and BOISSON is null)
           or (NOURRITURE is null and BOISSON is not null)); 

alter table AUTRE_DEPENSE add constraint COEX_AUTRE_DEPENSE
     check((MONTANT_DEPENSE is not null and STATUT_DEPENSE is not null)
           or (MONTANT_DEPENSE is null and STATUT_DEPENSE is null)); 

alter table AUTRE_DEPENSE add constraint FKgerer_FK
     foreign key (ID_TIERS)
     references RESPONSABLE (ID_TIERS);

alter table BAR add constraint FKPER_BAR_FK
     foreign key (ID_TIERS)
     references PERSONNEL (ID_TIERS);

alter table BOISSON add constraint FKART_BOI_FK
     foreign key (NOM)
     references ARTICLE (NOM);

-- Not implemented
-- alter table BON_COMMANDE add constraint ID_BON_COMMANDE_CHK
--     check(exists(select * from commande
--                  where commande.ID_COMMANDE = ID_COMMANDE)); 

-- Not implemented
-- alter table BON_COMMANDE add constraint ID_BON_COMMANDE_CHK
--     check(exists(select * from concerne
--                  where concerne.ID_COMMANDE = ID_COMMANDE)); 

-- Not implemented
-- alter table BON_COMMANDE add constraint ID_BON_COMMANDE_CHK
--     check(exists(select * from BON_LIVRAISON
--                  where BON_LIVRAISON.ID_COMMANDE = ID_COMMANDE)); 

alter table BON_LIVRAISON add constraint FKpour_FK
     foreign key (ID_FACTURE)
     references FACTURE (ID_FACTURE);

alter table BON_LIVRAISON add constraint FKlivrer_FK
     foreign key (ID_COMMANDE)
     references BON_COMMANDE (ID_COMMANDE);

alter table commande add constraint FKcom_FOU_FK
     foreign key (ID_TIERS)
     references FOURNISSEUR (ID_TIERS);

alter table commande add constraint FKcom_BON_FK
     foreign key (ID_COMMANDE)
     references BON_COMMANDE (ID_COMMANDE);

alter table commande add constraint FKcom_RES_FK
     foreign key (C_R_ID_TIERS)
     references RESPONSABLE (ID_TIERS);

alter table concerne add constraint FKcon_PRO_FK
     foreign key (ID_PRODUIT)
     references PRODUIT (ID_PRODUIT);

alter table concerne add constraint FKcon_BON_1
     foreign key (ID_BON_LIV)
     references BON_LIVRAISON (ID_BON_LIV);

alter table concerne add constraint FKcon_BON_FK
     foreign key (ID_COMMANDE)
     references BON_COMMANDE (ID_COMMANDE);

alter table CONGE add constraint FKdroit_FK
     foreign key (ID_TIERS)
     references PERSONNEL (ID_TIERS);

alter table CONTRAT add constraint FKappartient_FK
     foreign key (ID_TIERS)
     references PERSONNEL (ID_TIERS);

alter table CUISINE add constraint FKPER_CUI_FK
     foreign key (ID_TIERS)
     references PERSONNEL (ID_TIERS);

alter table DESSERT add constraint FKNOU_DES_FK
     foreign key (NOM)
     references NOURRITURE (NOM);

alter table ENTREE add constraint FKNOU_ENT_FK
     foreign key (NOM)
     references NOURRITURE (NOM);

alter table etre_capable add constraint FKetr_FIC_FK
     foreign key (NUM_FICHE_SALAIRE)
     references FICHE_SALAIRE (NUM_FICHE_SALAIRE);

alter table etre_capable add constraint FKetr_CON
     foreign key (DATE_DEBUT, ID_TIERS)
     references CONGE (DATE_DEBUT, ID_TIERS);

-- Not implemented
-- alter table FACTURE add constraint ID_FACTURE_CHK
--     check(exists(select * from BON_LIVRAISON
--                  where BON_LIVRAISON.ID_FACTURE = ID_FACTURE)); 

alter table FACTURE add constraint FKetablir_FK
     foreign key (ID_TIERS)
     references FOURNISSEUR (ID_TIERS);

alter table FICHE_SALAIRE add constraint FKpeut_avoir_FK
     foreign key (ID_TIERS)
     references PERSONNEL (ID_TIERS);

alter table FOURNISSEUR add constraint FKPER_FOU_FK
     foreign key (ID_TIERS)
     references PERSONNE (ID_TIERS);

alter table HEURE_TRAVAIL add constraint FKengendrer_FK
     foreign key (NUM_FICHE_SALAIRE)
     references FICHE_SALAIRE (NUM_FICHE_SALAIRE);

alter table HEURE_TRAVAIL add constraint FKtravailler_FK
     foreign key (ID_TIERS)
     references PERSONNEL (ID_TIERS);

alter table NOURRITURE add constraint EXTONE_NOURRITURE
     check((DESSERT is not null and ENTREE is null and PLAT is null)
           or (DESSERT is null and ENTREE is not null and PLAT is null)
           or (DESSERT is null and ENTREE is null and PLAT is not null)); 

alter table NOURRITURE add constraint FKART_NOU_FK
     foreign key (NOM)
     references ARTICLE (NOM);

alter table PERSONNE add constraint EXTONE_PERSONNE
     check((PERSONNEL is not null and FOURNISSEUR is null)
           or (PERSONNEL is null and FOURNISSEUR is not null)); 

alter table PERSONNEL add constraint EXTONE_PERSONNEL_1
     check((NUM_SECURITE_SOCIALE is not null and IND_NOM_ENTREPRISE is null and IND_NUM_ENTREPRISE is null)
           or (NUM_SECURITE_SOCIALE is null and IND_NOM_ENTREPRISE is not null and IND_NUM_ENTREPRISE is null)
           or (NUM_SECURITE_SOCIALE is null and IND_NOM_ENTREPRISE is null and IND_NUM_ENTREPRISE is not null)); 

alter table PERSONNEL add constraint EXTONE_PERSONNEL
     check((RESPONSABLE is not null and CUISINE is null and BAR is null and SALLE is null)
           or (RESPONSABLE is null and CUISINE is not null and BAR is null and SALLE is null)
           or (RESPONSABLE is null and CUISINE is null and BAR is not null and SALLE is null)
           or (RESPONSABLE is null and CUISINE is null and BAR is null and SALLE is not null)); 

alter table PERSONNEL add constraint COEX_PERSONNEL
     check((IND_NOM_ENTREPRISE is not null and IND_NUM_ENTREPRISE is not null)
           or (IND_NOM_ENTREPRISE is null and IND_NUM_ENTREPRISE is null)); 

alter table PERSONNEL add constraint FKPER_PER_FK
     foreign key (ID_TIERS)
     references PERSONNE (ID_TIERS);

alter table PERSONNEL add constraint FKdiriger_FK
     foreign key (Dir_ID_TIERS)
     references RESPONSABLE (ID_TIERS);

alter table peut_contenir_ add constraint FKpeu_RES_FK
     foreign key (ID_RESERVATION)
     references RESERVATION (ID_RESERVATION);

alter table peut_contenir_ add constraint FKpeu_REC_FK
     foreign key (ID_RECU)
     references RECU_PAIMENT (ID_RECU);

alter table peut_contenir_ add constraint FKpeu_ART_FK
     foreign key (NOM)
     references ARTICLE (NOM);

alter table PLAT add constraint FKNOU_PLA_FK
     foreign key (NOM)
     references NOURRITURE (NOM);

alter table PRODUIT add constraint FKcontient_FK
     foreign key (ID_STOCK)
     references STOCK (ID_STOCK);

alter table propose add constraint FKpro_PRO
     foreign key (ID_PRODUIT)
     references PRODUIT (ID_PRODUIT);

alter table propose add constraint FKpro_FOU_FK
     foreign key (ID_TIERS)
     references FOURNISSEUR (ID_TIERS);

-- Not implemented
-- alter table RECU_PAIMENT add constraint ID_RECU_PAIMENT_CHK
--     check(exists(select * from peut_contenir_
--                  where peut_contenir_.ID_RECU = ID_RECU)); 

-- Not implemented
-- alter table RESERVATION add constraint ID_RESERVATION_CHK
--     check(exists(select * from peut_contenir_
--                  where peut_contenir_.ID_RESERVATION = ID_RESERVATION)); 

alter table RESERVATION add constraint FKmanager_FK
     foreign key (ID_TIERS)
     references RESPONSABLE (ID_TIERS);

-- Not implemented
-- alter table RESPONSABLE add constraint FKPER_RES_CHK
--     check(exists(select * from AUTRE_DEPENSE
--                  where AUTRE_DEPENSE.ID_TIERS = ID_TIERS)); 

alter table RESPONSABLE add constraint FKPER_RES_FK
     foreign key (ID_TIERS)
     references PERSONNEL (ID_TIERS);

alter table SALLE add constraint FKPER_SAL_FK
     foreign key (ID_TIERS)
     references PERSONNEL (ID_TIERS);

alter table se_compose_de add constraint FKse__PRO
     foreign key (ID_PRODUIT)
     references PRODUIT (ID_PRODUIT);

alter table se_compose_de add constraint FKse__ART_FK
     foreign key (NOM)
     references ARTICLE (NOM);

alter table STOCK add constraint FKsuperviser_FK
     foreign key (ID_TIERS)
     references RESPONSABLE (ID_TIERS);


-- Index Section
-- _____________ 

create unique index ID_ARTICLE_IND
     on ARTICLE (NOM);

create unique index ID_AUTRE_DEPENSE_IND
     on AUTRE_DEPENSE (ID_DEPENSE);

create index FKgerer_IND
     on AUTRE_DEPENSE (ID_TIERS);

create unique index FKPER_BAR_IND
     on BAR (ID_TIERS);

create unique index FKART_BOI_IND
     on BOISSON (NOM);

create unique index ID_BON_COMMANDE_IND
     on BON_COMMANDE (ID_COMMANDE);

create unique index ID_BON_LIVRAISON_IND
     on BON_LIVRAISON (ID_BON_LIV);

create index FKpour_IND
     on BON_LIVRAISON (ID_FACTURE);

create index FKlivrer_IND
     on BON_LIVRAISON (ID_COMMANDE);

create index FKcom_FOU_IND
     on commande (ID_TIERS);

create unique index FKcom_BON_IND
     on commande (ID_COMMANDE);

create index FKcom_RES_IND
     on commande (C_R_ID_TIERS);

create unique index ID_concerne_IND
     on concerne (ID_BON_LIV, ID_PRODUIT, ID_COMMANDE);

create index FKcon_PRO_IND
     on concerne (ID_PRODUIT);

create index FKcon_BON_IND
     on concerne (ID_COMMANDE);

create unique index ID_CONGE_IND
     on CONGE (DATE_DEBUT, ID_TIERS);

create index FKdroit_IND
     on CONGE (ID_TIERS);

create unique index ID_CONTRAT_IND
     on CONTRAT (ID_CONTRAT);

create index FKappartient_IND
     on CONTRAT (ID_TIERS);

create unique index FKPER_CUI_IND
     on CUISINE (ID_TIERS);

create unique index FKNOU_DES_IND
     on DESSERT (NOM);

create unique index FKNOU_ENT_IND
     on ENTREE (NOM);

create unique index ID_etre_capable_IND
     on etre_capable (DATE_DEBUT, ID_TIERS, NUM_FICHE_SALAIRE);

create index FKetr_FIC_IND
     on etre_capable (NUM_FICHE_SALAIRE);

create unique index ID_FACTURE_IND
     on FACTURE (ID_FACTURE);

create index FKetablir_IND
     on FACTURE (ID_TIERS);

create unique index ID_FICHE_SALAIRE_IND
     on FICHE_SALAIRE (NUM_FICHE_SALAIRE);

create index FKpeut_avoir_IND
     on FICHE_SALAIRE (ID_TIERS);

create unique index FKPER_FOU_IND
     on FOURNISSEUR (ID_TIERS);

create unique index SID_HEURE_TRAVAIL_IND
     on HEURE_TRAVAIL (DATE, ID_TIERS);

create index FKengendrer_IND
     on HEURE_TRAVAIL (NUM_FICHE_SALAIRE);

create index FKtravailler_IND
     on HEURE_TRAVAIL (ID_TIERS);

create unique index FKART_NOU_IND
     on NOURRITURE (NOM);

create unique index ID_PERSONNE_IND
     on PERSONNE (ID_TIERS);

create unique index FKPER_PER_IND
     on PERSONNEL (ID_TIERS);

create index FKdiriger_IND
     on PERSONNEL (Dir_ID_TIERS);

create unique index FKpeu_RES_IND
     on peut_contenir_ (ID_RESERVATION);

create unique index FKpeu_REC_IND
     on peut_contenir_ (ID_RECU);

create index FKpeu_ART_IND
     on peut_contenir_ (NOM);

create unique index FKNOU_PLA_IND
     on PLAT (NOM);

create unique index ID_PRODUIT_IND
     on PRODUIT (ID_PRODUIT);

create index FKcontient_IND
     on PRODUIT (ID_STOCK);

create unique index ID_propose_IND
     on propose (ID_PRODUIT, ID_TIERS);

create index FKpro_FOU_IND
     on propose (ID_TIERS);

create unique index ID_RECU_PAIMENT_IND
     on RECU_PAIMENT (ID_RECU);

create unique index ID_RESERVATION_IND
     on RESERVATION (ID_RESERVATION);

create index FKmanager_IND
     on RESERVATION (ID_TIERS);

create unique index FKPER_RES_IND
     on RESPONSABLE (ID_TIERS);

create unique index FKPER_SAL_IND
     on SALLE (ID_TIERS);

create unique index ID_se_compose_de_IND
     on se_compose_de (ID_PRODUIT, NOM);

create index FKse__ART_IND
     on se_compose_de (NOM);

create unique index ID_STOCK_IND
     on STOCK (ID_STOCK);

create index FKsuperviser_IND
     on STOCK (ID_TIERS);


DELIMITER $$

CREATE VIEW Comptabilite as
SELECT( FS.PER_DATE_DEBUT as DATE, ((SELECT( HT.NOMBRE_HEURE_TRAVAILLER from HEURE_TRAVAIL HT where HT.NUM_FICHE_SALAIRE = FS.NUM_FICHE_SALAIRE) * FS.TARIF_HORAIRE - FS.TAXE + (FS.PRIME- FS.DEDUCTION_PRIME))*-1)  as MONTANT, 'SALAIRE' as TYPE from FICHE_SALAIRE FS)
UNION
SELECT( AD.DATE_DEPENSE as DATE, AD.MONTANT_DEPENSE*-1 as MONTANT, 'AUTRE DEPENSE' as TYPE from AUTRE_DEPENSE AD)
UNION
SELECT( FT.DATE as DATE, FT.MONTANT*-1 as MONTANT, 'FACTURE' as TYPE from FACTURE FT)
UNION
SELECT( RP.DATE as DATE, SUM(AT.PRIX from ARTICLE AT where( AT.NOM = PC.NOM from peut_contenir_ PC WHERE(PC.ID_RECU = RP.ID_RECU))) as MONTANT, 'RECU' as TYPE from RECU_PAIMENT RP)
$$

DELIMITER ;

DELIMITER $$

CREATE VIEW STOCK_DE_PRODUIT as
     SELECT(P.NOM as NOM, P.ID_PRODUIT as IDENTIFIANT, P.QTE as QUANTITE, (SUM(BC.QTE from BON_COMMANDE BC where(BC.ID_BON_COMMANDE = CC.ID_COMMANDE from concerne CC where( CC.ID_PRODUIT = P.ID_PRODUIT)))- SUM(BL.QTE from BON_LIVRAISON BL WHERE(BL.ID_BON_LIV = CC.ID_BON_LIV WHERE( CC.ID_PRODUIT = P.ID_PRODUIT)))) as QUANTITE_EN_APPROCHE, P.PRIX as PRIX, P.ID_STOCK as EMPLACEMENT from PRODUIT P)
$$

DELIMITER ;

DELIMITER $$


CREATE VIEW PERSONNEL_ACTIF as 
SELECT (p.ID_TIERS AS IDENTIFIANT , p.NOM as nom , p.EMAIL as email )
IF PE.CUISINE = 1
THEN select('CUISINE' as JOB)
IF PE.BAR = 1
THEN select('BAR' as JOB)
IF PE.SALLE = 1
THEN select('SALLE' as JOB)
IF PE.RESPONSABLE = 1
THEN select('RESPONSABLE' as JOB)
FROM PERSONNE P , PERSONNEL pe , CONTRAT C 
WHERE p.ID_TIERS = pe.ID_TIERS and pe.ID_TIERS = C.ID_TIERS 

$$

DELIMITER ;
















from FICHE_SALAIRE FS, FACTURE  F,AUTRE_DEPENSE AD 

SELECT 
