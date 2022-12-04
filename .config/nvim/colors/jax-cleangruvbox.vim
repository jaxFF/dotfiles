" -----------------------------------------------------------------------------
" File: gruvbox.vim
" Description: Retro groove color scheme for Vim
" Author: morhetz <morhetz@gmail.com>
" Source: https://github.com/gruvbox-community/gruvbox
" -----------------------------------------------------------------------------

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name='jax'

set background=dark

" Global Settings: {{{

if !exists('g:gruvbox_guisp_fallback') || index(['fg', 'bg'], g:gruvbox_guisp_fallback) == -1
  let g:gruvbox_guisp_fallback='NONE'
endif

if !exists('g:gruvbox_contrast_dark')
  let g:gruvbox_contrast_dark='medium'
endif

if !exists('g:gruvbox_contrast_light')
  let g:gruvbox_contrast_light='medium'
endif

" }}}
" Palette: {{{

let s:colors = {}

let s:colors.bg0 = ['#282828', 235] " soft = ['#32302f', 236]    hard = ['#1d2021', 234]
let s:colors.bg1 = ['#3c3836', 237]
let s:colors.bg2 = ['#504945', 239]
let s:colors.bg3 = ['#665c54', 241]
let s:colors.bg4 = ['#7c6f64', 243]

let s:colors.gray = ['#928374', 245] " also 244

let s:colors.fg0 = ['#fbf1c7', 229] " soft = ['#f2e5bc', 228]    hard = ['#f9f5d7', 230]
let s:colors.fg1 = ['#ebdbb2', 223]
let s:colors.fg2 = ['#d5c4a1', 250]
let s:colors.fg3 = ['#bdae93', 248]
let s:colors.fg4 = ['#a89984', 246]

let s:colors.red = ['#ff1b00', 167]
let s:colors.green = ['#b8bb26', 142]
let s:colors.yellow = ['#fabd2f', 214]
let s:colors.blue = ['#83a598', 109]
let s:colors.purple = ['#d3869b', 175]
let s:colors.aqua = ['#8ec07c', 108]
let s:colors.orange = ['#fe8019', 208]

" }}}

let s:bold = 'bold,'
let s:italic = 'italic,'
let s:underline = 'underline,'
let s:undercurl = 'undercurl,'
let s:inverse = 'inverse,'

let s:vim_bg = ['bg', 'bg']
let s:vim_fg = ['fg', 'fg']
let s:none = ['NONE', 'NONE']

let s:italicize_comments = s:italic
if exists('g:gruvbox_italicize_comments')
  if g:gruvbox_italicize_comments == 0
    let s:italicize_comments = ''
  endif
endif

let s:italicize_strings = ''
if exists('g:gruvbox_italicize_strings')
  if g:gruvbox_italicize_strings == 1
    let s:italicize_strings = s:italic
  endif
endif

" }}}
" Highlighting Function: {{{

function! s:HL(group, fg, ...)
  " Arguments: group, guifg, guibg, gui, guisp

  " foreground
  let fg = a:fg

" background
if a:0 >= 1
  let bg = a:1
else
  let bg = s:none
endif

" emphasis
if a:0 >= 2 && strlen(a:2)
  let emstr = a:2
else
  let emstr = 'NONE,'
endif

let histring = [ 'hi', a:group,
      \ 'guifg=' . fg[0], 'ctermfg=' . fg[1],
      \ 'guibg=' . bg[0], 'ctermbg=' . bg[1],
      \ 'gui=' . emstr[:-2], 'cterm=' . emstr[:-2]
      \ ]

" special
if a:0 >= 3
  call add(histring, 'guisp=' . a:3[0])
endif

execute join(histring, ' ')
endfunction

" }}}
" Gruvbox Hi Groups: {{{

" memoize common hi groups
call s:HL('GruvboxFg0', s:colors.fg0)
call s:HL('GruvboxFg1', s:colors.fg1)
call s:HL('GruvboxFg2', s:colors.fg2)
call s:HL('GruvboxFg3', s:colors.fg3)
call s:HL('GruvboxFg4', s:colors.fg4)
call s:HL('GruvboxGray', s:colors.gray)
call s:HL('GruvboxBg0', s:colors.bg0)
call s:HL('GruvboxBg1', s:colors.bg1)
call s:HL('GruvboxBg2', s:colors.bg2)
call s:HL('GruvboxBg3', s:colors.bg3)
call s:HL('GruvboxBg4', s:colors.bg4)

call s:HL('GruvboxRed', s:colors.red)
call s:HL('GruvboxRedBold', s:colors.red, s:none, s:bold)
call s:HL('GruvboxGreen', s:colors.green)
call s:HL('GruvboxGreenBold', s:colors.green, s:none, s:bold)
call s:HL('GruvboxYellow', s:colors.yellow)
call s:HL('GruvboxYellowBold', s:colors.yellow, s:none, s:bold)
call s:HL('GruvboxBlue', s:colors.blue)
call s:HL('GruvboxBlueBold', s:colors.blue, s:none, s:bold)
call s:HL('GruvboxPurple', s:colors.purple)
call s:HL('GruvboxPurpleBold', s:colors.purple, s:none, s:bold)
call s:HL('GruvboxAqua', s:colors.aqua)
call s:HL('GruvboxAquaBold', s:colors.aqua, s:none, s:bold)
call s:HL('GruvboxOrange', s:colors.orange)
call s:HL('GruvboxOrangeBold', s:colors.orange, s:none, s:bold)

call s:HL('GruvboxRedSign', s:colors.red, s:colors.bg1)
call s:HL('GruvboxGreenSign', s:colors.green, s:colors.bg1)
call s:HL('GruvboxYellowSign', s:colors.yellow, s:colors.bg1)
call s:HL('GruvboxBlueSign', s:colors.blue, s:colors.bg1)
call s:HL('GruvboxPurpleSign', s:colors.purple, s:colors.bg1)
call s:HL('GruvboxAquaSign', s:colors.aqua, s:colors.bg1)
call s:HL('GruvboxOrangeSign', s:colors.orange, s:colors.bg1)

call s:HL('GruvboxRedUnderline', s:none, s:none, s:undercurl, s:colors.red)
call s:HL('GruvboxGreenUnderline', s:none, s:none, s:undercurl, s:colors.green)
call s:HL('GruvboxYellowUnderline', s:none, s:none, s:undercurl, s:colors.yellow)
call s:HL('GruvboxBlueUnderline', s:none, s:none, s:undercurl, s:colors.blue)
call s:HL('GruvboxPurpleUnderline', s:none, s:none, s:undercurl, s:colors.purple)
call s:HL('GruvboxAquaUnderline', s:none, s:none, s:undercurl, s:colors.aqua)
call s:HL('GruvboxOrangeUnderline', s:none, s:none, s:undercurl, s:colors.orange)

" }}}

" Vanilla colorscheme ---------------------------------------------------------
" General UI: {{{

" Normal text
call s:HL('Normal', s:colors.fg1, s:colors.bg0)

" Screen line that the cursor is
call s:HL('CursorLine',   s:none, s:colors.bg1)

" Tab pages line filler
call s:HL('TabLineFill', s:colors.bg4, s:colors.bg1)
" Active tab page label
call s:HL('TabLineSel', s:colors.green, s:colors.bg1)
" Not active tab page label
hi! link TabLine TabLineFill

" Match paired bracket under the cursor
call s:HL('MatchParen', s:none, s:colors.bg3, s:bold)

" Highlighted screen columns
call s:HL('ColorColumn',  s:none, s:colors.bg1)

" Concealed element: \lambda → λ
call s:HL('Conceal', s:colors.blue, s:none)

" Line number of CursorLine
call s:HL('CursorLineNr', s:colors.yellow, s:colors.bg1)

hi! link NonText GruvboxBg2
hi! link SpecialKey GruvboxFg4

call s:HL('Visual', s:none, s:colors.bg3) ", s:inverse)
hi! link VisualNOS Visual

call s:HL('Search', s:colors.yellow, s:colors.bg0, s:inverse)
call s:HL('IncSearch', s:colors.orange, s:colors.bg0, s:inverse)

call s:HL('QuickFixLine', s:colors.bg0, s:colors.yellow, s:bold)

call s:HL('Underlined', s:colors.blue, s:none, s:underline)

call s:HL('StatusLine',   s:colors.bg2, s:colors.fg1, s:inverse)
call s:HL('StatusLineNC', s:colors.bg1, s:colors.fg4, s:inverse)

" The column separating vertically split windows
call s:HL('VertSplit', s:colors.bg3, s:colors.bg0)

" Current match in wildmenu completion
call s:HL('WildMenu', s:colors.blue, s:colors.bg2, s:bold)

" Directory names, special names in listing
hi! link Directory GruvboxGreenBold

" Titles for output from :set all, :autocmd, etc.
hi! link Title GruvboxGreenBold

" Error messages on the command line
call s:HL('ErrorMsg',   s:colors.bg0, s:colors.red, s:bold)
" More prompt: -- More --
hi! link MoreMsg GruvboxYellowBold
" Current mode message: -- INSERT --
hi! link ModeMsg GruvboxYellowBold
" 'Press enter' prompt and yes/no questions
hi! link Question GruvboxOrangeBold
" Warning messages
hi! link WarningMsg GruvboxRedBold

" }}}
" Gutter: {{{

" Line number for :number and :# commands
call s:HL('LineNr', s:colors.bg4, s:none)

" Column where signs are displayed
call s:HL('SignColumn', s:none, s:colors.bg1)

" Line used for closed folds
call s:HL('Folded', s:colors.gray, s:colors.bg1, s:italic)
" Column where folds are displayed
call s:HL('FoldColumn', s:colors.gray, s:colors.bg1)

" }}}
" Cursor: {{{

" Character under cursor
call s:HL('Cursor', s:none, s:none, s:inverse)
" Visual mode cursor, selection
hi! link vCursor Cursor
" Input moder cursor
hi! link iCursor Cursor
" Language mapping cursor
hi! link lCursor Cursor

" }}}
" Syntax Highlighting: {{{

hi! link Special GruvboxOrange

call s:HL('Comment', s:colors.gray, s:none, s:italicize_comments)
call s:HL('Todo', s:vim_fg, s:none, s:bold . s:italic)
call s:HL('Error', s:colors.red, s:none, s:bold . s:inverse)

" Generic statement
hi! link Statement GruvboxRed
" if, then, else, endif, swicth, etc.
hi! link Conditional GruvboxRed
" for, do, while, etc.
hi! link Repeat GruvboxRed
" case, default, etc.
hi! link Label GruvboxRed
" try, catch, throw
hi! link Exception GruvboxRed
" sizeof, "+", "*", etc.
hi! link Operator GruvboxFg1
" Any other keyword
hi! link Keyword GruvboxRed

" Variable name
hi! link Identifier GruvboxBlue
" Function name
hi! link Function GruvboxGreenBold

" Generic preprocessor
hi! link PreProc GruvboxAqua
" Preprocessor #include
hi! link Include GruvboxAqua
" Preprocessor #define
hi! link Define GruvboxAqua
" Same as Define
hi! link Macro GruvboxAqua
" Preprocessor #if, #else, #endif, etc.
hi! link PreCondit GruvboxAqua

" Generic constant
hi! link Constant GruvboxPurple
" Character constant: 'c', '/n'
hi! link Character GruvboxPurple
" String constant: "this is a string"
call s:HL('String',  s:colors.green, s:none, s:italicize_strings)
" Boolean constant: TRUE, false
hi! link Boolean GruvboxPurple
" Number constant: 234, 0xff
hi! link Number GruvboxPurple
" Floating point constant: 2.3e10
hi! link Float GruvboxPurple

" Generic type
hi! link Type GruvboxYellow
" static, register, volatile, etc
hi! link StorageClass GruvboxOrange
" struct, union, enum, etc.
hi! link Structure GruvboxAqua
" typedef
hi! link Typedef GruvboxYellow

" }}}
" Completion Menu: {{{

if version >= 700
  " Popup menu: normal item
  call s:HL('Pmenu', s:colors.fg1, s:colors.bg2)
  " Popup menu: selected item
  call s:HL('PmenuSel', s:colors.bg2, s:colors.blue, s:bold)
  " Popup menu: scrollbar
  call s:HL('PmenuSbar', s:none, s:colors.bg2)
  " Popup menu: scrollbar thumb
  call s:HL('PmenuThumb', s:none, s:colors.bg4)
endif

" }}}
" Diffs: {{{

call s:HL('DiffDelete', s:colors.red, s:colors.bg0, s:inverse)
call s:HL('DiffAdd',    s:colors.green, s:colors.bg0, s:inverse)
"call s:HL('DiffChange', s:colors.bg0, s:colors.blue)
"call s:HL('DiffText',   s:colors.bg0, s:colors.yellow)

" Alternative setting
call s:HL('DiffChange', s:colors.aqua, s:colors.bg0, s:inverse)
call s:HL('DiffText',   s:colors.yellow, s:colors.bg0, s:inverse)

" }}}
" LSP: {{{

hi! link LspDiagnosticsDefaultError GruvboxRed
hi! link LspDiagnosticsSignError GruvboxRedSign
hi! link LspDiagnosticsUnderlineError GruvboxRedUnderline

hi! link LspDiagnosticsDefaultWarning GruvboxYellow
hi! link LspDiagnosticsSignWarning GruvboxYellowSign
hi! link LspDiagnosticsUnderlineWarning GruvboxYellowUnderline

hi! link LspDiagnosticsDefaultInformation GruvboxBlue
hi! link LspDiagnosticsSignInformation GruvboxBlueSign
hi! link LspDiagnosticsUnderlineInformation GruvboxBlueUnderline

hi! link LspDiagnosticsDefaultHint GruvboxAqua
hi! link LspDiagnosticsSignHint GruvboxAquaSign
hi! link LspDiagnosticsUnderlineHint GruvboxAquaUnderline

" }}}

" Plugin specific -------------------------------------------------------------
" IndentLine: {{{

if !exists('g:indentLine_color_term')
  let g:indentLine_color_term = s:colors.bg2[1]
endif
if !exists('g:indentLine_color_gui')
  let g:indentLine_color_gui = s:colors.bg2[0]
endif

" }}}
" CtrlP: {{{

hi! link CtrlPMatch GruvboxYellow
hi! link CtrlPNoEntries GruvboxRed
hi! link CtrlPPrtBase GruvboxBg2
hi! link CtrlPPrtCursor GruvboxBlue
hi! link CtrlPLinePre GruvboxBg2

call s:HL('CtrlPMode1', s:colors.blue, s:colors.bg2, s:bold)
call s:HL('CtrlPMode2', s:colors.bg0, s:colors.blue, s:bold)
call s:HL('CtrlPStats', s:colors.fg4, s:colors.bg2, s:bold)

" }}}
" FZF: {{{

let g:fzf_colors = {
      \ 'fg':      ['fg', 'GruvboxFg1'],
      \ 'bg':      ['fg', 'GruvboxBg0'],
      \ 'hl':      ['fg', 'GruvboxYellow'],
      \ 'fg+':     ['fg', 'GruvboxFg1'],
      \ 'bg+':     ['fg', 'GruvboxBg1'],
      \ 'hl+':     ['fg', 'GruvboxYellow'],
      \ 'info':    ['fg', 'GruvboxBlue'],
      \ 'prompt':  ['fg', 'GruvboxFg4'],
      \ 'pointer': ['fg', 'GruvboxBlue'],
      \ 'marker':  ['fg', 'GruvboxOrange'],
      \ 'spinner': ['fg', 'GruvboxYellow'],
      \ 'header':  ['fg', 'GruvboxBg3']
      \ }

call s:HL('Fzf1', s:colors.blue, s:colors.bg1)
call s:HL('Fzf2', s:colors.orange, s:colors.bg1)
call s:HL('Fzf3', s:colors.fg4, s:colors.bg1)

" }}}
" NERDTree: {{{

hi! link NERDTreeDir GruvboxAqua
hi! link NERDTreeDirSlash GruvboxAqua

hi! link NERDTreeOpenable GruvboxOrange
hi! link NERDTreeClosable GruvboxOrange

hi! link NERDTreeFile GruvboxFg1
hi! link NERDTreeExecFile GruvboxYellow

hi! link NERDTreeUp GruvboxGray
hi! link NERDTreeCWD GruvboxGreen
hi! link NERDTreeHelp GruvboxFg1

hi! link NERDTreeToggleOn GruvboxGreen
hi! link NERDTreeToggleOff GruvboxRed

" }}}
" Telescope.nvim: {{{
hi! link TelescopeNormal GruvboxFg1
hi! link TelescopeSelection GruvboxOrangeBold
hi! link TelescopeSlectionCaret GruvboxRed
hi! link TelescopeMultiSelection GruvboxGray
hi! link TelescopeBorder TelescopeNormal
hi! link TelescopePromptBorder TelescopeNormal
hi! link TelescopeResultsBorder TelescopeNormal
hi! link TelescopePreviewBorder TelescopeNormal
hi! link TelescopeMatching GruvboxBlue
hi! link TelescopePromptPrefix GruvboxRed
hi! link TelescopePrompt TelescopeNormal

" }}}

" Filetype specific -----------------------------------------------------------
" Diff: {{{

hi! link diffAdded GruvboxGreen
hi! link diffRemoved GruvboxRed
hi! link diffChanged GruvboxAqua

hi! link diffFile GruvboxOrange
hi! link diffNewFile GruvboxYellow

hi! link diffLine GruvboxBlue

" }}}
" Html: {{{

hi! link htmlTag GruvboxAquaBold
hi! link htmlEndTag GruvboxAquaBold

hi! link htmlTagName GruvboxBlue
hi! link htmlArg GruvboxOrange

hi! link htmlScriptTag GruvboxPurple
hi! link htmlTagN GruvboxFg1
hi! link htmlSpecialTagName GruvboxBlue

call s:HL('htmlLink', s:colors.fg4, s:none, s:underline)

hi! link htmlSpecialChar GruvboxRed

call s:HL('htmlBold', s:vim_fg, s:vim_bg, s:bold)
call s:HL('htmlBoldUnderline', s:vim_fg, s:vim_bg, s:bold . s:underline)
call s:HL('htmlBoldItalic', s:vim_fg, s:vim_bg, s:bold . s:italic)
call s:HL('htmlBoldUnderlineItalic', s:vim_fg, s:vim_bg, s:bold . s:underline . s:italic)

call s:HL('htmlUnderline', s:vim_fg, s:vim_bg, s:underline)
call s:HL('htmlUnderlineItalic', s:vim_fg, s:vim_bg, s:underline . s:italic)
call s:HL('htmlItalic', s:vim_fg, s:vim_bg, s:italic)

" }}}
" Xml: {{{

hi! link xmlTag GruvboxAquaBold
hi! link xmlEndTag GruvboxAquaBold
hi! link xmlTagName GruvboxBlue
hi! link xmlEqual GruvboxBlue
hi! link docbkKeyword GruvboxAquaBold

hi! link xmlDocTypeDecl GruvboxGray
hi! link xmlDocTypeKeyword GruvboxPurple
hi! link xmlCdataStart GruvboxGray
hi! link xmlCdataCdata GruvboxPurple
hi! link dtdFunction GruvboxGray
hi! link dtdTagName GruvboxPurple

hi! link xmlAttrib GruvboxOrange
hi! link xmlProcessingDelim GruvboxGray
hi! link dtdParamEntityPunct GruvboxGray
hi! link dtdParamEntityDPunct GruvboxGray
hi! link xmlAttribPunct GruvboxGray

hi! link xmlEntity GruvboxRed
hi! link xmlEntityPunct GruvboxRed
" }}}
" Vim: {{{

call s:HL('vimCommentTitle', s:colors.fg4, s:none, s:bold . s:italicize_comments)

hi! link vimNotation GruvboxOrange
hi! link vimBracket GruvboxOrange
hi! link vimMapModKey GruvboxOrange
hi! link vimFuncSID GruvboxFg3
hi! link vimSetSep GruvboxFg3
hi! link vimSep GruvboxFg3
hi! link vimContinue GruvboxFg3

" }}}
" C: {{{

hi! link cOperator GruvboxPurple
hi! link cppOperator GruvboxPurple
hi! link cStructure GruvboxOrange

" }}}
" Python: {{{

hi! link pythonBuiltin GruvboxOrange
hi! link pythonBuiltinObj GruvboxOrange
hi! link pythonBuiltinFunc GruvboxOrange
hi! link pythonFunction GruvboxAqua
hi! link pythonDecorator GruvboxRed
hi! link pythonInclude GruvboxBlue
hi! link pythonImport GruvboxBlue
hi! link pythonRun GruvboxBlue
hi! link pythonCoding GruvboxBlue
hi! link pythonOperator GruvboxRed
hi! link pythonException GruvboxRed
hi! link pythonExceptions GruvboxPurple
hi! link pythonBoolean GruvboxPurple
hi! link pythonDot GruvboxFg3
hi! link pythonConditional GruvboxRed
hi! link pythonRepeat GruvboxRed
hi! link pythonDottedName GruvboxGreenBold

" }}}
" CSS: {{{

hi! link cssBraces GruvboxBlue
hi! link cssFunctionName GruvboxYellow
hi! link cssIdentifier GruvboxOrange
hi! link cssClassName GruvboxGreen
hi! link cssColor GruvboxBlue
hi! link cssSelectorOp GruvboxBlue
hi! link cssSelectorOp2 GruvboxBlue
hi! link cssImportant GruvboxGreen
hi! link cssVendor GruvboxFg1

hi! link cssTextProp GruvboxAqua
hi! link cssAnimationProp GruvboxAqua
hi! link cssUIProp GruvboxYellow
hi! link cssTransformProp GruvboxAqua
hi! link cssTransitionProp GruvboxAqua
hi! link cssPrintProp GruvboxAqua
hi! link cssPositioningProp GruvboxYellow
hi! link cssBoxProp GruvboxAqua
hi! link cssFontDescriptorProp GruvboxAqua
hi! link cssFlexibleBoxProp GruvboxAqua
hi! link cssBorderOutlineProp GruvboxAqua
hi! link cssBackgroundProp GruvboxAqua
hi! link cssMarginProp GruvboxAqua
hi! link cssListProp GruvboxAqua
hi! link cssTableProp GruvboxAqua
hi! link cssFontProp GruvboxAqua
hi! link cssPaddingProp GruvboxAqua
hi! link cssDimensionProp GruvboxAqua
hi! link cssRenderProp GruvboxAqua
hi! link cssColorProp GruvboxAqua
hi! link cssGeneratedContentProp GruvboxAqua

" }}}
" JavaScript: {{{

hi! link javaScriptBraces GruvboxFg1
hi! link javaScriptFunction GruvboxAqua
hi! link javaScriptIdentifier GruvboxRed
hi! link javaScriptMember GruvboxBlue
hi! link javaScriptNumber GruvboxPurple
hi! link javaScriptNull GruvboxPurple
hi! link javaScriptParens GruvboxFg3

" }}}
" YAJS: {{{

hi! link javascriptImport GruvboxAqua
hi! link javascriptExport GruvboxAqua
hi! link javascriptClassKeyword GruvboxAqua
hi! link javascriptClassExtends GruvboxAqua
hi! link javascriptDefault GruvboxAqua

hi! link javascriptClassName GruvboxYellow
hi! link javascriptClassSuperName GruvboxYellow
hi! link javascriptGlobal GruvboxYellow

hi! link javascriptEndColons GruvboxFg1
hi! link javascriptFuncArg GruvboxFg1
hi! link javascriptGlobalMethod GruvboxFg1
hi! link javascriptNodeGlobal GruvboxFg1
hi! link javascriptBOMWindowProp GruvboxFg1
hi! link javascriptArrayMethod GruvboxFg1
hi! link javascriptArrayStaticMethod GruvboxFg1
hi! link javascriptCacheMethod GruvboxFg1
hi! link javascriptDateMethod GruvboxFg1
hi! link javascriptMathStaticMethod GruvboxFg1

" hi! link javascriptProp GruvboxFg1
hi! link javascriptURLUtilsProp GruvboxFg1
hi! link javascriptBOMNavigatorProp GruvboxFg1
hi! link javascriptDOMDocMethod GruvboxFg1
hi! link javascriptDOMDocProp GruvboxFg1
hi! link javascriptBOMLocationMethod GruvboxFg1
hi! link javascriptBOMWindowMethod GruvboxFg1
hi! link javascriptStringMethod GruvboxFg1

hi! link javascriptVariable GruvboxOrange
" hi! link javascriptVariable GruvboxRed
" hi! link javascriptIdentifier GruvboxOrange
" hi! link javascriptClassSuper GruvboxOrange
hi! link javascriptIdentifier GruvboxOrange
hi! link javascriptClassSuper GruvboxOrange

" hi! link javascriptFuncKeyword GruvboxOrange
" hi! link javascriptAsyncFunc GruvboxOrange
hi! link javascriptFuncKeyword GruvboxAqua
hi! link javascriptAsyncFunc GruvboxAqua
hi! link javascriptClassStatic GruvboxOrange

hi! link javascriptOperator GruvboxRed
hi! link javascriptForOperator GruvboxRed
hi! link javascriptYield GruvboxRed
hi! link javascriptExceptions GruvboxRed
hi! link javascriptMessage GruvboxRed

hi! link javascriptTemplateSB GruvboxAqua
hi! link javascriptTemplateSubstitution GruvboxFg1

" hi! link javascriptLabel GruvboxBlue
" hi! link javascriptObjectLabel GruvboxBlue
" hi! link javascriptPropertyName GruvboxBlue
hi! link javascriptLabel GruvboxFg1
hi! link javascriptObjectLabel GruvboxFg1
hi! link javascriptPropertyName GruvboxFg1

hi! link javascriptLogicSymbols GruvboxFg1
hi! link javascriptArrowFunc GruvboxYellow

hi! link javascriptDocParamName GruvboxFg4
hi! link javascriptDocTags GruvboxFg4
hi! link javascriptDocNotation GruvboxFg4
hi! link javascriptDocParamType GruvboxFg4
hi! link javascriptDocNamedParamType GruvboxFg4

hi! link javascriptBrackets GruvboxFg1
hi! link javascriptDOMElemAttrs GruvboxFg1
hi! link javascriptDOMEventMethod GruvboxFg1
hi! link javascriptDOMNodeMethod GruvboxFg1
hi! link javascriptDOMStorageMethod GruvboxFg1
hi! link javascriptHeadersMethod GruvboxFg1

hi! link javascriptAsyncFuncKeyword GruvboxRed
hi! link javascriptAwaitFuncKeyword GruvboxRed

" }}}
" ObjectiveC: {{{

hi! link objcTypeModifier GruvboxRed
hi! link objcDirective GruvboxBlue

" }}}
" Lua: {{{

hi! link luaIn GruvboxRed
hi! link luaFunction GruvboxAqua
hi! link luaTable GruvboxOrange

" }}}
" Java: {{{

hi! link javaAnnotation GruvboxBlue
hi! link javaDocTags GruvboxAqua
hi! link javaCommentTitle vimCommentTitle
hi! link javaParen GruvboxFg3
hi! link javaParen1 GruvboxFg3
hi! link javaParen2 GruvboxFg3
hi! link javaParen3 GruvboxFg3
hi! link javaParen4 GruvboxFg3
hi! link javaParen5 GruvboxFg3
hi! link javaOperator GruvboxOrange

hi! link javaVarArg GruvboxGreen

" }}}
" Markdown: {{{

call s:HL('markdownItalic', s:colors.fg3, s:none, s:italic)
call s:HL('markdownBold', s:colors.fg3, s:none, s:bold)
call s:HL('markdownBoldItalic', s:colors.fg3, s:none, s:bold . s:italic)

hi! link markdownH1 GruvboxGreenBold
hi! link markdownH2 GruvboxGreenBold
hi! link markdownH3 GruvboxYellowBold
hi! link markdownH4 GruvboxYellowBold
hi! link markdownH5 GruvboxYellow
hi! link markdownH6 GruvboxYellow

hi! link markdownCode GruvboxAqua
hi! link markdownCodeBlock GruvboxAqua
hi! link markdownCodeDelimiter GruvboxAqua

hi! link markdownBlockquote GruvboxGray
hi! link markdownListMarker GruvboxGray
hi! link markdownOrderedListMarker GruvboxGray
hi! link markdownRule GruvboxGray
hi! link markdownHeadingRule GruvboxGray

hi! link markdownUrlDelimiter GruvboxFg3
hi! link markdownLinkDelimiter GruvboxFg3
hi! link markdownLinkTextDelimiter GruvboxFg3

hi! link markdownHeadingDelimiter GruvboxOrange
hi! link markdownUrl GruvboxPurple
hi! link markdownUrlTitleDelimiter GruvboxGreen

call s:HL('markdownLinkText', s:colors.gray, s:none, s:underline)
hi! link markdownIdDeclaration markdownLinkText

" }}}
" Json: {{{

hi! link jsonKeyword GruvboxGreen
hi! link jsonQuote GruvboxGreen
hi! link jsonBraces GruvboxFg1
hi! link jsonString GruvboxFg1

" }}}
" C#: {{{

hi! link csBraces GruvboxFg1
hi! link csEndColon GruvboxFg1
hi! link csLogicSymbols GruvboxFg1
hi! link csParens GruvboxFg3
hi! link csOpSymbols GruvboxFg3
hi! link csInterpolationDelimiter GruvboxFg3
hi! link csInterpolationAlignDel GruvboxAquaBold
hi! link csInterpolationFormat GruvboxAqua
hi! link csInterpolationFormatDel GruvboxAquaBold

" }}}
" Rust: {{{

hi! link rustSigil GruvboxOrange
hi! link rustEscape GruvboxAqua
hi! link rustStringContinuation GruvboxAqua
hi! link rustEnum GruvboxAqua
hi! link rustStructure GruvboxAqua
hi! link rustModPathSep GruvboxFg2
hi! link rustCommentLineDoc Comment
hi! link rustDefault GruvboxAqua

" }}}


" Functions -------------------------------------------------------------------
" Search Highlighting Cursor {{{

function! GruvboxHlsShowCursor()
  call s:HL('Cursor', s:colors.bg0, s:colors.orange)
endfunction

function! GruvboxHlsHideCursor()
  call s:HL('Cursor', s:none, s:none, s:inverse)
endfunction

" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
