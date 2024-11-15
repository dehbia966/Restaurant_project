import tkinter as tk

# Créer la fenêtre principale
root = tk.Tk()
root.title("Fenêtre principale")
root.geometry("300x500")

#init du dic avec 2 clients
personnes={
    1:{'nom':'x',  'prenom':'xx',   'rue':'rue du poivre 40',   'postal':'5000',    'mail':'dupontmarie@gmail.com' ,    'gsm':'0412345678' ,  'statut':'client'},
    2:{'nom':'y',  'prenom':'yy',   'rue':'rue du poivre 25',   'postal':'5000',    'mail':'lambday@gmail.com' ,    'gsm':'0499999999' ,  'statut':'gerant'}
}


#======================================= Enregistrement de l utilisateur =======================================# 
def Register_Menu():
    #desactive la fenetre initiale root
    root.attributes("-disabled",True)
    
    #crée une autre fenetre pour contenir les données entrée par l utilisateur
    register_window = tk.Toplevel(root)
    register_window.title("Enregistrement utilisateur")
    register_window.geometry("300x500")

    def user_register():
        if (Sname_entry.get()!='' and Fname_entry.get()!='' and rue_entry.get()!='' and postal_entry.get()!='' and mail_entry.get()!='' and tel_entry.get()!='' and len(choix.get())>3 ) :
            emplacement=len(personnes)+1
            personnes[emplacement]={'nom':Sname_entry.get(),'prenom':Fname_entry.get(),'rue':rue_entry.get(),'postal':postal_entry.get(),'mail':mail_entry.get() ,'gsm':tel_entry.get() ,'statut':choix.get()}

            #réactive la fenetre principale et detruit al fenetre actuel
            root.attributes("-disabled",False)
            print(personnes)
            register_window.destroy()

        else:
            error_label.config(text="Veuillez remplir tout les champs svp")

    def retour():
        root.attributes("-disabled",False)
        register_window.destroy()
        print(personnes)
            

    #crée les differents champs d entrée
    Title_label = tk.Label(register_window, text="|Info utilisateur|")
    Title_label.pack(side="top",anchor="center",pady=10)

    Fname_label = tk.Label(register_window, text="Prenom : ")
    Fname_label.pack(side="top",anchor="center")
    Fname_entry = tk.Entry(register_window)
    Fname_entry.pack(side="top",anchor="center",pady=1)

    Sname_label = tk.Label(register_window, text="Nom : ")
    Sname_label.pack(side="top",anchor="center")
    Sname_entry = tk.Entry(register_window)
    Sname_entry.pack(side="top",anchor="center",pady=1)

    mail_label = tk.Label(register_window, text="Adresse mail : ")
    mail_label.pack(side="top",anchor="center")
    mail_entry = tk.Entry(register_window)
    mail_entry.pack(side="top",anchor="center",pady=1)

    tel_label = tk.Label(register_window, text="Numero de tel : ")
    tel_label.pack(side="top",anchor="center")
    tel_entry = tk.Entry(register_window)
    tel_entry.pack(side="top",anchor="center",pady=1)

    rue_label = tk.Label(register_window, text="Rue : ")
    rue_label.pack(side="top",anchor="center")
    rue_entry = tk.Entry(register_window)
    rue_entry.pack(side="top",anchor="center",pady=1)

    postal_label = tk.Label(register_window, text="Code postal : ")
    postal_label.pack(side="top",anchor="center")
    postal_entry = tk.Entry(register_window)
    postal_entry.pack(side="top",anchor="center",pady=10)

    choix =tk.StringVar()
    champChoix=tk.Frame(register_window)
    champChoix.pack(side="top",anchor="center")
    client_perm=tk.Checkbutton(champChoix,text="Client",variable=choix,onvalue="client",offvalue=" ")
    client_perm.pack(side="left")
    client_perm=tk.Checkbutton(champChoix,text="Personnel",variable=choix,onvalue="personnel",offvalue=" ")
    client_perm.pack(side="left")
    client_perm=tk.Checkbutton(champChoix,text="Gérant",variable=choix,onvalue="gerant",offvalue=" ")
    client_perm.pack(side="left")
    client_perm=tk.Checkbutton(champChoix,text="Externe",variable=choix,onvalue="externe",offvalue=" ")
    client_perm.pack(side="left")
    
    #Boutons pour enregister données dans le dic/BD

    validate_button=tk.Button(register_window,text="Valider",command=user_register)
    validate_button.pack(pady=10)
    validate_button.configure(bg="#90EE90")

    back_button=tk.Button(register_window,text="Retour",command=retour)
    back_button.pack()
    back_button.configure(bg="salmon")

    error_label = tk.Label(register_window, text="")
    error_label.pack()
    
#======================================= Connection  de l utilisateur =======================================# 

def Login_Menu(personnes):

    if valid_user():

        user_index=get_user_index(root_prenom_entry.get(),root_nom_entry.get())

        def back_home():
                root.attributes("-disabled",False)
                UserMenu_window.destroy()
        
        def back_login_menu(actual_window):
            UserMenu_window.attributes("-disabled",False)
            actual_window.destroy()


        def display_user_info():

            #pour mySQL table - https://www.plus2net.com/python/tkinter-mysql.php
            UserInfo_window=tk.Toplevel(UserMenu_window)
            UserInfo_window.geometry('300x500')
            UserInfo_window.title("Info Utilisateur")

            for things in personnes[int(user_index)]:
                #print(things, type(things))
                userInfo=tk.Label(UserInfo_window,text=f'{things} : {personnes[int(user_index)][things]}')
                userInfo.pack(side="top",anchor="center")
            
            backUserInfo=tk.Button(UserInfo_window,text="Retour",command=lambda:back_login_menu(UserInfo_window))
            backUserInfo.pack(side="top",pady=50)
            backUserInfo.configure(bg="salmon")

            
            

        def reservation_rest():
            pass

        def rapport_rest():
            pass

        def un_sub():
            pass

        UserMenu_window=tk.Toplevel(root)
        UserMenu_window.geometry('300x500')
        root.attributes("-disabled",True)
        login_title=tk.Label(UserMenu_window,text=f'Bonjour {root_prenom_entry.get()}',pady=30)
        login_title.pack()

        info_user=tk.Button(UserMenu_window,text="Info Utilisateur",command=display_user_info)
        info_user.pack(anchor='center',pady=10)

        reservation=tk.Button(UserMenu_window,text="Réservation",command=reservation_rest)
        reservation.pack(anchor='center',pady=10)

        print(personnes[user_index]["statut"])
        if personnes[user_index]["statut"]=="gerant":
            rapportA=tk.Button(UserMenu_window,text="Rapport Annuel",command=rapport_rest)
            rapportA.pack(anchor='center',pady=10)

            rapportM=tk.Button(UserMenu_window,text="Rapport Mensuel",command=rapport_rest)
            rapportM.pack(anchor='center',pady=10)

        xxx=tk.Button(UserMenu_window,text="Option à choisir")
        xxx.pack(anchor='center',pady=10)

        unsub=tk.Button(UserMenu_window,text="Se desinscrire",command=un_sub)
        unsub.pack(anchor='center',pady=10)

        log_out=tk.Button(UserMenu_window,text="Se déconecter",command=back_home)
        log_out.pack(anchor='center',pady=50)
        log_out.configure(bg="salmon")
            

        #def Info_Menu():


        #def Rapport_Menu():


        #def Reservation_Menu():


def valid_user():
    for gens in personnes.values() :
        #print("boucle1 passée")
        if (root_prenom_entry.get() == gens['prenom'] and root_nom_entry.get() == gens['nom']):
            #print("cond1 passée")
            return True
        else:
            invalid_login.config(text="Nom ou Prenom invalide")
            #print("erreur")
            

def get_user_index(firstName,secName):
    for index, personne in personnes.items():
        if firstName == personne['prenom'] and secName == personne['nom']:
            return index


# Boutons de la fenêtre principale
message_home = tk.Label(root,text="| Bienvenue au restaurant Lephare |")
sign_button = tk.Button(root, text="Sign", command=Register_Menu)
Fname_label = tk.Label(root,text="Entrez votre nom :")
Sname_label = tk.Label(root,text="Entrez votre prenom :")
login_button = tk.Button(root, text="Login", command=lambda :Login_Menu(personnes))
invalid_login = tk.Label(root,text='')

root_nom_entry=tk.StringVar()
root_prenom_entry=tk.StringVar()

root_nom = tk.Entry(root,textvariable=root_nom_entry)
root_prenom = tk.Entry(root,textvariable=root_prenom_entry)


message_home.pack(side="top",pady=5)
sign_button.pack(side="top", pady=20)
login_button.pack(side="top", pady=10)

Fname_label.pack()
root_nom.pack(side="top")
Sname_label.pack()
root_prenom.pack(side="top")
invalid_login.pack()


# Démarrer la boucle principale
root.mainloop()

#-Liens utiles-
# https://docs.python.org/fr/3/library/tkinter.ttk.html?highlight=label%20variable
# https://stackoverflow.com/questions/18736465/how-to-center-a-tkinter-widget
# https://www.youtube.com/watch?v=YXPyB4XeYLA
# https://www.youtube.com/watch?v=ibf5cx221hk
