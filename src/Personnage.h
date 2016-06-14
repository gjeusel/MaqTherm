#ifndef PERSONNAGE_H
#define PERSONNAGE_H

#include <iostream>
#include <string>
#include "Arme.h"

class Personnage
{
  public:

  Personnage(); // Constructeur
  Personnage(std::string nomPerso); // Surchage du constructeur
  Personnage(std::string nomArme, int degatsArme); // Surchage du constructeur
  Personnage(std::string nomPerso, std::string nomArme, int degatsArme); // Surchage du constructeur

  ~Personnage(); // Destructeur

  void recevoirDegats(int nbDegats);
  void attaquer(Personnage &cible);
  void boirePotionDeVie(int quantitePotion);
  void changerArme(std::string nomNouvelleArme, int degatsNouvelleArme);
  bool estVivant() const;
  void afficherEtat() const;

  private:

  std::string m_nomPerso;
  int m_vie;
  int m_mana;
  Arme m_arme;
};

#endif
