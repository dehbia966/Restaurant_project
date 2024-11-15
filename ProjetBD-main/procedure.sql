DELIMITER $$

CREATE PROCEDURE BILAN_COMPTABLE_ANNEE(IN year INT)
BEGIN
    DECLARE benefice FLOAT DEFAULT 0;
    DECLARE depense FLOAT DEFAULT 0;
    DECLARE depense_salaire FLOAT DEFAULT 0;
    DECLARE depense_facture FLOAT DEFAULT 0;
    DECLARE depense_autre FLOAT DEFAULT 0;
    
    SET benefice = (SELECT SUM(comp.MONTANT) FROM Comptabilite comp WHERE YEAR(comp.DATE) = year AND comp.TYPE = 'RECU');
    SET depense_salaire = (SELECT SUM(comp.MONTANT) FROM Comptabilite comp WHERE YEAR(comp.DATE) = year AND comp.TYPE = 'SALAIRE');
    SET depense_facture = (SELECT SUM(comp.MONTANT) FROM Comptabilite comp WHERE YEAR(comp.DATE) = year AND comp.TYPE = 'FACTURE');
    SET depense_autre = (SELECT SUM(comp.MONTANT) FROM Comptabilite comp WHERE YEAR(comp.DATE) = year AND comp.TYPE = 'AUTRE DEPENSE');
    
    SET depense = depense_salaire + depense_autre + depense_facture;
    
    SELECT year AS 'Annee comptable', benefice AS 'Benefice total', depense AS 'Depense totale', depense_salaire AS 'Depense pour le salaire', depense_facture AS 'Depense pour les commandes', depense_autre AS 'Autres depenses',
          ROUND(benefice - depense, 2) AS 'Profit de l annee';
END $$
DELIMITER ;

DELIMITER $$

CREATE PROCEDURE BILAN_COMPTABLE_MOIS(IN year INT, IN month INT)
BEGIN
    DECLARE benefice FLOAT DEFAULT 0;
    DECLARE depense FLOAT DEFAULT 0;
    DECLARE depense_salaire FLOAT DEFAULT 0;
    DECLARE depense_facture FLOAT DEFAULT 0;
    DECLARE depense_autre FLOAT DEFAULT 0;
    
    SET benefice = (SELECT SUM(comp.MONTANT) FROM Comptabilite comp WHERE YEAR(comp.DATE) = year AND MONTH(comp.DATE) = month AND comp.TYPE = 'RECU');
    SET depense_salaire = (SELECT SUM(comp.MONTANT) FROM Comptabilite comp WHERE YEAR(comp.DATE) = year AND MONTH(comp.DATE) = month AND comp.TYPE = 'SALAIRE');
    SET depense_facture = (SELECT SUM(comp.MONTANT) FROM Comptabilite comp WHERE YEAR(comp.DATE) = year AND MONTH(comp.DATE) = month AND comp.TYPE = 'FACTURE');
    SET depense_autre = (SELECT SUM(comp.MONTANT) FROM Comptabilite comp WHERE YEAR(comp.DATE) = year AND MONTH(comp.DATE) = month AND comp.TYPE = 'AUTRE DEPENSE');
    
    SET depense = depense_salaire + depense_autre + depense_facture;
    
    SELECT ROUND(benefice - depense, 2) AS 'Profit du mois', year AS 'Annee comptable', benefice AS 'Benefice total', depense AS 'Depense totale', depense_salaire AS 'Depense pour le salaire', depense_facture AS 'Depense pour les commandes', depense_autre AS 'Autres depenses';
END $$
DELIMITER ;

use physique;
create user 'client'@'%' identified by 'mysqlpassword';
create user 'responsable'@'%' identified by 'mysqlpassword';
grant execute ON procedure BILAN_COMPTABLE_ANNEE to 'responsable'@'%';
grant execute ON procedure BILAN_COMPTABLE_MOIS to 'responsable'@'%';

