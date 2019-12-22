unit UnitMenu;

interface
uses UnitPersonnage, UnitMagasin, unitCombat, GestionEcran, unitLieu;

  //Procédure qui affiche le menu initial
  procedure menuInitial();

  //Procédure pour lancer le jeu
  procedure LaunchGame();

  //Procédure pour quitter le jeu
  procedure QuitGame();

  //Procédure pour afficher l'interface du jeu
  procedure InterfaceInGame();

implementation

  //Procédure qui affiche le menu initial
  procedure menuInitial();
  var
    rep : Integer;
  begin
    repeat
      writeln('Commencer une partie - 1');
      writeln('Quitter - 2');
      write('Choisissez votre action : ');
      readln(rep);
      if (rep<1) OR (rep>2) then //On teste si la réponse est bien ce que l'on veut
      begin
        writeln('Veuillez saisir une réponse valide');
        attendre(1000);
        effacerEcran();
      end;
    until (rep>=1) AND (rep<=2);
    case rep of //On lance les fonctions en conséquences
         1:LaunchGame();
         2:QuitGame();
    end;
  end;


  //Procédure pour lancer le jeu
  procedure LaunchGame();
  begin
    effacerEcran();
    createCharacter();
  end;


  //Procédure pour quitter le jeu
  procedure QuitGame();
  var
    rep : Char;
  begin
    repeat
    effacerEcran();
    write('Etes vous sur de vouloir quitter ? [o/n] : ');
    readln(rep);
    if rep ='o' then
       writeln('Au plaisir de vous revoir')
    else if rep<>'n' then
        begin
        writeln('Veuillez saisir une réponse valide');
        attendre(1000);
        end;
    until (rep = 'o') OR (rep = 'n');
    effacerEcran();
    Halt(1);
  end;

  //Procédure pour afficher l'interface du jeu
  procedure InterfaceInGame();
  begin
    writeln('===========================');
    writeln('Pseudo : ', getPersonnage().pseudo);
    writeln('Race : ', getPersonnage().race);
    writeln('PV : ', getPersonnage().pv, ' / ', getPersonnage().pvMax);
    writeln('Bourse : ', getPersonnage().argent, ' Gold');
    writeln('===========================');
  end;

end.

