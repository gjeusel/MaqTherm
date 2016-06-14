#include "Personnage.h"

using namespace std;

// Constructeur {{{
Personnage::Personnage() : m_nomPerso("Lee Wong"), m_vie(101), m_mana(100)
{

}

Personnage::Personnage(std::string nomPerso) : m_nomPerso(nomPerso),
m_vie(101), m_mana(100)
{

}

Personnage::Personnage(std::string nomArme, int degatsArme) :
m_nomPerso("Lee Wong"), m_vie(100), m_mana(100), m_arme(nomArme, degatsArme)
{

}

Personnage::Personnage(std::string nomPerso, std::string nomArme, int degatsArme) :
m_nomPerso(nomPerso), m_vie(100), m_mana(100), m_arme(nomArme, degatsArme)
{

}
// }}}

Personnage::~Personnage()
{
      /* Rien à mettre ici car on ne fait pas d'allocation dynamique
       * dans la classe Personnage. Le destructeur est donc inutile.
       * En temps normal, un destructeur fait souvent des delete et quelques
       * autres vérifications si nécessaire avant la destruction de l'objet. */
}

void Personnage::recevoirDegats(int nbDegats)
{
  m_vie = m_vie - nbDegats ;

  if (m_vie < 0)
  {
    m_vie = 0;
  }

}

void Personnage::attaquer(Personnage &cible)
{
  cible.recevoirDegats(m_arme.getDegats());
}

void Personnage::boirePotionDeVie(int quantitePotion)
{
  m_vie = m_vie + quantitePotion ;

  if (m_vie > 100)
  {
    m_vie = 100;
  }

}

void Personnage::changerArme(string nomNouvelleArme, int degatsNouvelleArme)
{
  m_arme.changer(nomNouvelleArme, degatsNouvelleArme);
}

bool Personnage::estVivant() const
{
  return m_vie > 0 ;
}

void Personnage::afficherEtat() const
{
  cout << m_nomPerso << " :" << endl;
  cout << m_vie  << " de vie" << endl;
  cout << m_mana  << " de mana" << endl;
  m_arme.afficher();
}
