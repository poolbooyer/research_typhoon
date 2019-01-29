# research_typhoon
## このソフトウェアについて
このソフトウェアは分散コンピューティングの解析に用いたプログラムです。
## about
### pigScript/typhoonMove.pig
気象庁から提供されるCSVファイルを読み込み、その中から台風番号と、
最低気圧、最低気圧時の緯度と経度、その時の年日時、各台風のデータ数を出力します。
### pigScript/typhoonland.pig
気象庁から提供されるCSVファイルを読み込み、その中から上陸(もしくは上陸直前)時の台風番号と、気圧、位置情報と日時情報を出力します。
### checker/serch.rb
typhoonMove.pigで出力されたデータをもとに各台風の最低気圧時の位置にピンを
表示することのできるkmlファイルを生成します。
### checker/plot_land.rb
tyhoonland.pigで出力されたデータをもとに上陸地点にピンを表示することのできるkmlファイルを生成します。
### style.kml
rubyで出力されたkmlファイル表示時にpinが同じにならないよう、
各年でピンを変更するよう記述してあります。