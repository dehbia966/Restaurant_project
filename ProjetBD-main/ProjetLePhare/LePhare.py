import mysql.connector
import os,time
from Display_UserInfo_And_Modifie import ClientInfo
from Display_UserInfo_And_Modifie import AjoutFournisseur,AjoutPersonnel,SupprimerPersonnel,passer_reservation
import builtins

#=====Setup de la lisaison vers la BD=====

#Testé avec ces données :

#INSERT INTO `PERSONNE` (`ID_TIERS`, `NOM`, `PRENOM`, `DATE_NAISSANCE`, `EMAIL`, `SEXE_`, `PERSONNEL`, `FOURNISSEUR`) VALUES
#(1,	'Pag',	'Robert',	'1990-06-26',	'RobertPag@unamur.be',	'Homme',	1,	NULL),
#(2,	'Pag',	'Roberta',	'1991-06-26',	'RoberatPag@unamur.be',	'Femme',	1,	NULL),
#(3,	'Gerant',	'Gere',	'2023-05-19',	'gerantgere@ger.com',	'Homme',	1,	NULL),
#(4,	'Gerant2',	'Gere',	'2023-05-19',	'gerantgere@ger.com',	'Homme',	1,	NULL),
#(5,	'Cuistot',	'cuisine',	'2023-05-19',	'cuistotCuisine@ger.com',	'Homme',	1,	NULL);
#
#INSERT INTO `PERSONNEL` (`ID_TIERS`, `NUM_SECURITE_SOCIALE`, `IND_NOM_ENTREPRISE`, `IND_NUM_ENTREPRISE`, `CUISINE`, `BAR`, `SALLE`, `RESPONSABLE`, `Dir_ID_TIERS`) VALUES
#(3,	NULL,	'ef546',	'efe65',	NULL,	NULL,	NULL,	1,	NULL);
#
#
#INSERT INTO `RESPONSABLE` (`ID_TIERS`) VALUES
#(3);
#
#------- Fournisseur , pas dans le doc principal
#INSERT INTO `PERSONNE` (`ID_TIERS`, `NOM`, `PRENOM`, `DATE_NAISSANCE`, `EMAIL`, `SEXE_`, `PERSONNEL`, `FOURNISSEUR`) VALUES
#(8,	'Fourni',	'Produits',	'2023-05-19',	'fourniProd@ger.com',	'Homme',	NULL,	1);
#
#INSERT INTO `FOURNISSEUR` (`ID_TIERS`, `NOM_ETABLISSEMENT`) VALUES
#(8,	'Fournini');


    # Établir la connexion à la base de données
connection = mysql.connector.connect(
    host="localhost",
    port=3300,
    user="mysqlUser",
    password="mysqlPassword",
    database="physique"
)
#cursorClient = connection.cursor()


#=====Code principal=====
cursorClient = connection.cursor()
BDisON=True
while (BDisON): 
    os.system("cls")
    print("======================== Bienvenue chez LePhare ========================")
    print("| 1. Inscription") # 1/1
    print("| 2. Connexion") # 3 /5
    print("| 3. Quitter")
    choice1=int(input("|\n|Veuillez choisir le nombre correspondant au choix voulu \n"))
    
    
    if (choice1==1): #Check
        os.system("cls")

        print("======================= Inscription =======================")
        print("|")
        print("| 1. Ajout d'un Fournisseur")
        print("| 2. Ajout d'un membre de personnel")
        print("| 3. Ajout d'un client")
        print("| 4. Quitter")

        choice3= int(input("|\n|Veuillez choisir le nombre correspondant au choix voulu \n|"))
        if choice3==1:
            print("|Veuillez saisir les données requises :\n")#le nom, prénom, date_naissance,email,sexe,nom de l'etablissement\n")
            Nom=input("Nom : ")
            Prenom=input("Prenom : ")
            Date_n=input("Date de Naissance (YYYY-MM-DD): ")
            Email=input("Email : ")
            Sexe=input("Sexe : ")
            Etablissement=input("Nom De L'etabllissement du fournisseur : ")
            
            AjoutFournisseur([Nom,Prenom,Date_n,Email,Sexe,Etablissement],connection)

        elif (choice3 == 2 or choice3 ==3 ): 
            Nom=input("Nom : ")
            Prenom=input("Prenom : ")
            Date_n=input("Date_Naissance : ")
            Email=input("Email : ")
            Sexe=input("Sexe : ")

            # si membre du personnel
            if (choice3 == 2):
                Poste=input("Poste (1=Cuisine,2=Bar,3=Salle) : ")
                Num_sec=input("Num de secu : ")
                Num_ENTREPRISE=input("Numéro Entreprise : ")

                AjoutPersonnel([Nom,Prenom,Date_n,Email,Sexe,Num_sec,"Le Phare",Num_ENTREPRISE,Poste],connection)
            else:
                AjoutPersonnel([Nom,Prenom,Date_n,Email,Sexe,"0","client","0"],connection) #6 pour savoir si client ou non


    if (choice1==2):
        userConnected=True
         #Juste pour la demo , je demande juste l id
        chosenUser=input("Quel est votre id ?")

        query = "SELECT * FROM PERSONNE WHERE ID_TIERS = %s;"%chosenUser
        cursorClient.execute(query)

        # Récupérer les resultats de la requete
        CLIENT = cursorClient.fetchall()

        if ( len(CLIENT)<=0 or CLIENT[0][4]=="-"):
            print("Aucune donnée utilisateur")
            time.sleep(1)
            print(".")
            time.sleep(1)
            userConnected=False

        while(userConnected):
            os.system("cls")

            print("=======================Bienvenue sur votre page perso=======================")
            print("| 1. Consulter ses données et les modifier") #Bon
            print("| 2. Effacer les données du compte")         #Bon
            print("| 3. Passer une reservation")                #Bon
            print("| 4. Rapport Annuel+Mensuel")             #Seulement si c est le responsable
            print("| 5. Voir les personnes sous contrats")   #Seulement si c est le responsable
            print("| 6. Se deconnecter")
            choiceConnected=int(input("|\n|Veuillez choisir le nombre correspondant au choix voulu \n"))

            if (choiceConnected==1): #Check
                ClientInfo(chosenUser,connection)

            if (choiceConnected==2): #Check
                SupprimerPersonnel(chosenUser,connection) 
                userConnected=False

            if (choiceConnected==3): #Check
                passer_reservation(chosenUser,connection)

            if (choiceConnected==4):
                print("-")

            if (choiceConnected==5):
                print("-")

            if (choiceConnected==6):
                userConnected=False

            if (choiceConnected==7):
                query = "SELECT * FROM RESERVATION ;"
                cursorClient.execute(query)

                # Récupérer les resultats de la requete
                requete = cursorClient.fetchall()
                print(requete)
                time.sleep(5)

            if (choiceConnected==8):
                query = "SELECT * FROM RECU_PAIMENT ;"
                cursorClient.execute(query)

                # Récupérer les resultats de la requete
                requete = cursorClient.fetchall()
                print(requete)
                time.sleep(5)



    if (choice1>=3):
        BDisON=False

    


connection.close()

