require 'rexml/document'
#kml出力を行う
def create_kml(data,num,documents)
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
        description.add_text(line[1].to_s+","+line[4].to_s+","+line[2].to_s+","+line[3].to_s)
        
        #親ノードに名称を追加
        placemark.add_element(description)

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
    fname=num.to_s+"data.kml"
    File.open(fname, 'w') do |file|
        doc.write(file, indent=2)
    end
end


#データを読み込み
read_data = []
File.open("data/output/part-r-00000", mode = "rt"){|f|
  read_data = f.read
}
#読み込んだデータを改行コードで配列に格納
read_data=read_data.split("\n")
line_data=[]
#配列をtab空白単位で分割
read_data.each do |line|
    line_data.push(line.split("\t"))
end
#読み込んだ情報を,単位で分割
data=[]
line_data.each do |line|
    line.each do |cel|
        data.push(cel.split(","))
    end
end
#各要素の型変換を実施
i=0
data_count=0
data.each do|line|
    data[i][0]=line[0].to_i
    data[i][1]=line[1].to_f
    data[i][2]=line[2].to_f
    data[i][3]=line[3].to_f
    data[i][4]=line[4].to_i
    i=i+1
end
#配列を50単位で分割
data=data.each_slice(50).to_a
i=0
#各データについて出力を実施
data.each do |block|
    Documents = REXML::Element.new('Document')
    create_kml(block,i,Documents)
    i=i+1
end

