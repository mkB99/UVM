import sys

for i in range(1,14):
   file1 = open(sys.argv[i],"a")
   file1.write("\n`endif")
   file1.close()


