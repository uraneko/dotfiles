### Contents
- hyprland configs
- neovim configs
- fish shell hand made prompt
- wired config file
- tofi config file
- tmux config file
- alacritty config file 
- kmonad config file 

> [!NOTE]
> Some of the scripts/configs are messy or have inefficient logic, I don't feel like fixing them until my next config season comes around, but feel free to open an issue with an enhancement or fix to something, I'll review it and merge it if it makes sense. 

### Alacritty-Themes

first make sure to clone the alacritty-theme repo 

```bash
git clone https://github.com/alacritty/alacritty-theme
```

then you can change your theme like so

```toml
# alacritty.toml
general.import = [
  	"alacritty-theme/themes/<theme_name>.toml"
  ]
```
