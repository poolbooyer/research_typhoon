#データを読み込み
read_data = []
File.open("data/output/part-r-00000", mode = "rt"){|f|
  read_data = f.read
}
#読み込んだデータを改行コードで配列に格納
read_data=read_data.split("\n")
data=[]
#配列をtab空白単位で分割
read_data.each do |line|
    data.push(line.split("\t"))
end
#各要素の型変換を実施
i=0
data.each do|line|
    data[i][0]=line[0].to_i
    data[i][1]=line[1].to_f
    data[i][2]=line[2].to_i
    i=i+1
end
#データを期間の昇順にソート
data_sort=data.sort{|a, b|a[2] <=> b[2]}
p data_sort