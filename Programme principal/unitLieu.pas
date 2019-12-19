unit unitLieu;

interface

uses
    SysUtils, unitPersonnage, unitCombat, unitMagasin, unitInventaire, unitDate, GestionEcran, TypInfo;

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
var lieu1, lieu2, lieu3, lieu4, lieu5, lieu6, position : TInformation;

function GetChoixMenu() : Integer;
function getOuverture() : boolean;
function getPosition() : TInformation;
procedure updateOuverture();
procedure initLieu();
procedure deplacement();
function afficheLieuxPossibles() : Integer;
procedure setLieu(var lieuAAffect,lieu:TInformation);

implementation
uses unitMenu;

var
  choixMenu : Integer;
  ouvert : Boolean;

function GetChoixMenu() : Integer;
begin
  GetChoixMenu := choixMenu;
end;

function getOuverture():boolean;
begin
  getOuverture:=ouvert;
end;

function getPosition():TInformation;
begin
  getPosition:=position;
end;

procedure updateOuverture();
var
  d : dateCourante;
begin
  d := getDate();
  if (d.t.heure<=7) or (d.t.heure>=20) then
    ouvert := false
  else
     ouvert := true;
end;

procedure setLieu(var lieuAAffect,lieu:TInformation);
var
  i:Integer;//indice de parcours du tableau
begin
   lieuAAffect.nom:=lieu.nom;
   lieuAAffect.indice:=lieu.indice;
   for i:=low(lieu.possibiliteLieu) to high(lieu.possibilitelieu) do
   begin
     lieuAAffect.possibiliteLieu[i]:=lieu.possibiliteLieu[i];
   end;
end;

function afficheLieuxPossibles() : Integer;
var
  i,
  selectedChoice : Integer;
  posInitial : coordonnees;
  listePos : String;
begin
    listePos := '';
    writelnPerso('Position : ' + position.nom);
    posInitial.x := positionCurseur().x;
    posInitial.y := positionCurseur().y+1;
    for i:= 1 to 6 do
      if position.possibiliteLieu[i] then
        case i of
          1:begin writelnPerso(lieu1.nom); listePos := listePos + IntToStr(i);end; //Blancherive
          2:begin writelnPerso(lieu2.nom); listePos := listePos + IntToStr(i);end; //Marché de Blancherive
          3:begin writelnPerso(lieu3.nom); listePos := listePos + IntToStr(i);end; //Chateau
          4:begin writelnPerso(lieu4.nom); listePos := listePos + IntToStr(i);end; //Porte de la ville
          5:begin writelnPerso(lieu5.nom); listePos := listePos + IntToStr(i);end; //Boutique
          //Le menu est obtenu avec des chiffres dans le négatif
        end;
    selectedChoice := selectionMenuEtInterface(posInitial, length(listePos), 1, 22, LightBlue, White);
    if selectedChoice >= 0 then
       choixMenu := StrToInt(listePos[selectedChoice+1])
    else
       choixMenu := selectedChoice;
    afficheLieuxPossibles := choixMenu;
end;

procedure deplacement();
var
  choix:Integer;

begin
  choix := afficheLieuxPossibles();
  case choix of
       1:setLieu(position,lieu1); //Blancherive
       2:setLieu(position,lieu2); //Marché de Blancherive
       3:setLieu(position,lieu3); //Chateau
       4:setLieu(position,lieu4); //Porte de la ville
       5:setLieu(position,lieu5); //Boutique
       else
         if choix < 0 then
           setLieu(position,lieu6); //Menu
  end;
  incrementeDate();
  updateOuverture();
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

  lieu6.nom := 'Menu';
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
