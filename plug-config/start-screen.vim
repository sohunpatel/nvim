let g:startify_session_dir = '~/.config/nvim/session'

let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Files']            },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ ]

let g:startify_bookmarks = [
            \ { 'x': '~/.xmonad/xmonad.hs' },
            \ { 'i': '~/.config/nvim/init.vim' },
            \ { 'z': '~/.zshrc' }
            \ ]

let g:startify_session_autoload = 1
let g:startify_session_delete_buffers = 1
let g:startify_change_to_vcs_root = 1
let g:startify_fortune_use_unicode = 1
let g:startify_session_persistence = 1
let g:startify_enable_special = 0

let g:startify_custom_header = [
\'                                               _______________________',
\'   _______________________-------------------                       `\ ',
\' /:--__                                                              |',
\'||< > |                                   ___________________________/',
\'| \__/_________________-------------------                         |',
\'|                                                                  |',
\' |                       THE LORD OF THE RINGS                      |',
\' |                                                                  |',
\' |       Three Rings for the Elven-kings under the sky,             |',
\'  |        Seven for the Dwarf-lords in their halls of stone,        |',
\'  |      Nine for Mortal Men doomed to die,                          |',
\'  |        One for the Dark Lord on his dark throne                  |',
\'  |      In the Land of Mordor where the Shadows lie.                 |',
\'   |       One Ring to rule them all, One Ring to find them,          |',
\'   |       One Ring to bring them all and in the darkness bind them   |',
\'   |     In the Land of Mordor where the Shadows lie.                |',
\'  |                                              ____________________|_',
\'  |  ___________________-------------------------                      `\ ',
\'  |/`--_                                                                 |',
\'  ||[ ]||                                            ___________________/',
\'   \===/___________________--------------------------',
\]

