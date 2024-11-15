-- *********************************************
-- * SQL MySQL generation                      
-- *--------------------------------------------
-- * DB-MAIN version: 11.0.2              
-- * Generator date: Sep 14 2021              
-- * Generation date: Fri May 19 17:24:43 2023 
-- * LUN file: C:\Users\Liam\Downloads\BASE_DONNEE_FINAL.lun 
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
     check((IND_NUM_ENTREPRISE is not null and NUM_SECURITE_SOCIALE is null)
           or (IND_NUM_ENTREPRISE is null and NUM_SECURITE_SOCIALE is not null)); 

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
SELECT FS.PER_DATE_DEBUT as DATE, ((SELECT HT.NOMBRE_HEURE_TRAVAILLER from HEURE_TRAVAIL HT where HT.NUM_FICHE_SALAIRE = FS.NUM_FICHE_SALAIRE) * FS.TARIF_HORAIRE - FS.TAXE + (FS.PRIME- FS.DEDUCTION_PRIME))*-1  as MONTANT, 'SALAIRE' as TYPE from FICHE_SALAIRE FS
UNION
SELECT AD.DATE_DEPENSE as DATE, AD.MONTANT_DEPENSE*-1 as MONTANT, 'AUTRE DEPENSE' as TYPE from AUTRE_DEPENSE AD
UNION
SELECT FT.DATE as DATE, FT.MONTANT*-1 as MONTANT, 'FACTURE' as TYPE from FACTURE FT
UNION
SELECT RP.DATE AS DATE, (SELECT SUM(AT.PRIX) FROM ARTICLE AT INNER JOIN peut_contenir_ PC ON AT.NOM = PC.NOM WHERE PC.ID_RECU = RP.ID_RECU) AS MONTANT, 'RECU' AS TYPE FROM RECU_PAIMENT RP;

$$

DELIMITER ;

DELIMITER $$

CREATE VIEW STOCK_DE_PRODUIT AS
SELECT
    P.NOM AS NOM,
    P.ID_PRODUIT AS IDENTIFIANT,
    P.QTE AS QUANTITE,
    (
        SELECT SUM(BC.QTE)
        FROM BON_COMMANDE BC
        WHERE BC.ID_COMMANDE IN (
            SELECT CC.ID_COMMANDE
            FROM concerne CC
            WHERE CC.ID_PRODUIT = P.ID_PRODUIT
        )
    ) - (
        SELECT SUM(BL.QTE)
        FROM BON_LIVRAISON BL
        WHERE BL.ID_BON_LIV IN (
            SELECT CC.ID_BON_LIV
            FROM concerne CC
            WHERE CC.ID_PRODUIT = P.ID_PRODUIT
        )
    ) AS QUANTITE_EN_APPROCHE,
    P.PRIX AS PRIX,
    P.ID_STOCK AS EMPLACEMENT
FROM
    PRODUIT P;
$$

DELIMITER ;

DELIMITER $$

CREATE VIEW PERSONNEL_ACTIF AS
SELECT
    P.ID_TIERS AS IDENTIFIANT,
    P.NOM AS nom,
    P.EMAIL AS email,
    CASE
        WHEN PE.CUISINE = 1 THEN 'CUISINE'
        WHEN PE.BAR = 1 THEN 'BAR'
        WHEN PE.SALLE = 1 THEN 'SALLE'
        WHEN PE.RESPONSABLE = 1 THEN 'RESPONSABLE'
        ELSE NULL
    END AS JOB
FROM
    PERSONNE P
JOIN
    PERSONNEL PE ON P.ID_TIERS = PE.ID_TIERS
JOIN
    CONTRAT C ON PE.ID_TIERS = C.ID_TIERS;

$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER FicheSalaire_dans_dateContrat
BEFORE INSERT ON FICHE_SALAIRE FOR EACH ROW
BEGIN
     DECLARE rowcount INT;
     SELECT COUNT(*) INTO rowcount FROM FICHE_SALAIRE, CONTRAT
     WHERE FICHE_SALAIRE.ID_TIERS = CONTRAT.ID_TIERS
     AND (FICHE_SALAIRE.PER_DATE_DEBUT BETWEEN CONTRAT.DATE_DEBUT AND CONTRAT.DATE_FIN
          AND FICHE_SALAIRE.PER_DATE_FIN BETWEEN CONTRAT.DATE_DEBUT AND CONTRAT.DATE_FIN);
     IF rowcount > 0 THEN
          SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Date non valide car n''est pas dans le contrat du travailleur';
     END IF;
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER Conge_dans_dateContrat
BEFORE INSERT ON CONGE FOR EACH ROW
BEGIN
     DECLARE rowcount INT;
     SELECT COUNT(*) INTO rowcount FROM CONGE, CONTRAT 
     WHERE CONGE.ID_TIERS = CONTRAT.ID_TIERS
     AND (CONGE.DATE_DEBUT BETWEEN CONTRAT.DATE_DEBUT AND CONTRAT.DATE_FIN
          AND DATE_ADD(CONGE.DATE_DEBUT, INTERVAL CONGE.NOMBRE_JOUR DAY) BETWEEN CONTRAT.DATE_DEBUT AND CONTRAT.DATE_FIN);
     IF rowcount > 0 THEN
          SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Date non valide car n''est pas dans le contrat du travailleur';
     END IF;
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER FichePaye_Superposee
BEFORE INSERT ON FICHE_SALAIRE FOR EACH ROW
BEGIN
     DECLARE rowcount INT;
     SELECT COUNT(*) INTO rowcount FROM FICHE_SALAIRE 
     WHERE ID_TIERS = NEW.ID_TIERS
     AND (NEW.PER_DATE_DEBUT BETWEEN PER_DATE_DEBUT AND PER_DATE_FIN
          AND NEW.PER_DATE_FIN BETWEEN PER_DATE_DEBUT AND PER_DATE_FIN);
     IF rowcount > 0 THEN
          SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Date non valide car chevauche une autre date';
     END IF;
END$$

DELIMITER ;

DELIMITER $$
CREATE TRIGGER Contrat_Superposee
BEFORE INSERT ON CONTRAT FOR EACH ROW
BEGIN
     DECLARE rowcount INT;
     SELECT COUNT(*) INTO rowcount FROM CONTRAT 
     WHERE ID_TIERS = NEW.ID_TIERS
     AND (NEW.DATE_DEBUT BETWEEN DATE_DEBUT AND DATE_FIN
          AND NEW.DATE_FIN BETWEEN DATE_DEBUT AND DATE_FIN);
     IF rowcount > 0 THEN
          SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Date non valide car chevauche une autre date';
     END IF;
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER CongeAnnuel_CDD_CDI
BEFORE INSERT ON CONGE FOR EACH ROW
BEGIN
     DECLARE rowcount INT;
     SET rowcount = 0;
     SELECT COUNT(*) INTO rowcount FROM CONGE, CONTRAT, FICHE_SALAIRE
     WHERE CONGE.ID_TIERS = CONTRAT.ID_TIERS
     AND CONGE.TYPE = 'annuel'
     AND (CONTRAT.TYPE = 'CDI' OR CONTRAT.TYPE = 'CDD')
     AND CONGE.DATE_DEBUT BETWEEN FICHE_SALAIRE.PER_DATE_DEBUT AND FICHE_SALAIRE.PER_DATE_FIN
     AND DATE_ADD(CONGE.DATE_DEBUT, INTERVAL CONGE.NOMBRE_JOUR DAY) BETWEEN FICHE_SALAIRE.PER_DATE_DEBUT AND FICHE_SALAIRE.PER_DATE_FIN;
     IF rowcount > 0 THEN
          SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Congee non valide car pas compris entre debut et fin de la fiche salaire';
     END IF;
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER CHECK_HEURE_TRAVAIL_CONGE
BEFORE INSERT ON HEURE_TRAVAIL
FOR EACH ROW
BEGIN
    DECLARE ID_TRAVAILLEUR INT DEFAULT 0;
    DECLARE DATE_FIN DATE DEFAULT '0001-01-01';
    
    SET ID_TRAVAILLEUR = (SELECT ID_TIERS FROM CONGE WHERE ID_TIERS = NEW.ID_TIERS);
    SET DATE_FIN = DATE_ADD((SELECT DATE_DEBUT FROM CONGE WHERE ID_TIERS = ID_TRAVAILLEUR), INTERVAL (SELECT NOMBRE_JOUR FROM CONGE WHERE ID_TIERS = ID_TRAVAILLEUR) DAY);
    
    IF (SELECT DATE_DEBUT FROM CONGE WHERE ID_TIERS = ID_TRAVAILLEUR) <= (SELECT DATE FROM HEURE_TRAVAIL WHERE ID_TIERS = ID_TRAVAILLEUR) AND (SELECT DATE FROM HEURE_TRAVAIL WHERE ID_TIERS = ID_TRAVAILLEUR) <= DATE_FIN THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Un membre du personnel ne peut pas faire des heures de travail durant ses congés';
    END IF;
END $$


DELIMITER ;

DELIMITER $$

create trigger CHECK_DATE_PAYEMENT_DATE_RESERVATION
before insert on RECU_PAIMENT for each row
BEGIN
    declare ID_PAYEMENT int default 0;
    set ID_PAYEMENT = (select ID_RESERVATION from peut_contenir_ where ID_RECU = new.ID_RECU);
    if (select re.DATE from RECU_PAIMENT re where re.ID_RECU = new.ID_RECU) < (select res.DATE from RESERVATION res where res.ID_RESERVATION = ID_PAYEMENT)
    then
        signal sqlstate'45000'set message_text ='Un recu de payement ne peut pas être lié à une réservation future';
    end if;
end $$
DELIMITER ;

DELIMITER $$ 

create trigger CHECK_DATE_FACTURE_BON_LIVRAISON
before insert on FACTURE for each row
BEGIN
 if (select bl.DATE from BON_LIVRAISON bl where bl.ID_FACTURE=new.ID_FACTURE)>new.DATE
 then
 signal sqlstate'45000'set message_text ='Une facture ne peut pas être antérieur au bon de livraison correspondant';
 end if;
end $$

DELIMITER ;

DELIMITER $$

create trigger CHECK_DATE_LIVRAISON_COMMANDE
before insert on BON_LIVRAISON for each row
BEGIN
 if(select com.DATE from BON_COMMANDE where com.ID_COMMANDE = new.ID_COMMANDE)>new.DATE
 then
 signal sqlstate'45000'set message_text ='un bon de livraison ne peut pas être antérieur à la commande correspondante';
 end if;
end $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER CHECK_QTE_COMMANDE_LIVRAISON
BEFORE INSERT ON BON_LIVRAISON FOR EACH ROW
BEGIN
 DECLARE total_QTE FLOAT DEFAULT 0;
 IF ((SELECT SUM(QTE) FROM BON_LIVRAISON WHERE ID_COMMANDE = NEW.ID_COMMANDE) + NEW.QTE) > (SELECT com.QTE FROM BON_COMMANDE com WHERE com.ID_COMMANDE = NEW.ID_COMMANDE) THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La quantité totale livrée dépasse la quantité commandée';
END IF;
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER Verif_Facture_Fournisseur
BEFORE INSERT
ON FACTURE
FOR EACH ROW
BEGIN
  IF EXISTS (
    SELECT *
    FROM inserted i
    INNER JOIN BON_LIVRAISON bl ON i.ID_BON_LIV = bl.ID_BON_LIV
    INNER JOIN BON_COMMANDE bc ON i.ID_COMMANDE = bc.ID_COMMANDE
    INNER JOIN FOURNISSEUR f ON i.ID_TIERS = bc.ID_TIERS
    WHERE f.ID_TIERS <> i.ID_TIERS
  ) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Le fournisseur ne peut facturer que sa commande';
  END IF;
END $$
       
DELIMITER ;

DELIMITER $$

CREATE TRIGGER Verif_Facture_Fournisseur_INSERT
BEFORE INSERT ON FACTURE
FOR EACH ROW
BEGIN
    DECLARE id_bl INT DEFAULT 0;
    SET id_bl = (SELECT ID_BON_LIV FROM BON_LIVRAISON WHERE ID_FACTURE = NEW.ID_FACTURE);
    
    IF (SELECT con.ID_COMMANDE FROM concerne con WHERE con.ID_BON_LIV = id_bl 
        NOT IN (SELECT ID_COMMANDE FROM COMMANDE WHERE ID_TIERS = NEW.ID_TIERS)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Le fournisseur ne peut facturer que sa commande';
    END IF;
END$$


DELIMITER ;

DELIMITER $$

CREATE TRIGGER Verif_Facture_Fournisseur_UPDATE
BEFORE UPDATE ON FACTURE
FOR EACH ROW
BEGIN
    DECLARE id_bl INT DEFAULT 0;
    SET id_bl = (SELECT ID_BON_LIV FROM BON_LIVRAISON WHERE ID_FACTURE = NEW.ID_FACTURE);
    
    IF (SELECT con.ID_COMMANDE FROM concerne con WHERE con.ID_BON_LIV = id_bl 
        NOT IN (SELECT ID_COMMANDE FROM COMMANDE WHERE ID_TIERS = NEW.ID_TIERS)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Le fournisseur ne peut facturer que sa commande';
    END IF;
END$$


DELIMITER ;

DELIMITER $$

CREATE TRIGGER Verif_Livraison_Fournisseur
BEFORE INSERT ON BON_LIVRAISON
FOR EACH ROW
BEGIN
  DECLARE fournisseur_id INT;
  
  SELECT bc.ID_TIERS INTO fournisseur_id
  FROM BON_COMMANDE bc
  WHERE bc.ID_COMMANDE = NEW.ID_COMMANDE;
  
  IF facture.ID_TIERS <> fournisseur_id THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Le fournisseur ne peut livrer que sa commande';
  END IF;
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER HeureTravail_dans_DateContrat
BEFORE INSERT ON HEURE_TRAVAIL FOR EACH ROW
BEGIN
     DECLARE rowcount INT;
     SELECT COUNT(*) INTO rowcount FROM HEURE_TRAVAIL, CONTRAT
     WHERE HEURE_TRAVAIL.ID_TIERS = CONTRAT.ID_TIERS AND HEURE_TRAVAIL.DATE BETWEEN CONTRAT.DATE_DEBUT AND CONTRAT.DATE_FIN;
     IF rowcount > 0 THEN
     SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Date non valide car n''est pas dans le contrat du travailleur';
     END IF;
END$$

DELIMITER ;


ALTER TABLE `CONTRAT`
CHANGE `DATE_DEBUT` `DATE_DEBUT` date NOT NULL AFTER `ID_CONTRAT`,
CHANGE `DATE_FIN` `DATE_FIN` date NOT NULL AFTER `DATE_DEBUT`;

INSERT INTO `PERSONNE` (`ID_TIERS`, `NOM`, `PRENOM`, `DATE_NAISSANCE`, `EMAIL`, `SEXE_`, `PERSONNEL`, `FOURNISSEUR`) VALUES
(1,	'Pag',	'Robert',	'1990-06-26',	'RobertPag@unamur.be',	'Homme',	1,	NULL),
(2,	'Pag',	'Roberta',	'1991-06-26',	'RoberatPag@unamur.be',	'Femme',	1,	NULL),
(3,	'Gerant',	'Gere',	'2023-05-19',	'gerantgere@ger.com',	'Homme',	1,	NULL),
(4,	'Dandom',	'Der',	'2023-05-19',	'dandomder@ger.com',	'Homme',	1,	NULL),
(5,	'Cuistot',	'cuisine',	'2023-05-19',	'cuistotCuisine@ger.com',	'Homme',	1,	NULL),
(8,	'Fourni',	'Produits',	'2023-05-19',	'fourniProd@ger.com',	'Homme',	NULL,	1),
(21,	'Cobaye',	'coco',	'0000-01-01',	'-',	'-',	1,	NULL);


INSERT INTO `PERSONNEL` (`ID_TIERS`, `NUM_SECURITE_SOCIALE`, `IND_NOM_ENTREPRISE`, `IND_NUM_ENTREPRISE`, `CUISINE`, `BAR`, `SALLE`, `RESPONSABLE`, `Dir_ID_TIERS`) VALUES
(3,	NULL,	'ef546',	'efe65',	NULL,	NULL,	NULL,	1,	NULL),
(5,	'1',	NULL,	NULL,	1,	NULL,	NULL,	NULL,	NULL);

-- Insertion du personnel id=5 ==================================================
INSERT INTO `CONTRAT` (`ID_CONTRAT`, `DATE_DEBUT`, `DATE_FIN`, `TYPE`, `ID_TIERS`) VALUES
(1,	'2023-05-21',	'2024-05-21',	'0',	3),
(2,	'2023-05-21',	'2024-05-21',	'1',	5);

INSERT INTO `FICHE_SALAIRE` (`NUM_FICHE_SALAIRE`, `PER_DATE_DEBUT`, `PER_DATE_FIN`, `TAXE`, `PRIME`, `DEDUCTION_PRIME`, `TARIF_HORAIRE`, `ID_TIERS`) VALUES
('5',	'2023-05-21',	'2023-06-21',	24,	70,	6,	15,	5);

INSERT INTO `CONGE` (`ID_TIERS`, `DATE_DEBUT`, `NOMBRE_JOUR`, `TYPE`) VALUES
(5,	'2023-05-21',	1,	'maladie');

INSERT INTO `HEURE_TRAVAIL` (`DATE`, `ID_TIERS`, `HEURE_DEBUT`, `NOMBRE_HEURE_TRAVAILLER`, `NUM_FICHE_SALAIRE`) VALUES
('2023-05-26',	5,	'2023-05-21',	4,	'5');


INSERT INTO `RESPONSABLE` (`ID_TIERS`) VALUES
(3);

INSERT INTO `FOURNISSEUR` (`ID_TIERS`, `NOM_ETABLISSEMENT`) VALUES
(8,	'Fournini');

-- ---- Ajout article -> nourriture -> (plat,entree,dessert) && boisson
INSERT INTO `ARTICLE` (`NOM`, `PRIX`, `DESCRIPTION`, `NOURRITURE`, `BOISSON`) VALUES
('carpaccio',	20,	' bœufcrue,coupée en tranches très fines',	'1',	NULL),
('Eau',	1,	'eau plate',	NULL,	'1'),
('Fanta',	2,	'Soft pétillante a l orange',	NULL,	'1'),
('Glace Vanille',	3,	'Glace goût vanille',	'1',	NULL),
('Pain à l\'ail',	4,	'4 pain à l\'ail',	'1',	NULL),
('Pizza basique',	8,	'sauce tomate + mozza',	'1',	NULL),
('soumaun lotte',	21,	'thon',	'1',	NULL),
('Spaghetti bolognaise',	7,	'Pates + sauce bolognaise + viande haché',	'1',	NULL),
('vetello',	15,	' tranches viande de veau + sauce de thon',	'1',	NULL);

INSERT INTO `NOURRITURE` (`NOM`, `PLAT`, `ENTREE`, `DESSERT`) VALUES
('carpaccio',	'1',	NULL,	NULL),
('Glace Vanille',	NULL,	NULL,	'1'),
('Pain à l\'ail',	NULL,	'1',	NULL),
('Pizza basique',	'1',	NULL,	NULL),
('soumaun lotte',	'1',	NULL,	NULL),
('Spaghetti bolognaise',	'1',	NULL,	NULL),
('vetello',	'1',	NULL,	NULL);

INSERT INTO `BOISSON` (`NOM`) VALUES
('Eau'),
('Fanta');


INSERT INTO `PLAT` (`NOM`) VALUES
('carpaccio'),
('Pizza basique'),
('soumaun lotte'),
('Spaghetti bolognaise'),
('vetello');

INSERT INTO `ENTREE` (`NOM`) VALUES
('Pain à l\'ail');

INSERT INTO `DESSERT` (`NOM`) VALUES
('Glace Vanille');


INSERT INTO `RESERVATION` (`ID_RESERVATION`, `DATE`, `NOM_PERSONNE`, `NUM_TEL`, `NOMBRE_PERSONNE`, `ENFANT`, `ANIMAUX`, `HEURE_ARRIVE`, `ANNIVERSAIRE`, `ID_TIERS`) VALUES
(1,	'2023-05-20',	'Cuistot',	888888,	1,	0,	0,	'2023-05-20',	'0',	3);

INSERT INTO `RECU_PAIMENT` (`ID_RECU`, `DATE`, `HEURE_RECU`, `TVA`) VALUES
(1,	'2023-05-20',	'1',	21);


INSERT INTO `AUTRE_DEPENSE` (`ID_DEPENSE`, `DATE_DEPENSE`, `MONTANT_DEPENSE`, `DESCRIPTION`, `STATUT_DEPENSE`, `ID_TIERS`) VALUES
(1,	'2023-05-21',	400,	'Achat tables',	'1',	3);

