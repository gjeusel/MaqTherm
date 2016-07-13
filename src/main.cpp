#include <iostream>
#include <string>
#include "Personnage.h"
#include "Duree.h"

using namespace std;

int main()
{

  Duree duree1(0, 10, 29);
  Duree duree2(0, 159, 200);
  Duree duree3(0, 10, 29);
  Duree resultat;

  duree1.afficherDuree();
  cout << "plus" << endl;
  duree2.afficherDuree();
  cout << "donne" << endl;

  duree3 = duree1 + duree2;
  duree3.afficherDuree();


//// JEUX {{{
//  //Création des personnages
//  Personnage David("David"), Goliath("Goliath","Epée aiguisée", 20);

//  // Au combat !
//  Goliath.attaquer(David);
//  David.boirePotionDeVie(20);
//  Goliath.attaquer(David);
//  David.attaquer(Goliath);
//  Goliath.changerArme("Double hache tranchante vénéneuse de la mort", 40);
//  Goliath.attaquer(David);

//  Goliath.afficherEtat();
//  David.afficherEtat();
////}}}

  return 0;
}
