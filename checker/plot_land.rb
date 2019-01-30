require 'rexml/document'
#kml出力を行う
def create_kml(data)
    #元のノード(コメント)を生成
    doc = REXML::Document.new
    doc << REXML::XMLDecl.new('1.0', 'UTF-8')

    # ルートノードを作成
    kml = REXML::Element.new('kml')
    kml.add_attribute('xmlns','http://www.opengis.net/kml/2.2')
    doc.add_element(kml)

    #ドキュメントノードを作成
    root=REXML::Element.new('Document')
    # ルートノードの下に子ノードを追加
    data.each do |line|
        #y.push(line[4])
        title=line[4]+"年"+line[5]+"/"+line[6]+" "+line[7]+"時"
        #台風番号を名称に格納
        name = REXML::Element.new('name')
        name.add_text(title)

        #親ノードに名称を追加
        placemark = REXML::Element.new('Placemark')
        placemark.add_element(name)

        #説明を追加
        description = REXML::Element.new('description')
        title="<h1>"+line[4]+"年"+line[5]+"/"+line[6]+" "+line[7]+"時</h1>"
        info="<dl><dt>気圧</dt><dd>"+line[1]+"</dd></dl>"
        text=title+info
        description.add_text(text)
        
        #親ノードに名称を追加
        placemark.add_element(description)

        #スタイル読み込み用タグを追加
        styleurl= REXML::Element.new('styleUrl')
        stylepath="style.kml#"+line[4]
        styleurl.add_text(stylepath)
        placemark.add_element(styleurl)
        #位置情報を格納
        point = REXML::Element.new('Point')
        coordinates = REXML::Element.new('coordinates')
        coordinates.add_text(line[3]+","+line[2]+",0.")
        
        #親ノードに位置情報を追加
        point.add_element(coordinates)
        placemark.add_element(point)
        root.add_element(placemark)
        
        
    end
    #元ノードに追加
    kml.add_element(root)
    #ファイルに出力
    #各年のファイル名を作成
    for num in 0..10 do
        if data[num]!=nil then
            fname="kml/land/"+data[num][4]+".kml"
            File.open(fname, 'w') do |file|
                doc.write(file, indent=2)
            end
        end
    end
    
end
#データの読み込み
def read_data()
    #データを読み込み
    read_data = []
    File.open("data/output/land/part-r-00000", mode = "rt"){|f|
        read_data = f.read
    }
    #読み込んだデータを改行コードで配列に格納
    read_data=read_data.split("\n")
    line_data=[]
    #配列をtab空白単位で分割
    read_data.each do |line|
        line_data.push(line.split("\t"))
    end
    return line_data
end
#データの分割
def divideData(full_data)
    
    #読み込んだ情報を,単位で分割
    split_data=[]
    full_data.each do |line|
        line.each do |cel|
            split_data.push(cel.split(","))
        end
    end
    return split_data
end
def split_by_year(data)
    #年ごとに配列に一時保存
    stack=[]
    for num in 0..10 do
        stack[num]=[]
    end
    #年ごとに振り分け
    data.each do |line|
        if line[4]=="2008" then
            stack[0].push(line)
        elsif line[4]=="2009" then
            stack[1].push(line)
        elsif line[4]=="2010" then
            stack[2].push(line)
        elsif line[4]=="2011" then
            stack[3].push(line)
        elsif line[4]=="2012" then
            stack[4].push(line)
        elsif line[4]=="2013" then
            stack[5].push(line)
        elsif line[4]=="2014" then
            stack[6].push(line)
        elsif line[4]=="2015" then
            stack[7].push(line)
        elsif line[4]=="2016" then
            stack[8].push(line)
        elsif line[4]=="2017" then
            stack[9].push(line)
        elsif line[4]=="2018" then
            stack[10].push(line)
        end
    end
    return stack
end
def dataOutput(data)
    #各データについて出力を実施
    data.each do |block|
        create_kml(block)
    end
end
data=read_data()
data=divideData(data)
data=split_by_year(data)
dataOutput(data)