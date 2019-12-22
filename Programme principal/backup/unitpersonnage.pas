unit UnitPersonnage;

{$codepage utf8}

interface
  uses GestionEcran, SysUtils, TypInfo;

  type race = (Khajiit, HautElfe, Sombrage, Imperiaux);

  type personnage = Record
                  race : race;
                  pseudo : String;
                  argent,
                  pv,
                  pvMax,
                  attaque,
                  defense : Integer;
                  end;

  //Fonction qui renvoie le personnage
  function getPersonnage() : Personnage;

  //Procédure qui défini le personnage
  procedure setPersonnage(perso : personnage);

  //Procédure pour créer le personnage
  procedure createCharacter();

implementation
  uses unitMenu;

  var
    persoChoose : personnage; //Variable qui enregistre le personnage créé par l'utilisateur

  //Fonction qui renvoie le personnage
   function getPersonnage() : personnage;
   begin
     getPersonnage := persoChoose;
   end;

  //Procédure qui défini le personnage
   procedure setPersonnage(perso : personnage);
   begin
     persoChoose := perso;
   end;

  //Procédure pour créer le personnage
  procedure createCharacter();
  var
    repUtilisateur : Integer; //Reponse saisis par l'utilisateur
    coordOrigin : coordonnees; //Coordonnées des différents texte affiché
    listeTexte : array of String; //
  begin
    repeat
      redo();
      coordOrigin.x := 40;
      coordOrigin.y := 9;
      deplacerCurseur(coordOrigin);

      //Affichage du pseudo
      dessinercadre(posXY(coordOrigin.x-4, coordOrigin.y-2), posXY(coordOrigin.x + 124, coordOrigin.y+2), double, White, Black);
      ecrireEnPosition(posXY(coordOrigin.x+2, coordOrigin.y-2), ' Pseudonyme ');
      ecrireEnPosition(coordOrigin, 'Choisissez le pseudonyme de votre personnage : ');

      readln(persoChoose.pseudo);
      coordOrigin.y := coordOrigin.y + 2;
      deplacerCurseur(coordOrigin);

      //Affichage des races
      coordOrigin.y := coordOrigin.y + 4;
      deplacerCurseur(coordOrigin);

      setLength(listeTexte, 4);
      listeTexte[0] := '> Khajiit      ' + 'Originaires d''Elsweyr, les Khajiits sont des felins humanoides. D''apres une legende, ils auraient ete crees par les Elfes. Les Khajiits sont tres intelligents, prestes et souples. Leur grande agilite naturelle fait d''eux d''excellents voleurs. La lune influence beaucoup sur leur force.';
      listeTexte[1] := '> Haut Elfe    ' + 'Les Hauts Elfes sont originaires du mythique continent d''Almeris, maintenant disparu. Ils vivent aujourd''hui sur l''Archipel de l''Automne en Bordeciel. Leur comportement hautain est tres peu apprecie des autres races.Les Hauts Elfes sont tres doues dans les arts mystiques mais tres vulnerables face a la magie. Ils sont extremement intelligents et habiles, ils excellent dans la magie des arcanes. Malgre leur statut de magicien ils rentent de bons guerriers avec des talents de forges et d''escrime.';
      listeTexte[2] := '> Sombrage     ' + 'Le clan Sombrage est le clan nordique descendant d''Ysgamor et ses 500 guerriers. Ils sont arrivÃ©s d''Atmora pour vivre dans la province Bordeciel. Les Sombrages sont souvent caracterises comme barbares, leur resistance au froid leur permette de porter des armures plus legeres, leur apportant une agilite au combat rare, meme avec des armes lourdes';
      listeTexte[3] := '> Imperiaux    ' + 'Les Imperiaux paraissent plus faibles que les autres races a cause de leur apparence plutot frele mais ils sont les meilleurs soldats de leur rang. Bien que leurs armures lourdes les protege des coups les plus importants, leurs attaques restent ralenties par tout le poids qu''ils portent';

      dessinercadre(posXY(coordOrigin.x-4, coordOrigin.y-2), posXY(coordOrigin.x + 124, coordOrigin.y + length(listeTexte)*7), double, White, Black);
      ecrireEnPosition(posXY(coordOrigin.x+2, coordOrigin.y-2), ' Races ');
      ecrireEnPosition(coordOrigin, 'Choisissez le pseudonyme de votre personnage : ');

      coordOrigin.y := coordOrigin.y + 2;
      afficherListeMenu(listeTexte, coordOrigin, 7);
      repUtilisateur := selectionMenu(coordOrigin, 4, 7, 10, LightBlue, White) + 1;

      persoChoose.race := race(repUtilisateur-1);
      case repUtilisateur of //Attribution numéro pour les stats
         1:
         begin
         persoChoose.argent := 50;
         persoChoose.pv := 100;
         persoChoose.pvMax := 100;
         persoChoose.attaque := 20;
         persoChoose.defense := 15;
         end;
         2:
         begin
         persoChoose.argent := 10;
         persoChoose.pv := 75;
         persoChoose.pvMax := 75;
         persoChoose.attaque := 25;
         persoChoose.defense := 15;
         end;
         3:
         begin
         persoChoose.argent := 10;
         persoChoose.pv := 120;
         persoChoose.pvMax := 120;
         persoChoose.attaque := 15;
         persoChoose.defense := 20;
         end;
         4:
         begin
         persoChoose.argent := 100;
         persoChoose.pv := 95;
         persoChoose.pvMax := 95;
         persoChoose.attaque := 15;
         persoChoose.defense := 15;
         end;
      end;

      //Affichage confirmation du personnage
      coordOrigin.y := coordOrigin.y + length(listeTexte)*7;

      coordOrigin.y := coordOrigin.y + 2;
      deplacerCurseur(coordOrigin);

      dessinercadre(posXY(coordOrigin.x-4, coordOrigin.y-2), posXY(coordOrigin.x + 124, coordOrigin.y + 5), double, White, Black);
      ecrireEnPosition(posXY(coordOrigin.x+2, coordOrigin.y-2), ' Confirmation ');
      ecrireEnPosition(coordOrigin, 'Voulez-vous confirmez la création de votre personnage ?');

      setLength(listeTexte, 2);
      listeTexte[0] := '> oui';
      listeTexte[1] := '> non';
      coordOrigin.y := coordOrigin.y + 2;
      afficherListeMenu(listeTexte, coordOrigin, 1);
      repUtilisateur := selectionMenu(coordOrigin, 2, 1, 4, LightBlue, White); //0 = oui et 1 = non

    until repUtilisateur=0;
  end;

end.

