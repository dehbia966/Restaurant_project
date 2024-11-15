import mysql.connector
from mysql.connector import errorcode
"""fonctionnalités"""


def callProcedure(requete, values=(), utilisateur="client"):
    """
    Executes a stored procedure in the MySQL database.

    requete: The SQL query for calling the stored procedure.
    values: The parameter values for the stored procedure, defaults to ().
    utilisateur: The username to connect to the database, defaults to "client".
    :return: The result of the stored procedure
    """
    cnx = mysql.connector.connect(
        user=utilisateur,
        password='password',
        host='127.0.0.1',
        port='3306',
        database='physique'
    )
    cursor = cnx.cursor()
    
    cursor.callproc(requete, values)
    cnx.commit()
    
    retour = []
    for result in cursor.stored_results():
        retour.extend(result.fetchall())
    
    cursor.close()
    cnx.close()
    
    return retour

"""console admin"""

def adminConnection():
    c2 = True

    while(c2):
        print("\n")
        print("1. Accéder au rapport compatibilite annuel\n")
        print("2. Accéder au rapport compatibilite annuel par mois\n")
        print("0. Quitter\n")
        choice2 = input("Choisissez un nombre entre 0 et 7 : ")

        if choice2 == "1":
            annee = int(input("Choisissez une année : "))
            donnee = callProcedure('VIEW_BILAN_COMPTABLE',(annee,),'responsable')
            print("-----------")
            for element in donnee:
                print("annee comptable : ",element[0][0])
                print("******************")
                print("benefice: ", element[0][1])
                print("******************")
                print("depenses totales : ", element[0][2])
                print("-----------")
                print("depense pour les salaire: ", element[0][3])
                print("depense en achat de produits: ", element[0][4])
                print("autres depenses: ", element[0][5])
                print("profit de l'année : ", element[0][6])
                print("-----------")
        elif choice2 == "2":
            annee = int(input("Choisissez une année : "))
            print("annee comptable,benefice total,benefice des ventes d'oiseaux,benefice des services vendus,benefice des ventes de nourriture,depenses totales,depenses en achat d'oiseaux,depenses en achat de nourriture,profit de l'année")
            for i in range(1,13):
                    aaa = callProcedure('BILAN_COMPTABLE_MOIS', (annee,i),'responsable')
                    print("MOIS : ",i,"->",aaa[0][0])
        else:
            c2 = False
        