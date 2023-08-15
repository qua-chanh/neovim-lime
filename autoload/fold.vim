function! nvim_treesitter#fold() abort
	return luaeval(printf('require"treesitter.fold".get(%d)', v:lnum))
endfunction