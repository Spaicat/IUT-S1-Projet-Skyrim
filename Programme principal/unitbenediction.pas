unit unitbenediction;


interface

uses unitpersonnage, UnitMenu,GestionEcran;

//PROCEDURE

//Permet, en fin de combat, de choisir une bénédiction des Dieux nordiques.
procedure Benediction(var perso: personnage);


implementation

procedure Benediction(var perso: personnage);

var
  texte1 : Coordonnees; // Première bénédiction (ODIN)
  texte2 : Coordonnees; // Deuxième bénédiction (IDUNN)
  texte3 : Coordonnees; // Troisième bénédiction (THOR)
  texte4 : Coordonnees; // Phrase finale de choix ("Vous êtes bénis par ...")
  temp : Integer;

begin
  texte1.x := 30;    //Assimilation des coordonnées au premier choix
  texte1.y := 40;

  texte2.x := 30;    //Assimilation des coordonnées au second choix
  texte2.y := 45;

  texte3.x := 30;    //Assimilation des coordonnées au troisième choix
  texte3.y := 50;

  texte4.x := 30;    //Assimilation des coordonnées à la phrase finale des choix "vous êtes bénis par ..."
  texte4.y := 55;

  //CHOIX DE LA BENEDICTION
  writeln('De quelle bénédiction souhaitez-vous beneficiez pour la suite de votre aventure ?');
  //ODIN
  ecrireEnPosition(texte1,'Benediction d''Odin - Votre force prend exemple sur celle du Dieu de la guerre. Votre attaque est augmentee de 30');
  //IDUNN
  ecrireEnPosition(texte2,'Benediction d''Idunn - La deesse de la jeunesse immortelle ameliore votre resistance. Votre vie sera augmentee de 30');
  //THOR
  ecrireEnPosition(texte3,'Bénédiction de Thor - Le tonnerre et la protection de Thor vous accompagne. Votre attaque, votre vie et votre defense sont augmente de 10');

  temp := selectionMenu(texte1,3,5,20,3,15); //Permet de sélectionner son choix grâce aux touches flèches haut/bas et la touche entrée

  case temp of
  0 :         //BENEDICTION D'ODIN
    begin
    perso.attaque:= perso.attaque + 30;
    ecrireEnPosition(texte4,'Vous etes benis par Odin. ');
    writeln('Votre attaque est desormais de ',perso.attaque);
    end;
  1:          //BENEDICTION D'IDUNN
    begin
    perso.pv:= perso.pv + 30;
    perso.pvMax := perso.pvMax +30;
    ecrireEnPosition(texte4,'Vous etes benis pas Idunn. ');
    writeln('Votre vie est elevee a ',perso.pv,' pv');
    end;
  2:         //BENEDICTION DE THOR
    begin
    perso.pv:= perso.pv + 10;
    perso.attaque:= perso.attaque + 10;
    perso.defense:= perso.defense +10;
    ecrireEnPosition(texte4,'Vous etes benis par Thor. ');
    writeln('Votre vie est de ',perso.pv,' pv, votre attaque est désormais de ',perso.attaque,' et votre defense est de ',perso.defense);
    end;
  end;

end;

end.
