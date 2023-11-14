-- This will compile markdown files using pandoc to pdf
vim.bo.makeprg = [[ pandoc -f markdown -t pdf -V geometry:"top=2cm, bottom=1.5cm, left=2cm, right=2cm" -o %:p:r.pdf % ]]
vim.opt_local.conceallevel = 3
