# pyenv 概要

## pyenv とは

- [pyenv][1] は Python の複数バージョンを管理するためのツール
- `pyenv` は Windows でサポートされていないため、通常の方法ではインストールできない
- Windows Subsystem for Linux を使えば入れることはできますが、Windows 用にポーティングされた [pyenv-win][2] を使用してインストールするのが最も簡単

## 導入方法（Windows）
1. PowerShell で以下のコマンドを入力し、`pyenv-win` をインストールする

    ```pwsh
    Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/pyenv-win/pyenv-win/master/pyenv-win/install-pyenv-win.ps1" -OutFile "./install-pyenv-win.ps1"; &"./install-pyenv-win.ps1"
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
        PowerShell -ExecutionPolicy RemoteSigned -Command "Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/pyenv-win/pyenv-win/master/pyenv-win/install-pyenv-win.ps1" -OutFile "./install-pyenv-win.ps1"; &"./install-pyenv-win.ps1""  
        ```
    - このコマンドを実行した後に、カレントディレクトリに `install-pyenv-win.ps1` というインストーラーが保存されている
2. `pyenv-win` 関連のユーザー環境変数を設定する
    ```pwsh
    [System.Environment]::SetEnvironmentVariable('PYENV',$env:USERPROFILE + "\.pyenv\pyenv-win\","User")
    ```
    ```pwsh
    [System.Environment]::SetEnvironmentVariable('PYENV_ROOT',$env:USERPROFILE + "\.pyenv\pyenv-win\","User")
    ```
    ```pwsh
    [System.Environment]::SetEnvironmentVariable('PYENV_HOME',$env:USERPROFILE + "\.pyenv\pyenv-win\","User")
    ```
    ```pwsh
    [System.Environment]::SetEnvironmentVariable('path', $env:USERPROFILE + "\.pyenv\pyenv-win\bin;" + $env:USERPROFILE + "\.pyenv\pyenv-win\shims;" + [System.Environment]::GetEnvironmentVariable('path', "User"),"User")
    ```
3. PowerShell を一度閉じ、再度開きなおす
4. `pyenv --version` を入力し、バージョンの情報が表示されればインストールが完了している
    - 実行エラーが出る場合は`手順 1`を参照する
        ```pwsh
        PowerShell -ExecutionPolicy RemoteSigned pyenv --version
        ```
5. そのままだと最新の `pyenv` になっていないことがあるので、念のため `pyenv update` を行う
    - 実行エラーが出る場合は`手順 1`を参照する
        ```pwsh
        PowerShell -ExecutionPolicy RemoteSigned pyenv update
        ```
6. `pyenv install -l` で `pyenv-win` がサポートしている Python のバージョン一覧を確認する
    - 実行エラーが出る場合は`手順 1`を参照する
        ```pwsh
        PowerShell -ExecutionPolicy RemoteSigned pyenv install -l
        ```
7. `pyenv install <version>` でサポートしているバージョンの中から、任意のバージョンをインストールする
    - 実行エラーが出る場合は`手順 1`を参照する
        ```pwsh
        PowerShell -ExecutionPolicy RemoteSigned pyenv install <version>
        ```
8. `pyenv global <version>` でインストールした任意の Python のバージョンをグローバルなバージョンとして設定する
    - 実行エラーが出る場合は`手順 1`を参照する
        ```pwsh
        PowerShell -ExecutionPolicy RemoteSigned pyenv global <version>
        ```
9. `python --version` と入力して、上記の Python のバージョンが使われていることを確認する
    - もしローカルで入っている Python のバージョンが表示されている場合は、ローカルで入っている Python を優先して使用している可能性がある
    - `where.exe python` で Python コマンドの候補を確認し、`pyenv` 関連のパスが一番上にきているか確認する
    - もし `pyenv` の優先順位が低い場合、システム環境変数に Python コマンドに関連する環境変数が設定されている影響である可能性が高い
        - Path環境変数では、内部的にはユーザーがシステムにサインインすると、内部的にはシステム環境変数とユーザー環境変数が、[システム環境変数Pathの後ろにユーザー環境変数Pathの内容が追加される][4]ため、システム環境変数の Python が上位にきてしまう
        - PowerShell に `$env:Path -split ";"` と入れてその順番を確認することができる 
    - 以下のいずれかの対処法を試す
        - Python のバージョンは `pyenv` で管理すると決めて、システム環境変数の Path環境変数に存在する Python のパスを消す
        - システム環境変数の Path環境変数で、ローカルの Python のパスよりも上位に `pyenv` のパスを設定する


## 削除方法（Windows）

1. [公式手順][5] に記載している `pip install --upgrade pyenv-win`で `pyenv-win` を最新版にする
    - インストーラーを使ってインストールする手順だったが、`pip` を使ってアンインストールしたいからこの手順を踏んでいるのだと理解している
    - c.f. インストーラーでの更新方法は PowerShell 上で `install-pyenv-win.ps1` を実行する
        - 
        ```pwsh
        PowerShell -ExecutionPolicy RemoteSigned install-pyenv-win.ps1
        ```
        - 公式では `&"${env:PYENV_HOME}\install-pyenv-win.ps1"` のコマンドで実行してくれと書いているが、`install-pyenv-win.ps1` はそこに無いのでエラーになるため注意
2. `pip uninstall pyenv-win` を行う
3. 環境変数が消えていない場合は、`%USERPROFILE%\.pyenv\pyenv-win\bin` と `%USERPROFILE%\.pyenv\pyenv-win\shims` を削除する


[1]: https://github.com/pyenv/pyenv
[2]: https://github.com/pyenv-win/pyenv-win
[3]: https://learn.microsoft.com/ja-jp/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7.5
[4]: https://atmarkit.itmedia.co.jp/ait/articles/1805/11/news035.html
[5]: https://github.com/pyenv-win/pyenv-win/blob/master/README.md#how-to-update-pyenv