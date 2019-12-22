unit unitLieu;

interface

  uses SysUtils, unitPersonnage, unitCombat, unitMagasin, unitInventaire, unitDate, GestionEcran, TypInfo;

  type
    TTableau = array [1..8] of Boolean;       // 1 = Blancherive // 2 = Marché de Blancherive // 3 = Chateau //4 = Porte de la ville // 5 = Boutique // 6 = Menu // 7 = Auberge // 8 = Clan Drakion

  type
    TInformation = record         //Definition du type lieu  TInforamtion
      nom : String;
      indice:Integer;
      possibiliteLieu : TTableau;
    end;

  //Fonction qui permet de retouner les information du lieu 1
  function getLieu1() : TInformation;

  //Procedure qui permet de definir un lieu sur le jeu
  procedure setLieu(var lieuAAffect,lieu:TInformation);

  //Fonction qui permet de resortir les choix du joueur
  function GetChoixMenu() : Integer;

  //Fonction qui indique grace a une variable booléenne si le batiment est ouvert a une certaine heure
  function getOuverture() : boolean;

  //Fonction qui permet de retouner la valeur de la position du joueur
  function getPosition() : TInformation;

  //Procedure qui met la position du personnage a un certain lieu
  procedure setPosition(pos : TInformation);

  //On met a jour les batiment en fonction de l'heure du jeu
  procedure updateOuverture();

  //Fonction qui permet d'afficher les lieux possibles
  function afficheLieuxPossibles() : Integer;

  //Procedure qui permet de se déplacer de lieux en lieux
  procedure deplacement();

  //Fonction qui initialise tout les lieux
  procedure initLieu();

implementation
  uses unitMenu;

  var lieu1, lieu2, lieu3, lieu4, lieu5, lieu6, lieu7, lieu8, //Variable correspondant à chaque lieu qui existe
      position : TInformation; //Variable correspondant à la position actuelle de l'utilisateur
      choixMenu : Integer; //Entier correspondant au choix que l'utilisateur à fait (négatif si le choix est dans le menu à gauche et positif si c'est dans la selection des lieux)
      ouvert : Boolean; //Booléen qui défini si le magasin est ouvert ou non

  //Fonction qui permet de retouner les information du lieu 1
  function getLieu1() : TInformation;
  begin
    getLieu1 := lieu1;
  end;

  //Procedure qui permet de definir un lieu sur le jeu
  procedure setLieu(var lieuAAffect,lieu:TInformation);
  var
    i:Integer; //indice de parcours du tableau
  begin
     lieuAAffect.nom:=lieu.nom;
     lieuAAffect.indice:=lieu.indice;
     for i:=low(lieu.possibiliteLieu) to high(lieu.possibilitelieu) do
     begin
       lieuAAffect.possibiliteLieu[i]:=lieu.possibiliteLieu[i];       //On affecte tous les lieux possible
     end;
  end;

  //Fonction qui permet de resortir les choix du joueur
  function GetChoixMenu() : Integer;
  begin
    GetChoixMenu := choixMenu;        //On retourne la valeur du choix du menu du joueur
  end;

  //Fonction qui indique grace a une variable booléenne si le batiment est ouvert a une certaine heure
  function getOuverture():boolean;        //La fonction indique si le batiment est ouvert a l'heure du jeu
  begin
    getOuverture := ouvert;
  end;

  //Fonction qui permet de retouner la valeur de la position du joueur
  function getPosition():TInformation;
  begin
    getPosition := position;      //On retourne la valeur de la position du joueur
  end;

  //Procedure qui met la position du personnage a un certain lieu
  procedure setPosition(pos : TInformation);
  begin
    position := pos;              //On definie la position du joueur
  end;

  //On met a jour les batiment en fonction de l'heure du jeu
  procedure updateOuverture();
  var
    d : dateCourante; //Variable qui definie la date et l'heure du jeux
  begin
    d := getDate();
    if (d.t.heure<=7) or (d.t.heure>=20) then  //On met a jour les lieux en fnction de l'heure de la journee
      ouvert := false
    else
       ouvert := true;
  end;

  //Fonction qui permet d'afficher les lieux possibles
  function afficheLieuxPossibles() : Integer;
  var
    i, //Variable de la boucle
    selectedChoice : Integer; //Entier correspondant au choix selectionnée par l'utilisateur
    posInitial : coordonnees; //Coordonnées du menu de selection
    listePos : String; //Liste sous forme de chaine de caractères indiquant les lieux possibles (et donc à afficher)
  begin
      listePos := '';
      writelnPerso('Position : ' + position.nom);
      posInitial.x := positionCurseur().x;
      posInitial.y := positionCurseur().y+1;

      //On affiche les différentes possibilité de deplacement en fonction de la postion
      for i:= 1 to 8 do
        if position.possibiliteLieu[i] then
          case i of
            1:begin writelnPerso(lieu1.nom); listePos := listePos + IntToStr(i);end; //Blancherive
            2:begin writelnPerso(lieu2.nom); listePos := listePos + IntToStr(i);end; //Marché de Blancherive
            3:begin writelnPerso(lieu3.nom); listePos := listePos + IntToStr(i);end; //Chateau
            4:begin writelnPerso(lieu4.nom); listePos := listePos + IntToStr(i);end; //Porte de la ville
            5:begin writelnPerso(lieu5.nom); listePos := listePos + IntToStr(i);end; //Boutique
            //Le menu (6) est obtenu avec des chiffres dans le négatif
            7:begin writelnPerso(lieu7.nom); listePos := listePos + IntToStr(i);end; //Auberge
            8:begin writelnPerso(lieu8.nom); listePos := listePos + IntToStr(i);end; //Clan Drakion
          end;
      selectedChoice := selectionMenuEtInterface(posInitial, length(listePos), 1, 22, LightBlue, White);
      if selectedChoice >= 0 then
         choixMenu := StrToInt(listePos[selectedChoice+1])
      else
         choixMenu := selectedChoice;
      afficheLieuxPossibles := choixMenu;
  end;

  //Procedure qui permet de se déplacer de lieux en lieux
  procedure deplacement();
  var
    choix:Integer; //Variable qui stoke le choix de l'utilisateur

  begin
    choix := afficheLieuxPossibles();
    case choix of
         1:setLieu(position,lieu1); //Blancherive
         2:setLieu(position,lieu2); //Marché de Blancherive
         3:setLieu(position,lieu3); //Chateau
         4:setLieu(position,lieu4); //Porte de la ville           //On setposition selon le lieu choisie
         5:setLieu(position,lieu5); //Boutique
         7:setLieu(position,lieu7); //Auberge
         8:setLieu(position,lieu8); //Clan Drakion
         else
           if choix < 0 then
             setLieu(position,lieu6); //Menu
    end;
    incrementeDate();
    updateOuverture();
  end;

  //Fonction qui initialise tout les lieux
  procedure initLieu();       //On definie le nom, l'indice, et les possibilité de tous les lieux
  begin
    lieu1.nom :='Bourg de Blancherive';
    lieu1.indice:=1;
    lieu1.possibiliteLieu[1] := False;
    lieu1.possibiliteLieu[2] := True;
    lieu1.possibiliteLieu[3] := False;  //On definie les possibilitées de deplacement du Bourg de Blancherive
    lieu1.possibiliteLieu[4] := True;
    lieu1.possibiliteLieu[5] := True;
    lieu1.possibiliteLieu[6] := True;
    lieu1.possibiliteLieu[7] := True;
    lieu1.possibiliteLieu[8] := False;

    lieu2.nom := 'Marche de Blancherive';
    lieu2.indice:=2;
    lieu2.possibiliteLieu[1] := True;
    lieu2.possibiliteLieu[2] := False;
    lieu2.possibiliteLieu[3] := True;     //On definie les possibilitées de deplacement du marche de Blancherive
    lieu2.possibiliteLieu[4] := False;
    lieu2.possibiliteLieu[5] := False;
    lieu2.possibiliteLieu[6] := True;
    lieu2.possibiliteLieu[7] := False;
    lieu2.possibiliteLieu[8] := False;

    lieu3.nom := 'Chateau de Blancherive';
    lieu3.indice:=3;
    lieu3.possibiliteLieu[1] := False;
    lieu3.possibiliteLieu[2] := True;
    lieu3.possibiliteLieu[3] := False;        //On definie les possibilitées de deplacement du chateau de Blancherive
    lieu3.possibiliteLieu[4] := False;
    lieu3.possibiliteLieu[5] := False;
    lieu3.possibiliteLieu[6] := True;
    lieu3.possibiliteLieu[7] := False;
    lieu3.possibiliteLieu[8] := False;

    lieu4.nom := 'Porte de Blancherive';
    lieu4.indice:=4;
    lieu4.possibiliteLieu[1] := True;
    lieu4.possibiliteLieu[2] := False;
    lieu4.possibiliteLieu[3] := False;        //On definie les possibilitées de deplacement de la porte de Blancherive
    lieu4.possibiliteLieu[4] := False;
    lieu4.possibiliteLieu[5] := False;
    lieu4.possibiliteLieu[6] := True;
    lieu4.possibiliteLieu[7] := False;
    lieu4.possibiliteLieu[8] := True;

    lieu5.nom := 'Boutique';
    lieu5.indice:=5;
    lieu5.possibiliteLieu[1] := True;
    lieu5.possibiliteLieu[2] := False;
    lieu5.possibiliteLieu[3] := False;    //On definie les possibilitées de deplacement de la boutique du jeu
    lieu5.possibiliteLieu[4] := False;
    lieu5.possibiliteLieu[5] := False;
    lieu5.possibiliteLieu[6] := False;
    lieu5.possibiliteLieu[7] := False;
    lieu5.possibiliteLieu[8] := False;

    lieu6.nom := 'Menu';
    lieu6.indice:=6;
    lieu6.possibiliteLieu[1] := True;
    lieu6.possibiliteLieu[2] := True;
    lieu6.possibiliteLieu[3] := True;
    lieu6.possibiliteLieu[4] := True;   //On definie les possibilitées de deplacement de L'inventaire du personnage
    lieu6.possibiliteLieu[5] := True;
    lieu6.possibiliteLieu[6] := False;
    lieu6.possibiliteLieu[7] := True;
    lieu6.possibiliteLieu[8] := False;

    lieu7.nom := 'Auberge';
    lieu7.indice:=7;
    lieu7.possibiliteLieu[1] := True;
    lieu7.possibiliteLieu[2] := False;      //On definie les possibilitées de deplacement de L'Auberge
    lieu7.possibiliteLieu[3] := False;
    lieu7.possibiliteLieu[4] := False;
    lieu7.possibiliteLieu[5] := False;
    lieu7.possibiliteLieu[6] := False;
    lieu7.possibiliteLieu[7] := False;
    lieu7.possibiliteLieu[8] := False;

    lieu8.nom := 'Clan Drakion';
    lieu8.indice:=8;
    lieu8.possibiliteLieu[1] := False;
    lieu8.possibiliteLieu[2] := False;
    lieu8.possibiliteLieu[3] := False;    //On definie les possibilitées de deplacement du Clan Drakion
    lieu8.possibiliteLieu[4] := True;
    lieu8.possibiliteLieu[5] := False;
    lieu8.possibiliteLieu[6] := False;
    lieu8.possibiliteLieu[7] := False;
    lieu8.possibiliteLieu[8] := False;

    setLieu(position,lieu1);

  end;
end.
