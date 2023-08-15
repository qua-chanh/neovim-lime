function! treesitter#indent() abort
	return luaeval(printf('require"treesitter.indent".get(%d)', v:lnum))
endfunction