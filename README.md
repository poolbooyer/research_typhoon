# research_typhoon
## このソフトウェアについて
このソフトウェアは分散コンピューティングの解析に用いたプログラムです。
## about
### pigScript/typhoonMove.pig
気象庁から提供されるCSVファイルを読み込み、その中から台風番号と、
最低気圧、最低気圧時の緯度と経度、各台風のデータ数を出力します。
### checker/serch.rb
pigで出力されたデータをもとに各台風の最低気圧時の位置にピンを
表示することのできるkmlファイルを生成します。