fd = DetectFreezing();

for i = 1:size(GyZ)
   fd.Zscroll(GyZ(i))
   fd.Xscroll(AcX(i))
   if(fd.isFreezing == true)
       sprintf('Freezing detected!')
       fd.freezeTime
       break
   end
end
if(fd.isFreezing == false)
sprintf('No freezing detected.')
end