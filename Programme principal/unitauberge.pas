unit unitAuberge;

interface
uses GestionEcran, unitPersonnage, UnitMenu, unitLieu, SysUtils, unitDate;

//PROCEDURE

//Procédure qui lance l'accès à l'auberge
procedure LancerAuberge(var perso : personnage);


implementation

procedure LancerAuberge(var perso : personnage);
var
  coorTexte : Coordonnees; //Coordonnées du texte Se Reposer
  coorTexte2 : Coordonnees; //Coordonnées du texte Partir
  temp : Integer; //Choix de l'utilsateur (Se reposer ou partir)
  d:dateCourante; //Date actuelle

begin
  coorTexte := positionCurseur();

  coorTexte2.x := positionCurseur().x;
  coorTexte2.y := positionCurseur().y + 5;

  InterfaceInGame();

  if not getOuverture() then
  begin
    writelnPerso('Bienvenue dans mon auberge !');
    writelnPerso('Voulez-vous vous reposez et repartir demain matin quand les lieux sont plus sûrs?');
    writelnPerso('Cela vous coutera 20 or');
    ecrireEnPosition(coorTexte,'Se Reposer');
    ecrireEnPosition(coorTexte2,'Partir');

    temp := selectionMenu(coorTexte,2,5, 20, 3,15);

    if temp <> 1 then
      begin
      if perso.argent >= 20 then
        begin
        effacerEcran();
        perso.argent := perso.argent - 20;
        perso.pv := perso.pvMax;
        repeat
          d:=getDate();
          incrementeDate();
        until (d.t.heure<8) ;
        writelnPerso('Vous vous etes bien reposer vous regagner toute votre vie !');
        end
      else
         begin
         effacerEcran();
         writelnPerso('Vous n''avez pas asser d''or...');
         end;
       end
    else
      begin
      effacerEcran();
      writelnPerso('Au revoir !');
      end;
  end
  else
  begin
       writelnPerso('DESOLE NOUS SOMMES FERMES ! REVENEZ A PARTIR DE 20H CE SOIR');

  end;
  readlnPerso();
end;

end.

