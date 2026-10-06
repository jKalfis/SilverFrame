# SilverFrame

A lightweight World of Warcraft (1.12.0 / Vanilla / OctoWoW) addon that customizes your player frame with Rare or Elite dragon textures.

## Features

- **Custom Dragon Textures:** Choose between Winged Silver Dragon, Simple Silver Dragon, or Gold Dragon.
- **Saved Preference:** Automatically saves your frame selection across game sessions.
- **Zero Overhead:** Extremely simple and lightweight performance footprint.

## Slash Commands

You can use `/sf` or `/silverframe` followed by a parameter to change your frame texture in real time.

| Command | Aliases | Effect |
| :--- | :--- | :--- |
| `/sf 1` | `/sf rare`, `/sf rare-elite` | Applies the **Winged Silver Dragon** texture (*Rare Elite*). |
| `/sf 2` | `/sf rare2`, `/sf raresimple` | Applies the **Simple Silver Dragon** texture (*Rare*). |
| `/sf 3` | `/sf elite`, `/sf gold` | Applies the **Gold Dragon** texture (*Elite*). |
| `/sf normal` | `/sf reset`, `/sf 0` | Restores the default Blizzard player frame. |
| `/sf` | *(none)* | Displays the help menu with all available options in the chat. |

### Technical Overview

* **Texture Manipulation:** When a slash command is executed, the script updates `PlayerFrameTexture` and flips the texture coordinates horizontally (`SetTexCoord(1, 0, 0, 1)`) so the dragon aligns with the player portrait layout.
* **Persistent Settings:** Your selected frame is stored in `SilverFrameDB`. It automatically re-applies upon loading screens, zone transfers, UI reloads (`/reload`), or full game restarts.
