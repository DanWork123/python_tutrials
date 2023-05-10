# 1. Poetry とは？

Poetry とは Python のパッケージマネージャの一つです。
他の言語で言うところの、`npm` や `yarn` や `cargo` などと同じです。

以下はできることの一例です。
- pip と同じようにパッケージを PyPI などからダウンロードしてきてインストールする
- パッケージ管理ファイルの生成・変更
- プロジェクトごとの仮想環境のセットアップ


<br>

# 2. Poetry をインストールする
- https://python-poetry.org/docs/#installing-with-the-official-installer
    - `get-poetry.py` を使ったインストールは終了したとの旨が記載されているため、多くの記事で使われている方法と以下はやや異なることに注意

## 手順
1. Poetry をインストールする
    - 以下の方法でインストールする場合を記載している
        - 1-1. 最新版をインストール先を指定しないでインストールする場合
        - 1-2. 最新版をインストール先を指定してインストールする場合
        - 1-3. 過去バージョンをインストールする場合
2. Poetry のパスを通す
    - インストール後に以下のような文言が表示されているはず（一例）
        ```
        To get started you need Poetry's bin directory (C:\Users\<ユーザー名>\AppData\Roaming\Python\Scripts) in your `PATH` environment variable.
        ```
3. インストールを確認する

  
### 1. Poetry をインストールする
#### 1-1. 最新版をインストール先を指定しないでインストールする場合
デフォルトで Poetry は以下にインストールされる。
- MacOS: `~/Library/Application Support/pypoetry`
- Linux/Unix: `~/.local/share/pypoetry`
- Windows: `%APPDATA%\pypoetry`
    - `%APPDATA%` は `C:\Users\<ユーザー名>\AppData\Roaming` などに設定されている（環境変数を確認）
    - `poetry.exe` 自体は `%APPDATA%\Python\Scripts\poetry.exe` に作成された

インストール方法は以下
- MacOS / Linux / Windows (WSL)
    ```
    curl -sSL https://install.python-poetry.org | python3 -
    ```

- Windows (PowerShell)
    ```
    (Invoke-WebRequest -Uri https://install.python-poetry.org -UseBasicParsing).Content | py -
    ```


#### 1-2. 最新版をインストール先を指定してインストールする場合
`$POETRY_HOME` という環境変数を定義してインストールする。
```
curl -sSL https://install.python-poetry.org | POETRY_HOME=<任意の箇所 e.g. /etc/poetry> python3 -
```


#### 1-3. 過去バージョンをインストールする場合

TODO: これは後回し


### 2. Poetry のパスを通す
環境変数 `$PATH` に以下のディレクトリが登録されているかを確認する。
- UNIX: `$HOME/.local/bin`
- Windows: `%APPDATA%\Python\Scripts`
- `$POETRY_HOME` という環境変数が設定されている場合は、`$POETRY_HOME/bin`

登録されていない場合は `$PATH` に登録する。



<br>

# 3. Poetry を使う

## 手順
0. Poetry のインストール
1. Python のセットアップ
2. Poetry プロジェクトのセットアップ
3. 仮想環境のセットアップ
4. 依存パッケージの追加・更新
5. 仮想環境で実行

## 0. Poetry のインストール
`2. Poetry をインストールする` を実施する。
この時、Python はすでにインストールされている前提。

## 1. Python のセットアップ
特定のバージョンの Python を使用したい場合は、`pyenv` を使ってインストールしておく。
`pyenv` のインストール方法は以下を参照（pyenv-virtualenvは不要）。
- https://qiita.com/ksato9700/items/5d9eba10fe6b8e064178#%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB
```
# インストールされているバージョンを確認
pyenv versions 

# インストール可能なバージョンを表示
pyenv install --list

# 指定したバージョンをインストール
pyenv install <python-version>

# グローバルなデフォルトを指定したバージョンに変更
pyenv global <python-version>
```

## 2. Poetry プロジェクトのセットアップ
「新規に立ち上げる場合」と「既にあるプロジェクトを Poetry 管理下に置く場合」の二通りの方法ある。

### 2-1. 新規に立ち上げる場合
```
poetry new <プロジェクトの名前>
```

上記を実行すると、以下のような構成のフォルダが生成される。

```
<プロジェクトの名前>
├── README.rst
├── <プロジェクトの名前>
│   └── __init__.py
├── pyproject.toml
└── tests
    ├── __init__.py
    └── test_<プロジェクトの名前>.py
```

- **README.rst** <br>
そのプロジェクトの概要を記述するファイル。
デフォルトでは中身は空で、`.rst` は [reStructedText](https://docutils.sourceforge.io/rst.html) というマークアップ言語で書かれることを期待している拡張子。
`Markdown` が良ければ `README.md` などに変えてしまっても問題ない。

- **<プロジェクトの名前>/** <br>
このパッケージの Python ソースコードを格納するディレクトリ。
`__init__.py` は、デフォルトでは中でバージョンの定義だけがされている。

- **pyproject.toml** <br>
Poetry プロジェクトに関するメタデータや依存関係を記述するためのファイル。
[TOML](https://toml.io/en/) という形式で書かれている。

- **tests/** <br>
ユニットテストを格納するディレクトリ。
`test_<プロジェクトの名前>.py` にはバージョン番号を確認する簡単なテストが書かれている。


### 2-2. 既にあるプロジェクトを Poetry 管理下に置く場合

TODO: ここは後回し


## 3. 仮想環境のセットアップ
作成したプロジェクトのディレクトリに移動する。
以下のコマンドを用いて、作成したプロジェクト用の仮想環境を立ち上げる。
```
poetry install
```

TODO: 依存関係が不要な場合を書く


## 4. 依存パッケージの追加・更新
### パッケージの追加
`poetry new` した場合や `poetry init` で依存関係の追加をスキップした場合は、必要なパッケージを追加する必要がある。
パッケージをプロジェクトに追加する場合は以下のコマンドを実行する。
pip 同様に指定したパッケージだけでなく、それが依存しているパッケージも併せてインストールしてくれ、`pyproject.toml` にインストールしたパッケージをバージョンとともに追加してくれる。
```
poetry add <パッケージ名>
```

### パッケージの更新
既にインストールされているパッケージのうち、アップグレードが可能なパッケージを確認する場合は以下のコマンドを実行する。
```
poetry update --dry-run
```

アップグレードをする場合は以下のコマンドを実行する。
```
poetry update
```

この際、アップグレードされるのは `poetry.lock` だけで `pyproject.toml` はそのままなので、新しいバージョンの新機能を使う場合などは `pyproject.toml` を手動で修正して依存するバージョンを変える必要がある。
`poetry.lock` は Poetry が自動生成するファイルの一つで、現在仮想環境にインストールされているパッケージのリストとそのバージョンが記載されている。
`poetry install` は `poetry.lock` を先に見に行くため、`poetry.lock` が現在の開発で使われているパッケージのバージョンであるという運用をする。



## 5. 仮想環境で実行
### 一瞬仮想環境に入って Python プログラムを実行する（その後仮想環境を出て終わる）
```
poetry run python <Python ファイル>
```

### 仮想環境に入ってから Python プログラムを実行する（そのまま仮想環境に残る）
```
poetry shell
python <Python ファイル>
```

依存関係で追加したパッケージに含まれる Python ファイル以外を実行することもできる。
以下は一例。
```
poetry run pytest
```


# 参考情報一覧
|  情報源  |  備考  |
| :--- | :--- |
|  [Poetry をサクッと使い始めてみる](https://qiita.com/ksato9700/items/b893cf1db83605898d8a)  |  包括的に説明されている（メインの参考情報）  |
|    |    |