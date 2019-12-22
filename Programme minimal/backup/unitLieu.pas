unit unitLieu;

interface

  uses
      SysUtils,unitPersonnage,unitCombat,unitMagasin,unitInventaire,GestionEcran;

  type
    cateLieu = (magasin,fight,autre);
    TTableau = array [1..6] of Boolean;       // 1 = Blancherive // 2 = Marché de Blancherive // 3 = Chateau //4 = Porte de la ville // 5 = Boutique // 6 = Inventaire

  type
    TInformation = record
      nom : String;
      indice:Integer;
      possibiliteLieu : TTableau;
      cate:cateLieu;
    end;

  //Fonction qui permet de retouner les information du lieu 1
  function getLieu1() : TInformation;

  //Procedure qui permet de definir un lieu sur le jeu
  procedure setLieu(var lieuAAffect,lieu:TInformation);

  //Fonction qui permet de retouner la valeur de la position du joueur
  function getPosition() : TInformation;

  //Procedure qui met la position du personnage a un certain lieu
  procedure setPosition(pos : TInformation);

  //Fonction qui permet d'afficher les lieux possibles
  procedure afficheLieuxPossibles();

  //Procedure qui permet de se déplacer de lieux en lieux
  procedure deplacement();

  //Fonction qui initialise tout les lieux
  procedure initLieu();

implementation
  var lieu1, lieu2, lieu3, lieu4, lieu5, lieu6, //Variable correspondant à chaque lieu qui existe
    position : TInformation; //Variable correspondant à la position actuelle de l'utilisateur

    //Fonction qui permet de retouner les information du lieu 1
  function getLieu1() : TInformation;
  begin
    getLieu1 := lieu1;
  end;

  //Procedure qui permet de definir un lieu sur le jeu
  procedure setLieu(var lieuAAffect,lieu:TInformation);
  var
    i:Integer;//indice de parcours du tableau
  begin
     effacerEcran();
     lieuAAffect.nom:=lieu.nom;
     lieuAAffect.indice:=lieu.indice;
     for i:=low(lieu.possibiliteLieu) to high(lieu.possibilitelieu) do
     begin
       lieuAAffect.possibiliteLieu[i]:=lieu.possibiliteLieu[i];
     end;
  end;

  //Fonction qui permet de retouner la valeur de la position du joueur
  function getPosition():TInformation;
  begin
    getPosition := position;
  end;

  //Procedure qui met la position du personnage a un certain lieu
  procedure setPosition(pos : TInformation);
  begin
    position := pos;
  end;

  //Fonction qui permet d'afficher les lieux possibles
  procedure afficheLieuxPossibles();
  var
    i:Integer;
  begin
      writeln('Position : ',position.nom);
      for i:= 1 to 6 do
        if position.possibiliteLieu[i] then
          case i of
            1:begin writeln(i,' : ',lieu1.nom);end;
            2:begin writeln(i,' : ',lieu2.nom);end;
            3:begin writeln(i,' : ',lieu3.nom);end;
            4:begin writeln(i,' : ',lieu4.nom);end;
            5:begin writeln(i,' : ',lieu5.nom);end;
            6:begin writeln(i,' : ',lieu6.nom);end;
          end;
  end;

  //Procedure qui permet de se déplacer de lieux en lieux
  procedure deplacement();
  var
    choix:Integer;
  begin
    afficheLieuxPossibles();
    writeln('Ou voulez-vous aller ?');
    readln(choix);
    while((choix<1) or (choix>6) or not(position.possibiliteLieu[choix])) do
    begin
      writeln('Vous ne pouvez pas aller ici directement');
      afficheLieuxPossibles();
      writeln('Ou voulez-vous aller ?');
      readln(choix);
    end;
    case choix of
         1:setLieu(position,lieu1);
         2:setLieu(position,lieu2);
         3:setLieu(position,lieu3);
         4:setLieu(position,lieu4);
         5:setLieu(position,lieu5);
         6:setLieu(position,lieu6);
    end;
  end;

  procedure initLieu();
  begin
    lieu1.nom :='Bourg de Blancherive';
    lieu1.indice:=1;
    lieu1.cate:=autre;
    lieu1.possibiliteLieu[1] := False;
    lieu1.possibiliteLieu[2] := True;
    lieu1.possibiliteLieu[3] := False;
    lieu1.possibiliteLieu[4] := True;
    lieu1.possibiliteLieu[5] := True;
    lieu1.possibiliteLieu[6] := True;

    lieu2.nom := 'Marche de Blancherive';
    lieu2.indice:=2;
    lieu2.cate:=autre;
    lieu2.possibiliteLieu[1] := True;
    lieu2.possibiliteLieu[2] := False;
    lieu2.possibiliteLieu[3] := True;
    lieu2.possibiliteLieu[4] := False;
    lieu2.possibiliteLieu[5] := False;
    lieu2.possibiliteLieu[6] := True;

    lieu3.nom := 'Chateau de Blancherive';
    lieu3.indice:=3;
    lieu3.cate:=autre;
    lieu3.possibiliteLieu[1] := False;
    lieu3.possibiliteLieu[2] := True;
    lieu3.possibiliteLieu[3] := False;
    lieu3.possibiliteLieu[4] := False;
    lieu3.possibiliteLieu[5] := False;
    lieu3.possibiliteLieu[6] := True;

    lieu4.nom := 'Porte de Blancherive';
    lieu4.indice:=4;
    lieu4.cate:=fight;
    lieu4.possibiliteLieu[1] := True;
    lieu4.possibiliteLieu[2] := False;
    lieu4.possibiliteLieu[3] := False;
    lieu4.possibiliteLieu[4] := False;
    lieu4.possibiliteLieu[5] := False;
    lieu4.possibiliteLieu[6] := True;

    lieu5.nom := 'Boutique';
    lieu5.indice:=5;
    lieu5.cate:=magasin;
    lieu5.possibiliteLieu[1] := True;
    lieu5.possibiliteLieu[2] := False;
    lieu5.possibiliteLieu[3] := False;
    lieu5.possibiliteLieu[4] := False;
    lieu5.possibiliteLieu[5] := False;
    lieu5.possibiliteLieu[6] := False;

    lieu6.nom := 'Inventaire';
    lieu6.indice:=6;
    lieu6.cate:=autre;
    lieu6.possibiliteLieu[1] := True;
    lieu6.possibiliteLieu[2] := True;
    lieu6.possibiliteLieu[3] := True;
    lieu6.possibiliteLieu[4] := True;
    lieu6.possibiliteLieu[5] := False;
    lieu6.possibiliteLieu[6] := False;

    setLieu(position,lieu1);

  end;
end.

