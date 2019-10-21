/* Code à placer en début et fin de LOG */

/* Création d'un fichier de log */
proc printto log= "Path/Nom_de_la_log.txt" new; /* Option 'new' écrase la précédente log du même nom */
run;


/* CODE SAS */


/* Termine l'écriture de la Log */
proc printto; 
run;

/* Attention : sans fermeture de la procéture, le log continuera de se remplir 
avec les résultat d'autres scripts SAS */

/* Attention 2 : Si on appelle un script dans un script (%include 'nom_fichier_sas'), 
faire attention à l'enchainement des commandes de LOG */
