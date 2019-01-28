require 'rexml/document'
#kml出力を行う
def create_kml(data,documents)
    #元のノード(コメント)を生成
    doc = REXML::Document.new
    doc << REXML::XMLDecl.new('1.0', 'UTF-8')

    # ルートノードを作成
    kml = REXML::Element.new('kml')
    kml.add_attribute('xmlns','http://www.opengis.net/kml/2.2')
    doc.add_element(kml)
    
    # ルートノードの下に子ノードを追加
    data.each do |line|
        #台風番号を名称に格納
        name = REXML::Element.new('name')
        name.add_text(line[0].to_s)

        #親ノードに名称を追加
        placemark = REXML::Element.new('Placemark')
        placemark.add_element(name)

        #説明を追加
        description = REXML::Element.new('description')
        title="<h1>"+line[5].to_s+"年"+line[0].to_s[-2..-1]+"号</h1>"
        date="<dl><dt>date</dt><dd>"+line[5].to_s+"/"+line[6].to_s+"/"+line[7].to_s+" "+line[8].to_s+"時</dd></dl>"
        info="<dl><dt>気圧</dt><dd>"+line[1].to_s+"</dd><dt>データ数</dt><dd>"+line[4].to_s+"</dd></dl>"
        text=title+date+info
        description.add_text(text)
        
        #親ノードに名称を追加
        placemark.add_element(description)

        #スタイル読み込み用タグを追加
        styleurl= REXML::Element.new('styleUrl')
        stylepath="style.kml#"+line[5].to_s
        styleurl.add_text(stylepath)
        placemark.add_element(styleurl)
        #位置情報を格納
        point = REXML::Element.new('Point')
        coordinates = REXML::Element.new('coordinates')
        coordinates.add_text(line[3].to_s+","+line[2].to_s+",0.")
        
        #親ノードに位置情報を追加
        point.add_element(coordinates)
        placemark.add_element(point)
        documents.add_element(placemark)
    end
    #元ノードに追加
    kml.add_element(documents)
    #ファイルに出力
    #各年のファイル名を作成
    fname="kml/"+data[0][5].to_s+".kml"
    File.open(fname, 'w') do |file|
        doc.write(file, indent=2)
    end
end
#データの読み込み
def read_data()
    #データを読み込み
    read_data = []
    File.open("data/output/part-r-00000", mode = "rt"){|f|
        read_data = f.read
    }
    #読み込んだデータを改行コードで配列に格納
    read_data=read_data.split("\n")
    return read_data
end
#データの分割
def divideData(read_data)
    line_data=[]
    #配列をtab空白単位で分割
    read_data.each do |line|
        line_data.push(line.split("\t"))
    end
    #読み込んだ情報を,単位で分割
    split_data=[]
    line_data.each do |line|
        line.each do |cel|
            split_data.push(cel.split(","))
        end
    end
    return split_data
end
#各要素の型変換を実施
def exchange(data)
    i=0
    data.each do|line|
        data[i][0]=line[0].to_i
        data[i][1]=line[1].to_f
        data[i][2]=line[2].to_f
        data[i][3]=line[3].to_f
        data[i][4]=line[4].to_i
        data[i][5]=line[5].to_i
        data[i][6]=line[6].to_i
        data[i][7]=line[7].to_i
        data[i][8]=line[8].to_i
        i=i+1
    end
    return data
end
def split_by_year(data)
    #年ごとに配列に一時保存
    stack=[]
    for num in 0..10 do
        stack[num]=[]
    end
    #年ごとに振り分け
    data.each do |line|
        if line[5]==2008 then
            stack[0].push(line)
        elsif line[5]==2009 then
            stack[1].push(line)
        elsif line[5]==2010 then
            stack[2].push(line)
        elsif line[5]==2011 then
            stack[3].push(line)
        elsif line[5]==2012 then
            stack[4].push(line)
        elsif line[5]==2013 then
            stack[5].push(line)
        elsif line[5]==2014 then
            stack[6].push(line)
        elsif line[5]==2015 then
            stack[7].push(line)
        elsif line[5]==2016 then
            stack[8].push(line)
        elsif line[5]==2017 then
            stack[9].push(line)
        elsif line[5]==2018 then
            stack[10].push(line)
        end
    end
    return stack
end
data=read_data()
data=divideData(data)
data=exchange(data)
data=split_by_year(data)
#各データについて出力を実施
data.each do |block|
    Documents=""
    Documents = REXML::Element.new('Document')
    create_kml(block,Documents)
end