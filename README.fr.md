<div align="right">
  <a href="./README.md">🇺🇸 English</a> | <a href="./README.zh.md">🇨🇳 中文</a> | <a href="./README.ja.md">🇯🇵 日本語</a> | <a href="./README.es.md">🇪🇸 Español</a> | <strong>🇫🇷 Français</strong>
</div>

# sw-agiledevelopment 🦸

> Un ensemble de compétences style Agile Development pour agents de codage AI — flux de travail d'ingénierie logicielle structurés de la clarification des besoins à la révision de code.

Un ensemble complet de compétences de flux de travail d'ingénierie logicielle qui aide les agents de codage AI à accomplir chaque étape de l'analyse des besoins à la révision de code de manière systématique et reproductible.

---

## 🚀 Démarrage Rapide

### Installation

**OpenCode Plugin (Recommandé)**

Dites simplement à votre Agent IA :

> "Installe le plugin sw-agiledevelopment depuis https://github.com/vaycentsun/sw-agiledevelopment et suis les instructions dans `.opencode/INSTALL.md`."

L'Agent lira le guide d'installation, configurera le plugin et vérifiera l'installation automatiquement.

**Codex Plugin Installation**

Dites simplement à votre Agent IA :

> "Installe le plugin sw-agiledevelopment depuis https://github.com/vaycentsun/sw-agiledevelopment et suis les instructions dans `.codex-plugin/INSTALL.md`."

L'Agent lira le guide d'installation, configurera le plugin et vérifiera l'installation automatiquement.

---

## 🗺️ Flux de Travail Principal

```
Démarrer Nouvelle Fonctionnalité
    ↓
sw-requirements-clarification (Clarification et Conception)
    ↓ Sortie : business-specs/YYYY-MM-DD--feature.md
sw-technical-spec (Rédaction des Spécifications Techniques)
    ↓ Sortie : technical-specs/YYYY-MM-DD--feature.md
sw-working-plan (Rédaction du Plan d'Implémentation)
    ↓ Sortie : plans/YYYY-MM-DD--feature-plan.md
sw-subagent-development (Développement Piloté par Sous-Agent)
    ├── sw-test-driven-dev (TDD pour chaque tâche)
    ├── sw-code-review (Révision après tâches)
    ↓
sw-task-verification (Vérification des Tâches)
    ↓
sw-finishing-branch (Achèvement de Branche)
```

**Chemins alternatifs :**
- `sw-execute-plan` — Exécuter les plans par lots dans la même session (sans sous-agents)
- `sw-parallel-debugging` — Débogage parallèle des échecs indépendants

---

## 📋 Aperçu des Compétences

| Compétence | Objectif | Condition de Déclenchement |
|------------|----------|----------------------------|
| **sw-requirements-clarification** | Transformer les idées en besoins métier | Démarrage d'une nouvelle fonctionnalité |
| **sw-technical-spec** | Rédiger des spécifications techniques structurées | Besoins clarifiés |
| **sw-working-plan** | Créer des plans d'implémentation détaillés | Besoin d'un plan d'exécution |
| **sw-subagent-development** | Exécuter les plans en utilisant des sous-agents | Tâches sont indépendantes |
| **sw-execute-plan** | Exécuter les plans par lots dans la même session | Ne pas utiliser de sous-agents |
| **sw-test-driven-dev** | Appliquer le cycle RED-GREEN-REFACTOR | Implémenter ou corriger |
| **sw-code-review** | Demander et gérer le feedback de révision | Après tâche, avant merge |
| **sw-systematic-debugging** | Investigation systématique des bogues | Bogues ou tests échoués |
| **sw-parallel-debugging** | Débogage parallèle | 2+ échecs indépendants |
| **sw-task-verification** | Vérifier l'achèvement de la tâche | Prêt à marquer comme terminée |
| **sw-finishing-branch** | Vérifier, décider et nettoyer la branche | Toutes les tâches terminées |
| **sw-writing-skills** | Créer et valider de nouvelles compétences | Besoin de créer une nouvelle compétence |
| **sw-using-agiledevelopment** | Bootstrap du système de compétences | Début de chaque conversation |

---

## 📄 Licence

[MIT](./LICENSE)

---

## 🙏 Remerciements

- Basé sur la méthodologie Agile Development, inspiré du format de compétences [Superpowers](https://github.com/anthropics/superpowers)
- Inspiré par des pratiques matures d'ingénierie logicielle
