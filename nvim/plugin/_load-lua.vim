" hack to load lua files in same dir until lua loaded with runtimepath

for f in split(glob(expand('<sfile>:h') . '/*.lua'), '\n')
  exec 'luafile' f
endfor
