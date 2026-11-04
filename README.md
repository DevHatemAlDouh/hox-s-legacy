<div align="center">

# ⚔️ Hox's Legacy

**A 2D action-adventure game built with Godot and GDScript**

[![Engine](https://img.shields.io/badge/Engine-Godot%204.4-478CBF?style=flat-square&logo=godot-engine)](https://godotengine.org/)
[![Language](https://img.shields.io/badge/Language-GDScript-355570?style=flat-square&logo=godot-engine)](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/)
[![Genre](https://img.shields.io/badge/Genre-2D%20Action%20Adventure-FF4081?style=flat-square)](#)

---

</div>

## 📖 Overview

**Hox's Legacy** is a work-in-progress 2D action-adventure game. Explore a pixel-art world, face enemies, and use spells as you progress through the current level.

## ✨ Current Features

- **🕹️ Platforming:** Horizontal movement and variable-height jumping.
- **⚔️ Enemy Encounters:** Enemies patrol, detect the player, and chase when nearby.
- **🎯 Targeting:** Target enemies in range during combat.
- **✨ Spell Collection:** Pick up spells and view collected spells in the spell menu.
- **❤️ Health & Items:** Health tracking and a usable flask.
- **🌒 Pixel-Art World:** Hand-authored 2D environments, animated characters, and lighting.

> This project is actively being developed; features and controls may change.

## 🛠️ Tech Stack

| Layer / Tool    | Technology        |
| :-------------- | :---------------- |
| **Game Engine** | Godot 4.4         |
| **Language**    | GDScript          |
| **Game Type**   | 2D                |
| **Rendering**   | Godot 2D renderer |

## 📂 Project Structure

```text
.
├── Assists/       # Environment art, audio, and other visual assets
├── Components/    # Shared health, hitbox, hurtbox, and targeting components
├── Enemies/       # Enemy scenes, scripts, and assets
├── Engien/        # Gameplay systems, spells, damage, and UI
├── Player/        # Player scene, controller, and assets
├── World/         # Level and world-object scenes
├── project.godot  # Godot project settings and input actions
└── README.md
```

## 🚀 Getting Started

### Prerequisites

- [Godot 4.4](https://godotengine.org/download/)
- Git

### Setup

1. **Clone the repository:**

   ```bash
   git clone https://github.com/DevHatemAlDouh/hox-s-legacy.git
   cd hox-s-legacy
   ```

2. **Import the project:** Open Godot, choose **Import**, and select this repository's `project.godot` file.

3. **Run the game:** Press **F5** to run the configured main scene (`World/level1.tscn`).

## 🎮 Controls

| Action              | Default Input                                      |
| :------------------ | :------------------------------------------------- |
| **Move**            | `A` / `D`                                          |
| **Jump**            | `Space`                                            |
| **Attack**          | Left mouse button                                  |
| **Target enemy**    | Right mouse button                                 |
| **Change target**   | Mouse wheel up / down                              |
| **Open spell menu** | Hold the key assigned to `Spells` in the Input Map |
| **Use flask**       | `R`                                                |

Controls can be reviewed or changed under **Project → Project Settings → Input Map**.

## 🤝 Contributing

Contributions, feedback, and bug reports are welcome. For changes, please open an issue or pull request describing what you changed and how you tested it.

## 👨‍💻 Developer

**Hatem Al-Douh**

- **GitHub:** [@DevHatemAlDouh](https://github.com/DevHatemAlDouh)
- **Repository:** [DevHatemAlDouh/hox-s-legacy](https://github.com/DevHatemAlDouh/hox-s-legacy)

<!-- {use profolio game} -->
