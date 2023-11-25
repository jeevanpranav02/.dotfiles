 " Reference https://vonheikemen.github.io/devlog/tools/using-netrw-vim-builtin-file-explorer/

"  nnoremap - :Ex<CR>
"  " Set up highlighting for Netrw file explorer
"  highlight NetrwFile ctermfg=green
"  highlight link netrwMarkFile Search
"
"  " Configure Netrw settings
"  let g:netrw_browse_split = 0
"  let g:netrw_banner = 0
"  let g:netrw_winsize = 25
"  let g:netrw_liststyle = 0
"  " let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
"  let g:netrw_localcopydircmd = 'cp -r'
"
"  " Remap navigation keys and define some useful mappings
"  nnoremap <leader><Up> :tabnext<CR>
"  nnoremap <leader><Down> :tabprevious<CR>
"  nnoremap <leader>q :Lex<CR>
"
"  " Define a function for custom Netrw mappings
"  function! NetrwMapping()
"      " Map keys for navigation within Netrw buffer
"      nmap <buffer> H u
"      nmap <buffer> h -^
"      nmap <buffer> l <CR>
"
"      " Map keys for file operations
"      nmap <buffer> . gh
"      nmap <buffer> P <C-w>z
"
"      " Open Netrw explorer in a new tab
"      nmap <buffer> L <CR>:Lexplore<CR>
"      nmap <buffer> <Leader>q :Lexplore<CR>
"
"      " Marking and unmarking files
"      nmap <buffer> <TAB> mf
"      nmap <buffer> <S-TAB> mF
"      nmap <buffer> <Leader><TAB> mu
"
"      " Other custom mappings
"      nmap <buffer> ff %:w<CR>:buffer #<CR>
"      nmap <buffer> fe R
"      nmap <buffer> fc mc
"      nmap <buffer> fC mtmc
"      nmap <buffer> fx mm
"      nmap <buffer> fX mtmm
"      nmap <buffer> f; mx
"
"      " Display marked files
"      nmap <buffer> fl :echo join(netrw#Expose("netrwmarkfilelist"), "\n")<CR>
"
"      " Display target file/directory
"      nmap <buffer> fq :echo 'Target:' . netrw#Expose("netrwmftgt")<CR>
"
"      " Mark current file and quick close Netrw
"      nmap <buffer> fd mtfq
"
"      " Mark bookmarked directories
"      nmap <buffer> bb mb
"      nmap <buffer> bd mB
"      nmap <buffer> bl gb
"
"      " Remove files recursively with confirmation
"      nmap <buffer> FF :call NetrwRemoveRecursive()<CR>
"  endfunction
"
"  " Define a function to handle recursive file removal
"  function! NetrwRemoveRecursive()
"      if &filetype ==# 'netrw'
"          " Map Enter key to confirm recursive removal
"          cnoremap <buffer> <CR> rm -r<CR>
"          normal mu
"          normal mf
"
"          " Attempt to remove files and handle cancellation
"          try
"              normal mx
"          catch
"              echo "Canceled"
"          endtry
"
"          " Unmap Enter key after use
"          cunmap <buffer> <CR>
"      endif
"  endfunction
"
"  " Set up autocmd to apply Netrw custom mappings when filetype is netrw
"  augroup netrw_mapping
"      autocmd!
"      autocmd filetype netrw call NetrwMapping()
"  augroup END
"
 "-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
 "-- vim.keymap.set("n", "-", vim.cmd.Ex)
