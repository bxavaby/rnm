<div align="center">

<img src="assets/rnml.svg" width="320" alt="rnm logo" />

─────────────────

![Linux](https://img.shields.io/badge/Linux-000000?style=for-the-badge&logo=linux&logoColor=D86830)
![Zig](https://img.shields.io/badge/Zig-%23000000.svg?style=for-the-badge&logo=zig&logoColor=D86830)

# _random name maker_

### Generate random names in the command-line with ```rnm```

<br>

<img src="assets/help.png" width="958" alt="rnm help" />

<br>

<div align="left">

## Install

Download the latest binary from [**Releases**](../../releases/latest) and add it to your PATH:

```
chmod +x rnm
sudo mv rnm /usr/local/bin/
```

<br>

<details>
<summary><b>Build from source (alternative)</b></summary>

<br>

```
git clone https://github.com/bxavaby/rnm.git
cd rnm
zig build -Doptimize=ReleaseFast
sudo mv zig-out/bin/rnm /usr/local/bin/
```

</details>

<br>

## Usage

**Flags:**
- `-l` `<3–10>` _defines the length_ 
- `-f` `<char>` _defines the first letter_
- `-v` / `version` _prints the current version_ 
- `-h` / `help` _shows the help message_

> ※ **Note:** `-l` and `-f` are order-independent but cannot be grouped (yet).

<br>

<details>
<summary><b>Examples</b></summary>

<br>

```
$ rnm
favoda
```

```
$ rnm -l 4
pace
```

```
$ rnm -f l -l 4 && rnm -f e -l 5
losa
ezura
```

</details>

</div>

<br>

─────────────────

*First ziguana steps. Decided to make something moderately useful, while keeping it somewhat crude. Hence the logo.*

**[Report Bug](../../issues)** | **[Suggest Feature](../../issues)**

**MIT License © 2025 bxavaby**

</div>
