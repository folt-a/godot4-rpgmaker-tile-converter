# godot4-rpgmaker-tile-converter
 Convert RPGMaker Tileset images to Godot4 tileset and converted images.

RPGツクールのタイルセット画像をGodot4のタイルセット（.tres）と、展開した画像(.png)に変換します。

## 使い方

1. batch_rpgmaker_tile_converter.gd をGodot4プロジェクトのどこかに追加します。

2. RPGツクールのタイルセット画像をGodot4プロジェクトのどこかに追加します。

対応するオートタイルは、ツクールと同じサイズ、同じ形式にする必要があります。
末尾の _A1 の部分で判別しています。

A1タイル タイルセットの名前_A1.png
A2タイル タイルセットの名前_A2.png
A3タイル タイルセットの名前_A3.png
A4タイル タイルセットの名前_A4.png

3. スクリプトエディタでbatch_rpgmaker_tile_converter.gd を開き、
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

4. スクリプトエディタで実行します。

「ファイル」→「実行（Ctrl + Shift + X）」

5. 指定したディレクトリにタイルセットと画像が出力されます。

タイルセットはTerrainが設定されています。

シーンにTileMapを作成し、TileSetを設定すると塗り始めることができます。

下バーの「TileMap」→「地形タブ」にTerrainが表示されています。
Terrainを選択し、パレットの全方向矢印の「コネクタ」を選択して塗るとオートタイルになります。

---

※コリジョン（当たり判定）は設定されていません。

コリジョンを設定する場合は、TileSetのインスペクター設定から「Physics Layers」を追加し、

下バーのTileSetの設定の「ペイント」からコリジョンを塗ることができます。
