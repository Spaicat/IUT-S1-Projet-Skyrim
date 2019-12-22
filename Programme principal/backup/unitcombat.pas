unit unitCombat;

{$codepage utf8}

interface
    uses unitPersonnage, unitInventaire, GestionEcran, SysUtils, TypInfo;

  //FONCTIONS ET PROCEDURES

    //Procedure gérant tous les combats
    procedure combat(var perso,monstre: personnage;var inventairePerso : Inventaire;var fuite : Boolean);

    //Fonction permettant de gérer le premier dragon
    function Illyar():personnage;
    
    //Fonction permettant de gérer le second dragon
    function Qjard():Personnage;
    
    //Fonction permettant de gérer le troisième dragon
    function Ksiorn():Personnage;
    
    //Fonction permettant de gérer l'Ivrogne qui est là la nuit sur la place du marché
    function Ivrogne():Personnage;


implementation

uses UnitMenu, unitLieu;

function Illyar():Personnage;
var
   monstre : Personnage; //Monstre correspondant à la fonction

begin
     monstre.pseudo:= 'Illyar';         //On définit les differente statsitique des ennemies
     monstre.pv:= 120;
     monstre.pvMax:=120;
     monstre.attaque:=10;
     monstre.argent:=12;
     Illyar := monstre;
end;

function Qjard():Personnage;
var
   monstre : Personnage; //Monstre correspondant à la fonction

begin
     monstre.pseudo := 'Qjard';         //On définit les differente statsitique des ennemies
     monstre.pv := 125;
     monstre.pvMax := 125;
     monstre.attaque := 11;
     monstre.argent := 12;
     Qjard := monstre;
end;

function Ksiorn():Personnage;
var
   monstre : Personnage; //Monstre correspondant à la fonction

begin
     monstre.pseudo := 'Ksiorn';            //On définit les differente statsitique des ennemies
     monstre.pv := 130;
     monstre.pvMax := 130;
     monstre.attaque := 20;
     monstre.argent := 12;
     Ksiorn := monstre;
end;
function Ivrogne():Personnage;
var
   monstre : Personnage; //Monstre correspondant à la fonction
begin
   monstre.pseudo := 'L''Ivrogne';          //On définit les differente statsitique des ennemies
   monstre.pv := 75;
   monstre.pvMax := 75;
   monstre.attaque := 15;
   monstre.argent := 30;
   Ivrogne := monstre;
end;


//Procedure gérant tous les combats
procedure combat(var perso,monstre: personnage;var inventairePerso : Inventaire;var fuite : Boolean);

var
   sortie: Boolean;     //Variable de sortie de boucle
   choix: Integer;      //Variable qui definie les choix du joueur
   attaque: Integer;     //Variable qui stock l'attaque du personnage et du monstre
   rng : Integer;        //Variable qui stokera une valeur aleatoire
   effet : Integer;     //Variable qui définie l'effet du personnage //0 = rien //1 = étourdissement
   effetDuree : Integer;  //Variable qui compte la duree de l'effet
   asciiText, //Variable qui contient l'ascii art à afficher quand on est mort
   textTemp : String; //Variable qui contient le texte à afficher dans les cadres
   coorTemp : coordonnees; //Variable qui contient l'emplacement (en haut à gauche) des cadres

begin
      randomize;
      sortie := False;
      fuite := False;
      effet := 0;
      effetDuree := 0;

       while sortie=FALSE DO
       begin
         attendre(3000);
         setPersonnage(perso);
         InterfaceInGame();
         writelnPerso();

         //On affiche les informations du monstre
         coorTemp := positionCurseur();
         textTemp := ' PV : ' + IntToStr(monstre.pv) + ' / ' + IntToStr(monstre.pvMax);
         dessinercadre(coorTemp, posXY(coorTemp.x + length(textTemp)+5 + length(monstre.pseudo), coorTemp.y+4), double, White, Black); //On dessine le cadre qui entoure le texte
         ecrireEnPosition(posXY(coorTemp.x+4, coorTemp.y), ' Ennemi : ' + monstre.pseudo + ' ');
         ecrireEnPosition(posXY(coorTemp.x+3, coorTemp.y+2), textTemp);
         deplacerCurseur(posXY(coorTemp.x, coorTemp.y+5));

         //On sélectionne les options
         writelnPerso('Choisissez une option : ');
         writelnPerso(' >  Attaquer');
         writelnPerso(' >  Se defendre');
         writelnPerso(' >  Utiliser une potion');
         writelnPerso(' >  Fuite');
         choix := selectionMenu(posXY(positionCurseur().x, positionCurseur().y-3), 4, 1, 2, LightBlue, White) + 1;

         case choix of
              1:            //Attaque
              begin
                if effet = 1 then           //Si etoudit
                  begin
                  writelnPerso('Vous etes etoudit');
                  rng := random(2);
                  if rng = 1 then
                    begin
                    writelnPerso('Vous n''avez pas reussie a frapper...');      //Cas ou l'étoudissement empèche d'attaquer
                    effetDuree := effetDuree + 1;
                    attaque:= monstre.attaque + random(monstre.attaque div 2);
                    if attaque < 0 then
                      attaque := 0;
                    perso.pv:= perso.pv - attaque;
                    writelnPerso();
                    writelnPerso(monstre.pseudo + ' vous attaque, ' + ' vous subissez ' + IntToStr(attaque) + ' pv. Il vous reste ' + IntToStr(perso.pv) + ' pv.');
                    if effetDuree = 3 then
                      effet := 0;
                    end
                  else
                    begin
                    writelnPerso('Vous frapper malgre l''etourdissement');    //Cas ou on eux quand meme frapper
                    attaque:= perso.attaque + random(perso.attaque div 2);
                    monstre.pv := monstre.pv - attaque;
                    if monstre.pv <= 0 then
                      monstre.pv :=  0;
                    writelnPerso('Vous attaquez ' + monstre.pseudo + ' il subit ' + IntToStr(attaque) + ' pv. Il lui reste ' + IntToStr(monstre.pv) + ' pv.');
                    attaque:= monstre.attaque + random(monstre.attaque div 2);
                    if attaque < 0 then
                      attaque := 0;
                    perso.pv:= perso.pv - attaque;
                    writelnPerso();
                    writelnPerso(monstre.pseudo + ' vous attaque, ' + ' vous subissez ' + IntToStr(attaque) + ' pv. Il vous reste ' + IntToStr(perso.pv) + ' pv.');
                    effetDuree := effetDuree + 1;
                    if effetDuree = 3 then
                      effet := 0;
                    end;
                  end
                else
                  begin
                  attaque:= perso.attaque + random(perso.attaque div 2);
                  monstre.pv := monstre.pv - attaque;
                  if monstre.pv <= 0 then
                    monstre.pv :=  0;
                  writelnPerso('Vous attaquez ' + monstre.pseudo + ' il subit ' + IntToStr(attaque) + ' pv. Il lui reste ' + IntToStr(monstre.pv) + ' pv.');
                  attaque:= monstre.attaque + random(monstre.attaque div 2);
                  if attaque < 0 then
                    attaque := 0;
                  perso.pv:= perso.pv - attaque;
                  writelnPerso();
                  writelnPerso(monstre.pseudo + ' vous attaque, ' + ' vous subissez ' + IntToStr(attaque) + ' pv. Il vous reste ' + IntToStr(perso.pv) + ' pv.');
                  rng := random(4);
                  if rng = 1 then
                    begin
                    writelnPerso('Le coup vous a etoudit !');
                    effet := 1;
                    end;
                  end;
              end;
              2:        //Defense
              begin
                if effet = 1 then
                  begin
                  writelnPerso('Vous etes etoudit');
                  rng := random(2);
                  if rng = 1 then
                    begin
                    writelnPerso('Vous n''avez pas reussie a frapper...');
                    effetDuree := effetDuree + 1;
                    attaque:= monstre.attaque + random(monstre.attaque div 2);
                    if attaque < 0 then
                      attaque := 0;
                    perso.pv:= perso.pv - attaque;
                    writelnPerso();
                    writelnPerso(monstre.pseudo + ' vous attaque, ' + ' vous subissez ' + IntToStr(attaque) + ' pv. Il vous reste ' + IntToStr(perso.pv) + ' pv.');
                    if effetDuree = 3 then
                      effet := 0;
                    end
                  else
                    begin
                    writelnPerso('Vous frapper malgre l''etourdissement');
                    attaque:= perso.attaque + random(perso.attaque div 2);
                    monstre.pv := monstre.pv - attaque;
                    if monstre.pv <= 0 then
                      monstre.pv :=  0;
                    writelnPerso('Vous attaquez ' + monstre.pseudo + ' il subit ' + IntToStr(attaque) + ' pv. Il lui reste ' + IntToStr(monstre.pv) + ' pv.');
                    attaque:= monstre.attaque + random(monstre.attaque div 2);
                    if attaque < 0 then
                      attaque := 0;
                    perso.pv:= perso.pv - attaque;
                    writelnPerso();
                    writelnPerso(monstre.pseudo + ' vous attaque, ' + ' vous subissez ' + IntToStr(attaque) + ' pv. Il vous reste ' + IntToStr(perso.pv) + ' pv.');
                    effetDuree := effetDuree + 1;
                    if effetDuree = 3 then
                      effet := 0;
                    end;
                  end
                else
                  begin
                  attaque:= (perso.attaque div 2) + random(perso.attaque div 2);
                  monstre.pv := monstre.pv - attaque;
                  writelnPerso('Vous contrez ' + monstre.pseudo + ' il subit ' + IntToStr(attaque) + '. Il lui reste ' + IntToStr(monstre.pv));
                  attaque:= (monstre.attaque + random(monstre.attaque div 2)) - perso.defense;
                  if attaque < 0 then
                    attaque := 0;
                  perso.pv:= perso.pv - attaque;
                  writelnPerso(monstre.pseudo + ' vous attaque, ' + ' vous subissez ' + IntToStr(attaque) + ' pv. Il vous reste ' + IntToStr(perso.pv) + ' pv.');
                  end;
              end;
              3:      //Potion
              begin
                if inventairePerso.possession[3] = 0 then       //Vérifie que le joueur ai une potion
                  begin
                  writelnPerso('Vous N''avez pas de potion...');
                  writelnPerso('Choissiser une autre option.');
                  end
                else
                  begin
                  writelnPerso('Vous consommer une potion !');
                  writelnPerso('Vous regagnez 100 PV !');
                  inventairePerso.possession[3] := inventairePerso.possession[3]-1;     //On la consomme
                  perso.pv := perso.pv + 100;
                  if perso.pv > perso.pvMax then
                    perso.pv := perso.pvMax;
                  attaque:= monstre.attaque + random(monstre.attaque div 2);
                  if attaque < 0 then
                    attaque := 0;
                  perso.pv:= perso.pv - attaque;
                  writelnPerso();
                  writelnPerso(monstre.pseudo + ' vous attaque, vous subissez ' + IntToStr(attaque) + ' pv. Il vous reste ' + IntToStr(perso.pv) + ' pv.');
                  rng := random(4);
                  if rng = 1 then
                    begin
                    writelnPerso('Le coup vous a etoudit !');
                    effet := 1;
                    end;
                  end;
              end;
              4:            //Fuite
              begin
                rng := random(2);
                if rng = 1 then
                  begin
                  writelnPerso('Vous vous enfuyez !');      //Cas ou on reussie a fuir
                  sortie:= True;
                  fuite := True;
                  readlnPerso();
                  end
                else
                  begin
                  writelnPerso('Vous n''avez pas reussi a vous enfuir...');         //Cas ou on ne reussie pas a fuir
                  attaque:= (monstre.attaque + random(monstre.attaque div 2)) - perso.defense;
                  perso.pv:= perso.pv - attaque;
                  writelnPerso(monstre.pseudo + ' vous attaque, vous subissez ' + IntToStr(attaque) + ' pv. Il vous reste ' + IntToStr(perso.pv) + ' pv.');
                  rng := random(5);
                  if rng = 1 then
                    begin
                    writelnPerso('Le coup vous a etoudit !');
                    effet := 1;
                    end;
                  end;
              end;
       end;
         if monstre.pv<=0 then          //Si on gagne le combat
           begin
             sortie := True;
             writelnPerso('Vous avez gagnez !!');
             writelnPerso('Vous gagnez ' + IntToStr(monstre.argent) + ' or !');
             perso.argent := perso.argent + monstre.argent;
             readlnPerso();
           end;
         if perso.pv <= 0 then          //Si on  plus de point de vie
           begin
           redo();
           asciiText :=             '##           ##                                                                                                                                              ##';
           asciiText := asciiText + '`##         ##                                                      ,#                                                                             ,#        ##';
           asciiText := asciiText + ' `##       ##                                                       ##                                                                             ##        ##';
           asciiText := asciiText + '  `##     ##   ,a#####a,   ##       ##  ,a#####a,      ,a#####a,  #######  ,a#####a,  ,a#####a,     ##,#####,,a####a,    ,a#####a,   ##,#####a,  #######     ##';
           asciiText := asciiText + '   `##   ##   ##"     "##  ##       ##  ##[    ""     ###_____##    ##    ###_____##  ##[    ""     ###    "##"    "##  ##"     "##  ###    "##    ##        ##';
           asciiText := asciiText + '    `## ##    ##       ##  ##       ##   `"####,      ###"""""""    ##    ###"""""""   `"####,      ##      ##      ##  ##       ##  ##            ##          ';
           asciiText := asciiText + '     `###     "##,   ,##"   ##,   ,###  ##    ]##     "##,   ,##    ##,   "##,   ,##  ##    ]##     ##      ##      ##  "##,   ,##"  ##            ##,       ##';
           asciiText := asciiText + '      `#       `"#####"      "##### ##  `"#####"       `"#####"     "####  `"#####"   `"#####"      ##      ##      ##   `"#####"    ##            "####     ##';
           ecrireTexte(posXY(20, 26), asciiText, 159);

           readlnPerso();
           Halt(1);
           end;
         writelnPerso();
       end;
end;
end.
