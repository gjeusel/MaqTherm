#ifndef DUREE_H
#define DUREE_H

#include <string>
#include <iostream>

class Duree
{
  public :
  Duree(int heures = 0, int minutes = 0, int secondes = 0);
  Duree(Duree const& a);
  ~Duree();

  // Chained overload to make a member a default value for a method's argument
  //void afficherDuree() const;
  //void afficherDuree(std::string str) const;

  void afficherDuree() const;

  bool estEgal(Duree const& b) const;
  bool estPlusPetitQue(Duree const& b) const;

  Duree& operator+=(Duree const& b) ;

  std::string getNomDuree() const;
  int getHeures() const;
  int getMinutes() const;
  int getSecondes() const;

  private :
  //std::string m_nomDuree;
  int m_heures;
  int m_minutes;
  int m_secondes;
};

  bool operator==(Duree const& a, Duree const& b);
  bool operator!=(Duree const& a, Duree const& b);
  bool operator<(Duree const& a, Duree const& b);
  bool operator>(Duree const& a, Duree const& b);
  bool operator<=(Duree const& a, Duree const& b);
  bool operator>=(Duree const& a, Duree const& b);

  Duree operator+(Duree const& a, Duree const& b);

#endif
