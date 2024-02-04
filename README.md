# godot4-rpgmaker-tile-converter
 Convert RPGMaker Tileset images to Godot4 tileset and converted images.

RPGツクールのタイルセット画像をGodot4のタイルセット（.tres）と、展開した画像(.png)に変換します。

## 使い方

### batch_rpgmaker_tile_converter.gd をGodot4プロジェクトのどこかに追加します。

### RPGツクールのタイルセット画像をGodot4プロジェクトのどこかに追加します。

対応するオートタイルは、ツクールと同じサイズ、同じ形式にする必要があります。
末尾の _A1 の部分で判別しています。

A1タイル タイルセットの名前_A1.png
A2タイル タイルセットの名前_A2.png
A3タイル タイルセットの名前_A3.png
A4タイル タイルセットの名前_A4.png

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
