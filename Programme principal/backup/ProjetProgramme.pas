program ProjetProgramme;

{$codepage utf8} //On définit l'encodage en utf-8

uses UnitMenu, UnitPersonnage, UnitMagasin, unitCombat, unitLieu, unitInventaire, unitDate, unitAuberge,unitbenediction,
     GestionEcran, TypInfo, Keyboard, Classes, SysUtils, Windows;

var
  scenario : Integer; //Variable qui definiera ou le joueur en est dans l'histoire
  anciennePosition,      //Variable qui stoke l'ancienne position du joueur
  posTemp : TInformation;   //Variable qui stoke la position du personnage
  persoTemp,             //Variable qui définie les caracteristique et nom et la race du personnage
  monstre : Personnage;  //Variable qui définie les caracteristique et nom du monstre
  fuite : Boolean;       //Variable boolenne qui definie si le joueur a fuit d'un combat
  fin : Boolean;         //Variable boolenne qui sert de condition a la boucle principale
  lieuBourg : TInformation;   //Position du lieu 1

  nChoix : Integer;      //Vraiable de choix du joueur

  o1,                    //Objet 1 //Epee
  o2,                    //Objet 2 //Bouclier
  o3 : Objet;            //Objet 3 //Potion
  inventairePerso : Inventaire;         //Inventaire du personnage
  inventaireMagasin : Inventaire;            //Inventaire du magasin
  indicateur : Integer; //Variable qui indique si le joueur a un objet equiper ou non
  nomEquipement : String;          //Nom de l'objet equiper par le joueur
begin
  fin := False;
  menuInitial(fin);            //Creation du Menu Principal avec selection du personnage

  if (fin = False) then
    begin
    persoTemp := getPersonnage();

    initLieu();
    indicateur := 0;
    nomEquipement := '';
    fuite := False;
    initObjet(o1,o2,o3);
    initInventaire(inventairePerso,o1,o2,o3);
    initInventaire(inventaireMagasin,o1,o2,o3);
    inventaireMagasin.possession[1]:=3;
    inventaireMagasin.possession[2]:=3;
    inventaireMagasin.possession[3]:=3;
    initDate();
    scenario := 1;

    anciennePosition := getLieu1();

    InterfaceInGame(); //Creation de l'interface

    writelnPerso('Vous etes un habitant de Blancherive, votre femme, Alnya, vit aupres de vous depuis plusieurs annees.');
    writelnPerso('Vous revenez de la chasse de la semaine. Un homme en fine armure se tient face a votre maison, tenant une hache couverte de sang');
    writelnPerso('Vous abandonnez toutes vos affaires sur le sol en voyant les cheveux d’Alnya noyes dans son sang aux pieds de l''homme. ');               //Affichage du scenario
    writelnPerso('Vous ne gardez que votre epee et courez pour vous jeter sur le meurtrier de votre bien aime.');
    writelnPerso('Vous tranchez le corps de l''ennemi qui s''averait etre un soldat sombrage, il meurt sur le coup sans avoir le temps de se retourner.  ');
    writelnPerso();
    writelnPerso('Le melange de haine et de tristesse vous fait fondre en larme sur le corps sans vie de votre femme.');
    writelnPerso('Vous lui rendez hommage en immolant son corps et jetant ses cendres dans la riviere qu''elle adorait');
    writelnPerso('Vous gardez son talisman pres de votre coeur. ');
    writelnPerso();
    deplacement();
    end;


  while (fin = False) do
    begin
    posTemp := getPosition(); //On prends le nom du lieu actuel
    case posTemp.nom of

    'Auberge' :
    begin
    LancerAuberge(persoTemp); //On lance la procédure auberge
    setPersonnage(persoTemp);
    lieuBourg := getLieu1();
    posTemp := getPosition();
    setLieu(posTemp, lieuBourg);
    setPosition(posTemp); //On met à jour la position
    end;

    'Boutique' :
    begin
      InterfaceInGame();

      if not(getOuverture()) then //On vérifie si la boutique est fermé
      begin
           writeln('LE MAGASIN EST FERME ! REVENEZ A 8H DEMAIN MATIN !');
           readln();
           effacerEcran();
      end
      else
      begin
        writelnPerso('Que voulez-vous faire');
        writelnPerso();
        writelnPerso(' >  Acheter');
        writelnPerso(' >  Vendre');
        writelnPerso(' >  Negocier');
        writelnPerso(' >  Quitter');
        nChoix := selectionMenu(posXY(positionCurseur().x, positionCurseur().y-3), 4, 1, 2, LightBlue, White);

        case nChoix of
        0 :
          begin
          achat(persoTemp,inventairePerso,inventaireMagasin);
          setPersonnage(persoTemp);
          redo();
          end;
        1 :
          begin
          vente(persoTemp,inventairePerso,inventaireMagasin);
          setPersonnage(persoTemp);
          redo();
          end;
        2 :
          begin
          writelnPerso();
          negociation();
          end;
        3 :
          begin
          setPosition(getLieu1());
          end;
        end;
      end;
    end;

    'Menu' :
      begin
      redo();
      gestionMenu(persoTemp,inventairePerso,indicateur,nomEquipement);
      setPersonnage(persoTemp);
      setPosition(anciennePosition);
      InterfaceInGame();
      end;

    'Porte de Blancherive' :
      begin
      if scenario = 1 then
        begin
        writelnPerso();
        anciennePosition := getPosition();
        InterfaceInGame();
        writelnPerso('Bienvenue devant la porte de Blancherive');
        writelnPerso('Sortir maintenant serai une perte de temps...');
        writelnPerso();
        writelnPerso('Ou voulez-vous aller ?');
        writelnPerso();
        deplacement();
        end
      else if scenario = 2 then
        begin
        writelnPerso();
        anciennePosition := getPosition();
        InterfaceInGame();
        scenario := scenario + 1;
        writelnPerso('Vous patrouillez autour de la ville pres de la foret.');
        writelnPerso('Un bruit retentit de derriere les fourres, vous decidez de vous approcher mais un coup violent vous ejecte en arriere,');
        writelnPerso('vous tombez au sol. Vous reconnaissez un geant qui s''approche de vous. ');
        writelnPerso('Vous ne pouvez-vous defendre et êtes voues a mourir.');
        writelnPerso('Lorsque le geant s''apprete à vous tuer, un bruit d''aile se fait entendre a votre gauche.');
        writelnPerso('Vous n’avez pas le temps de vous retourner que le geant se fait repousser en arriere et immoler par de puissantes flammes.');
        writelnPerso('En levant les yeux vous pouvez observer un grand dragon se tenir devant vous, il vous observe quelques secondes');
        writelnPerso('Vous devez vous rendre au chateau pour faire votre rapport au Jarl.');
        writelnPerso(' avant de s’elancer dans les airs et disparaitre dans la brume au-dessus des arbres.');

        writelnPerso();
        writelnPerso('Ou voulez-vous aller ?');
        writelnPerso();
        deplacement();
        end
      else if scenario = 3 then
        begin
        writelnPerso();
        anciennePosition := getPosition();
        InterfaceInGame();
        writelnPerso('Vous devez faire votre rapport au Jarl !');

        writelnPerso();
        writelnPerso('Ou voulez-vous aller ?');
        writelnPerso();
        deplacement();
        end
      else
        begin
        writelnPerso();
        anciennePosition := getPosition();
        InterfaceInGame();
        writelnPerso('Vous etes un deserteur vous n''avez plus de raison de revenir ici...');

        writelnPerso();
        writelnPerso('Ou voulez-vous aller ?');
        writelnPerso();
        deplacement();
        end;
      end;

    'Bourg de Blancherive' :
      begin
      if scenario = 1 then
        begin
        redo();
        writelnPerso();
        anciennePosition := getPosition();
        InterfaceInGame();   //Creation de l'interface
        writelnPerso('Souhaitant vous debarrassez du corps sans vie de l''ennemi Sombrage,');
        writelnPerso('vous decouvrez un plan stratégique expliquant le déroulement d''une prochaine attaque de Blancherive. ');
        writelnPerso('Vous devez vous présentez au Jarl situe dans le chateau de la ville pour lui remettre ce plan. ');
        writelnPerso();
        writelnPerso('Ou voulez-vous aller ?');
        writelnPerso();
        deplacement();
        end
      else if (scenario = 2) OR (scenario = 3) then
        begin
        writelnPerso();
        anciennePosition := getPosition();
        InterfaceInGame();
        writelnPerso('Vous voila en charge de la patrouille officiel de Blancherive');
        writelnPerso('Votre patrouille a lieu pres de la porte de la ville');
        writelnPerso();
        writelnPerso('Ou voulez-vous aller ?');
        writelnPerso();
        deplacement();
        end
      else
        begin
        writelnPerso();
        anciennePosition := getPosition();
        InterfaceInGame();
        writelnPerso('Vous etes un deserteur vous n''avez plus de raison de revenir ici...');

        writelnPerso();
        writelnPerso('Ou voulez-vous aller ?');
        writelnPerso();
        deplacement();
        end;
      end;


    'Marche de Blancherive' :
      begin
      writelnPerso();
      anciennePosition := getPosition();
      InterfaceInGame();

      writelnPerso('Vous voila au grand marche de Blancherive');
      writelnPerso('D''ici vous pouvez voir le Chateau emblematique de Blancherive : Fort-Dragon');
      writelnPerso();
      if not getOuverture() then
      begin
          writelnPerso('Un Ivrogne vous attaque !!');
          monstre:=Ivrogne();
          combat(persoTemp,monstre,inventairePerso,fuite);
          setPersonnage(persoTemp);
          InterfaceInGame();
      end
      else
      begin
          writelnPerso('Ou voulez-vous aller ?');
          writelnPerso();
      end;
      deplacement();
      waitUneHeure();
      end;

    'Chateau de Blancherive' :
      begin
      if scenario = 1 then
        begin
        writelnPerso();
        anciennePosition := getPosition();
        InterfaceInGame();
        scenario:= scenario+1;
        writelnPerso('Vous vous approchez du Jarl et vous agenouillez devant lui.');
        writelnPerso('"Je me presente à vous pour vous remettre un plan decouvert sur le corps d''un Sombrage. Celui-ci vise à attaquer notre ville. "');
        writelnPerso('Le Jarl récupère le plan entre vos mains et l''observe quelques secondes. ');
        writelnPerso('" Relevez-vous. Je vous remercie infiniment pour votre aide et votre fidelite à notre peuple. ');
        writelnPerso('Ce plan nous permettra de proteger la ville efficacement lors de cette attaque, et de riposter en retour.');
        writelnPerso('"Je souhaiterai que vous fassiez parti de mon armee. Vous serez assigne au titre de patrouilleur si vous acceptez, vous aurez de belles recompenses."');
        writelnPerso('Vous etes maintenant assigne à l’armee Imperiale. Vous devez à present patrouiller en dehors de la ville.');
        writelnPerso();
        writelnPerso('Ou voulez-vous aller ?');
        writelnPerso();
        deplacement();
        end
      else if scenario = 2 then
        begin
        writelnPerso();
        anciennePosition := getPosition();
        InterfaceInGame();
        writelnPerso('Vous etes maintenant de patrouille devant la porte de la ville');
        writelnPerso('Vous feriz mieux d''y aller');
        writelnPerso();
        writelnPerso('Ou voulez-vous aller ?');
        writelnPerso();
        deplacement();
        end
      else if scenario = 3 then
        begin
        writelnPerso();
        anciennePosition := getPosition();
        InterfaceInGame();
        scenario := scenario +1;
        writelnPerso('Vous approchez du Jarl et lui faites votre rapport. Celui-ci décide de lancer une chasse contre le dragon.');
        writelnPerso('Vous refusez d''obeir a ses ordres et tentez de le convaincre, il vous menace de mise a mort mais vous decidez de partir tout de même.');
        writelnPerso('Vous etes a present deserteur de la Legion Imperiale, vous devez imperativement sortir de la ville pour echapper aux gardes,');
        writelnPerso(' l''exterieur de celle-ci aura peut-etre de quoi vous accueillir ...');

        writelnPerso();
        writelnPerso('Ou voulez-vous aller ?');
        writelnPerso();
        deplacement();
        end
       else
         begin
         writelnPerso();
         anciennePosition := getPosition();
         InterfaceInGame();
         writelnPerso('Vous etes un deserteur vous n''avez plus de raison de revenir ici...');

         writelnPerso();
         writelnPerso('Ou voulez-vous aller ?');
         writelnPerso();
         deplacement();
         end;
      end;
    'Clan Drakion':
      begin
      if scenario <> 4 then
        begin
        writelnPerso();
        anciennePosition := getPosition();
        InterfaceInGame();
        writelnPerso('Vous n''avez aucune raison d''y aller maintenant');
        writelnPerso();
        writelnPerso('Ou voulez-vous aller ?');
        writelnPerso();
        deplacement();
        end
      else
        begin
        writelnPerso();
        anciennePosition := getPosition();
        InterfaceInGame();

        writelnPerso('Les membres du clan preparent votre rituel d’initiation, vous vous placez au centre des runes nordiques dessiner au sol. ');
        writelnPerso('Ils entreprennent un chant dans la langue draconienne.');
        writelnPerso('Etonnamment vous decrypter les paroles de celui-ci. ');
        writelnPerso('Lors du chant termine, l''esprit d’Alduin et Orya apparaissent face a vous');
        writelnPerso('Vous les observez en silence avant qu’ils prennent la parole. ');
        writelnPerso();
        writelnPerso('Alduin : nous attendions ce moment avec impatience, Orya et moi ');
        writelnPerso('Tu ne comprends encore ce que je veux dire mais nous allons t’expliquer.');
        writelnPerso('Tu n’es reellement pas originaire de ce monde, tu es notre creation, a Orya et moi.');
        writelnPerso();
        writelnPerso('Orya : : Je sais que ce que nous sommes en train de te dire parait ireel, mais tu es notre enfant, l’elu du clan Drakion');
        writelnPerso('Tu dois a present assumer tes responsabilites, et suivre notre voie');
        writelnPerso('Je t’en prie, accepte-nous en tant que compagnon, nous serons a tes cotes pendant la destruction de ce monde.');
        readlnPerso();
        InterfaceInGame();
        writelnPerso();
        writelnPerso('Vous restez interloque jusqu’a entendre le mot ‘destruction’.');
        writelnPerso('Ils vous expliquent alors que vous etes voue a assouvir leur desir de destruction');
        writelnPerso('destruction mais vous refusez de les servir pour detruire ce monde ou vous avez grandi. ');
        writelnPerso();
        writelnPerso('Alduin : Comment oses-tu refuser de servir tes createurs ?');
        writelnPerso();
        writelnPerso('Alduin s''apprete a vous faire disparaitre de ce monde lorsque Orya l’arrete. ');
        writelnPerso('Elle l’empeche de vous tuer et vous regarde, vous demandant des explications');
        writelnPerso();
        writelnPerso('J’ai grandi sur ce monde, il est si beau si l’on retire les guerres qui ravage les pays.');
        writelnPerso('J’ai vecu aupres de ma compagne, decedee, sur ce monde.');
        writelnPerso('Je ne veux pas le voir disparaitre. J’ai prier les Dieux qui vous ont creee et je vous prie ,à votre tour,');
        writelnPerso('d’apprendre a voir la beaute de ces terres et acceptez, a mes cotes, de vaincre le mal qui ronge celles-ci.');
        writelnPerso('Apprenez le pardon aupres de nos Dieux et accompagnez-moi.');
        readlnPerso();
        InterfaceInGame();

        writelnPerso('Orya vous regarde avant de fixer ses yeux sur Alduin, qui observe les alentours. ');
        writelnPerso('Il transforme son esprit sous forme humaine avant de venir poser sa main sur votre visage');
        writelnPerso('Il s’excuse d’avoir laisser la haine, et la rage, avoir pris le dessus sur lui avant de regarder vos yeux');
        writelnPerso();
        writelnPerso('Alduin : Si tu tiens tant a ce monde, alors j’accepte de t’accompagner dans cette quete, mon fils.');
        writelnPerso('Nous te suivrons et t’offrirons notre force lors de tes combats. Nous serons toujours aupres de toi, ne l’oublie pas.');
        readlnPerso();
        InterfaceInGame();

        writelnPerso('L’esprit d’Alduin et Orya quitte ce monde afin de partir demander le pardon des Dieux.');
        writelnPerso('Ceux-ci leur accorde une seconde chance et decide de vous observer durant votre quete.');
        writelnPerso('Ces nouvelles ne plaisent pas a tous les dragons, certains se retournent contre vos createurs,');
        writelnPerso('vous devez les vaincre afin de mettre fin a tout cela.');
        writelnPerso('Ces dragons sont Illyar, Qjard et Ksiorn, de puissants dragons que le clan vous aidera a invoquer.');
        writelnPerso();
        writelnPerso('Le clan vous aide a invoquer Illyar, le premier dragon. Il apparait et vous devez le combattre.');

        readlnPerso();
        InterfaceInGame();
        repeat
          writelnPerso('Illyar Vous attaque');
          monstre := Illyar();
          combat(persoTemp,monstre,inventairePerso,fuite);
          setPersonnage(persoTemp);
        until fuite = False;

        Benediction(persoTemp);
        setPersonnage(persoTemp);

        readlnPerso();
        InterfaceInGame();

        repeat
          writelnPerso('Qjard a ete invoque');
          writelnPerso('Qjard Vous attaque');
          monstre := Qjard();
          combat(persoTemp,monstre,inventairePerso,fuite);
          setPersonnage(persoTemp);
        until fuite = False;

        Benediction(persoTemp);
        setPersonnage(persoTemp);

        readlnPerso();
        InterfaceInGame();

        repeat
          writelnPerso('Ksiorn a ete invoque');
          writelnPerso('Ksiorn Vous attaque');
          monstre := Ksiorn();
          combat(persoTemp,monstre,inventairePerso,fuite);
          setPersonnage(persoTemp);
        until fuite = False;

        Benediction(persoTemp);
        setPersonnage(persoTemp);

        readlnPerso();
        InterfaceInGame();

        writelnPerso('Vous avez reussi a battre tous les dragons.');
        writelnPerso('Les Dieux vous promettent l''entree au Valhalla lorsque votre heure sera venue. ');
        writelnPerso('Vous vivez au sein de ce clan le reste de votre vie, et combattez la guerre qui ravage votre monde');
        writelnPerso('avec Alduin et Orya a vos cotes et le talisman de votre femme pres de votre cœur.');
        writelnPerso();
        writelnPerso('Vous avez atteint la fin du jeu, felicitations !!');
        fin := True;



        end;
      end;



    end;  // Fin du case
  end;  // Fin du while

readln;
end.

