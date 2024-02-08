# godot4-rpgmaker-tile-converter
 Convert RPGMaker Tileset images to Godot4 tileset and converted images.
english

It's easy, just specify the directory and run it.

This is one editor script that is not an add-on.

---
Japanese

RPGツクールのタイルセット画像をGodot4のタイルセット（.tres）と、展開した画像(.png)に変換します。

ディレクトリを指定して、実行するだけなので楽です。

アドオンではない1つのエディタスクリプトです。

英語の下の方に日本語の説明があります。

---

## How To Use

### Add batch_rpgmaker_tile_converter.gd in your Godot4 project.

### Add the RPGMaker style tileset images in your Godot4 project.

Put the image files in one directory.

The corresponding auto-tile image must be the same size and format as in RPGMaker style.

It is identified by the _A1 part at the end.

RMVX 32px and RMMV RMMZ 48px are supported.

For image sizes and detailed standards, please check with the RPGMaker websites.

- A1 tile tileset name_A1.png
- A2 tile tileset name_A2.png
- A3 tile tileset name_A3.png
- A4 tile tileset name_A4.png

### Open batch_rpgmaker_tile_converter.gd in godot script editor, edit directory path code.

this section.

```gd
## 対象ディレクトリ
const TARGET_DIR = "res://sprite/"
## 出力先ディレクトリ
## 画像出力先ディレクトリ
const OUTPUT_SPRITE_DIR = "res://output_sprite/"
## タイルセット出力先ディレクトリ
const OUTPUT_TILESET_DIR = "res://tileset/"
```

### Run the script in godot script editor.

File -> Run (Ctrl + Shift + X)

### Tileset and images are output to the specified directory.

The tileset is set to Terrains and TerrainSets.

Create a TileMap in the scene and set TileSet to start tile painting.

Terrain is displayed in the "TileMap" -> "Terrain Tab" on godot bottom bar.

Select Terrain, then select "Connector" with the all-arrows in all directions on the palette to paint it, and it will auto-tile.

![image](https://github.com/folt-a/godot4-rpgmaker-tile-converter/assets/32963227/e2faa23c-8d66-47fd-b76f-290e3e3694f9)

*Collision (hit detection) is not set.*

To set collision, add "Physics Layers" from TileSet inspector settings,

Collision can be painted from "Paint" in the TileSet settings on the bottom bar.

! [image](https://github.com/folt-a/godot4-rpgmaker-tile-converter/assets/32963227/a28d585b-5add-49b4-af22-99a44383961d)

! [image](https://github.com/folt-a/godot4-rpgmaker-tile-converter/assets/32963227/26d6cdff-594c-4e99-921a-0b5c0462cf5c)

---

## 使い方

### batch_rpgmaker_tile_converter.gd をGodot4プロジェクトのどこかに追加します。

### RPGツクールのタイルセット画像をGodot4プロジェクトのどこかに追加します。

対応するオートタイル画像は、ツクールと同じサイズ、同じ形式にする必要があります。
末尾の _A1 の部分で判別しています。

VXの32pxとMV・MZの48pxに対応しています。

画像サイズやくわしい規格はツクールのものを調べてください。

- A1タイル タイルセットの名前_A1.png
- A2タイル タイルセットの名前_A2.png
- A3タイル タイルセットの名前_A3.png
- A4タイル タイルセットの名前_A4.png

### スクリプトエディタでbatch_rpgmaker_tile_converter.gd を開き、
ディレクトリのパスを設定します。

この部分を編集します。

```gd
## 対象ディレクトリ
const TARGET_DIR = "res://sprite/"
## 出力先ディレクトリ
## 画像出力先ディレクトリ
const OUTPUT_SPRITE_DIR = "res://output_sprite/"
## タイルセット出力先ディレクトリ
const OUTPUT_TILESET_DIR = "res://tileset/"
```

### スクリプトエディタで実行します。

「ファイル」→「実行（Ctrl + Shift + X）」

### 指定したディレクトリにタイルセットと画像が出力されます。

タイルセットはTerrainが設定されています。

シーンにTileMapを作成し、TileSetを設定すると塗り始めることができます。

下バーの「TileMap」→「地形タブ」にTerrainが表示されています。
Terrainを選択し、パレットの全方向矢印の「コネクタ」を選択して塗るとオートタイルになります。

![image](https://github.com/folt-a/godot4-rpgmaker-tile-converter/assets/32963227/e2faa23c-8d66-47fd-b76f-290e3e3694f9)

---

※コリジョン（当たり判定）は設定されていません。

コリジョンを設定する場合は、TileSetのインスペクター設定から「Physics Layers」を追加し、

下バーのTileSetの設定の「ペイント」からコリジョンを塗ることができます。

![image](https://github.com/folt-a/godot4-rpgmaker-tile-converter/assets/32963227/a28d585b-5add-49b4-af22-99a44383961d)

![image](https://github.com/folt-a/godot4-rpgmaker-tile-converter/assets/32963227/26d6cdff-594c-4e99-921a-0b5c0462cf5c)

他にもTileSetにはいろいろ設定があります。
