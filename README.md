<div align="center">
  <h1 style="font-size: 24px; color: blue;">My NixOs 24.05 environment, KDE & Nvidia</h1>
</div>

 #### My NixOS GNOME 24.05 also available !
 ```bash
 https://github.com/tolgaerok/nixos-2405-gnome
 ```
#

![nixos-2405xcf](https://github.com/tolgaerok/nixos-kde-2405/assets/110285959/8b116fed-97b8-4c4a-8fff-84eb33ac25bc)

<table style="border-collapse: collapse; width: 100%;">
  <tr>
    <td style="border: none; width: 30%;" valign="top">
      <div align="center">  
          <img src="https://github.com/tolgaerok/nixos/assets/110285959/fa785dec-f839-43f2-9e03-58adb73d12c3" alt="HP" style="width: 80%;">
          <br>          
        </a>
      </div>
    </td>
    <td style="border: none; width: 70%;">
      <table>
        <tr>
          <th align="left">Device</th>
          <th align="left">Specification</th>
        </tr>
        <tr>
          <td>BLUE-TOOTH</td>
          <td>REALTEK 5G</td>
        </tr>
        <tr>
          <td>CPU</td>
          <td>Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz x 8 (Haswell)</td>
        </tr>
        <tr>
          <td>GPU</td>
          <td>NVIDIA GeForce GT 1030/PCIe/SSE2</td>
        </tr>
        <tr>
          <td>MODEL</td>
          <td>HP EliteDesk 800 G1 SFF</td>
        </tr>
        <tr>
          <td>MOTHERBOARD</td>
          <td>Intel® Q87</td>
        </tr>
        <tr>
          <td>NETWORK</td>
          <td>Intel Corporation Wi-Fi 6 AX210/AX211/AX411 160MHz</td>
        </tr>
        <tr>
          <td>RAM</td>
          <td>28 GB DDR3</td>
        </tr>
        <tr>
          <td>SATA</td>
          <td>SAMSUNG SSD 870 EVO 500GB</td>
        </tr>        
      </table>
    </td>

    
  </tr>
</table>

# Notes:


### Update NIXOS to 24.11 - Latest Version.

```bash
sudo nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixos
sudo nix-channel --update
sudo nixos-rebuild switch --upgrade
```

- Install git and some other programs for KDE 6

- It take some Time.. Just Wait!
```bash
nix-env -iA nixos.git     - 53.18 MiB download, 119.48 MiB unpacked
nix-env -iA nixos.hyfetch - 1.80 MiB download, 14.05 MiB unpacked
nix-shell -p kdePackages.plasma-workspace - 1028.37 MiB download, 2834.11 MiB unpacked
nix-shell -p kdePackages.sddm      - 3.49 MiB download, 5.62 MiB unpacked
nix-shell -p kdePackages.full      - 74.62 MiB download, 232.35 MiB unpacked
nix-env -iA nixos.kdePackages.kwin - 188.33 MiB download, 195.40 MiB unpacked
```
- You can find many programs here for NIX OS
```bash
https://search.nixos.org/packages?channel=unstable
```
