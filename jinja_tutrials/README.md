# 1. Jinja / jinja2 とは？

Jinja / jinja2 とは Python の web 開発でよく使用されるテンプレートエンジンの一つです。

以下はできることの一例です。
- テンプレートファイルの読み込み
- 文字列の埋め込み
- 分岐・ループの制御分


<br>

# 2. jinja2 をインストールする
- https://jinja.palletsprojects.com/en/3.1.x/

## 手順
1. 必要に応じて仮想環境に入る
2. pip コマンドでインストールする
    `pip install jinja2`


<br>

# 3. jinja / jinja2 を使う

## 3-1. 記法

| 記法 | 意味 |
| ----- | ----- |
| {% ... %} | Statements |
| {{ ... }} | Expressions |
| {# ... #} | Comments |
| # ... ## | Line Statements


- Statements: `{% ... %}` の中に Jinja の様々な処理を書くことができる
    - 変数の定義: `set` を使用する
        - e.g. `text` という変数の中に `aaaa` を代入して表示
            ```
            {% set text='aaaa' %}
            {{ text }}
            ```
    - if 文: `{% if <条件式> %}` で始めて `{% else %}` や `{% elif <条件式> %}` などを経て `{% endif %}` で制御文を閉じる
    - for 文: `{% for <ループ変数> in <シーケンス> %}` で始めて `{% endfor %}` で制御文を閉じる

- Expressions: `{{変数名}}` とすることで文字列を埋め込める
    - e.g. `僕の名前は {{ name }} です。{{ lang }} が好きです。`
    - Python の `"{}".format(hoge)` のイメージ

TODO: 説明を拡充する


## 3-2. 使用方法

テンプレートファイルを用意しなくても使用できる。
以下の例では、`Template(プレースホルダ)` でプレースホルダに対するテンプレートオブジェクトを生成している。
テンプレートオブジェクトの `render(埋め込む内容)` メソッドで埋め込む内容を指定することで、戻り値として入力したデータが埋め込まれたデータが返ってくる。
```
from jinja2 import Template
 
tpl_text = '僕の名前は{{ name }}です！！{{ lang }}が好きです！！'
template = Template(tpl_text)
 
data = {'name': 'Kuro', 'lang': 'Python'}
disp_text = template.render(data) # 辞書で指定する
print(disp_text) # 僕の名前はKuroです！！Pythonが好きです！！
```

ただし、テンプレートファイルを別ファイルから読み込んで使用するのが一般的。
テンプレートファイルの拡張子は `j2` でも `jinja` でも `tmpl` でも `tpl` でも `txt` でも問題ない。
まず、`Environment(loader=FileSystemLoader('テンプレートファイル配置ディレクトリのルート'))` を用いて
その後、テンプレートオブジェクトの `get_template('テンプレートファイル名')` を用いることでファイルからテンプレートオブジェクトを生成する。

e.g. sample.tpl
```
僕の名前は {{ name }} です。{{ lang }} が好きです。

{# if文のsample #}
{% if x > 0 %}
xは0より大きいです
{% elif x == 0 %}
xは0です
{% else %}
xは0より小さいです
{% endif %}

{# for文のsample #}
商品一覧
{% for item in items %}
・　{{ item }}
{% endfor %}
```


# 参考情報一覧
|  情報源  |  備考  |
| :--- | :--- |
| [jinja2 入門 その 1](https://www.python.ambitious-engineer.com/archives/760) | 簡易的に説明されている |
| [Jinja 公式](https://jinja.palletsprojects.com/en/3.1.x/)  |  公式  |
| [Jinjaテンプレートの書き方をがっつり調べてまとめてみた。](https://qiita.com/simonritchie/items/cc2021ac6860e92de25d) | 詳細にまとめられている |