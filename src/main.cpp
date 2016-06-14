#include <iostream>
#include <string>
#include "Personnage.h"

using namespace std;

int main()
{
  //Création des personnages
  Personnage David("David"), Goliath("Goliath","Epée aiguisée", 20);

  // Au combat !
  Goliath.attaquer(David);
  David.boirePotionDeVie(20);
  Goliath.attaquer(David);
  David.attaquer(Goliath);
  Goliath.changerArme("Double hache tranchante vénéneuse de la mort", 40);
  Goliath.attaquer(David);

  Goliath.afficherEtat();
  David.afficherEtat();

  return 0;
}
