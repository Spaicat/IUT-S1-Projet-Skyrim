program ProjetProgramme;

uses UnitMenu, UnitPersonnage, UnitMagasin, unitCombat, GestionEcran, unitLieu,unitInventaire;

var
  scenario : Integer; //Variable qui definiera ou le joueur en est dans l'histoire
  posTemp, //Variable qui définit la position du joueur
  anciennePosition : TInformation; //Variable qui stoke l'ancienne position du joueur
  dragonFeu,
  persoTemp : Personnage; //Variable qui définie les caracteristique et nom et la race du personnage
  fuite : Boolean; //Variable boolenne qui definie si le joueur a fuit d'un combat

  nChoix : Integer; //Variable de choix du joueur

  o1,         //Objet 1 //Epee
  o2,         //Objet 2 //Bouclier
  o3 : Objet; //Objet 3 //Potion
  inventairePerso,                 //Inventaire du personnage
  inventaireMagasin : Inventaire;  //Inventaire du magasin
  indicateur : Integer; //Variable qui indique si le joueur a un objet equiper ou non
  nomEquipement : String; //Nom de l'objet equiper par le joueur

begin
  changerTailleConsole(200,60);
  fuite := False;
  menuInitial();   //Creation du Menu Principal avec selection du personnage
  anciennePosition := getLieu1();
  initLieu();
  indicateur := 0;
  nomEquipement := '';
  InterfaceInGame();        //Creation de l'interface
  initObjet(o1,o2,o3);
  initInventaire(inventairePerso,o1,o2,o3);
  initInventaire(inventaireMagasin,o1,o2,o3);
  inventaireMagasin.possession[1]:=3;
  inventaireMagasin.possession[2]:=3;
  inventaireMagasin.possession[3]:=3;
  scenario := 1;
  writeln();
  writeln('En vous promenant devant la porte de Blancherive vous voyer un Garde mourrant');
  writeln('En allant a sa rencontre vous remarquer d''etrange brulure sur le corp...');
  writeln('Alors qu''il est au bord du malaise il vous dit :');               //Affichage du scenario
  writeln('Ils arrivent....Les dragons.....');
  writeln('Il vous tendit alors un parchemin scelle.. ');
  writeln('Vous comprirent donc qu''ils faut le livrer au Jarl de Blancherive');
  writeln();
  deplacement();


  while scenario = 1 do
    begin
    posTemp := getPosition();
    persoTemp := getPersonnage();
    case posTemp.nom of

    'Boutique' :
      begin
      effacerEcran();
      InterfaceInGame();
      writeln('Que voulez-vous faire');
      writeln();
      writeln('1 Pour vendre');
      writeln('2 pour acheter');
      writeln('0 pour quitter');
      readln(nChoix);

      case nChoix of
        0 :
          begin
          setPosition(getLieu1());
          effacerEcran();
          end;
        1 :
        begin
        vente(persoTemp,inventairePerso,inventaireMagasin);
        effacerEcran();
        end;
        2 :
        begin
        achat(persoTemp,inventairePerso,inventaireMagasin);
        effacerEcran();
        end;
      end;
      setPersonnage(persoTemp);
      end;

    'Inventaire' :
      begin
      afficheInventaire(inventairePerso);
      equipement(persoTemp,inventairePerso,indicateur,nomEquipement);
      setPersonnage(persoTemp);
      effacerEcran();
      deplacement();
      end;

    'Porte de Blancherive' :
      begin
      writeln();
      anciennePosition.nom := 'Porte de Blancherive';
      InterfaceInGame();
      writeln('Bienvenue devant la porte de Blancherive');
      writeln('Sortir maintenant serai une perte de temps...');
      writeln();
      writeln('Ou voulez-vous aller ?');
      writeln();
      deplacement();
      end;

    'Bourg de Blancherive' :
      begin
      writeln();
      anciennePosition.nom := 'Bourg de Blancherive';
      InterfaceInGame();   //Creation de l'interface
      writeln('Vous revoila a l''entre de Blancherive');
      writeln('Vous devez donnez le message au jarl le plus vite possible');

      writeln();
      writeln('Ou voulez-vous aller ?');
      writeln();
      deplacement();
      end;


    'Marche de Blancherive' :
      begin
      writeln();
      anciennePosition.nom := 'Marche de Blancherive';
      InterfaceInGame();
      writeln('Bienvenue au marché de Blancherive');
      writeln('Vous voila au grand marche de Blancherive');
      writeln('D''ici vous pouvez vous le Chateau emblematique de Blancherive : Fort-Dragon');
      writeln();
      writeln('Ou voulez-vous aller ?');
      writeln();
      deplacement();
      end;

    'Chateau de Blancherive' :
      begin
      writeln();
      anciennePosition.nom := 'Chateau de Blancherive';
      InterfaceInGame();
      writeln('Bienvenue au Chateux de Blancherive');
      writeln('En arrivant a Fort-Dragon les garde vous arrête un instant et vous laisse passer a la vu du parchemin');
      writeln('Vous donner le parchemin au jarl il vous dit alors panique a situation');
      couleurTexte(4);
      writeln('LES DRAGONS SONT DE RETOUR');
      couleurTexte(15);
      writeln('Vous vous proposez donc d''aller a la porte de la ville pour le retarder');
      scenario:= scenario+1;
      writeln();
      writeln('Ou voulez-vous aller ?');
      writeln();
      deplacement();
      end;

    end;  // Fin du case
    end;  // Fin du while scenario = 1

  while scenario = 2 do
    begin
    posTemp := getPosition();
    persoTemp := getPersonnage();
    case posTemp.nom of

    'Boutique' :
      begin
      InterfaceInGame();
      writeln('Que voulez-vous faire');
      writeln();
      writeln('1 Pour vendre');
      writeln('2 pour acheter');
      writeln('0 pour quitter');
      readln(nChoix);

      case nChoix of
        0 : setPosition(getLieu1());

        1 :
        begin
        vente(persoTemp,inventairePerso,inventaireMagasin);
        setPersonnage(persoTemp);
        effacerEcran();
        end;
        2 :
        begin
        achat(persoTemp,inventairePerso,inventaireMagasin);
        setPersonnage(persoTemp);
        effacerEcran();
        end;
      end;
      end;

    'Inventaire' :
      begin
      afficheInventaire(inventairePerso);
      equipement(persoTemp,inventairePerso,indicateur,nomEquipement);
      setPersonnage(persoTemp);
      readln;
      effacerEcran();
      setPosition(anciennePosition);
      deplacement();
      end;


    'Porte de Blancherive' :
      begin
      writeln();
      dragonFeu.pv := 70;
      dragonFeu.pvMax := 70;
      dragonFeu.attaque := 20;
      dragonFeu.pseudo := 'Dragon De Feu';
      dragonFeu.argent := 100;
      writeln('Il est la !!!');
      writeln('Le ',dragonFeu.pseudo,' vous attaque !');
      combat(persoTemp,dragonFeu,inventairePerso,fuite);
      setPersonnage(persoTemp);
      effacerEcran();
      if fuite = False then
        begin
        writeln('Vous avez accomplie l''impossible !!');
        writeln('Le jarl vous a fait chevalier d''elite de Blancherive !!');
        couleurTexte(4);
        writeln('CONGRATULATION');
        couleurTexte(15);
        readln();
        Halt(1);
        end
      else
        begin
        writeln('Vous avez faillit a votre quete...');
        writeln('La ville a ete detruite...');
        couleurTexte(4);
        writeln('FIN');
        couleurTexte(15);
        readln();
        Halt(1);
        end;

      end;

    'Bourg de Blancherive' :
      begin
      writeln();
      anciennePosition.nom := 'Bourg de Blancherive';
      InterfaceInGame();   //Creation de l'interface
      writeln('Vers la porte de la ville vous entender un grand bruit...');
      couleurTexte(4);
      writeln('La BETE EST ARRIVE !');
      couleurTexte(15);
      writeln('Si vous y aller il n''y aura plus de retour en arriere...');
      writeln();
      writeln('Ou voulez-vous aller ?');
      writeln();
      deplacement();
      end;


    'Marche de Blancherive' :
      begin
      writeln();
      anciennePosition.nom := 'Marche de Blancherive';
      InterfaceInGame();
      writeln('Bienvenue au marché de Blancherive');
      writeln('Vous voila au grand marche de Blancherive');
      writeln('D''ici vous pouvez vous le Chateau emblematique de Blancherive : Fort-Dragon');
      writeln();
      writeln('Ou voulez-vous aller ?');
      writeln();
      deplacement();
      end;

    'Chateau de Blancherive' :
      begin
      writeln();
      anciennePosition.nom := 'Chateau de Blancherive';
      InterfaceInGame();
      writeln('Diriger vous au plus vite au porte de la ville !');
      writeln();
      writeln('Ou voulez-vous aller ?');
      writeln();
      deplacement();
      end;

    end;  // Fin du case
    end;  // Fin du while scenario = 2

readln;
end.

