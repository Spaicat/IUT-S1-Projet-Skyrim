unit unitInventaire;


interface
  uses GestionEcran, unitPersonnage, SysUtils, TypInfo;
  // TYPES

  type categorie=(Soin,Protection,Degats);

  type Objet = record
     nom: String;
     valeur: Integer;
     cate: Categorie;
     action: Integer;
  end;

    type listeObj = array[1..3] of Objet;
    type poss = array[1..3] of Integer;

  type inventaire = record
     listeObjets : listeObj;
     possession : poss;
  end;

  // FONCTIONS ET PROCEDURES

  //Procedure qui definie les objets
  procedure initObjet(var o1,o2,o3:Objet);

  //Procedure qui definie l'inventaire
  procedure initInventaire(var liste:Inventaire; var o1,o2,o3:Objet);

  //Procedure qui affiche les objets
  procedure afficheObjet(var o:Objet);

  //Procedure qui affiche l'inventaire
  procedure afficheInventaire(var liste:Inventaire);

  //Procedure qui permet d'equiper des objets
  procedure equipement(var perso : Personnage;var inventairePerso : Inventaire; var indicateur : Integer; var nomEquipement : String);

implementation
   uses UnitMenu;

   //Procedure qui definie les objets
   procedure initObjet(var o1,o2,o3:Objet);
   begin
      o1.nom:='Epee';
      o1.valeur:=5;
      o1.cate:=Degats;
      o1.action:=20;

      o2.nom:='Bouclier';
      o2.valeur:=3;
      o2.cate:=Protection;
      o2.action:=10;

      o3.nom:='Potion de soin';
      o3.valeur:=5;
      o3.cate:=Soin;
      o3.action:=30;
   end;

   //Procedure qui definie l'inventaire
   procedure initInventaire(var liste:Inventaire; var o1,o2,o3:Objet);
   begin
      liste.listeObjets[1]:=o1;
      liste.listeObjets[2]:=o2;
      liste.listeObjets[3]:=o3;

      liste.possession[1]:=1;
      liste.possession[2]:=0;
      liste.possession[3]:=0;
   end;

   //Procedure qui affiche les objets
   procedure afficheObjet(var o:Objet);
   var
       coorTemp : coordonnees; //Coordonnées de la position initial
   begin
       coorTemp := positionCurseur();

       dessinercadre(coorTemp, posXY(coorTemp.x + 30, coorTemp.y+6), double, White, Black); //On dessine le cadre qui entoure le texte
       ecrireEnPosition(posXY(coorTemp.x+4, coorTemp.y), ' ' + o.nom + ' ');

       deplacerCurseur(posXY(coorTemp.x+4, coorTemp.y+1));

       writelnPerso('Valeur : ' + IntToStr(o.valeur) + ' or');
       writelnPerso(GetEnumName(TypeInfo(categorie), Ord(o.cate)) + ' : ' + IntToStr(o.action));
       deplacerCurseur(posXY(coorTemp.x, coorTemp.y+5));
   end;

   //Procedure qui affiche l'inventaire
   procedure afficheInventaire(var liste:Inventaire);
   var
     i:Integer; //Variable de la boucle
     textTemp : String; //Variable qui contient la quantité à afficher dans le cadre correspondant
   begin
     for i:=1 to length(liste.listeObjets) DO
     begin
        if (liste.possession[i]>0) then
        begin
             afficheObjet(liste.listeObjets[i]);
             textTemp := 'Quantite : ' + IntToStr(liste.possession[i]) + ' ';
             ecrireEnPosition(posXY(positionCurseur().x+4, positionCurseur().y-1), textTemp);
             deplacerCurseur(posXY(positionCurseur().x - length(textTemp)-4, positionCurseur().y+3));
             writelnPerso();
        end;
     end;
   end;

   //Procedure qui permet d'equiper des objets
   procedure equipement(var perso : Personnage; var inventairePerso : Inventaire; var indicateur : Integer; var nomEquipement : String);
   var
     option : Integer; //Choix fait par l'utilisateur
     sortie : Boolean; //Variable de la boucle
     coorTemp : coordonnees; //Coordonnées de la position initial
   begin
     sortie := False;
     coorTemp := positionCurseur();
     while sortie = False do
     begin
       ecrireEnPosition(positionCurseur(), '                                       ');
       deplacerCurseur(coorTemp);
       writelnPerso('De quel objet voulez-vous vous equiper ?');
       writelnPerso();
       writelnPerso(' >  Epee');
       writelnPerso(' >  Bouclier');
       writelnPerso(' >  Potion');
       writelnPerso(' >  Partir');
       option := selectionMenu(posXY(positionCurseur().x, positionCurseur().y-3), 4, 1, 2, LightBlue, White) + 1;
       case option of
         1 :
           begin
           if inventairePerso.possession[1] > 0 then
           begin
             if indicateur = 1 then
               begin
               if nomEquipement = 'Epee' then
                 begin
                 writelnPerso('Elle est deja equiper');
                 readlnPerso();
                 end
               else
                 begin
                 writelnPerso('Vous vous en Equiper');
                 readlnPerso();
                 perso.defense := perso.defense - 10;
                 perso.attaque := perso.attaque + 20;
                 indicateur := indicateur + 1;
                 nomEquipement := 'Epee';
                 end;
               end
             else
               begin
               writelnPerso('Vous vous equiper de l''epee !');
               readlnPerso();
               perso.attaque := perso.attaque + 20;
               indicateur := indicateur + 1;
               nomEquipement := 'Epee';
               end;
            end
           else
             begin
             writelnPerso('Vous n''avez pas cet objet...');
             readlnPerso();
             end;
           end;
         2 :
           begin
           if inventairePerso.possession[2] > 0 then
             begin
             if indicateur = 1 then
               begin
               if nomEquipement = 'Bouclier' then
                 begin
                 writelnPerso('Elle est deja equiper');
                 readlnPerso();
                 end
               else
                 begin
                 writelnPerso('Vous vous en Equiper');
                 readlnPerso();
                 perso.defense := perso.defense + 10;
                 perso.attaque := perso.attaque - 20;
                 indicateur := indicateur + 1;
                 nomEquipement := 'Bouclier';
                 end;
               end
             else
               begin
               writelnPerso('Vous vous equiper du Bouclier !');
               readlnPerso();
               perso.defense := perso.defense + 10;
               indicateur := indicateur + 1;
               nomEquipement := 'Bouclier';
               end;

             end
            else
               begin
               writelnPerso('Vous n''avez pas cet objet...');
               readlnPerso();
               end;
           end;
         3 :
           begin
           if inventairePerso.possession[3] > 0 then
             begin
             writelnPerso('Vous consommer une potion !');
             writelnPerso('Vous regagner 30 PV !');
             perso.pv := perso.pv + 30;
             if perso.pv > perso.pvMax then
               perso.pv := perso.pvMax;
             inventairePerso.possession[3] := inventairePerso.possession[3]-1;
             readlnPerso();
             end
           else
             begin
             writelnPerso('Vous n''avez pas de potion...');
             readlnPerso();
             end;
           end;
         4 : sortie := True;
       end;
     end;
   end;
end.
