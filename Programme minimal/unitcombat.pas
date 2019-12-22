unit unitCombat;

interface
    uses unitPersonnage,unitInventaire,GestionEcran;

    //Procedure gérant tous les combats
    procedure combat(var perso,monstre: personnage;var inventairePerso : Inventaire;var fuite : Boolean);


implementation

  //Procedure gérant tous les combats
  procedure combat(var perso,monstre: personnage;var inventairePerso : Inventaire;var fuite : Boolean);
  var
     sortie: Boolean;
     choix: Integer;
     attaque: Integer;
     rng : Integer;
  begin
  randomize;
  sortie := False;
  randomize();

         while sortie=FALSE DO
         begin

           //Affichage et selection du choix
           attendre(4000);
           effacerEcran();
           writeln('=============');
           writeln('PV : ',perso.pv,' / ',perso.pvMax);
           writeln('=============');
           writeln();
           writeln('=============');
           writeln('PV Monstre : ',monstre.pv,' / ',monstre.pvMax);
           writeln('=============');
           writeln();
           writeln('Choisissez une option : ');
           writeln('1 - Attaquer');
           writeln('2 - Se defendre');
           writeln('3 - Utiliser une potion');
           writeln('4 - Fuite');
           readln(choix);

           //Actions en fonction du choix
           case choix of
                1:
                begin
                  attaque:= perso.attaque + random(perso.attaque div 2);
                  monstre.pv := monstre.pv - attaque;
                  if monstre.pv <= 0 then
                    monstre.pv :=  0;
                  writeln('Vous attaquez ',monstre.pseudo,' il subit ',attaque,' pv. Il lui reste ',monstre.pv,' pv.');
                  attaque:= monstre.attaque + random(monstre.attaque div 2);
                  perso.pv:= perso.pv - attaque;
                  writeln;
                  writeln(monstre.pseudo,' vous attaque, ',' vous subissez ',attaque,' pv. Il vous reste ',perso.pv,' pv.');
                end;
                2:
                begin
                  attaque:= (perso.attaque div 2) + random(perso.attaque div 2);
                  monstre.pv := monstre.pv - attaque;
                  writeln('Vous contrez ',monstre.pseudo,' il subit ',attaque,'. Il lui reste ',monstre.pv);
                  attaque:= (monstre.attaque + random(monstre.attaque div 2)) - perso.defense;
                  perso.pv:= perso.pv - attaque;
                  writeln(monstre.pseudo,' vous attaque, ',' vous subissez ',attaque,' pv. Il vous reste ',perso.pv,' pv.');
                end;
                3:
                begin
                  if inventairePerso.possession[3] = 0 then
                    begin
                    writeln('Vous N''avez pas de potion...');
                    writeln('Choissiser une autre option.');
                    end
                  else
                    begin
                    writeln('Vous consommer une potion !');
                    writeln('Vous regagnez 30 PV !');
                    inventairePerso.possession[3] := inventairePerso.possession[3]-1;
                    perso.pv := perso.pv + 30;
                    if perso.pv > perso.pvMax then
                      perso.pv := perso.pvMax;
                    attaque:= monstre.attaque + random(monstre.attaque div 2);
                    perso.pv:= perso.pv - attaque;
                    writeln();
                    writeln(monstre.pseudo,' vous attaque, ',' vous subissez ',attaque,' pv. Il vous reste ',perso.pv,' pv.');
                    end;
                end;
                4:
                begin
                  rng := random(2);
                  if rng = 1 then
                    begin
                    writeln('Vous vous enfuyez !');
                    sortie:=TRUE;
                    fuite := True;
                    end
                  else
                    begin
                    writeln('Vous n''avez pas reussi a vous enfuir...');
                    attaque:= (monstre.attaque + random(monstre.attaque div 2)) - perso.defense;
                    perso.pv:= perso.pv - attaque;
                    writeln(monstre.pseudo,' vous attaque, ',' vous subissez ',attaque,' pv. Il vous reste ',perso.pv,' pv.');
                    end;
                end;
           end;
           if monstre.pv<=0 then
             begin
               sortie := True;
               writeln('Vous avez gagnez !!');
               writeln('Vous gagnez ',monstre.argent,' or !');
               perso.argent := perso.argent + monstre.argent;
             end;
           if perso.pv <= 0 then
             begin
             writeln('Vous êtes mort...');
             readln();
             Halt(1);
             end;
           writeln;
         end;
  end;
end.

