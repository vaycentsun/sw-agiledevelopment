<div align="right">
  <a href="./README.md">🇺🇸 English</a> | <a href="./README.zh.md">🇨🇳 中文</a> | <a href="./README.ja.md">🇯🇵 日本語</a> | <strong>🇪🇸 Español</strong> | <a href="./README.fr.md">🇫🇷 Français</a>
</div>

# sw-agiledevelopment 🦸

> Un conjunto de habilidades estilo Agile Development para agentes de codificación AI — flujos de trabajo de ingeniería de software estructurados desde el análisis de requisitos hasta la revisión de código.

Un conjunto completo de habilidades de flujo de trabajo de ingeniería de software que ayuda a los agentes de codificación AI a completar cada paso desde el análisis de requisitos hasta la revisión de código de manera sistemática y reproducible.

---

## 🚀 Inicio Rápido

### Instalación

**OpenCode Plugin (Recomendado)**

Simplemente dile a tu Agente de IA:

> "Instala el plugin sw-agiledevelopment desde https://github.com/vaycentsun/sw-agiledevelopment y sigue las instrucciones en `.opencode/INSTALL.md`."

El Agente leerá la guía de instalación, configurará el plugin y verificará la instalación automáticamente.

**Codex Plugin Installation**

Simplemente dile a tu Agente de IA:

> "Instala el plugin sw-agiledevelopment desde https://github.com/vaycentsun/sw-agiledevelopment y sigue las instrucciones en `.codex-plugin/INSTALL.md`."

El Agente leerá la guía de instalación, configurará el plugin y verificará la instalación automáticamente.

**Copilot Plugin Installation**

Simplemente dile a tu Agente de IA:

> "Instala el plugin sw-agiledevelopment desde https://github.com/vaycentsun/sw-agiledevelopment y sigue las instrucciones en `.copilot/INSTALL.md`."

El Agente leerá la guía de instalación, configurará el plugin y verificará la instalación automáticamente.

---

## 🗺️ Flujo de Trabajo Principal

```
Iniciar Nueva Función
    ↓
sw-requirements-clarification (Análisis de Requisitos y Diseño)
    ↓ Salida: business-specs/YYYY-MM-DD--feature.md
sw-technical-spec (Escritura de Especificaciones Técnicas)
    ↓ Salida: technical-specs/YYYY-MM-DD--feature.md
sw-working-plan (Escritura del Plan de Implementación)
    ↓ Salida: plans/YYYY-MM-DD--feature-plan.md
sw-subagent-development (Desarrollo Impulsado por Subagentes)
    ├── sw-test-driven-dev (TDD para cada tarea)
    ├── sw-code-review (Revisión después de tareas)
    ↓
sw-task-verification (Verificación de Tareas)
    ↓
sw-finishing-branch (Finalización de Rama)
```

**Rutas alternativas:**
- `sw-execute-plan` — Ejecutar planes en lote en la misma sesión (sin subagentes)
- `sw-parallel-debugging` — Depuración paralela de fallos independientes

---

## 📋 Resumen de Habilidades

| Habilidad | Propósito | Condición de Activación |
|-----------|-----------|-------------------------|
| **sw-requirements-clarification** | Transformar ideas en requisitos de negocio | Iniciando desarrollo de nueva función |
| **sw-technical-spec** | Escribir especificación técnica estructurada | Requisitos clarificados |
| **sw-working-plan** | Crear planes de implementación detallados | Necesita plan de ejecución |
| **sw-subagent-development** | Ejecutar planes usando subagentes | Tareas son independientes |
| **sw-execute-plan** | Ejecutar planes en lote en misma sesión | No usar subagentes |
| **sw-test-driven-dev** | Aplicar ciclo RED-GREEN-REFACTOR | Implementar o corregir |
| **sw-code-review** | Solicitar y manejar feedback de revisión | Después de tarea, antes de merge |
| **sw-systematic-debugging** | Investigación sistemática de errores | Errores o pruebas fallando |
| **sw-parallel-debugging** | Depuración paralela | 2+ fallos independientes |
| **sw-task-verification** | Verificar completitud de tarea | Listo para marcar como completada |
| **sw-finishing-branch** | Verificar, decidir y limpiar rama | Todas las tareas completadas |
| **sw-writing-skills** | Crear y validar nuevas habilidades | Necesidad de crear una nueva habilidad |
| **sw-using-agiledevelopment** | Bootstrap del sistema de habilidades | Inicio de cada conversación |

---

## 📄 Licencia

[MIT](./LICENSE)

---

## 🙏 Agradecimientos

- Basado en la metodología Agile Development, con inspiración del formato de habilidades [Superpowers](https://github.com/anthropics/superpowers)
- Inspirado por prácticas maduras de ingeniería de software
