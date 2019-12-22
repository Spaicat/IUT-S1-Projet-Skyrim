unit UnitPersonnage;

interface
  uses GestionEcran, TypInfo;

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
  procedure setPersonnage(perso : personnage);

  //Procédure qui défini le personnage
  function getPersonnage() : Personnage;

  //Procédure pour créer le personnage
  procedure createCharacter();

implementation
  var
    persoChoose : personnage; //Variable qui enregistre le personnage créé par l'utilisateur

  procedure setPersonnage(perso : personnage);
  begin
    persoChoose := perso;
  end;


  //Fonction qui renvoie le personnage
  function getPersonnage() : personnage;
  begin
    getPersonnage := persoChoose;
  end;

  //Procédure pour créer le personnage
  procedure createCharacter();
  var
    repUtilisateur : Integer; //Reponse saisis par l'utilisateur
    repUtilisateurChar : String;
  begin
    repeat
      write('Choisissez le pseudonyme de votre personnage : ');
      readln(persoChoose.pseudo);
      writeln();
      repeat
          writeln('Races'); // LISTE DES RACES + DESCRIPTION
           writeln();
          writeln('Khajiit - 1');
           writeln();
           writeln('Originaires d''Elsweyr, les Khajiits sont des felins humanoides. D''apres une legende, ils auraient ete crees par les Elfes. Les Khajiits sont tres intelligents, prestes et souples. Leur grande agilite naturelle fait d''eux d''excellents voleurs. La lune influence beaucoup sur leur force.');
           writeln();
          writeln('Haut Elfe - 2');
           writeln();
           writeln('Les Hauts Elfes sont originaires du mythique continent d''Almeris, maintenant disparu. Ils vivent aujourd''hui sur l''Archipel de l''Automne en Bordeciel. Leur comportement hautain est tres peu apprecie des autres races.Les Hauts Elfes sont tres doues dans les arts mystiques mais tres vulnerables face a la magie. Ils sont extremement intelligents et habiles, ils excellent dans la magie des arcanes. Malgre leur statut de magicien ils rentent de bons guerriers avec des talents de forges et d''escrime.');
           writeln();
          writeln('Sombrage - 3');
           writeln();
           writeln('Le clan Sombrage est le clan nordique descendant d''Ysgamor et ses 500 guerriers. Ils sont arrivÃ©s d''Atmora pour vivre dans la province Bordeciel. Les Sombrages sont souvent caracterises comme barbares, leur resistance au froid leur permette de porter des armures plus legeres, leur apportant une agilite au combat rare, meme avec des armes lourdes');
           writeln();
          writeln('Imperiaux - 4');
           writeln();
           writeln('Les Imperiaux paraissent plus faibles que les autres races a cause de leur apparence plutot frele mais ils sont les meilleurs soldats de leur rang. Bien que leurs armures lourdes les protege des coups les plus importants, leurs attaques restent ralenties par tout le poids qu''ils portent');
           writeln();
          write('Choisissez une race : ');
          readln(repUtilisateur);
          if ((repUtilisateur<1) or (repUtilisateur>ord(high(race))+1)) then
             begin
             effacerEcran();
             writeln('Veuillez choisir une réponse valide');
             attendre(1000);
             end;
      until ((repUtilisateur>=1) and (repUtilisateur<=ord(high(race))+1));
      persoChoose.race := race(repUtilisateur-1);
      case repUtilisateur of //Attribution numéro pour les stats
         1:
         begin
         persoChoose.argent := 100;
         persoChoose.pv := 100;
         persoChoose.pvMax := 100;
         persoChoose.attaque := 20;
         persoChoose.defense := 15;
         end;
         2:
         begin
         persoChoose.argent := 20;
         persoChoose.pv := 75;
         persoChoose.pvMax := 75;
         persoChoose.attaque := 25;
         persoChoose.defense := 15;
         end;
         3:
         begin
         persoChoose.argent := 20;
         persoChoose.pv := 120;
         persoChoose.pvMax := 120;
         persoChoose.attaque := 15;
         persoChoose.defense := 20;
         end;
         4:
         begin
         persoChoose.argent := 200;
         persoChoose.pv := 95;
         persoChoose.pvMax := 95;
         persoChoose.attaque := 15;
         persoChoose.defense := 15;
         end;
      end;
      repeat
        writeln();
        writeln('===========================');
        writeln('Votre personnage s''appelle ', persoChoose.pseudo, ', il est de la race ', persoChoose.race);
        writeln('Voulez-vous confirmez ? [o/n] ');
        readln(repUtilisateurChar);
        if (repUtilisateurChar <> 'n') and (repUtilisateurChar<>'o') then
           begin
           effacerEcran();
           writeln('Veuillez saisir une réponse valide');
           attendre(1000);
           end;
      until (repUtilisateurChar='o') or (repUtilisateurChar='n');
    effacerEcran();
   until repUtilisateurChar='o';
  end;

end.

