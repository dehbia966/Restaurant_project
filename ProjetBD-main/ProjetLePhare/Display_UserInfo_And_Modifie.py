import mysql.connector
import os,time
import builtins

#C est bon
# Fonction qui prend en parametre l id du client et la connection vers la BD, et qui permet de voir ces info ainsi que les modifier si souhaité 
def ClientInfo(id_client,connection):

    inUserInfo=1
    # Creation du curseur pour exécuter des requetes SQL
    cursorClient = connection.cursor()
    while inUserInfo:
        # Executer la requete SQL pour recuperer les elements de la table PERSONNE
        query = "SELECT * FROM PERSONNE WHERE ID_TIERS = %s;"%id_client
        cursorClient.execute(query)

        # Récupérer les resultats de la requete
        CLIENT = cursorClient.fetchall()


        query = "select * from PERSONNE,PERSONNEL where PERSONNEL.id_tiers = %s and PERSONNEL.id_tiers = PERSONNE.id_tiers"%id_client
        cursorClient.execute(query)
        Poste=cursorClient.fetchall()
        
        print(Poste)
        #print(Poste[0][12])
        if len(Poste)<=0:
            query = "select * from PERSONNE,FOURNISSEUR where PERSONNE.id_tiers = %s and FOURNISSEUR.id_tiers = PERSONNE.id_tiers"%id_client
            cursorClient.execute(query)
            Poste2=cursorClient.fetchall()
            if len(Poste2)<=0: 
                role="Client"
            else:
                role="Fournisseur"
        else:
            #Poste=" - "
            if Poste[0][12]==1:
                role="Cuisine"
            elif Poste[0][13]==1:
                role="Bar"
            elif Poste[0][14]==1:
                role="Salle"
            else :
                role="Responsable"

        # Affiche les info de l utilisateur
        os.system("cls")

        if ( CLIENT[0][4] == "-" ):
            print(" -Utilisateur n existe plus- ")
            time.sleep(1)
            print(".")
            time.sleep(1)
            return


        print("=========================== Bienvenue %s =========================== "%CLIENT[0][2])
        print("| Page personnel :\n|")
        #print("| Nom :%s \t Prenom:%s \t Date de naissance:%s \t email:%s \t sexe:%s ")
        print("| Nom : %s" %CLIENT[0][1])
        print("| Prenom : %s" %CLIENT[0][2])
        print("| Date de naissance : %s" %CLIENT[0][3])
        print("| email : %s" %CLIENT[0][4])
        print("| sexe : %s " %CLIENT[0][5])
        print('| statut : %s \n|'%role)

        choice = int(input("| Entrez 0 pour sortir , 1 pour modifier les données utilisateur \n| "))

        if (choice ==0) : inUserInfo=0
        else :
            # Demande a l utilisateur quel info veut il modifier 
            changeUserData=1
            collumName=""
            while (changeUserData):
                print("| Quelle donnée voulez vous modifier ? \n| 1. Nom\n| 2. Prenom\n| 3. Date de naissance\n| 4. email\n| 5. sexe\n| 6. Retour")
                choice2=int(input("| "))
                if (choice2 == 1):
                    collumName="NOM"
                if (choice2 == 2):
                    collumName="PRENOM"
                if (choice2 == 3):
                    collumName="DATE_NAISSANCE"
                if (choice2 == 4):
                    collumName="EMAIL"
                if (choice2 == 5):
                    collumName="SEXE_"

                if (choice2 >= 6):
                    changeUserData=0
                else :
                    updatedThing=input("| Entrez la modification de la valeur : ")
                    #query="UPDATE PERSONNE SET %s = '%s' WHERE ID_TIERS=%d ;" %(collumName,updatedThing, id_client) 
                    query = "UPDATE PERSONNE SET {}= '{}' WHERE ID_TIERS = {};".format(collumName,updatedThing, id_client)
                    cursorClient.execute(query)
                    #print(query)     

#C est bon
def AjoutFournisseur(donner,connection):

    inUserInfo=1
    # Creation du curseur pour exécuter des requetes SQL
    cursor = connection.cursor()
    
    #Insertion dans personne avec donnée de l utilisateur
    query = "INSERT INTO `PERSONNE` (`NOM`, `PRENOM`, `DATE_NAISSANCE`, `EMAIL`, `SEXE_`, `PERSONNEL`, `FOURNISSEUR`) VALUES ('{}',	'{}',	'{}',	'{}',	'{}',	NULL,	1);".format(donner[0],donner[1],donner[2],donner[3],donner[4])
    cursor.execute(query)

    #recupere la derniere ligne mis a jour
    personne_id = cursor.lastrowid

    insert_fournisseur_query = "INSERT INTO FOURNISSEUR (ID_TIERS, NOM_ETABLISSEMENT) VALUES ({}, '{}');".format(personne_id, donner[5])

    cursor.execute(insert_fournisseur_query)

    print("\n=================================")
    print("Numero d id : ",personne_id)
    print("=================================")
    time.sleep(2)

#C est bon    
def AjoutPersonnel(donner,connection):

    # Creation du curseur pour exécuter des requetes SQL
    cursor = connection.cursor()

    query = "INSERT INTO `PERSONNE` (`NOM`, `PRENOM`, `DATE_NAISSANCE`, `EMAIL`, `SEXE_`, `PERSONNEL`, `FOURNISSEUR`) VALUES ('{}',	'{}',	'{}',	'{}',	'{}',	NULL,	1);".format(donner[0],donner[1],donner[2],donner[3],donner[4]) 
    cursor.execute(query)
    personne_id = cursor.lastrowid

    if ( donner[6] != "client" ):
        if (int(donner[8])==1):
            insert_personnel_query = "INSERT INTO `PERSONNEL` (`ID_TIERS`, `NUM_SECURITE_SOCIALE`, `IND_NOM_ENTREPRISE`, `IND_NUM_ENTREPRISE`, `CUISINE`, `BAR`, `SALLE`, `RESPONSABLE`, `Dir_ID_TIERS`) VALUES ({},	{},	NULL,	NULL,	1,	NULL,	NULL,	NULL,	NULL);".format(personne_id ,donner[5],donner[6],donner[7]) 
            cursor.execute(insert_personnel_query)
            
        if (int(donner[8])==2):
            insert_personnel_query = "INSERT INTO `PERSONNEL` (`ID_TIERS`, `NUM_SECURITE_SOCIALE`, `IND_NOM_ENTREPRISE`, `IND_NUM_ENTREPRISE`, `CUISINE`, `BAR`, `SALLE`, `RESPONSABLE`, `Dir_ID_TIERS`) VALUES ({},	{},	NULL,	NULL,	NULL,	1,	NULL,	NULL,	NULL);".format(personne_id ,donner[5],donner[6],donner[7])       
            cursor.execute(insert_personnel_query)
            
        if (int(donner[8])==3):
            insert_personnel_query = "INSERT INTO `PERSONNEL` (`ID_TIERS`, `NUM_SECURITE_SOCIALE`, `IND_NOM_ENTREPRISE`, `IND_NUM_ENTREPRISE`, `CUISINE`, `BAR`, `SALLE`, `RESPONSABLE`, `Dir_ID_TIERS`) VALUES ({},	{},	NULL,	NULL,	NULL,	NULL,	1,	NULL,	NULL);".format(personne_id ,donner[5],donner[6],donner[7])         
            cursor.execute(insert_personnel_query)
            

    print("\n=================================")
    print("Numero d id : ",personne_id)
    print("=================================")
    time.sleep(2)

#C est bon
def SupprimerPersonnel(id_client,connection):
    #print("-maintenance-")
    cursorClient = connection.cursor()

    query ="DELETE FROM CONGE WHERE ID_TIERS = %s;"%id_client
    cursorClient.execute(query)

    query ="DELETE FROM FICHE_SALAIRE WHERE ID_TIERS= %s;"%id_client
    cursorClient.execute(query)

    query ="DELETE FROM HEURE_TRAVAIL WHERE ID_TIERS= %s;"%id_client
    cursorClient.execute(query)

    query ="DELETE FROM PERSONNEL WHERE ID_TIERS= %s;"%id_client
    cursorClient.execute(query)

    query ="UPDATE PERSONNE SET DATE_NAISSANCE = '0-01-01', EMAIL = '-', SEXE_='-' WHERE ID_TIERS=%s"%id_client
    cursorClient.execute(query)



def passer_reservation (id,connection): # C est bon
    cursorReservation = connection.cursor()
# Demander les détails de la réservation à l'utilisateur
    
    os.system("cls")
    print("Quel type de nourriture voulez vous commander ?")
    print("| 1. Entrée ")
    print("| 2. Plat ")
    print("| 3. Dessert ")
    print("| 4. Retour")

    food_choice=int(input("| Entrez le numéro correspondant au choix voulu : " ))



    print("===========")
    # on recupere le nom du produit ainsi que son prix
    if (food_choice == 1):
        type_food_see=("SELECT * FROM `ENTREE`")
        cursorReservation.execute(type_food_see)
        food0 = cursorReservation.fetchall()
        prix=("SELECT NOM,PRIX FROM ARTICLE where NOURRITURE='1' and NOM = (select NOM from NOURRITURE where ARTICLE.NOM = NOM and ENTREE='1') ;")

    if (food_choice == 2):
        type_food_see=("SELECT * FROM `PLAT`")
        cursorReservation.execute(type_food_see)
        food0 = cursorReservation.fetchall()
        prix=("SELECT NOM,PRIX FROM ARTICLE where NOURRITURE='1' and NOM = (select NOM from NOURRITURE where ARTICLE.NOM = NOM and PLAT='1') ;")
        

    if (food_choice == 3):
        type_food_see=("SELECT * FROM `DESSERT`")
        cursorReservation.execute(type_food_see)
        food0 = cursorReservation.fetchall()
        prix=("SELECT NOM,PRIX FROM ARTICLE where NOURRITURE='1' and NOM = (select NOM from NOURRITURE where ARTICLE.NOM = NOM and DESSERT='1') ;")

    if (food_choice>=4):
        return

    cursorReservation.execute(prix)
    prix = cursorReservation.fetchall()

    #Affichage des differents articles
    i=1
    print("|")
    for element in food0:
        print("|",i,". ",element[0]," , prix :",prix[i-1][1])
        i+=1
    print("|")
    food_order=int(input("Quelle est votre choix ? : "))
    #print(food0[0][0])

    if (food_order <= len(food0)+1):
        print(food0[food_order-1][0])
    else:
        print("Choix non valide")
    
#======================================================================

    nom_personne=("select NOM from PERSONNE where ID_TIERS= {};".format(id) )
    cursorReservation.execute(nom_personne)
    nom_personne=cursorReservation.fetchall()

    #print(nom_personne)
    nom_personne=nom_personne[0][0]


    num_tel = input("Numéro de téléphone: ")
    nombre_personne = int(input("Nombre total de personnes: "))
    enfant = int(input("Nombre d'enfants: "))
    animaux = int(input("Nombre d'animaux: "))
    anniversaire = input("Anniversaire (1/0): ")

# creer une requete SQL pour inserer la reservation 

    id_reserv=("SELECT COUNT(*) FROM RESERVATION;")
    cursorReservation.execute(id_reserv)
    id_reserv = cursorReservation.fetchall()
    id_reserv= str(int(id_reserv[0][0])+1)
    #print(id_reserv)

    insert_reservation = "INSERT INTO `RESERVATION` (`ID_RESERVATION`, `DATE`, `NOM_PERSONNE`, `NUM_TEL`, `NOMBRE_PERSONNE`, `ENFANT`, `ANIMAUX`, `HEURE_ARRIVE`, `ANNIVERSAIRE`, `ID_TIERS`) VALUES ({},	CURDATE(),	'{}', {},	{},	{},	{},	NOW(),	'{}',	3);".format(id_reserv,nom_personne , num_tel , nombre_personne , enfant , animaux , anniversaire)


    prix_recu=str(prix[food_order-1][1])

    insert_recuPaiement="INSERT INTO `RECU_PAIMENT` (`ID_RECU`, `DATE`, `HEURE_RECU`, `TVA`) VALUES ({},	CURDATE(),	'1',	{});".format(id_reserv,prix_recu)

#Execution de la requete dans la table reservation  
    cursorReservation.execute(insert_reservation)

#Execution de la requete dans la table recu_paiement
    cursorReservation.execute(insert_recuPaiement)

    print("la reservation est faite avec succes ")
