unit unitDate;

interface

  uses SysUtils;

  type
    jour =(Morndas,Tirdas,Middas,Turdas,Fredas,Loredas,Sundas);
    mois = (Primetoile,Clairciel,Semailles,Ondepluie,Plantaisons,Mi_lan,Hautzenith,Vifazur,Atrefeu,Soufflegivre,Sombreciel,Soiretoile);


  type
    Time = record
      heure:Integer;
      minute:Integer;
    end;
    dateCourante = record
      t:Time;
      j:jour;
      i:Integer;//numéro du jour
      m:mois;
      a:Integer;
    end;

  //Procédure qui initialise la date (lorsqu'on lance le jeu)
  procedure initDate();

  //Fonction qui renvoie la date actuelle
  function getDate():dateCourante;

  //Procedure qui incrémente la date
  procedure incrementeDate();

  //Procédure qui permet d'incrémenter la date d'une heure
  procedure waitUneHeure();

  //Procédure qui affiche la date
  procedure writeDate();


implementation

  uses UnitMenu;

  var
    temps:dateCourante;

  //Procédure qui initialise la date (lorsqu'on lance le jeu)
  procedure initDate();
  begin
    temps.j:=Morndas;
    temps.i:=12;
    temps.m:=Clairciel;
    temps.t.heure:=10;
    temps.a:=156;
  end;

  //Fonction qui renvoie la date actuelle
  function getDate():dateCourante;
  begin
    getDate:=temps;
  end;

  //Fonction qui dit si une année est bissextile ou non
  function bissextile(annee : integer) : boolean;
  begin
    bissextile := ((annee mod 400 = 0) or ((annee mod 100 <> 0) and (annee mod 4 = 0)));
  end;

  //Fonction qui renvoie le jour suivant le jour passé en paramètre
  function jourSuivant(j : jour) : jour;
  begin
    if (j = Sundas)
    then jourSuivant := Morndas
    else jourSuivant := Succ(j);
  end;

  //Fonction qui renvoie le mois suivant le mois passé en paramètre
  function moisSuivant(m : mois) : mois;
  begin
    if (m = Soiretoile)
    then moisSuivant := Primetoile
    else moisSuivant := Succ(m)
  end;

  //Fonction qui renvoie le nombre de jour dans le mois correspondant en paramètre (et l'année si bissextile)
  function nbJours(m : mois; annee : integer) : integer;
  begin
    case m of
      Ondepluie, Mi_lan, Sombreciel: nbJours := 30;
      Clairciel:
      begin
        if(bissextile(annee))
        then nbJours := 29
        else nbJours := 28;
      end;
      else nbJours := 31 ;
    end;
  end;

  //Procedure qui incrémente la date
  procedure incrementeDate();
  begin
    randomize();
    temps.t.minute:=temps.t.minute+random(5)+6;
    if temps.t.minute>=60 then
    begin
      temps.t.minute:=0;
      temps.t.heure:=temps.t.heure+1;
    end;
    if temps.t.heure>=24 then
    begin
      temps.t.heure:=0;
      temps.j:=jourSuivant(temps.j);
      temps.i:=temps.i+1;
      if temps.i>nbJours(temps.m,temps.a) then
      begin
        temps.i:=1;
        temps.m:=moisSuivant(temps.m);
        if ord(temps.m)=1 then
        begin
          temps.a:=temps.a+1;
        end;
      end;
    end;
  end;

 //Fonction qui renvoie la chaine de caractères correspondant au jour passé en paramètre
 function strJour(j : jour):String;
  var
     res:String;
  begin
    case j of
      Morndas: res:='Morndas';
      Tirdas: res:='Tirdas';
      Middas: res:='Middas';
      Turdas: res:='Turdas';
      Fredas: res:='Fredas';
      Loredas: res:='Loredas';
      Sundas: res:='Sundas';
    end;
    strJour:=res;
  end;

  //Procédure qui permet d'incrémenter la date d'une heure
  procedure waitUneHeure();
  begin
    temps.t.heure:=temps.t.heure+1;
  end;

  //Fonction qui renvoie la chaine de caractères correspondant au mois passé en paramètre
  function strMois(m : mois):String;
  var
     res:String;
  begin
    case m  of
      Primetoile: res:='Primetoile';
      Clairciel: res:='Clairciel';
      Semailles: res:='Semailles';
      Ondepluie: res:='Ondepluie';
      Plantaisons: res:='Plantaisons';
      Mi_lan: res:='Mi_lan';
      Hautzenith: res:='Hautzenith';
      Vifazur: res:='Vifazur';
      Atrefeu: res:='Atrefeu';
      Soufflegivre: res:='Soufflegivre';
      Sombreciel: res:='Sombreciel';
      Soiretoile: res:='Soiretoile';
    end;
    strMois:=res;
  end;

  //Procédure qui affiche la date
  procedure writeDate();
  var
     res:String;
  begin
    res:=strJour(temps.j)+' '+IntToStr(temps.i)+' '+strMois(temps.m)+' de l''an '+IntToStr(temps.a)+' '+IntToStr(temps.t.heure)+'h';
    if temps.t.minute<10 then
       res:=res+'0';
    res:=res+IntToStr(temps.t.minute);
    write(res);
  end;

end.
