unit UnitMenu;

interface
uses UnitPersonnage, GestionEcran, unitLieu, TypInfo, Keyboard, Classes, SysUtils, unitInventaire, unitDate;

//Procédure qui affiche le menu initial
procedure menuInitial(var fin : Boolean);

//Procédure pour lancer le jeu
procedure LaunchGame();

//Procédure pour quitter le jeu
procedure QuitGame(var fin : Boolean);

//Procédure pour afficher l'interface du jeu
procedure InterfaceInGame();

//Affiche le choix effectué par l'utilisateur dans le menu du jeu (Menu sur la gauche)
procedure gestionMenu(var perso : Personnage; var inventairePerso : Inventaire; var indicateur : Integer; var nomEquipement : String);

//Procédure qui renvoie la touche du clavier pressée
function Key() : TKeyEvent;

//Efface l'écran et reconstitue le cadre
procedure redo();

//Procédure qui permet d'afficher un menu à partir d'une liste de texte (par exemple pour le menu initial)
procedure afficherListeMenu(ListeTexte : array of String; coordMenuInitial : coordonnees; distanceEntreTexte : Integer);

//Affiche une selection pour un menu (Pour l'esthetique du choix et pour savoir quel choix est selectionné)
function selectionMenu(coordMin : coordonnees; nbText, distanceEntreTexte, distanceDuFond, couleurFondTexte, couleurTexte : Integer) : Integer;

//Affiche une selection pour un menu (Pour l'esthetique du choix et pour savoir quel choix est selectionné) et en plus affiche le menu du jeu (Quêtes, Inventaire ...) (suivant le même fonctionnement)
function selectionMenuEtInterface(coordMin : coordonnees; nbText, distanceEntreTexte, distanceDuFond, couleurFondTexte, couleurTexte : Integer) : Integer;

//Procédure pour écrire un texte sur une largeur donnée (justifié)
procedure ecrireTexte(posCoord : coordonnees; textToWrite : String; largeur : Integer);

//Fonction writeln mais saute d'abord une ligne et marche avec des coordonnées non fixe (juste pour sauter une ligne)
procedure writelnPerso();

//Fonction writeln mais saute d'abord une ligne et marche avec des coordonnées non fixe
procedure writelnPerso(ligneAEcrire : String);

procedure readlnPerso();

//Fonction readln mais saute d'abord une ligne et marche avec des coordonnées non fixe (pour une chaine de caractères)
procedure readlnPerso(var ligneAEnregistrer : String);

//Fonction readln mais saute d'abord une ligne et marche avec des coordonnées non fixe (pour un entier)
procedure readlnPerso(var ligneAEnregistrer : Integer);

//Renvoie une coordonnée située en x et y
function posXY(x, y : Integer) : coordonnees;


implementation

//Procédure qui affiche le menu initial
procedure menuInitial(var fin : Boolean);
var
  coorT : coordonnees; //Coordonnées contenant l'emplacement du coin supérieur gauche des cadres dessiné
  ListeMenuInitial : array of String; //Tableau qui contient les textes à afficher dans le menu principal
  choiceMenu : Integer; //Entier correspondant au choix de l'utilisateur (Jouer ou quitter)
  asciiText : String; //Chaine de caractères contenant l'ascii art du titre
begin
  coorT.x := 94;      //Coor Texte
  coorT.y := 38;

  redo();
  couleurTexte(White);

  asciiText :=             '      #######      /                            ##### ##                                                              ';
  asciiText := asciiText + '    /       ###  #/                          ###### #####                          #                                  ';
  asciiText := asciiText + '   /         ##  ##                         /#   / ##  ###                        ###                           #     ';
  asciiText := asciiText + '   ##        #   ##                        /    / ##    ###                        #                           ##     ';
  asciiText := asciiText + '    ###          ##                            / ##      ##                                                    ##     ';
  asciiText := asciiText + '   ## ###        ##   ##  ##   ####           ## ##      ## ###  /###     /###   ###      /##       /###     ######## ';
  asciiText := asciiText + '    ### ###      ##   ###  ##    ###  /       ## ##      ##  ###/ #### / / ###  / ###    / ###     / ###  / ########  ';
  asciiText := asciiText + '      ### ###    ##    #   ##     ###/      /### ##      /    ##   ###/ /   ###/  ###   /   ###   /   ###/     ##     ';
  asciiText := asciiText + '        ### /##  ##   #    ##      ##      / ### ##     /     ##       ##    ##   ##   ##    ### ##            ##     ';
  asciiText := asciiText + '          #/ /## ##  #     ##      ##         ## ######/      ##       ##    ##   ##   ########  ##            ##     ';
  asciiText := asciiText + '           #/ ## ## ##     ##      ##         ## ######       ##       ##    ##   ##   #######   ##            ##     ';
  asciiText := asciiText + '            # /  ######    ##      ##         ## ##           ##       ##    ##   ##   ##        ##            ##     ';
  asciiText := asciiText + '  /##        /   ##  ###   ##      ##         ## ##           ##       ##    ##   ##   ####    / ###     /     ##     ';
  asciiText := asciiText + ' /  ########/    ##   ### / #########         ## ##           ###       ######   /##    ######/   ######/      ##     ';
  asciiText := asciiText + '/     #####       ##   ##/    #### ###        ## ##            ###       ####    ##/     #####     #####        ##    ';
  asciiText := asciiText + '|                                   ###       #  ##                              ##                                   ';
  asciiText := asciiText + ' \)                          #####   ###        ##                              #/                                    ';
  asciiText := asciiText + '                           /#######  /#        ##                             #/                                      ';
  asciiText := asciiText + '                          /      ###/       ###                                                                       ';
  ecrireTexte(posXY(40, 10), asciiText, 118);
  setLength(ListeMenuInitial, 2);

  ListeMenuInitial[0] := '    Jouer    ';
  dessinercadre(posXY(coorT.x-5, coorT.y-2), posXY(coorT.x+length(ListeMenuInitial[0])+4,coorT.y+2), double, White, Black);
  ListeMenuInitial[1] := '   Quitter   ';
  dessinercadre(posXY(coorT.x-5, coorT.y-2+5), posXY(coorT.x+length(ListeMenuInitial[1])+4,coorT.y+2+5), double, White, Black);
  afficherListeMenu(ListeMenuInitial, coorT, 5);
  choiceMenu := selectionMenu(coorT, 2, 5, 12, LightBlue, White);

  if choiceMenu = 0 then
    LaunchGame()
  else
    QuitGame(fin);
end;


//Procédure pour lancer le jeu
procedure LaunchGame();
var
  text : String; //Variable qui enregistre le texte à afficher
  coorT : coordonnees; //Variable qui enregistre les coordonnées du cadre (coin supérieur gauche)
begin
  redo();
  coorT.x := 72;
  coorT.y := 27;
  text := 'Pour selectionner le menu, appuyez sur "tab" !';

  dessinercadre(coorT, posXY(coorT.x+length(text)+5, coorT.y+4), double, White, Black); //On dessine le cadre qui entoure le texte
  ecrireEnPosition(posXY(coorT.x+4, coorT.y), ' Conseil ');
  ecrireEnPosition(posXY(coorT.x+3,coorT.y+2), text);

  readlnPerso();
  createCharacter();
end;

//Procédure pour quitter le jeu
procedure QuitGame(var fin : Boolean);
var
  rep : Integer; //Entier correspondant au choix de l'utilisateur (oui ou non)
  coordOrigin : coordonnees; //Coordonnées correspondant à la position des textes
  listeTexte : array of String; //Tableau qui contient les textes à afficher dans la selection (oui ou non)
begin
  redo();

  coordOrigin.x := 97;
  coordOrigin.y := 29;
  
  ecrireEnPosition(posXY(83, coordOrigin.y-2), 'Etes vous sur de vouloir quitter ?');

  setLength(listeTexte, 2);
  listeTexte[0] := ' oui ';
  listeTexte[1] := ' non ';
  afficherListeMenu(listeTexte, coordOrigin, 2);
  rep := selectionMenu(coordOrigin, 2, 2, 4, LightBlue, White);
  if rep = 0 then
    begin
    ecrireEnPosition(posXY(87, coordOrigin.y+4), 'Au plaisir de vous revoir !');
    fin := true;
    end
  else
     menuInitial(fin);
end;

//Procédure pour afficher l'interface du jeu
procedure InterfaceInGame();
var
  posTemp, //Position initial de la ligne de séparation entre l'interface (en haut) et le menu (à gauche)
  posInterface, //Position du contenu de l'interface
  posCadre1 : coordonnees; //Position du coin haut gauche
  i : Integer; //Variable de boucle
  textTemp : String; //Variable qui affiche chaque ligne de l'inventaire
  listeInterface : array of String; //Tableau qui contient les textes à afficher dans le menu à gauche
begin
  redo();
  posInterface.x := 5;
  posInterface.y := 4;
  posCadre1.x := 3;

  textTemp := 'Pseudo : ' + getPersonnage().pseudo;
  ecrireEnPosition(posInterface, textTemp);
  posInterface.y := posInterface.y+1;

  textTemp := 'Race : ' + GetEnumName(TypeInfo(race), Ord(getPersonnage().race));
  ecrireEnPosition(posInterface, textTemp);
  posInterface.y := posInterface.y+1;

  textTemp := 'PV : ' + IntToStr(getPersonnage().pv) + ' / ' + IntToStr(getPersonnage().pvMax);
  ecrireEnPosition(posInterface, textTemp);
  posInterface.y := posInterface.y+1;

  textTemp := 'Bourse : ' + IntToStr(getPersonnage().argent) + ' Gold';
  ecrireEnPosition(posInterface, textTemp);
  posInterface.y := posInterface.y+1;

  textTemp := 'Position : ' + getPosition().nom;
  ecrireEnPosition(posInterface, textTemp);
  posInterface.y := posInterface.y+1;

  textTemp := 'Date : ';
  ecrireEnPosition(posInterface, textTemp);
  writeDate();
  posInterface.y := posInterface.y+1;

  posCadre1.y := posInterface.y+2;
  couleurTexte(Red);
  deplacerCurseur(posCadre1);
  for i := posCadre1.x-1 to 195 do //On dessine la ligne du bas
    write(#205);

  posTemp := posCadre1;
  posCadre1.x := 25;
  for i := posCadre1.y to 56 do
    begin
    posCadre1.y := posCadre1.y + 1;
    deplacerCurseur(posCadre1);
    write(#186);
    end;
  couleurTexte(White);

  setLength(listeInterface, 2);
  listeInterface[0] := 'Personnage';
  listeInterface[1] := 'Inventaire';

  posCadre1.x := 9;
  posCadre1.y := posTemp.y + 3;
  afficherListeMenu(listeInterface, posCadre1, 5);

  posCadre1.x := 28;
  posCadre1.y := posTemp.y+1;
  deplacerCurseur(posCadre1);
end;

//Procédure qui n'est pas dans l'interface et qui affiche toutes les informations du personnage
procedure afficheMenuPersonnage();
var
  asciiArtText : String; //Chaine de caractères contenant l'ascii art du livre
  coorTemp : coordonnees; //Coordonnées de la position du coin supérieur gauche de l'ascii art
begin
  InterfaceInGame();

  coorTemp := positionCurseur();

  asciiArtText :=                '    ____________________   ____________________    ';
  asciiArtText := asciiArtText + '.-/|                    \ /                    |\-.';
  asciiArtText := asciiArtText + '||||                     |                     ||||';
  asciiArtText := asciiArtText + '||||                     |        ~~*~~        ||||';
  asciiArtText := asciiArtText + '||||                     |                     ||||';
  asciiArtText := asciiArtText + '||||                     |                     ||||';
  asciiArtText := asciiArtText + '||||                     |                     ||||';
  asciiArtText := asciiArtText + '||||                     |      --==*==--      ||||';
  asciiArtText := asciiArtText + '||||                     |                     ||||';
  asciiArtText := asciiArtText + '||||                     |                     ||||';
  asciiArtText := asciiArtText + '||||                     |                     ||||';
  asciiArtText := asciiArtText + '||||                     |                     ||||';
  asciiArtText := asciiArtText + '||||                     |                     ||||';
  asciiArtText := asciiArtText + '||||                     |                     ||||';
  asciiArtText := asciiArtText + '||||____________________ | ____________________||||';
  asciiArtText := asciiArtText + '||/=====================\|/=====================\||';
  asciiArtText := asciiArtText + '\----------------------~___~---------------------/ ';
  ecrireTexte(positionCurseur(), asciiArtText, 51);

  deplacerCurseur(posXY(coorTemp.x+5, coorTemp.y+2));
  writelnPerso('Pseudo : ' + getPersonnage().pseudo);
  writelnPerso('Race : ' + GetEnumName(TypeInfo(race), Ord(getPersonnage().race)));
  writelnPerso('PV : ' + IntToStr(getPersonnage().pv) + ' / ' + IntToStr(getPersonnage().pvMax));
  writelnPerso('Bourse : ' + IntToStr(getPersonnage().argent) + ' Gold');
  writelnPerso();
  writelnPerso('     --==*==--');
  writelnPerso();
  writelnPerso('Attaque : ' + IntToStr(getPersonnage().attaque));
  writelnPerso('Defense : ' + IntToStr(getPersonnage().defense));
  readlnPerso();
end;

//Affiche le choix effectué par l'utilisateur dans le menu du jeu (Menu sur la gauche)
procedure gestionMenu(var perso : Personnage; var inventairePerso : Inventaire; var indicateur : Integer; var nomEquipement : String);
begin
  if GetChoixMenu() = -1 then //Affiche les informations du personnage
    afficheMenuPersonnage()
  else if GetChoixMenu() = -2 then //Affiche l'inventaire du personnage
    begin
      InterfaceInGame();
      afficheInventaire(inventairePerso);
      equipement(perso,inventairePerso,indicateur,nomEquipement);
    end;
end;

//Procédure qui renvoie la touche du clavier pressée
function Key() : TKeyEvent;
var
  K:TKeyEvent;
begin
InitKeyBoard;
  Repeat
    K:=GetKeyEvent;
    K:=TranslateKeyEvent(K);
  until (GetKeyEventChar(K)<>'');
  Key :=K;
DoneKeyBoard;
end;

//Efface l'écran et reconstitue le cadre
procedure redo();
var
  coorC, //Coordonnées du coin du cadre supérieur gauche
  coorC2 : coordonnees; //Coordonnées du coin du cadre inférieur droit
  largeur, //Largeur de l'écran
  hauteur : Integer; //Hauteur de l'écran
begin
  largeur := 200;
  hauteur := 60;
  coorC.x := 2;      //Coor 1
  coorC.y := 1;
  coorC2.x := largeur-3;     //Coor 2
  coorC2.y := hauteur-2;

  effacerEcran();
  changerTailleConsole(largeur,hauteur);
  dessinerCadre(coorC,coorC2,double,4,0);
  couleurTexte(White);
end;

//Procédure qui permet d'afficher un menu à partir d'une liste de texte (par exemple pour le menu initial)
procedure afficherListeMenu(ListeTexte : array of String; coordMenuInitial : coordonnees; distanceEntreTexte : Integer);
var
  i : Integer; //Variable de la boucle
  coordTemp : coordonnees; //Coordonnées de chaque texte
begin
  coordTemp.x := coordMenuInitial.x;
  coordTemp.y := coordMenuInitial.y;
  for i:=low(ListeTexte) to high(ListeTexte) do
      begin
      ecrireTexte(coordTemp, ListeTexte[i], 120);
      coordTemp.y := coordTemp.y + distanceEntreTexte;
      end;
end;

//Affiche une selection pour un menu (Pour l'esthetique du choix et pour savoir quel choix est selectionné)
function selectionMenu(coordMin : coordonnees; nbText, distanceEntreTexte, distanceDuFond, couleurFondTexte, couleurTexte : Integer) : Integer;
var
  coordTemp, //Variable de travail qui coorespond aux coordonnées de chaque ligne
  coordMax : coordonnees; //Coordonnées du premier choix
  selectedChoice : Integer; //Choix selectionné par l'utilisateur
  Touche : TKeyEvent; //Touche tapé par l'utilisateur
begin
  deplacerCurseur(CoordMin);
  coordTemp.x := coordMin.x;
  coordTemp.y := coordMin.y;
  ColorierZone(couleurFondTexte, couleurTexte, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
  coordMax.y := coordMin.y + (nbText-1)*distanceEntreTexte;
  coordMax.x := coordMin.x;
  repeat
    Touche := Key();
    if (KeyEventToString(Touche)='Up') then //On teste si la touche pressée est la flêche du haut
       if coordTemp.y = coordMin.y then
          begin
          ColorierZone(0, 15, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
          coordTemp := coordMax;
          deplacerCurseur(coordTemp);
          ColorierZone(couleurFondTexte, couleurTexte, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
          end
       else
          begin
          ColorierZone(0, 15, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
          coordTemp.y := coordTemp.y-distanceEntreTexte;
          deplacerCurseur(coordTemp);
          ColorierZone(couleurFondTexte, couleurTexte, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
          end
    else if (KeyEventToString(Touche)='Down') then //On teste si la touche pressée est la flêche du bas
       if coordTemp.y = coordMax.y then
          begin
          ColorierZone(0, 15, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
          coordTemp := coordMin;
          deplacerCurseur(coordTemp);
          ColorierZone(couleurFondTexte, couleurTexte, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
          end
       else
          begin
          ColorierZone(0, 15, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
          coordTemp.y := coordTemp.y+distanceEntreTexte;
          deplacerCurseur(coordTemp);
          ColorierZone(couleurFondTexte, couleurTexte, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
          end;

  until (KeyEventToString(Touche)=chr(13));
  selectedChoice := (coordTemp.y - CoordMin.y) div distanceEntreTexte; //On fait correspondre le choix effectué en calculant
  deplacerCurseur(coordMax);
  selectionMenu:=selectedChoice;
end;

//Affiche une selection pour un menu (Pour l'esthetique du choix et pour savoir quel choix est selectionné) et en plus affiche le menu du jeu (Quêtes, Inventaire ...) (suivant le même fonctionnement)
function selectionMenuEtInterface(coordMin : coordonnees; nbText, distanceEntreTexte, distanceDuFond, couleurFondTexte, couleurTexte : Integer) : Integer;
var
  coordTempInterface, //Variable de travail qui coorespond aux coordonnées de chaque ligne de l'interface (le menu à gauche)
  coordMinInterface, //Coordonnées du premier choix de l'interface (le menu à gauche)
  coordMaxInterface, //Coordonnées du dernier choix de l'interface (le menu à gauche)
  coordTemp, //Variable de travail qui coorespond aux coordonnées de chaque ligne
  coordMax : coordonnees; //Coordonnées du premier choix
  menuSelectionne, //Entier correspondant au menu séléctionné (à gauche ou à droite)
  selectedChoice : Integer; //Choix selectionné par l'utilisateur
  Touche : TKeyEvent; //Touche tapé par l'utilisateur
begin
  deplacerCurseur(CoordMin);
  coordTemp.x := coordMin.x;
  coordTemp.y := coordMin.y;
  ColorierZone(couleurFondTexte, couleurTexte, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
  coordMax.y := coordMin.y + (nbText-1)*distanceEntreTexte;
  coordMax.x := coordMin.x;


  coordTempInterface.x := 7;
  coordTempInterface.y := 15;
  coordMinInterface := coordTempInterface;
  coordMaxInterface.x := coordTempInterface.x;
  coordMaxInterface.y := coordTempInterface.y + 5;
  menuSelectionne := 0;

  repeat
    Touche := Key();
    if (menuSelectionne = 1) then //On teste si le menu selectionné correspond au menu du jeu (Quêtes, Inventaire ...)
       begin
       if (KeyEventToString(Touche)=chr(9)) then //On teste si la touche pressée est tab
          begin
          ColorierZone(0, 15, coordTempInterface.x, coordTempInterface.x+13, coordTempInterface.y);
          menuSelectionne := 0;
          ColorierZone(couleurFondTexte, couleurTexte, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
          end
       else if (KeyEventToString(Touche)='Up') then //On teste si la touche pressée est la flêche du haut
         if coordTempInterface.y = coordMinInterface.y then
            begin
            ColorierZone(0, 15, coordTempInterface.x, coordTempInterface.x+13, coordTempInterface.y);
            coordTempInterface := coordMaxInterface;
            deplacerCurseur(coordTempInterface);
            ColorierZone(couleurFondTexte, couleurTexte, coordTempInterface.x, coordTempInterface.x+13, coordTempInterface.y);
            end
         else
            begin
            ColorierZone(0, 15, coordTempInterface.x, coordTempInterface.x+13, coordTempInterface.y);
            coordTempInterface.y := coordTempInterface.y-5;
            deplacerCurseur(coordTempInterface);
            ColorierZone(couleurFondTexte, couleurTexte, coordTempInterface.x, coordTempInterface.x+13, coordTempInterface.y);
            end
      else if (KeyEventToString(Touche)='Down') then //On teste si la touche pressée est la flêche du bas
         if coordTempInterface.y = coordMaxInterface.y then
            begin
            ColorierZone(0, 15, coordTempInterface.x, coordTempInterface.x+13, coordTempInterface.y);
            coordTempInterface := coordMinInterface;
            deplacerCurseur(coordTempInterface);
            ColorierZone(couleurFondTexte, couleurTexte, coordTempInterface.x, coordTempInterface.x+13, coordTempInterface.y);
            end
         else
            begin
            ColorierZone(0, 15, coordTempInterface.x, coordTempInterface.x+13, coordTempInterface.y);
            coordTempInterface.y := coordTempInterface.y+5;
            deplacerCurseur(coordTempInterface);
            ColorierZone(couleurFondTexte, couleurTexte, coordTempInterface.x, coordTempInterface.x+13, coordTempInterface.y);
            end;
       end
    else //Sinon on est dans le menu qu'on veut implémenter (donc pas du jeu)
    begin;
      if (KeyEventToString(Touche)=chr(9)) then //On teste si la touche pressée est tab
         begin
         ColorierZone(0, 15, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
         menuSelectionne := 1;
         ColorierZone(couleurFondTexte, couleurTexte, coordTempInterface.x, coordTempInterface.x+13, coordTempInterface.y);
         end
      else if (KeyEventToString(Touche)='Up') then //On teste si la touche pressée est la flêche du haut
         if coordTemp.y = coordMin.y then
            begin
            ColorierZone(0, 15, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
            coordTemp := coordMax;
            deplacerCurseur(coordTemp);
            ColorierZone(couleurFondTexte, couleurTexte, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
            end
         else
            begin
            ColorierZone(0, 15, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
            coordTemp.y := coordTemp.y-distanceEntreTexte;
            deplacerCurseur(coordTemp);
            ColorierZone(couleurFondTexte, couleurTexte, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
            end
      else if (KeyEventToString(Touche)='Down') then //On teste si la touche pressée est la flêche du bas
         if coordTemp.y = coordMax.y then
            begin
            ColorierZone(0, 15, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
            coordTemp := coordMin;
            deplacerCurseur(coordTemp);
            ColorierZone(couleurFondTexte, couleurTexte, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
            end
         else
            begin
            ColorierZone(0, 15, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
            coordTemp.y := coordTemp.y+distanceEntreTexte;
            deplacerCurseur(coordTemp);
            ColorierZone(couleurFondTexte, couleurTexte, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
            end;
    end;

  until (KeyEventToString(Touche)=chr(13));

  if (menuSelectionne = 1) then
     selectedChoice := ((coordTempInterface.y - coordMinInterface.y) div 5)*(-1) - 1 //La fonction va renvoyer un nombre négatif si on selectionne le menu du jeu (Quêtes, Inventaire ...)
  else
     selectedChoice := (coordTemp.y - CoordMin.y) div distanceEntreTexte;  //La fonction va renvoyer un nombre positif ou nul si on selectionne le menu qu'on veut implémenter (donc pas du jeu)
  deplacerCurseur(coordMax);
  selectionMenuEtInterface:=selectedChoice;
end;



//Procédure pour écrire un texte sur une largeur donnée (justifié)
procedure ecrireTexte(posCoord : coordonnees; textToWrite : String; largeur : Integer);
var
  tempText : String; //Variable de travail qui contient le texte à écrire moins celui qui à déjà été écrit
  tempPosCoord : coordonnees; //Coordonnées de chaque ligne
begin
  tempPosCoord.y := posCoord.y - 1;
  tempPosCoord.x := posCoord.x;
  tempText := textToWrite;
  while length(tempText) > largeur do
    begin
    tempPosCoord.y := tempPosCoord.y + 1;
    ecrireEnPosition(tempPosCoord, copy(tempText, 0, largeur));
    tempText := copy(tempText, largeur+1, length(tempText)-largeur);
    end;
  if length(tempText) <> 0 then
     begin
     tempPosCoord.y := tempPosCoord.y + 1;
     ecrireEnPosition(tempPosCoord, tempText);
     end;
end;

//Fonction writeln mais saute d'abord une ligne et marche avec des coordonnées non fixe (juste pour sauter une ligne)
procedure writelnPerso();
begin
  deplacerCurseurXY(positionCurseur.x, positionCurseur.y+1);
end;

//Fonction writeln mais saute d'abord une ligne et marche avec des coordonnées non fixe
procedure writelnPerso(ligneAEcrire : String);
var
  posTemp : Integer; //Position en x du premier caractère de la ligne
begin
  posTemp := positionCurseur.x;
  deplacerCurseurXY(positionCurseur.x, positionCurseur.y+1);
  write(ligneAEcrire);
  deplacerCurseurXY(posTemp, positionCurseur.y);
end;

//Fonction readln qui marche avec des coordonnées non fixe (juste pour sauter une ligne)
procedure readlnPerso();
var
  posTemp : coordonnees; //Coordonnées de la position initial de là où on se situe (avant de faire une manipulation)
begin
  posTemp := positionCurseur;
  deplacerCurseurXY(positionCurseur.x, positionCurseur.y+1);
  readln();
  deplacerCurseur(posTemp);
end;

//Fonction readln mais saute d'abord une ligne et marche avec des coordonnées non fixe (pour une chaine de caractères)
procedure readlnPerso(var ligneAEnregistrer : String);
var
  posTemp : coordonnees; //Coordonnées de la position initial de là où on se situe (avant de faire une manipulation)
begin
  posTemp.x := positionCurseur.x;
  posTemp.y := positionCurseur.y+1;
  deplacerCurseur(posTemp);
  read(ligneAEnregistrer);
  deplacerCurseur(posTemp);
end;

//Fonction readln mais saute d'abord une ligne et marche avec des coordonnées non fixe (pour un entier)
procedure readlnPerso(var ligneAEnregistrer : Integer);
var
  posTemp : coordonnees; //Coordonnées de la position initial de là où on se situe (avant de faire une manipulation)
begin
  posTemp.x := positionCurseur.x;
  posTemp.y := positionCurseur.y+1;
  deplacerCurseur(posTemp);
  read(ligneAEnregistrer);
  deplacerCurseur(posTemp);
end;

//Renvoie une coordonnée située en x et y
function posXY(x, y : Integer) : coordonnees;
var
  coordTemp : coordonnees; //Coordonnées renvoyé par la fonction
begin
  coordTemp.x := x;
  coordTemp.y := y;
  posXY := coordTemp;
end;

end.

