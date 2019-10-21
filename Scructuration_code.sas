/***********************************************************************************
							MON PROJET
***********************************************************************************/

/***********************************************************************************
/*
/*  0 - Initialisation : On applique des options
/*
***********************************************************************************/

	option compress = binary; /* Option de compression données chiffrées */
	options fullstimer;
	OPTIONS MSGLEVEL=I;
	
/***********************************************************************************/
/*  Parametrage de la production des fichiers :
/*  Déclaration des macro variables qui vont permettre de paramétrer le script
/***********************************************************************************/
	/* paramètre 1 (année) */
	%let param1 = 2018;
	
  /* paramètre 2 (Dossier de script) */
	%let param2 = /home/Dossier_du_script;
  
  /* paramètre 3 (Dossier des output) */
	%let param3 = /home/Dossier_output;
  
  /* paramètre 4 (Dossier des input) */
	%let param4 = /home/Dossier_input;
  
  
/***********************************************************************************/
/*  Inclusion de scripts (fonctions, etc.) (ici viennent du dossier de scripts
/***********************************************************************************/
	
	/* Fonctions de calcul (générales) */
	%include "&param2./Macro_fonctions_calcul.sas";
	
	/* Fonctions spécifiques */
	%include "&param2./Fonctions_spe.sas";


/***********************************************************************************/
/*  Creation des sous-dossiers
/***********************************************************************************/

data _null_;
		newdir=dcreate("Sous_dossier_output1","&param3./"); /* On créer un premier sous-dossier dans le dossier 'output' */
run;
data _null_;
		newdir=dcreate("Sous_dossier_output2","param3./"); /* On créer un deuxième sous-dossier dans le dossier 'output' */
run;

/***********************************************************************************/
/*  Sources de donnees
/***********************************************************************************/

	libname Data1 	"&param4./Data1"; /* Schéma de tables SAS */
	
	Libname DATA_POSTGRE	postgres server=mrvpgsd101 port=5432 user="&userid." password="&pwd." 
	database=prod 	schema=nom_schema	CONOPTS='UseServerSidePrepare=1;UseDeclareFetch=1' READBUFF=32767; /* Schéma PostGre SQL*/
	
	libname DATA_ORACLE 	 oracle user="&userid." password="&pwd." path=oramrv schema=nom_schema; /* Schéma Oracle SQL */
		
/***********************************************************************************/
/*  Lancement du projet
/***********************************************************************************/

	/* Preparation des données */
	%include "&param2./script1.sas";
	
	/* Mise en forme des feuilles du tableur final */
	%include "&param2./script2.sas";
	
	/* Production des tableurs (XLSX) pour chaque secteur d'activité */
	%include "&param2./script3.sas";
