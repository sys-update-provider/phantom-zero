#!/bin/bash

# Couleurs
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}[*] Étape 1 : Nettoyage radical des fichiers corrompus...${NC}"
sudo rm -f /etc/apt/sources.list.d/i2p*
sudo rm -f /usr/share/keyrings/i2p-archive-keyring.gpg

echo -e "${BLUE}[*] Étape 2 : Importation moderne de la clé I2P...${NC}"
# On utilise curl et tee (méthode moderne) pour éviter l'erreur EOF
curl -sL https://geti2p.net/_static/i2p-archive-keyring.gpg | sudo tee /usr/share/keyrings/i2p-archive-keyring.gpg > /dev/null

echo -e "${BLUE}[*] Étape 3 : Création du dépôt I2P propre...${NC}"
echo "deb [signed-by=/usr/share/keyrings/i2p-archive-keyring.gpg] https://deb.i2p.net/ forky main" | sudo tee /etc/apt/sources.list.d/i2p.list

echo -e "${BLUE}[*] Étape 4 : Mise à jour et installation des dépendances...${NC}"
sudo apt-get update
# On installe i2p et secure-delete MAINTENANT pour qu'Anonsurf arrête de pleurer
sudo apt-get install -y i2p secure-delete tor git curl

echo -e "${BLUE}[*] Étape 5 : Préparation et Patch de Kali-Anonsurf...${NC}"
if [ -d "kali-anonsurf" ]; then sudo rm -rf kali-anonsurf; fi
git clone https://github.com/Und3rf10w/kali-anonsurf.git
cd kali-anonsurf

# PATCH CRITIQUE : On commente les lignes du script d'Anonsurf qui cassent le dépôt I2P
echo -e "${RED}[!] Neutralisation du code obsolète dans l'installeur d'Anonsurf...${NC}"
sed -i 's/wget -qO - https:\/\/geti2p.net\/_static\/i2p-archive-keyring.gpg/#/g' installer.sh
sed -i 's/apt-key add -/#/g' installer.sh

echo -e "${BLUE}[*] Étape 6 : Lancement de l'installation d'Anonsurf...${NC}"
sudo ./installer.sh
cd ..

echo -e "${GREEN}[+] VICTOIRE ! Tout est installé et configuré proprement.${NC}"
echo -e "\n${BLUE}--- RAPPEL DES COMMANDES ---${NC}"
echo -e "Anonymat Tor : ${GREEN}sudo anonsurf start${NC} / ${RED}sudo anonsurf stop${NC}"
echo -e "Réseau I2P   : ${GREEN}i2prouter start${NC} (puis va sur http://127.0.0.1:7657)"
