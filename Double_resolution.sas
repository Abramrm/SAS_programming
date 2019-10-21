	data _NULL_;
				set Table_construction;
					call symput("H",_N_); /* Macro varaible 'H' prends le nombre d'observations (_N_) comme valeur */
					call symput("Macro_var1"!!LEFT(_N_),compress(var1)); /* La macro variable 1 prends les valeurs des données de la colonne 'var1' auxquelle on concatène le numéro de ligne (_N_) */
					
          /* etc... call symput("Macro_varX"!!LEFT(_N_),compress(VarX)); 
          
          ... */
			run;

	/* Boucle qui cree les macro-variables qui regroupent les variables à appeler */
	%macro boucle_input_H;
		%do j = 1 %to &H;
			%global VARH&j;
				proc sql noprint;
					select VARIABLE_MRV into : VARH&j. separated by  " " from input2 
				where TABLE = "&&TABLEH&j.";
				quit;
		%end;
	%mend ;
	%boucle_input_H;

	/* Macro-fonction qui cree la table qui regroupe variables "brutes" */
	%macro merge_table_H();
			data input_fin ;
			merge 
					info (in = a)
				%do j = 1 %to &H. ; 
					&&BIBH&j...&&TABLEH&j.(keep = Clé_primaire &&VARH&j.) 
				%end ;
				;
			by SIREN DATE_DEB_EXERCICE DATE_FIN_EXERCICE ;
			if a;
			run; 
	%mend ;
	%merge_table_H();
