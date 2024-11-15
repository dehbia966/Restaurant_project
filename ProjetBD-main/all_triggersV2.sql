DELIMITER //

CREATE TRIGGER FicheSalaire_dans_dateContrat
BEFORE INSERT ON FICHE_SALAIRE FOR EACH ROW
BEGIN
     DECLARE rowcount INT;
     SELECT COUNT(*) INTO rowcount FROM FICHE_SALAIRE, CONTRAT
     WHERE FICHE_SALAIRE.ID_TIERS = CONTRAT.ID_TIERS
     AND (FICHE_SALAIRE.DATE_DEBUT BETWEEN CONTRAT.DATE_DEBUT AND CONTRAT.DATE_FIN
          AND FICHE_SALAIRE.DATE_FIN BETWEEN CONTRAT.DATE_DEBUT AND CONTRAT.DATE_FIN);
     IF rowcount > 0 THEN
          SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Date non valide car n''est pas dans le contrat du travailleur';
     END IF;
END//

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
END//

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
END//

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
END//

DELIMITER //

CREATE TRIGGER CongeAnnuel_CDD_CDI
BEFORE INSERT ON CONGE FOR EACH ROW
BEGIN
     DECLARE rowcount INT;
     SET rowcount = 0;
     SELECT COUNT(*) INTO rowcount FROM CONGE, CONTRAT, FICHE_SALAIRE
     WHERE CONGE.ID_TIERS = CONTRAT.ID_TIERS
     AND CONGE.TYPE = 'annuel'
     AND (CONTRAT.TYPE = 'CDI' OR CONTRAT.TYPE = 'CDD')
     AND CONGE.DATE_DEBUT BETWEEN FICHE_SALAIRE.DATE_DEBUT AND FICHE_SALAIRE.DATE_FIN
     AND DATE_ADD(CONGE.DATE_DEBUT, INTERVAL CONGE.NOMBRE_JOUR DAY) BETWEEN FICHE_SALAIRE.DATE_DEBUT AND FICHE_SALAIRE.DATE_FIN;
     IF rowcount > 0 THEN
          SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Congee non valide car pas compris entre debut et fin de la fiche salaire';
     END IF;
END //

DELIMITER ;


DELIMITER $$
 -----------------Corrigé===============================================
create trigger CHECK_HEURE_TRAVAIL_CONGE
before insert on HEURE_TRAVAIL for each row
BEGIN
    declare ID_TRAVAILLEUR int default 0;
    declare DATE_FIN date default '0000/00/00'
    set ID_TRAVAILLEUR = (select ID_TIERS from CONGE where  ID_TIERS = new.ID_TIERS);
    set DATE_FIN_CON = DATEADD(day, select(con.NOMBRE_JOUR from CONGE con where con.ID_TIERS = ID_TRAVAILLEUR), (select con.DATE_DEBUT from CONGE con where con.ID_TIERS = ID_TRAVAILLEUR));
    if (select con.DATE_DEBUT from CONGE con where con.ID_TIERS = ID_TRAVAILLEUR) <= ( select ht.date from HEURE_TRAVAIL ht where ht.ID_TIERS = ID_TRAVAILLEUR) and ( select ht.date from HEURE_TRAVAIL ht where ht.ID_TIERS = ID_TRAVAILLEUR) <= DATE_FIN_CON
    then
        signal sqlstate '45000' set message_text = 'Un membre du personnel ne peut pas faire des heures de travail durant ses congés';
    end if;
end $$

DELIMITER ;
 -----------------Corrigé===============================================

create trigger CHECK_DATE_PAYEMENT_DATE_RESERVATION
before insert on RECU_PAIMENT for each row
BEGIN
    declare ID_PAYEMENT int default 0;
    set ID_PAYEMENT = (select ID_RESERVATION from peut_contenir_ where ID_RECU = new.ID_RECU);
    if (select re.DATE from RECU_PAIMENT re where re.ID_RECU = new.ID_RECU) < (select res.DATE from RESERVATION res where res.ID_RESERVATION = ID_PAYEMENT)
    then
        signal sqlstate'45000'set message_text ='Un recu de payement ne peut pas être lié à une réservation future';
    end if;
end
DELIMITER ;

-----------------Corrigé===============================================
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

DELIMITER ;

DELIMITER $$
-----------------Corrigé===============================================
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
-----------------Corrigé===============================================
CREATE TRIGGER CHECK_QTE_COMMANDE_LIVRAISON
BEFORE INSERT ON BON_LIVRAISON FOR EACH ROW
BEGIN
    DECLARE total_QTE FLOAT DEFAULT 0;
    IF ((SELECT SUM(QTE) FROM BON_LIVRAISON WHERE ID_COMMANDE = NEW.ID_COMMANDE) + NEW.QTE) > (SELECT com.QTE FROM BON_COMMANDE com WHERE com.ID_COMMANDE = NEW.ID_COMMANDE) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La quantité totale livrée dépasse la quantité commandée';
    END IF;
END $$

 

DELIMITER ;


-----------------Corrigé===============================================
// trigger : le founisseur ne peut livrer que sa commande 

DELIMITER $$
-----------------Corrigé===============================================
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
       


// trigger : le founisseur ne peut facturer que sacommande
DELIMITER $$
-----------------Corrigé===============================================
CREATE TRIGGER Verif_Facture_Fournisseur_INSERT
BEFORE INSERT ON FACTURE
FOR EACH ROW
BEGIN
  IF EXISTS (
    SELECT *
    FROM BON_LIVRAISON bl
    INNER JOIN BON_COMMANDE bc ON NEW.ID_COMMANDE = bc.ID_COMMANDE
    INNER JOIN FOURNISSEUR f ON bc.ID_TIERS = f.ID_TIERS
    WHERE bl.ID_BON_LIV = NEW.ID_BON_LIV AND f.ID_TIERS <> NEW.ID_TIERS
  ) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Le fournisseur ne peut facturer que sa commande';
  END IF;
END $$


CREATE TRIGGER Verif_Facture_Fournisseur_UPDATE
BEFORE UPDATE ON FACTURE
FOR EACH ROW
BEGIN
  IF EXISTS (
    SELECT *
    FROM BON_LIVRAISON bl
    INNER JOIN BON_COMMANDE bc ON NEW.ID_COMMANDE = bc.ID_COMMANDE
    INNER JOIN FOURNISSEUR f ON bc.ID_TIERS = f.ID_TIERS
    WHERE bl.ID_BON_LIV = NEW.ID_BON_LIV AND f.ID_TIERS <> NEW.ID_TIERS
  ) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Le fournisseur ne peut facturer que sa commande';
  END IF;
END $$

DELIMITER ;

-- Corrigé===================================================================
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