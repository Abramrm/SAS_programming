	
  /* CSV */
    
data nom_table ;
infile "path/Fichier_CSV.csv" dsd dlm='|' truncover firstobs=2; /* Nom du fichier CSV à importer + délimitateur = "|" 
+ première observation sur la deuxième ligne */
input 	VAR1 : $32. /* On force SAS à appeler la première variable (colonne) "VAR1" et à lui attribuer un type character de longueur 32 */
			VAR2 : $32.
			VAR3 : $200.
      /* ETC... /
	;
run;
