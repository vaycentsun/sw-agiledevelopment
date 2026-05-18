<div align="right">
  <a href="./README.md">🇺🇸 English</a> | <a href="./README.zh.md">🇨🇳 中文</a> | <a href="./README.ja.md">🇯🇵 日本語</a> | <a href="./README.es.md">🇪🇸 Español</a> | <strong>🇫🇷 Français</strong>
</div>

# sw-agiledevelopment 🦸

> Un ensemble de compétences style Agile Development pour agents de codage AI — flux de travail d'ingénierie logicielle structurés de la clarification des besoins à la révision de code.

Un ensemble complet de compétences de flux de travail d'ingénierie logicielle qui aide les agents de codage AI à accomplir chaque étape de l'analyse des besoins à la révision de code de manière systématique et reproductible.

---

## 📦 Vue d'Ensemble

`sw-agiledevelopment` est un ensemble de compétences style Superpowers conçu pour [OpenCode](https://opencode.ai) et d'autres plateformes de codage AI. Il encapsule les pratiques matures d'ingénierie logicielle (TDD, révision de code, débogage systématique) en compétences d'agent structurées et réutilisables.

### Principes Fondamentaux

- **Piloté par le Processus** : Chaque compétence définit des conditions de déclenchement claires et des flux de travail d'exécution
- **Règles d'Abord** : Les règles non négociables sont placées en premier plan
- **Testé sous Pression** : Les compétences sont créées et validées via TDD
- **Livraison Incrémentale** : Flux de travail complet de la clarification des besoins à la livraison de code

---

## 🗂️ Structure du Projet

```
sw-agiledevelopment/
├── sw-requirements-clarification/              # Analyse et clarification des besoins
├── sw-technical-spec/             # Rédaction des spécifications techniques
├── sw-working-plan/              # Rédaction des plans d'implémentation
├── sw-subagent-development/       # Développement piloté par sous-agent
├── sw-test-driven-dev/            # Développement piloté par les tests
├── sw-code-review/                  # Révision de code (auto-déclenchée)
├── sw-systematic-debugging/       # Débogage systématique
├── sw-parallel-debugging/  # Débogage parallèle
├── sw-execute-plan/            # Exécution de plans
├── sw-task-verification/  # Vérification des tâches
├── sw-finishing-branch/           # Achèvement de branche de développement
├── sw-using-agiledevelopment/          # Bootstrap du système de compétences (entrée principale)
└── sw-writing-skills/             # Rédaction de nouvelles compétences (méta-compétence)
```

---

## 🚀 Flux de Travail Principal

Le flux de travail complet de développement logiciel s'exécute dans l'ordre suivant :

```
Démarrer Nouvelle Fonctionnalité
    ↓
sw-requirements-clarification (Clarification et Conception)
    ↓ Sortie : docs/sw-agiledevelopment/business-specs/YYYY-MM-DD--feature.md
sw-technical-spec (Rédaction des Spécifications Techniques)
    ↓ Sortie : docs/sw-agiledevelopment/technical-specs/YYYY-MM-DD--feature.md
sw-working-plan (Rédaction du Plan d'Implémentation)
    ↓ Sortie : docs/sw-agiledevelopment/plans/YYYY-MM-DD--feature-plan.md
sw-subagent-development (Développement Piloté par Sous-Agent)
    ├── sw-test-driven-dev (TDD pour chaque tâche)
    ├── sw-code-review (Révision après tâches)
    ↓
sw-task-verification (Vérification des Tâches)
    ↓
sw-finishing-branch (Achèvement de Branche)
```

---

## 📋 Aperçu des Compétences

| Compétence | Objectif | Condition de Déclenchement |
|------------|----------|----------------------------|
| **sw-requirements-clarification** | Transformer les idées en conception et spécifications complètes | Démarrage du développement d'une nouvelle fonctionnalité |
| **sw-working-plan** | Créer des plans d'implémentation détaillés | Conception terminée, besoin d'un plan d'exécution |
| **sw-subagent-development** | Exécuter les plans en utilisant des sous-agents | Avoir un plan d'implémentation, les tâches sont indépendantes |
| **sw-test-driven-dev** | Appliquer le cycle RED-GREEN-REFACTOR | Implémenter toute fonctionnalité ou corriger des bogues |
| **sw-code-review** | Dispatcher un sous-agent réviseur | Après tâche, avant merge |
| **sw-systematic-debugging** | Investigation systématique des bogues | Bogues trouvés ou tests échoués |
| **sw-parallel-debugging** | Débogage parallèle | 2+ échecs indépendants |
| **sw-execute-plan** | Exécuter les plans par lots dans la même session | Avoir un plan, ne pas utiliser de sous-agents |
| **sw-task-verification** | Vérification des tâches | Prêt à marquer la tâche comme terminée |
| **sw-finishing-branch** | Vérifier, décider et nettoyer la branche | Toutes les tâches terminées |
| **sw-writing-skills** | Créer et valider de nouvelles compétences | Besoin de créer une nouvelle compétence |
| **sw-using-agiledevelopment** | Bootstrap du système de compétences | Début de chaque conversation |

---

## 🎯 Démarrage Rapide

### Installation

**Méthode 1 : Plugin OpenCode (Recommandé)**

Ajoutez à votre `~/.config/opencode/opencode.json` :

```json
{
  "plugin": [
    "sw-agiledevelopment@git+http://192.168.1.100:53000/vaycent/sw-agiledevelopment.git#main"
  ],
  "permission": {
    "skill": {
      "*": "allow"
    }
  }
}
```

Redémarrez OpenCode. Le plugin sera installé automatiquement via Bun.

**Méthode 2 : Git Submodule**

```bash
cd <votre-projet>/skills/
git submodule add https://github.com/vaycentsun/sw-agiledevelopment.git
git submodule update --init --recursive
```

Pour mettre à jour le sous-module plus tard :

```bash
cd <votre-projet>/skills/sw-agiledevelopment
git pull origin main
cd <votre-projet>
git add skills/sw-agiledevelopment
git commit -m "Update sw-agiledevelopment submodule"
```

Ou clonez directement (non recommandé pour les projets utilisant le contrôle de version) :

```bash
cd <votre-projet>/skills/
git clone https://github.com/vaycentsun/sw-agiledevelopment.git
```

Redémarrez OpenCode ou rechargez les compétences.

### Exemple d'Utilisation

Lorsque vous démarrez une nouvelle fonctionnalité, l'agent reconnaît automatiquement et applique la compétence appropriée :

```
Utilisateur : Je veux développer une fonctionnalité d'authentification utilisateur

Agent : [Applique automatiquement la Compétence sw-requirements-clarification]
      1. Explorer le contexte du projet...
      2. Poser des questions de clarification...
      3. Proposer 2-3 approches...
      4. Présenter la conception en sections...
      5. Rédiger le document de spécification → docs/sw-agiledevelopment/technical-specs/2026-04-18--user-auth.md
      6. Invoquer sw-working-plan pour créer le plan d'implémentation...
```

---

## 🏗️ Structure de Compétence

Chaque compétence est un répertoire autonome suivant une structure unifiée :

```
sw-<skill-name>/
├── SKILL.md                    # Fichier de compétence principal (requis)
├── subagent-prompts/           # Invites de sous-agent (optionnel)
│   └── <name>-prompt.md

```

### Format SKILL.md

```markdown
---
name: skill-name
description: "Use when [condition de déclenchement spécifique]"
---

# Nom de la Compétence

## Règles de Fer
Règles clés qui ne doivent pas être violées

## Processus
Organigramme et étapes détaillées

## Drapeaux Rouges - Arrêter Immédiatement
Liste des signes de violation

## Table des Excuses Courantes
| Excuse | Réalité |
|--------|---------|

## Intégration
Compétences préalables et subséquentes

## Exemple de Sortie
Format de sortie attendu
```

---

## 🔑 Principes Clés

### Principe YAGNI

> You Aren't Gonna Need It (Tu n'auras pas besoin de ça)

- Ne pas ajouter de fonctionnalités non requises par la spécification
- Ne pas sur-ingenier
- Ne pas supposer de besoins futurs

### Principes de Développement avec Sous-Agents

- Utiliser un nouveau sous-agent pour chaque tâche
- Les sous-agents ne doivent pas hériter du contexte de session
- Fournir le texte de tâche complet et le contexte

### Principes de Révision

- **Objectif** : Basé sur des normes, pas des préférences personnelles
- **Constructif** : Fournir des suggestions d'amélioration spécifiques
- **Priorisé** : Se concentrer sur les problèmes critiques

---

## 🧪 Stratégie de Test

Ce projet développe des compétences en utilisant TDD :

1. **Tests d'Abord, Compétence Ensuite** - Sans exception
2. **Créer des Scénarios de Pression** - 3+ tests de combinaison de pressions
3. **Documenter les Échecs Baseline** - Observer le comportement d'échec sans compétence
4. **Écrire la Compétence pour Aborder les Échecs** - Cibler les échecs observés
5. **Vérifier la Conformité** - Retester avec la compétence
6. **Fermer les Échappatoires** - Trouver de nouvelles excuses, ajouter des contremesures

---

## 🤝 Contribuer

### Créer une Nouvelle Compétence

1. Utiliser la compétence `sw-writing-skills` pour guider le processus de création
2. Suivre l'approche TDD : tester d'abord, puis écrire
3. Créer 3+ tests de scénarios de pression
4. Documenter le comportement d'échec baseline
5. Écrire la compétence pour aborder les échecs spécifiques
6. Vérifier la conformité, fermer les échappatoires

### Convention de Commit

```bash
# Créer une nouvelle compétence
feat: add sw-<skill-name> for <purpose>

# Mettre à jour une compétence existante
fix: resolve <issue> in sw-<skill-name>

docs: update <section> in sw-<skill-name>
```

---

## 📄 Licence

[MIT](./LICENSE)

---

## 🙏 Remerciements

- Basé sur le format de compétences [Superpowers](https://github.com/anthropics/superpowers)
- Inspiré par des pratiques matures d'ingénierie logicielle

---

<div align="center">

**Rendre la programmation AI plus systématique, prévisible et de haute qualité** 🚀

</div>
