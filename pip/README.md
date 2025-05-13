
## Tip

- 仮想環境で `pip` を使おうとすると、確かに `bin/pip` は存在するのに、`bad interpreter: No such file or directory` というエラーが出て使えない
    - `python3 -m pip install` という形で `pip` を使うといけた
    - https://stackoverflow.com/questions/51373063/pip3-bad-interpreter-no-such-file-or-directory
    - さらに、`python -m pip install -U --force-reinstall pip` で `pip` のバージョンをアップグレードした後でもいけた

- `pip install matplotlib` をするときに、`The headers or library files could not be found for zlib, a required dependency when compiling Pillow from source.` と出てインストールができない
    - `python -m pip install -U --force-reinstall pip` で `pip` のバージョンをアップグレードしたらいけた
    - https://github.com/python-pillow/Pillow/issues/4242

- `pip uninstall -r requirements.txt -y` とすると、`requirements.txt` の内容でパッケージをアンインストールする