
/* PARAMeTRAGE DU RAPPORT */

%let ods = zoom = '80' frozen_headers="1" frozen_rowheaders="2" autofilter="1-107" absolute_column_width = "30px";
/* Parametres proc report */
%let options = NOWD ;
%let column_header = [background=#969491 foreground=black font=(Arial, 10pt, bold) cellheight=1.7cm  verticalalign = middle textalign=center];
%let column_header2 = [background=#e6ffcc foreground=black font=(Arial, 10pt, bold) cellheight=1.7cm tagattr = 'wraptext:yes' verticalalign = middle textalign=center];
%let column = [background = cxeeeeee foreground=black font=(Arial, 9pt) cellheight=0.4cm tagattr = 'wraptext:no' width=100%];

/* PROC REPORT EN EXPORT ODS */

%macro Export_xlsx2;
	ods excel file="Path/nom_fichier.xlsx" /* Création d'un fichier excel avec le procédure ODS*/
  
  options(sheet_name="Nom_onglet1" &ods.); /* Nom du premier onglet + options */

		/* Mise en forme page principale */
		proc report data=Nom_Table_feuille1 &options. /* On indique le nom de la table qui sera exportée dans l'onlget 1 */
			style(header) = &column_header.
			style(column) = &column.;
      
			define VAR1 / style(header) = {background = #ffe6cc}; /* Variable de type "Header" avec un fond de couleur "#ffe6cc"*/
			define VAR2 / style(header) = {background = #ffe6cc};
			define VAR3 / style(header) = {background =  #ffe6cc};
		
		run;

/* Ajout d'une nouvelle page : */
ods excel options(sheet_name="Nom_onglet2" &ods.);

proc report data=Nom_Table_feuille2 &options.
	style(header) = &column_header2.
	style(column) = &column.;
  
	column VAR1 VAR2 VAR3; /* Les variables de la table (Nom_Table_feuille2) qui sont retenues pour créer la feuille xlsx */
  
	define VAR1 /display; /* On indique que l'on veut afficher ces varialbes (necessaire pour "compute")*/
	define VAR2 /display;
	define VAR3 /display;

/* On crée une coloration conditionnelle pour les variables 1 et 2 */
	compute VAR1;
		if (VAR1 > 10 and VAR1 ne .) then call define (_COL_,"style","STYLE=[background=#99cc00]");
	endcomp;
	compute VAR2;
		if (VAR2 > 1000 and VAR2 ne .) then call define (_COL_,"style","STYLE=[background=#99cc00]");
	endcomp;

;
run;

/* ETC... */

ods excel close; /* Une fois qu'on a créer tous nos onglets, on ferme le fichier */

%mend;


%Export_xlsx2; /* Exécution de la macro fonction */
