# Poetry 概要

## Poetry とは

- [Poetry][1] とは Python のパッケージや依存関係のマネジメントツール
    - 他の言語で言うところの、`npm` や `yarn` や `cargo` などと同じ
- `pip` と同じようにパッケージを [PyPI][2] などからダウンロードしてきてインストールできる
- パッケージ管理ファイルの生成・変更が可能
- プロジェクトごとの仮想環境をセットアップすることができる

## 導入方法（Windows）
1. PowerShell で以下のコマンドを入力し、`poetry` をインストールする
    ```pwsh
    (Invoke-WebRequest -Uri https://install.python-poetry.org -UseBasicParsing).Content | py -
    ```
    - `get-poetry.py` を使ったインストールは終了したとの旨が記載されているため、多くの記事で使われている方法と以下はやや異なることに注意
    - インストール後に以下のような文言が表示されているはず（一例）
        ```
        To get started you need Poetry's bin directory (C:\Users\<ユーザー名>\AppData\Roaming\Python\Scripts) in your `PATH` environment variable.
        ```
        - もし、以下のようなエラーが出た場合、PowerShell のスクリプトの実行が[実行ポリシー][3]によって許可されていないことが原因
            ```pwsh
            CategoruInfo : セキュリティエラー: (: ) []、PSSecurityException
            FullyQualifiedErrorId : UnauthorizedAccess
            ```
        - PowerShell に以下のように入力して、実行ポリシーを確認することができる
            ```pwsh
            Get-ExecutionPolicy
            ```
        - 実行ポリシーが `Restricted` である場合、実行スクリプトの先頭に `PowerShell -ExecutionPolicy RemoteSigned` を付けて、一時的にポリシーを変更して実行する
            ```pwsh
            PowerShell -ExecutionPolicy RemoteSigned -Command "(Invoke-WebRequest -Uri https://install.python-poetry.org -UseBasicParsing).Content | py -"
            ```

2. ユーザー環境変数に `poetry` のパスを設定する
    ```pwsh
    [System.Environment]::SetEnvironmentVariable('path', $env:APPDATA + "\Python\Scripts;" + [System.Environment]::GetEnvironmentVariable('path', "User"),"User")
    ```
    - `poetry.exe` 自体は `%APPDATA%\Python\Scripts\poetry.exe` に作成されている

3. PowerShell を一度閉じ、再度開きなおす

4. `poetry --version` を入力し、バージョンの情報が表示されればインストールが完了している

5. `poetry` を最新バージョンにアップデートするためには、通常 `poetry self update` を入力すれば良いが、Windows の場合はセルフアップデートに問題がある場合があるため、再インストールが推奨されている
    - 一応 `poetry self update` 自体は通る

## 削除方法（Windows）
- PowerShell を開いて以下のコマンドを入力する
    ```pwsh
    (Invoke-WebRequest -Uri https://install.python-poetry.org -UseBasicParsing).Content | python - --uninstall
    ```
    - `%APPDATA%\Python\Script` の環境変数は残っているので、不要であれば削除する


## 使用方法（サンプルプロジェクト）
- 手順 2~5 は、特に Poetry プロジェクトを自分で構築する人向け
- 既存の Poetry プロジェクトを実行すればいいだけの人は、1/6~ を実行すればよい

1. Python をインストールする
    - `pyenv-win` を使用している場合、`pyenv local <python version>` などで現在のプロジェクトに対して特定のバージョンをアクティベートでき、その後で `poetry install` とすると poetry でそのバージョンの Python を使うことができる
        - `pyenv local` は現在のディレクトリに `.python-version` ファイルを作成し、そのディレクトリ内で Python を実行した場合はそのバージョンを使用する


2. Poetry プロジェクトを作成する
    - （新規の場合）任意のフォルダに移動し、下記コマンドでサンプルプロジェクト（名前：`poetry-demo`）を作成する
        ```
        poetry new poetry-demo
        ```
        - カレントディレクトリ以下に `poetry-demo` フォルダが作成される
            ```
            poetry-demo
            ├── pyproject.toml
            ├── README.md
            ├── src
            │   └── poetry_demo
            │       └── __init__.py
            └── tests
                └── __init__.py
            ```
        - `pyproject.toml` ：依存関係を管理するファイル
            - ファイル内にプロジェクト名なども記載されているため、もしプロジェクト名を変更したい場合は、ディレクトリ名だけでなく、このファイルの `[project]` の `name` フィールドや `[tool.poetry]` などの該当箇所も修正し、`poetry install` を実行して依存関係を更新する必要がある
            - [TOML][4] という形式で書かれている

        - `README.md`：そのプロジェクトの概要を記述するファイル
            - Poetry のバージョンによっては、`README.rst` の可能性もあり、これは  [reStructedText][5] というマークアップ言語で書かれることを期待している拡張子

        - `src\<project name>`：このパッケージの Python ソースコードを格納するディレクトリ
            - `__init__.py` は、デフォルトでは中でバージョンの定義だけがされている。

        - `tests`：ユニットテストを格納するディレクトリ
    - （既存の場合）poetry プロジェクト化したいディレクトリに移動し、下記コマンドで `pyproject.toml` を作成する
        ```
        poetry init
        ```

3. Python のバージョンを設定する
    - 必要に応じて `poetry.toml` の `[project]` の `requires-python` フィールドを書き換え、`poetry install` でその変更を反映させる

4. 必要なパッケージを `poetry add <package name>` でプロジェクトに追加する
    - e.g. `poetry add numpy`

5. パッケージのバージョンを指定する
    - `pyproject.toml` の `[project]` の `dependencies` フィールドの該当パッケージを修正し、`poetry install` でその変更を反映させる

6. 仮想環境でプログラムを実行する
    - `poetry run python <your_script>.py` で Python スクリプトを実行すると、プロジェクトで設定した仮想環境でプログラムが走る 
        - 通常 `%USERPROFILE%\AppData\Local\pypoetry\Cache` に仮想環境ができる
    - 仮想環境に最初に入ってから `python <your_script>.py` などとしたい場合は、最初に `poetry env activate` とすれば仮想環境に入ることができる
        - PowerShell の例
            ```pwsh
            Invoke-Expression (poetry env activate)
            ```
            - もし実行エラーになる場合は、以下を試す
                ```pwsh
                PowerShell -ExecutionPolicy RemoteSigned -Command "Invoke-Expression (poetry env activate)"
                ```
        - 以前は `poetry shell` だったが、変わったっぽい

7. パッケージのバージョンを更新する
    - 既にインストールされているパッケージのうち、アップグレードが可能なパッケージを確認する場合は以下のコマンドを実行する
    ```
    poetry update --dry-run
    ```
    - アップグレードをする場合は以下のコマンドを実行する。
    ```
    poetry update
    ```

    - この際、アップグレードされるのは `poetry.lock` だけで `pyproject.toml` はそのままなので、新しいバージョンの新機能を使う場合などは `pyproject.toml` を手動で修正して依存するバージョンを変える必要がある
        - `poetry.lock` は Poetry が自動生成するファイルの一つで、現在仮想環境にインストールされているパッケージのリストとそのバージョンが記載されている
        - `poetry install` は `poetry.lock` を先に見に行くため、`poetry.lock` が現在の開発で使われているパッケージのバージョンであるという運用をする。


[1]:https://python-poetry.org/
[2]:https://pypi.org/
[3]:https://python-poetry.org/docs/#installing-with-the-official-installer
[4]:https://toml.io/en/
[5]:https://docutils.sourceforge.io/rst.html