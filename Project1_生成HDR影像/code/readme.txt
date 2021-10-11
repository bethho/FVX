[Eij, rgb] = demo(s)

input:
s = 檔案路徑(包含檔案名稱重複的部分) (ex:'img_data/leaf/P123080#.JPG)
output:
Eij = radiance map
rgb = tonemapping後的HDR影像

執行此function時同時會愛該目錄底下儲存radiance map(ex:hdr_result.hdr)和Ttonemapping後的影像(ex:hdr.png)

在test.m有demo.m的範例程式
