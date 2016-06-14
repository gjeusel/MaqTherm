#ifndef ARME_H
#define ARME_H

#include <iostream>
#include <string>

class Arme
{
  public:

  Arme();
  Arme(std::string nom, int degats);
  ~Arme();

  void changer(std::string nom, int degats);
  void afficher() const;

  // Accesseurs :
  std::string getNom() const;
  int getDegats() const;

  private:

  std::string m_nom;
  int m_degats;

};

#endif
