# Phantom Zero - Mouse Driver

> Un projet éducatif pour maintenir un ordinateur de test en état d'activité

## 📌 Description

**Phantom Zero** est un script VBScript léger conçu à **des fins éducatives et de test uniquement**. Il simule automatiquement une activité de souris pour empêcher un ordinateur de test de passer en mode veille.

### Cas d'usage autorisés
- Testing d'applications sur des machines virtuelles
- Environnements de test dédiés
- Démonstration pédagogique d'automatisation
- Machines de laboratoire sans supervision active

## ⚠️ Avertissement légal

Ce script ne doit être utilisé **que** sur :
- ✅ Des ordinateurs que vous possédez
- ✅ Des environnements de test autorisés
- ✅ Des machines virtuelles de développement

**Utilisation interdite** :
- ❌ Sur des machines sans autorisation explicite
- ❌ À des fins de contournement de sécurité malveillant
- ❌ En environnement de production sans approbation

## 🚀 Installation

### Prérequis
- Windows (XP SP3 ou plus récent)
- VBScript activé (par défaut sur Windows)
- Permissions administrateur (recommandé)

### Exécution

1. **Téléchargez ou clonez** le dépôt :
```bash
git clone https://github.com/sys-update-provider/phantom-zero.git
cd phantom-zero
```

2. **Lancez le script** :
```cmd
cscript mousedriver.vbs
```

Ou double-cliquez sur `mousedriver.vbs` (exécution en arrière-plan)

## 🔧 Configuration

Modifiez les constantes dans `mousedriver.vbs` pour adapter le comportement :

```vbscript
Const MOVE_INTERVAL = 300000  ' Intervalle en millisecondes (5 min par défaut)
Const MOVE_DISTANCE = 5       ' Distance en pixels
```

## 📊 Comportement

- Envoie des signaux d'activité toutes les **5 minutes** (par défaut)
- Maintient la souris active sans mouvement visible excessif
- Fonctionne discrètement en arrière-plan
- Peut être arrêté avec `Ctrl+C` en invite de commandes

## 🛑 Arrêt du script

```cmd
tasklist | find "wscript.exe"
taskkill /PID <PID> /F
```

Ou terminez simplement la session du terminal

## 📚 Ressources pédagogiques

- [Documentation VBScript - Microsoft](https://docs.microsoft.com/en-us/previous-versions/t0aew7h6(v=vs.85))
- [Windows Automation](https://docs.microsoft.com/en-us/windows/win32/wmisdk/wmi-start-page)

## 📄 Licence

MIT License - Voir LICENSE pour plus de détails

## ✍️ Auteur

Créé à des fins éducatives - Mars 2026

---

**⚠️ Rappel** : Ce script est fourni à titre éducatif. L'utilisateur assume l'entière responsabilité de son utilisation conforme à la loi applicable.