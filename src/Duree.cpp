#include "Duree.h"

// Constructors and Destructor {{{
Duree::Duree(int heures, int minutes, int secondes) :
m_heures(heures), m_minutes(minutes), m_secondes(secondes)
{
  if (m_secondes >= 60)
  {
    m_minutes += m_secondes/60;
    m_secondes = m_secondes%60;
  }
  if (m_minutes >= 60)
  {
    m_heures += m_minutes/60;
    m_minutes = m_minutes%60;
  }
}

Duree::Duree(Duree const& a) :
m_heures(a.m_heures), m_minutes(a.m_minutes), m_secondes(a.m_secondes)
{

}

Duree::~Duree()
{

}
//}}}

//{{{ get methodes
//std::string Duree::getNomDuree() const
//{
//  return m_nomDuree;
//}

int Duree::getHeures() const
{
  return(m_heures);
}

int Duree::getMinutes() const
{
  return(m_minutes);
}

int Duree::getSecondes() const
{
  return(m_secondes);
}
//}}}

//void Duree::afficherDuree() const
//{
//  afficherDuree(m_nomDuree);
//}

//void Duree::afficherDuree(std::string str) const
//{
//  std::cout << str << " = " << m_heures << "h " << m_minutes << "min " << m_secondes << "sc" << std::endl;
//}

void Duree::afficherDuree() const
{
  std::cout << m_heures << "h " << m_minutes << "min " << m_secondes << "sc" << std::endl;
}

//{{{ Methods pour la surcharge d'opérateurs :
bool Duree::estEgal(Duree const& b) const
{
  return (m_secondes==b.m_secondes && m_minutes==b.m_minutes &&
m_heures==b.m_heures );
}

bool Duree::estPlusPetitQue(Duree const& b) const
{
  if(m_heures < b.m_heures)
    return true;
  else if (m_heures==b.m_heures && m_minutes < b.m_minutes)
    return true;
  else if (m_heures==b.m_heures && m_minutes==b.m_minutes && m_secondes < b.m_secondes)
    return true;
  else
    return false;
}

//}}}

//{{{ Surcharge d'opérateurs :

bool operator==(Duree const& a, Duree const& b)
{
  return a.estEgal(b);
}

bool operator!=(Duree const& a, Duree const& b)
{
  return !(a==b);
}

bool operator<(Duree const& a, Duree const& b)
{
  return a.estPlusPetitQue(b);
}

bool operator>(Duree const& a, Duree const& b)
{
  return (a!=b && a<b);
}

bool operator>=(Duree const& a, Duree const& b)
{
  return a<b;
}

bool operator<=(Duree const& a, Duree const& b)
{
  return (a<b || a==b);
}

Duree& Duree::operator+=(Duree const& b)
{
  m_secondes += b.m_secondes ;
  m_minutes += b.m_minutes ;
  m_heures += b.m_heures ;

  if (m_secondes >= 60)
  {
    m_minutes += m_secondes/60;
    m_secondes = m_secondes%60;
  }
  if (m_minutes >= 60)
  {
    m_heures += m_minutes/60;
    m_minutes = m_minutes%60;
  }
  return *this;
}

Duree operator+(Duree const& a, Duree const& b)
{
   Duree copie(a);
   copie += b;
   return copie;
}

//}}}
