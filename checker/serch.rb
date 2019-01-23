s = []
File.open("data/output/part-r-00000", mode = "rt"){|f|
  s = f.read
}
s=s.split("\n")
data=[]
s.each do |line|
    data.push(line.split("\t"))
end
i=0
j=0
data.each do|line|
    line.each do|cel|
        data[i][j]=cel.to_i
        j=j+1
    end
    i=i+1
    j=0
end
data_sort=data.sort{|a, b|a[2] <=> b[2]}
p data_sort