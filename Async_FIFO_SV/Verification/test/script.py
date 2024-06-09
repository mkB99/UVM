import sys

#   with open(i,'w') as fd:
#      fd.append("\n`endif")

for i in range(1,11):
   file1 = open(sys.argv[i],"a")
   file1.write("\n`endif")
   file1.close()


