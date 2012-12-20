" Documentation {{{1

" Name: vimExplorer.vim
" Version: 1.2
" Description: Explore directories quickly and operate on files.
" Author: Alexandre Viau (alexandreviau@gmail.com)
" Installation: Copy the plugin to the vim plugin directory.
"
" Usage {{{2
"
" Mappings: {{{3
"
" Open vimExplorer using the last accessed path {{{4

" <leader>vb Start vimExplorer in the current window
" <leader>vs Start vimExplorer in a new split (horizontal) window
" <leader>vv Start vimExplorer in a new vsplit (vertical) window
" <leader>vt Start vimExplorer in a new tab

" Open vimExplorer using a the current file's path {{{4

" <leader>VB Start vimExplorer in the current window
" <leader>VS Start vimExplorer in a new split (horizontal) window
" <leader>VV Start vimExplorer in a new vsplit (vertical) window
" <leader>VT Start vimExplorer in a new tab
"
" Directory browsing {{{4
"
" <space>l Open the selected directory
" <space>h Go to the parent directory
"
" <space>a Go to the path at the top of the buffer to edit it. Press <space>l or <enter> (in normal mode) to go the that path once edited.
" <space>f Set filter to show only certain files
" <space>F Remove the filter and show all files
" <space>L Open the selected directory recursively
" <space>o Reload directory
" <space>p Copy path
" <space>P Show current path in different formats and to the clipboard
" <space>x Open directory in external file manager
" NOTE: 1. You may write or edit a path manually in the "Path: " bar at the top of the buffer. Once the path is entered, press <space>l or <enter> to go to that path.
"       2. You may change the path of the external file manager in the <space>x mapping.
"
" Browsing history {{{4
"
" <space>l or <enter> Go to one of the history path shown at the top of the buffer, put cursor on one of the paths and execute this mapping. Tip: W or B to move from one path to another in the history. 
" <space>; Go to the history list (then do ; or , (from the vim 'f' command) to move forward and backward from one path to another, then when on the desired path, do <space>; to goto the directory.)
" <space>, Go to the end of the history list (then do ; or , (from the vim 'f' command) to move forward and backward from one path to another, then when on the desired path, do <space>, to goto the directory.)
" <space>H Delete the browsing history
" NOTE: 1. You may edit the history bar at the top of the buffer, you may add, remove or move paths on this line, it will be saved automatically when changing directory or doing <space>s to save the configuration or when vim quits if the cursor is in a vimExplorer window.
"       2. The maximum length of the history bar may be changed by setting the "s:HistoryMaxLength" variable
"       3. You may use the "set wrap" command to see all history if the list is long
"
" Directory bookmarks {{{4
"
" ma to mz Directory marks like similar to marks in vim using the m key but to mark directories instead of positions in files and ' or ` or ; to return to that directory. The maps are automatically activated on a directory listing. For example, press mw to mark the c:\windows directory, then do 'w (or `w or ;w) to return to that directory. All letters may be used from a to z, A to Z and 0 to 9. Press '' to view a list of all the bookmarked directories sorted by mark, or press ;; to view the same list but sorted by paths. When '' or ;; is pressed, the list is shown and a mark is asked as input to goto to its directory, this is another way that marks are used.
" m0 to m9 Same like ma to mz but using numbers as marks
" 'a to 'z or `a to `z To return to the directories marked by ma to mz  
" '0 to '9 or `0 to `9 Same like ma to mz but using numbers as marks
" <space>' Show all marked directories sorted by marks
" <space>[ Show all marked directories sorted by directories
"
" Directory favorites {{{4
"
" <space>b Add the path to the favorites bar
" <space>B Delete the favorites
"
" NOTE: 1. The favorites bar is another way of bookmarking directories. It is independant from the directory bookmarks (marks) showned above. It is a feature on its own.
"       2. You may edit the favorites bar at the top of the buffer, you may add, remove or move paths on this line, it will be saved automatically when changing directory or doing <space>s to save the configuration or when vim quits if the cursor is in a vimExplorer window.
"
" Directory file grep {{{4
"
" <space>G Simple grep command to search the files in the current directory and subdirectories. The results are appended at the end of the buffer. After the results are appended, if you want to open a file that appears in the grep results do <space>l on the line where that file is, the file will be opened on a split window at the line number where that grep found the keywords. 
" NOTE: The UnxUtils grep command dosen't seems to be able to do file filtering when doing a recursive grep, so no "include" will be prompted and all files will be grepped)
"
" Directory file search {{{4
"
" <space>L  To search files in a directory, open the selected directory recursively using <space>L and then search the buffer for the file using vim's "/" command or use vimgrep.
"
" Directory sorting {{{4
"
" <space>1 Sort by name
" <space>2 Sort by type
" <space>3 Sort by size
" <space>4 Sort by date
"
" File operations {{{4
"
" <space>d New directory
" <space>l or <enter> Open file in horizontal split window
" <space>v Open file in vertical split window
" <space>t Open file in new tab
" <space>c Clone file
" <space>D Delete file/directory
" <space>n New file
" <space>R Rename file
" <space>r Run file
"
" Shell operations {{{4
"
" <space><esc> Execute a command and insert its output in the buffer
" <space>C Open directory in shell
"
" Configuration file operations {{{4
"
" <space>o Reload configuration from file (useful if the .config.vim file was edited manually and you want to reload it in the vimExplorer window that is currently opened)
" <space>s Save configuration file
" NOTE: The configuration is automatically loaded when vim starts, and it is automatically closed when vim quits.
"
" Commands: {{{3
"
" Open vimExplorer using the last accessed path {{{4
"
" VimExplorerB Start vimExplorer in the current window
" VimExplorerS Start vimExplorer in a new split (horizontal) window
" VimExplorerV Start vimExplorer in a new vsplit (vertical) window
" VimExplorerT Start vimExplorer in a new tab
"
" Open vimExplorer using a the current file's path {{{4
"
" VimExplorerBF Start vimExplorer in the current window
" VimExplorerSF Start vimExplorer in a new split (horizontal) window
" VimExplorerVF Start vimExplorer in a new vsplit (vertical) window
" VimExplorerTF Start vimExplorer in a new tab

" Open vimExplorer using a path specified on the command line {{{4

" VimExplorerBP Start vimExplorer in the current window
" VimExplorerSP Start vimExplorer in a new split (horizontal) window
" VimExplorerVP Start vimExplorer in a new vsplit (vertical) window
" VimExplorerTP Start vimExplorer in a new tab
"
" How to get the current path and filename for usage in external scripts {{{3
"
" If you want to get the current path and filename from vimExplorer first call the "g:VeGetPath()" then use the following variables as needed.
" These paths variables may be used for example if you do new mappings or some kind of menu to execute operations on the current file or directory.
" Note that the current path and filename are copied when leaving the plugin or any file window for another window so the following variables could be used from there.
" If you don't want to copy the path when leaving any file window, but just when leaving a vimExplorer window, set the variable "s:GetPathOnLeaveAlways" to 0
"
" Filename
"   g:VeFileName (filename only without path)
"   g:VeFileNameQ (filename only without path + quotes)
"   g:VeFileName2Q (filename only without path + double quotes)
" Path with / (slash)
"   g:VePathS (without filename)
"   g:VePathSQ (without filename + quotes)
"   g:VePathS2Q (without filename + double quotes)
"   g:VeFullPathS (with filename)
"   g:VeFullPathSQ (with filename + quotes)
"   g:VeFullPathS2Q (with filename + double quotes)
" Path with \ (B = backslash)
"   g:VePathB (without filename)
"   g:VePathBQ (without filename + quotes)
"   g:VePathB2Q (without filename + double quotes)
"   g:VeFullPathB (with filename)
"   g:VeFullPathBQ (with filename + quotes)
"   g:VeFullPathB2Q (with filename + double quotes)
" Path with \\ (2B = double backslash)
"   g:VePath2B
"   g:VePath2BQ = (without filename + quotes)
"   g:VePath2B2Q = (without filename + double quotes)
"   g:VeFullPath2B (with filename)
"   g:VeFullPath2BQ (with filename + quotes)
"   g:VeFullPath2B2Q (with filename + double quotes)
"
" How to open vimExplorer from another script {{{3
"
" Call the function "g:VeDirectoryGoto()" and pass the path as parameter.
" Example:  cal g:VeDirectoryGoto('/usr/bin') or cal g:VeDirectoryGoto('c:/windows')
" You may have to do a "split", "vsplit" or "tabnew" before calling "g:VeDirectoryGoto()"
"
" Tips {{{2
"
"  - You may use the "set wrap" command to see all history if the list is long.
"  - To search files in a directory, open the selected directory recursively using <space>L and then search the buffer for the file using vim's "/" command or use vimgrep.
"  - I use also the MRU plugin in combination with vimExplorer to have a list of the last opened files, I find it extremely useful for vim editing.
"  - If you need to do file operations like copy or move files, since these are not implemented in the plugin, vimExplorer to move quickly between directories and then do <space>x to open you file manager or <space>C to open the console, also <space><esc> to run a command. 
"  - To go quickly to the favorites bar, do <space>; or <space>, which brings the cursor on the history bar, then do "j" to go down one line, then press ";" or "," to go forward and backward on the favorites bar.
"  - You may search the history and favorites using the "/" or the "?" command, especially the "?" command as the links are at the top of the file.
"
" Todo {{{2
"
"   Upload the plugin (comments modified)
"   test delete file/dir in linux
"   trouver comment mettre des end-of-line dans substitute est utiliser afin d'avoir des end-of-line dans le fichier .conf.vim j'ai essayer avec \n mais ca fait des @^ dans le fichier et quand je reload le fichier apres l'avoir saver je n'ai pas access a ses info entre autre les bookmark list
"   The mappings could probably be activated and deactivated using the <buffer> instruction and placed in the AddMaps function. I tried to put one directly there with the <buffer> instruction but it was still activated when I changed window, there is probably another option to set... But one advantage of having the mappings to a dictionnary is to be able to change the leader key for mappings dynamically and even change the mappings dynamically...maybe this could be done too without dictionnary... Different sets of mappings could be loaded/unloaded dynamically using a dictionnary this is another advantage... see later if there is time. Mappings could be also changed individually as a function to add the mappings would do them all at once.
"   put <buffer> in the autocommands so onenter and onleave will be executed only for a vimexplorer buffer and then no need for the ispluginwindow perhaps
"       I tried to put <buffer> to the TabEnter,WinEnter,BufEnter autocommands but it didn't work
"   see if autocommands functions called multiple times...if yes then find a way not to execute the code called multiple times, maybe by using a script counter...or a boolean
"   mettre le save config sur cursorHold autoevent 
"   continue commands to open in vsplit, new tab etc j'ai fait des type de window dans buildwindow() faire des commandes correspondantes sans trop dupliquer de code si possible
"   concernant ce qui suit a propos des tags...peut-etre pas le faire, les operations de copie se font mieux en windows et ca vaudrait pas la peine...c'est pas un file manager mais pour editer des fichiers...peut-etre ajouter <space>t pour tagger les fichier, ajouter les fichiers tagges dans un dictionnaire (dans le g:VeCfg) dans un section "taggedFiles". lorsqu'un fichier est tagge, appender un "*" apres le filename, et ajouter un highlight dans setcolor() pour highlighte les lignes qui se termine par "*". Le fullpath serait la cle de l'item de dictionnaire et le filename la value. avec ces deux si une commande demande un full path on l'aura et si une autre command demande seulement le filename (comme dans la command grep) on l'aura aussi. faire une fonction qui update la liste des fichier et ajoute les asterisque "*" apres les filename (avec un loop des values du dictionnaire et search replace les filename du buffer) et ajout le highligh (appelle setcolor()) utiliser pour grep, move et copy
"
" Bugs {{{2
"
"   1. le config file a ete overwrite pour une raison que j'ignore... a surveiller
"   2. ne fonctionne pas dans cygwin console et xconsole
"   3. On dirait qu'il a sauvegarder des endroit qui ne sont pas des lignes du listing comme emplacement de repertoire...voir si c'est pas des anciennes donnees
"   exemple
"   'C:/Documents and Settings': 'otal 0'
"   4. Le config file n'est pas loader pour une raison que j'ignore...
"   Added multilines in the configuration file. Note for some reasons I don't know yet, the end-of-line characters appear like this in the file ^M^@ (in windows, in linux it should be ^@) which is all on the same line when opened in vim. If the file is opened for example in wordpad, it appears with multiple lines. I have to check this out again.
"
" History {{{2
"
" 1.0 First release
"
" 1.1 Modified the GetFileName() function: when there is very large files with the number of bytes taking much spaces, the filenames may not be aligned, so to find the position of the first filename was not enough, I had to find the position of the filename on the current line, each independently.
"     Added the favorites bar that offers another way of bookmarking directories other than directory marks.
"     Corrected the history bar and favorites bar, the links where not executed when <space>l or <enter> were pressed on the "]" character.
"     Added initialization of the fileName variable to '' in the GetFileName() function
"     Added possibility to edit the history bar and favorites bar. They will be saved when changing directories or when <space>s is pressed, or when vim quits if the cursor is in a vimExplorer window.
"     You may now write or edit a path manually in the "Path: " bar at the top of the buffer. Once the path is entered, press <space>l or <enter> to go to that path.
"     Now use <space>a to go the path at the top of the buffer to edit it. Press <space>l or <enter> (in normal mode) to go the that path once edited.
"     Modified comments: there was <space>g to execute history paths, now <space>l or <enter>. I modified other comments as well.
" 1.2 Added <space>e (edit) to open files in current buffer.
"     Changed commands VimExplorerB, VimExplorerBF, VimExplorerBP for VimExplorerE, VimExplorerEF, VimExplorerEP 
"     Changed mappings \vb and \VB for \vb and \VE so it is similar to the <space>e command, to keep consistance between mappings.
"     Added very large max length for favorites not to autodelete them if there are too many like with the history bar.
"     Added the possibility to call g:VeGetPath() from any file, not just from a vimExplorer window, to get the multiple path formats to global variables. This allows for example to switch to another window where there would be a menu of links that contains the path variables in commands. One example could be that a code file is in edition, once saved, switch to menu window and execute the commands from the links. If you don't want to get the paths when leaving any files, set the "s:GetPathOnLeaveAlways" variable to 0
"     Modified comments

" Variables: Plugin {{{1

" Flag indicating that the plugin is starting for the first time and not already opened and accessed from another window
let g:VeOpening = 0

" To add debug information after a directory listing
let g:Debug = ''

" Variables: Configuration {{{1

let g:VeCfgFile = $home . '/vimExplorer.conf.vim'
" The declaration of the variable 'g:VeCfg' is in the g:VeLoadFromFile() function, this is to avoid to erase its content when developing and sourcing (so %) this file, but otherwise it should be here like this "let g:VeCfg = {}".

" Variables: Directory browsing {{{1

" The column position where the file name starts
let s:FileNameColNum = 0

" The line number where the directory listing is starting
let s:DirectoryListLineNum = 8

" The maximum lenght for the history bar the top of the buffer
let s:HistoryMaxLength = 1000

" The maximum lenght for the favorites bar the top of the buffer
let g:VeFavoritesMaxLength = 9999999

" Get the multiple path formats of the current file to global variables when leaving any file including the vimExplorer selected file. This is done by calling the g:VeGetPath() function
" If set to 0, then the path formats will be copied only when leaving a vimExplorer window
let s:GetPathOnLeaveAlways = 1

" Variables: Paths {{{2

" The declaration of the variable 'g:VePath' is in the g:VeLoadFromFile() function, this is to avoid to erase its content when developing and sourcing (so %) this file, but otherwise it should be here like this "let g:VePath = ''".
" Filename
let g:VeFileName = ''
let g:VeFileNameQ = '' " (with quotes)
let g:VeFileName2Q = '' " (with quotes)
" Path with /
let g:VePathS = '' " (without filename)
let g:VePathSQ = '' " (without filename + quotes)
let g:VePathS2Q = '' " (without filename + double quotes)
let g:VeFullPathS = '' " (with filename)
let g:VeFullPathSQ = '' " (with filename + quotes)
let g:VeFullPathS2Q = '' " (with filename + double quotes)
" Path with \
let g:VePathB = '' " (without filename)
let g:VePathBQ = '' " (without filename + quotes)
let g:VePathB2Q = '' " (without filename + double quotes)
let g:VeFullPathB = '' " (with filename)
let g:VeFullPathBQ = '' " (with filename + quotes)
let g:VeFullPathB2Q = '' " (with filename + double quotes)
" Path with \\
let g:VePath2B = '' " (without filename)
let g:VePath2BQ = '' " (without filename + quotes)
let g:VePath2B2Q = '' " (without filename + double quotes)
let g:VeFullPath2B = '' " (with filename)
let g:VeFullPath2BQ = '' " (with filename + quotes)
let g:VeFullPath2B2Q = '' " (with filename + double quotes)

" Variables: Ls command {{{2

" Default filter (all files)
let g:VeFilter = ''

" Default sorting
let g:VeSort = '-U'
let g:VeSortLabel = 'Name'

" Defaut recursive
let g:VeRecursive = ''

" Windows
if has('Win32')
    " Cygwin ls command
    "let s:LsCmdPath = 'c:\cygwin\bin\ls.exe'
    " UnixUtils ls command path (The version I tested dosen't show Windows7 links as links but shows them as regular directories, and it produce an error when changing to it and produces errors if russian directory name. It seems also more faster than cygwin ls but cygwin ls displays everything correctly.) 
    let s:LsCmdPath = 'C:\Usb\z_white\Apps\Portable\CmdUtils\ls.exe'
" Linux
else
    " ls command
    let s:LsCmdPath = 'ls'
endif

" Variables: Directory grep {{{1 

" Windows
if has('Win32')
    " Select the grep command: c = cygwin, u = UnxUtils (the options are not the same for both grep commands)
    " Cygwin grep command
    let s:GrepCmdType = 'c'
    let g:VeGrepCmdPath = 'c:\cygwin\bin\grep.exe'
    " UnxUtils command (it seems this version of the grep command dosen't seem to be able to do file filtering when doing a recursive grep, so no "include" will be prompted and all files will be grepped)
    "let s:GrepCmdType = 'u'
    "let g:VeGrepCmdPath = 'C:\Usb\z_white\Apps\Portable\CmdUtils\grep.exe'
" Linux
else
    let g:VeGrepCmdPath = 'grep'
endif

" Autocommands {{{1

au! VimEnter * cal g:VeLoadFromFile(1)
au! VimLeave * if s:IsPluginWindow() == 1 | cal g:VeSaveBar('History') | cal g:VeSaveBar('Favorites') | endif | cal g:VeSaveToFile() 
au! TabEnter,WinEnter,BufEnter * cal s:OnEnter()
au! TabLeave,WinLeave,BufLeave * cal s:OnLeave()

" Mappings: To start the plugin {{{1

" Open vimExplorer using the last accessed path {{{2

" Create the window in the current window
map <silent> <leader>ve :VimExplorerE<cr>
" Create the window in a new split (horizontal) window
map <silent> <leader>vs :VimExplorerS<cr>
" Create the window in a new vsplit (vertical) window
map <silent> <leader>vv :VimExplorerV<cr>
" Create the window in a new tab
map <silent> <leader>vt :VimExplorerT<cr>

" Open vimExplorer using a the current file's path {{{2

" Create the window in the current window
map <silent> <leader>VE :VimExplorerEF<cr>
" Create the window in a new split (horizontal) window
map <silent> <leader>VS :VimExplorerSF<cr>
" Create the window in a new vsplit (vertical) window
map <silent> <leader>VV> :VimExplorerVF<cr>
" Create the window in a new tab
map <silent> <leader>VT :VimExplorerTF<cr>

" Commands: To start the plugin {{{1

" Open vimExplorer using the last accessed path {{{2

" Create the window in the current window
command! -nargs=0 VimExplorerE let g:VeOpening = 1 | cal g:BuildWindow('e') | cal g:VeDirectoryGoto(g:VePath) | let g:VeOpening = 0
" Create the window in a new split (horizontal) window
command! -nargs=0 VimExplorerS let g:VeOpening = 1 | cal g:BuildWindow('s') | cal g:VeDirectoryGoto(g:VePath) | let g:VeOpening = 0
" Create the window in a new vsplit (vertical) window
command! -nargs=0 VimExplorerV let g:VeOpening = 1 | cal g:BuildWindow('v') | cal g:VeDirectoryGoto(g:VePath) | let g:VeOpening = 0
" Create the window in a new tab
command! -nargs=0 VimExplorerT let g:VeOpening = 1 | cal g:BuildWindow('t') | cal g:VeDirectoryGoto(g:VePath) | let g:VeOpening = 0

" Open vimExplorer using a the current file's path {{{2

" Create the window in the current window
command! -nargs=0 VimExplorerEF let g:VeOpening = 1 | let p = expand('%:p:h') | cal g:BuildWindow('e') | cal g:VeDirectoryGoto(p) | let g:VeOpening = 0
" Create the window in a new split (horizontal) window
command! -nargs=0 VimExplorerSF let g:VeOpening = 1 | let p = expand('%:p:h') | cal g:BuildWindow('s') | cal g:VeDirectoryGoto(p) | let g:VeOpening = 0
" Create the window in a new vsplit (vertical) window
command! -nargs=0 VimExplorerVF let g:VeOpening = 1 | let p = expand('%:p:h') | cal g:BuildWindow('v') | cal g:VeDirectoryGoto(p) | let g:VeOpening = 0
" Create the window in a new tab
command! -nargs=0 VimExplorerTF let g:VeOpening = 1 | let p = expand('%:p:h') | cal g:BuildWindow('t') | cal g:VeDirectoryGoto(p) | let g:VeOpening = 0

" Open vimExplorer using a path specified on the command line {{{2

" Create the window in the current window
command! -nargs=1 VimExplorerEP let g:VeOpening = 1 | cal g:BuildWindow('e') | cal g:VeDirectoryGoto(<f-args>) | let g:VeOpening = 0
" Create the window in a new split (horizontal) window
command! -nargs=1 VimExplorerSP let g:VeOpening = 1 | cal g:BuildWindow('s') | cal g:VeDirectoryGoto(<f-args>) | let g:VeOpening = 0
" Create the window in a new vsplit (vertical) window
command! -nargs=1 VimExplorerVP let g:VeOpening = 1 | cal g:BuildWindow('v') | cal g:VeDirectoryGoto(<f-args>) | let g:VeOpening = 0
" Create the window in a new tab
command! -nargs=1 VimExplorerTP let g:VeOpening = 1 | cal g:BuildWindow('t') | cal g:VeDirectoryGoto(<f-args>) | let g:VeOpening = 0

" Functions: Plugin {{{1

" s:IsPluginWindow() {{{2
" Check if currently in this plugin window
fu! s:IsPluginWindow()
    " Get first line where there is the name of the plugin
    let lines = getline(1, 1)
    " If the first line contains the name of the plugin then it is a plugin window
    if lines[0] == 'vimExplorer'
        retu 1
    else
        retu 0
    endif
endfu

" OnEnter() {{{2
fu! s:OnEnter()
    if g:VeOpening == 0
        " The window is a vimExplorer window {{{
        if s:IsPluginWindow() == 1
            " Get the instance path {{{
            " Don't check for current path if plugin is opening. OnEnter() is triggered when the window is builded by BuildWindow() and the path should not be copied at this point.
            " These lines of code below allow to use multiple windows of the plugin, getting the "instance" current path by copying the path at the top of the buffer and changing to it when changing from one window to another.
            " Copy path on the top of the plugin window 
            let savedPosition = getpos(".")
            " Go to the history bars
            norm gg
            " Check if the bar is found
            let path = ''
            if search('Path') != 0
                " Get the line
                let line = getline(line('.'))
                " Remove the label from the line
                let path = substitute(line, 'Path: [', '', '')
                " Remove "]" at the end
                let path = strpart(path, 0, len(path) - 1)
            endif
            " Go back to previous position
            cal setpos('.', savedPosition)
            " Change to this instance path directory
            cal s:ChangeDirectory(path)
            "}}}
        "}}}
        endif
    endif
endfu

" OnLeave() {{{2
fu! s:OnLeave()
    
    " Keep a copy of the current path and filename variables to use from another window, even if the current window is not a vimExplorer window. {{{3
    " This allows for example to switch to another window where there would be a menu of links that contains the path variables in commands.
    " One example could be that a code file is in edition, once saved, switch to menu window and execute the commands from the links.
    " If you don't want to get the paths when leaving any files, set the "s:GetPathOnLeaveAlways" variable to 0
    if s:GetPathOnLeaveAlways == 1 || s:IsPluginWindow() == 1
        cal g:VeGetPath()
    endif
endfu

" BuildWindow() (window creation, options and mappings) {{{2
fu! g:BuildWindow(winType)
    " Create the window in the current window {{{3
    if a:winType == 'e'
        enew
    " Create the window in a new split (horizontal) window
    elseif a:winType == 's'
        new
    " Create the window in a new vsplit (vertical) window
    elseif a:winType == 'v'
        vsplit
        enew
    " Create the window in a new tab
    elseif a:winType == 't'
        tabnew
    endif
    " Options: Local {{{3

    " Check help for information on these options
    setlocal fdc=0
    setlocal nonu
    setlocal nornu
    setlocal buftype=nofile
    setlocal bufhidden=delete
    setlocal noswapfile
    setlocal nowrap
    setlocal nobuflisted
    " Mappings: Common to all OSes {{{3

    " <space><esc> Execute a command and insert its output in the buffer
    nmap <buffer> <space><esc> :cal g:VeGetPath() \| let f = input('r! ', '') \| if f != '' \| exe 'norm G' \| exe 'r! ' . f \| endif<cr>
    " <space><enter> Open the selected item
    nmap <silent> <buffer> <enter> :cal g:VeOpenItem(0)<cr>
    " <space><backspace> Go to the parent directory
    nmap <silent> <buffer> <backspace> :cal g:VeDirectoryGoto('..')<cr>
    " <space><enter> Execute a command and insert its output in the buffer
    nmap <buffer> <space><esc> :cal g:VeGetPath() \| let f = input('r! ', '') \| if f != '' \| exe 'norm G' \| exe 'r! ' . f \| endif<cr>
    " <space>' Show all marked directories sorted by marks
    nmap <buffer> <space>' :cal g:VeShowMarks(0)<cr>
    " <space>[ Show all marked directories sorted by directories
    nmap <buffer> <space>[ :cal g:VeShowMarks(1)<cr>
    " <space>; Go to the history list (then do ; or , (from the vim 'f' command) to move forward and backward from one path to another, then when on the desired path, do <space>; to goto the directory.)
    nmap <silent> <buffer> <space>; :exe 'norm gg' \| call search('History') \| exe 'norm f['<cr>
    " <space>, Go to the end of the history list (then do ; or , (from the vim 'f' command) to move forward and backward from one path to another, then when on the desired path, do <space>, to goto the directory.)
    nmap <silent> <buffer> <space>, :exe 'norm gg' \| call search('History') \| exe 'norm $f[' \| norm ,<cr>
    " <space>1 Sort by name
    nmap <silent> <buffer> <space>1 :let g:VeSort = '-U' \| let g:VeSortLabel = 'Name' \| cal g:VeLs()<cr> 
    " <space>2 Sort by type
    nmap <silent> <buffer> <space>2 :let g:VeSort = '-X' \| let g:VeSortLabel = 'Type' \| cal g:VeLs()<cr> 
    " <space>3 Sort by size
    nmap <silent> <buffer> <space>3 :let g:VeSort = '-S' \| let g:VeSortLabel = 'Size' \| cal g:VeLs()<cr> 
    " <space>4 Sort by date
    nmap <silent> <buffer> <space>4 :let g:VeSort = '-t' \| let g:VeSortLabel = 'Date' \| cal g:VeLs()<cr> 
    " <space>a Go to the path at the top of the buffer to edit it. Press <space>l or <enter> (normal mode) to go the that path once edited.
    nmap <silent> <buffer> <space>a :exe 'norm gg' \| call search('Path') \| exe 'norm f]h'<cr>
    " <space>b Add the path to the favorites bar
    nmap <silent> <buffer> <space>b :cal g:VeAddToBar('favorites', g:VeFavoritesMaxLength) \| cal g:VeLs()<cr>
    " <space>B Delete the favorites
    nmap <silent> <buffer> <space>B :cal g:CfgSetItem(g:VeCfg, 'favorites', '') \| :cal g:VeLs()<cr>
    " <space>e Open file in new buffer
    nmap <silent> <buffer> <space>e :cal g:VeGetPath() \| exe 'e ' . g:VeFullPathS<cr>
    " <space>f Set filter to show only certain files
    nmap <silent> <buffer> <space>f :let g:VeFilter = input('Filter: ', g:VeFilter) \| cal g:VeLs()<cr>
    " <space>F Remove the filter and show all files
    nmap <silent> <buffer> <space>F :let g:VeFilter = '' \| cal g:VeLs()<cr>
    " <space>g Simple grep command to search the files in the current directory (not searching the subdirectories). The results are appended at the end of the buffer. After the results are appended, if you want to open a file that appears in the grep results do <space>l on the line where that file is, the file will be opened on a split window at the line number where that grep found the keywords.
    nmap <buffer> <space>g :cal g:VeGetPath() \| let k = input('grep files keywords: ') \| let i = input('include files: ', '*') \| if k != '' \| exe 'norm G' \| let n = line('.') \| exe 'r! ' . g:VeGrepCmdPath . ' -n -i ' .  k . ' ' . g:VePathS2Q . '/' . i  \| exe 'normal zR' . n . 'G' \| exe 'let @/="' . k . '"' \| exe 'normal n' \| endif<cr>
    " <space>G Simple grep command to search the files in the current directory and subdirectories. The results are appended at the end of the buffer. After the results are appended, if you want to open a file that appears in the grep results do <space>l on the line where that file is, the file will be opened on a split window at the line number where that grep found the keywords.
    if s:GrepCmdType == 'c'
        nmap <buffer> <space>G :cal g:VeGetPath() \| let k = input('+grep files keywords: ') \| let i = input('include files: ', '*') \| if k != '' \| exe 'norm G' \| let n = line('.') \| exe 'r! ' . g:VeGrepCmdPath . ' -n -i -r ' .  k . ' ' . g:VePathS2Q \| exe 'normal zR' . n . 'G' \| exe 'let @/="' . k . '"' \| exe 'normal n' \| endif<cr>
    elseif s:GrepCmdType == 'u'
        nmap <buffer> <space>G :cal g:VeGetPath() \| let k = input('+grep files keywords: ') \| if k != '' \| exe 'norm G' \| let n = line('.') \| exe 'r! ' . g:VeGrepCmdPath . ' -n -i -r ' .  k . ' ' . g:VePathS2Q \| exe 'normal zR' . n . 'G' \| exe 'let @/="' . k . '"' \| exe 'normal n' \| endif<cr>
    endif
    " <space>h Go to the parent directory
    nmap <silent> <buffer> <space>h :cal g:VeDirectoryGoto('..')<cr>
    " <space>l Open the selected item
    nmap <silent> <buffer> <space>l :cal g:VeOpenItem(0)<cr>
    " <space>L Open the selected item recursively (only the directory will open recursively, if the item is a file it will be opened like with <leader>l)
    nmap <silent> <buffer> <space>L :let g:VeRecursive = '-R' \| cal g:VeOpenItem(0)<cr>
    " <space>n New tab
    nmap <silent> <buffer> <space>n :tabnew<cr>
    " <space>o Reload directory
    nmap <silent> <buffer> <space>o :cal g:VeLs()<cr>
    " <space>o Reload configuration from file (useful if the .config.vim file was edited manually and you want to reload it in the vimExplorer window that is currently opened)
    nmap <silent> <buffer> <space>O :cal g:VeLoadFromFile(0)<cr>
    " <space>P Show current path
    nmap <silent> <buffer> <space>P :pwd<cr> 
    " <space>r Run file
    nmap <silent> <buffer> <space>r :cal g:VeGetPath() \| exe '! ' . g:VeFullPathB2Q<cr> 
    " <space>t Open file in new tab
    nmap <silent> <buffer> <space>t :cal g:VeGetPath() \| exe 'tabe ' . g:VeFullPathS<cr>
    " <space>v Open the selected item (in vertical split window)
    nmap <silent> <buffer> <space>v :cal g:VeOpenItem(1)<cr>
    " <space>s Save configuration file
    nmap <silent> <buffer> <space>s :cal g:VeSaveBar('History') \| cal g:VeSaveBar('Favorites') \| cal g:VeSaveToFile()<cr>
    " <space>H Delete the browsing history
    nmap <silent> <buffer> <space>H :cal g:CfgSetItem(g:VeCfg, 'history', '') \| :cal g:VeDirectoryGoto(g:VePath)<cr>

    " Mappings: Windows specific {{{3
    if has('Win32') == 1
        " <space>c Clone file
        nmap <silent> <buffer> <space>c :cal g:VeGetPath() \| let t = g:VeFileName . '_' . substitute(strftime('%x_%X'), ':', '-', 'g') \| exe '!copy ' . g:VeFileName2Q . ' "' . t . '"' \| cal g:VeLs() \| cal search(t)<cr>
        " <space>C Open directory in shell
        nmap <silent> <buffer> <space>C :exe '!cmd /k'<cr>
        " <space>d New directory
        nmap <silent> <buffer> <space>d :let t = input('Directory name: ') \| cal mkdir(t) \| cal g:VeLs() \| cal search(t)<cr>
        " <space>D Delete file/directory
        nmap <silent> <buffer> <space>D :cal g:VeGetPath() \| let r = input('Delete this directory/file [(y)es/(n)o]? ', '') \| if r == 'y' \| exe '!del /S/Q ' . g:VeFullPathB2Q \| exe '!rmdir /S/Q ' . g:VeFullPathB2Q \| endif \| cal g:VeLs()<cr>
        " <space>p Copy path
        nmap <silent> <buffer> <space>p :cal g:VeGetPath() \| let @* = g:VeFullPathB \| echo 'Path copied to clipboard: ' . g:VeFullPathB<cr>
        " <space>R Rename file
        nmap <silent> <buffer> <space>R :cal g:VeGetPath() \| let t = input('rename to: ', g:VeFileName) \| exe '!ren ' . g:VeFileName2Q . ' "' . t . '"' \| cal g:VeLs() \| cal search(t)<cr>
        " <space>x Open directory in windows explorer
        nmap <silent> <buffer> <space>x :cal g:VeGetPath() \| exe '!start explorer.exe ' . g:VePathB2Q<cr>) 

    " Mappings: Linux specific {{{3
    else
        " <space>c Clone file
        nmap <silent> <buffer> <space>c :cal g:VeGetPath() \| let t = g:VeFileName . "_' . substitute(strftime('%x_%X'), ':', '-', 'g') \| exe '!cp ' . g:VeFileName2Q . ' "' . t . '"' \| cal g:VeLs() \| cal search(t)<cr>
        " <space>C Open directory in shell
        nmap <silent> <buffer> <space>C :sh<cr>") 
        " <space>c New directory
        nmap <silent> <buffer> <space>c :let t = input("Directory name: ') \| cal mkdir(t) \| cal g:VeLs() \| cal search(t)<cr>
        " <space>D Delete file/directory
        nmap <silent> <buffer> <space>D :cal g:VeGetPath() \| let r = input("Delete this directory/file [(y)es/(n)o]? ', '') \| if r == 'y' \| exe '!rm ' . g:VeFullPathB2Q \| exe '!rmdir ' . g:VeFullPathB2Q \| endif<cr> \| cal g:VeLs()
        " <space>p Copy path
        nmap <silent> <buffer> <space>p :cal g:VeGetPath() \| let @* = g:VeFullPathS \| echo "Path copied to clipboard: ' . g:VeFullPathS<cr>') 
        " <space>R Rename file
        nmap <silent> <buffer> <space>R :cal g:VeGetPath() \| let t = input("rename to: ', g:VeFileName) \| exe '! mv ' . g:VeFileName2Q . ' "' . t . '"' \| cal g:VeLs() \| cal search(t)<cr>
        " <space>x Open directory in thunar
        nmap <silent> <buffer> <space>x :cal g:VeGetPath() \| exe "!thunar ' . g:VePathS2Q<cr>
    endif

    " Mappings: For marks (bookmarks) {{{3
    " Add mappings to mark directories (bookmark them) using vim markers style
    for n in range(0, 9)
      exe "nmap <silent> <buffer>m" . n . " :cal g:VeMarkPath('" . n . "')<cr>"
      exe "nmap <silent> <buffer>'" . n . " :cal g:VeGotoMark('" . n . "')<cr>"
      exe "nmap <silent> <buffer>`" . n . " :cal g:VeGotoMark('" . n . "')<cr>"
    endfor
    for n in range(1, 26)
      " uppercase  
      let l = nr2char(n + 64)
      exe "nmap <silent> <buffer>m" . l . " :cal g:VeMarkPath('" . l . "')<cr>"
      exe "nmap <silent> <buffer>'" . l . " :cal g:VeGotoMark('" . l . "')<cr>"
      exe "nmap <silent> <buffer>`" . l . " :cal g:VeGotoMark('" . l . "')<cr>"
      " lowercase  
      let l = nr2char(n + 96)
      exe "nmap <silent> <buffer>m" . l . " :cal g:VeMarkPath('" . l . "')<cr>"
      exe "nmap <silent> <buffer>'" . l . " :cal g:VeGotoMark('" . l . "')<cr>"
      exe "nmap <silent> <buffer>`" . l . " :cal g:VeGotoMark('" . l . "')<cr>"
    endfor
    "}}}
endfu
" Functions: Directory browsing {{{1

" s:GetFileName() {{{2
" Get the file name on the current line
fu! s:GetFileName()
    " Check if currently inside the directory listing, if the line is before the first line of the directory listing, return nothing
    if line('.') < s:DirectoryListLineNum
        return ''
    endif
    let fileName = ''
    " Get the line to check for patterns
    let line = getline(line('.'))
    let noFilterPattern = '[0-9]\s\w\{3\}\s\(\s\|[0-9]\)[0-9]\s\([0-9][0-9]:[0-9][0-9]\|\s[0-9]\{4\}\)\s\zs.*'
    let filterPattern = '^.*\/\zs.*$'
    " No filter used
    " -rw-r--r-- 1 User None 40960 Dec  7 14:46 vimExplorer.vim
    " Test from here ------------^ until here -^
    if line =~ noFilterPattern
        let fileName = matchstr(line, noFilterPattern)
    " A filter is used
    " -rwxr-xr-x 1 User None  536064 Feb  3  2009 C:/Usb/z_white/Apps/Portable/CmdUtils/7z.exe
    "^----- Test from here until here -------------------------------------------------^
    elseif  line =~ filterPattern
        let fileName = matchstr(line, noFilterPattern)
    endif
    retu fileName
endfu

" s:GetRecursivePath() {{{2
" Gets the current subdirectory path of a recursive listing that is displayed when the -R option is used 
" For example if the following subdirectory listing is displayed, then the c:/Temp\test path will be copied
" C:/Temp\test=:
" total 1
" drwxrwxrwx   1 user     group           0 Nov 20 21:49 .
" drwxrwxrwx   1 user     group           0 Dec 11 21:25 ..
" -rw-rw-rw-   1 user     group          15 Nov 19 21:45 test2.txt
fu! s:GetRecursivePath()
    " Remember current position
    norm m'
    " Search backwards if there is a place where there is a recusive path
    let match = search('^.*=:$', 'bW')
    " Not found
    if match == 0
        let path = ''
    " Found
    else
        " Backup register "
        let tmpReg = @" 
        " Copy the path to the " register
        norm yt=
        let path = @"
        " Set back register "
        let @" = tmpReg
        " Go back to previous position
        norm ''
    endif
    return path
endfu
" s:ChangeDirectory(path) {{{2
" Change directory
fu! s:ChangeDirectory(path)
    let path = a:path
    " If the path contains double / in case of root paths (c:/, d:/ etc) where usually paths don't end with a trailling /, root paths always have trailling /, so they may be one to many 
    if has("Win32") && len(g:VePath) == 3
        let path = substitute(path, '//', '/', 'g')
    endif
    " Change to the directory in vim
    exe 'cd ' . path
    " Get real path from vim without /../.. etc
    let path = getcwd()
    " Change to the directory in shell
    exe 'r! cd "' . path . '"'
    " If the path is with "\" the change them for "/"
    if stridx(path, '\') != -1
        let path = substitute(path, '\', '/', 'g')
    endif
    " Set the global path
    let g:VePath = path
endfu

" g:VeGetPath() {{{2
" To get the paths for external use
" If may be called to get path formats from a file in edition as well
fu! g:VeGetPath()
    " If the window is a vimExplorer window {{{3
    " Get the path from the directory listing information
    if s:IsPluginWindow() == 1
        " Attempt to get the current subdirectory path of a recursive listing that is displayed when the -R option is used 
        let path = s:GetRecursivePath()
        " If a path is found
        if path != ''
            " Set g:VePath to the current subdirectory path of the recursive listing
            let g:VePath = path
        endif
        " If root path in windows example c:/, then remove trailing slash, other paths don't have trailing slashes
        if has("Win32") && len(g:VePath) == 3
            let path = strpart(g:VePath, 0, 2)
        else
            let path = g:VePath
        endif
        let g:VeFileName = s:GetFileName()
    " If the window is not a vimExplorer window (like a file in edition for example) {{{3
    else
        " Get the path and filename for the current file
        let path = substitute(expand("%:p:h"), '\', '/', 'g')
        let g:VeFileName = expand("%:t")
    endif
    " Get the multiple path formats for the selected path to global variables for external use {{{3
    let g:VeFileNameQ = "'" . g:VeFileName . "'"
    let g:VeFileName2Q = '"' . g:VeFileName . '"'
    " With /
    let g:VePathS = path
    let g:VePathSQ = "'" . path . "'"
    let g:VePathS2Q = '"' . path . '"'
    let g:VeFullPathS = path . '/' . g:VeFileName
    let g:VeFullPathSQ = "'" . g:VeFullPathS . "'"
    let g:VeFullPathS2Q = '"' . g:VeFullPathS . '"'
    " With \
    let g:VePathB = substitute(path, '/', '\', 'g')
    let g:VePathBQ = "'" . g:VePathB . "'"
    let g:VePathB2Q = '"' . g:VePathB . '"'
    let g:VeFullPathB = g:VePathB . '\' . g:VeFileName
    let g:VeFullPathBQ = "'" . g:VeFullPathB . "'"
    let g:VeFullPathB2Q = '"' . g:VeFullPathB . '"'
    " With \\
    let g:VePath2B = substitute(path, '/', '\', 'g')
    let g:VePath2B = substitute(g:VePath2B, '\', '\\\\', 'g')
    let g:VePath2BQ = "'" . g:VePath2B . "'"
    let g:VePath2B2Q = '"' . g:VePath2B . '"'
    let g:VeFullPath2B = g:VePath2B . '\\' . g:VeFileName
    let g:VeFullPath2BQ = "'" . g:VeFullPath2B . "'"
    let g:VeFullPath2B2Q = '"' . g:VeFullPath2B . '"'
endfu

" g:VeLs() {{{2
" List the directory
fu! g:VeLs() 
    " Clear buffer
    norm ggVGd
    " List the directory
    " If not root path c:\ or another root, add quotes. Root path quoted ("c:\") will give an error. 
    " Or if there is a filter, then don't put quotes, quotes don't work in a filter
    if (has("Win32") && len(g:VePath) == 3) || g:VeFilter != ''
        " Set filter
        let filter = ''
        if g:VeFilter != ''
            let filter = '/' . g:VeFilter
        endif
        exe 'r! ' . s:LsCmdPath . ' -al ' . g:VeSort . ' ' . g:VeRecursive . ' ' . g:VePath . filter
    else
        " Don't use g:VePathS2Q here because the paths in g:VeGetPath() are not updated at this point, the listing as to be completed first because the function attempts to get the recursive paths is any
        exe 'r! ' . s:LsCmdPath . ' -al ' . g:VeSort . ' ' . g:VeRecursive . ' "' . g:VePath . '"'
    endif
    " Show the plugin name to identify the window as a vimExplorer window (the name could be shown in the status bar doing split vimExplorer but then a enew after it would remove the name, and without enew only two or more vimExplorer window would display the same content at the same time, being refreshed at the same time)
    cal append(0, 'vimExplorer')
    " Show path at the top of the buffer
    cal append(1, 'Path: [' . g:VePath . ']')
    " Show the history bar
    cal append(2, 'History: ' . g:CfgGetItem(g:VeCfg, 'history'))
    " Show the favorites bar
    cal append(3, 'Favorites: ' . g:CfgGetItem(g:VeCfg, 'favorites'))
    " Show the current sort order
    cal append(4, 'Sorted by: ' . g:VeSortLabel)
    " Go to first directory or first file
    exe 'norm gg' . s:DirectoryListLineNum . 'j'
    " Find remembered cursor line position in that directory and position the cursor there
    let fileName = g:CfgSectionGetItem(g:VeCfg, 'cursorPos', g:VePath)
    if fileName != ''
        cal search('\s' . fileName . '$')
        normal l
    endif
    " Set colors on specific items in the window {{{
    " The color constants are defined in the selected colorscheme.
    " Plugin name
    cal matchadd('Constant', '^vimExplorer$')
    " Path label
    cal matchadd('Constant', '^Path:')
    " History label
    cal matchadd('Constant', '^History:')
    " Favorites label
    cal matchadd('Constant', '^Favorites:')
    " Sort order label
    cal matchadd('Constant', '^Sorted by:')
    " Sort order
    cal matchadd('Comment', '^Sorted by: \zs.\{-}\ze$')
    " Directories
    cal matchadd('Directory', '^d.*$')
    " Grep results
    cal matchadd('htmlLink', '^.*\/.\{-}:[0-9]\+:\ze.*$')
    " Some files colors
    cal matchadd('Number', '^.\{-}.\(exe\|EXE\)$')
    cal matchadd('Statement', '^.\{-}.\(txt\|TXT\)$')
    " Links
    cal matchadd('htmlLink', '\[\zs.\{-}\ze\]')
    "}}}
    " Reinitialize the recursive option
    let g:VeRecursive = ''
    " Append debug info at the end of buffer
    cal append(line('$'), g:Debug)
endfu

" g:VeOpenItem(vSplit) {{{2
" Open the selected item
fu! g:VeOpenItem(vSplit)

    " Get the type of the current item {{{3
    " Get the line to check for patterns
    let line = getline(line('.'))
    " Variables used to check for a link
    let start = 0
    let end = 0
    " Check for directory pattern {{{4
    " Example: 'drwxrwxrwx  ' 
    if line =~ '^d.\{9}\s\s' 
        let itemType = 'd'
    " Check for file pattern {{{4
    " Example: '-rwxrwxrwx  ' 
    elseif line =~ '^-.\{9}\s\s' 
        let itemType = 'f'
    " Check for a grep result pattern {{{4
    " Example: 'C:/vim/vim73/plugin/dbext.vim:66:command! -range -nargs=0 DBExecRangeSQL <line1>,<line2>call dbext#DB_execRangeSql()'
    elseif line =~ '^.*\/.\{-}:[0-9]\+:.*$'
        let itemType = 'g'
    " Check for a link {{{4
    " Example of links are the path bar, history bar or the favorites bar at the top of the buffer, it contains the visited paths each one enclosed in []. These links could be elsewhere.
    " Example: ' [C:/Temp] [C:/vim/vim73/plugin]'
    elseif line =~ '\s\[.\{-}/.\{-}]'
        " Save cursor postion
        let previous = col('.')
        " Check if the "[" is the current character {{{5
        if strpart(line, previous - 1, 1) == '['
            let start = col('.')
        else " If it is not the current character, search backwards for "["
            call search('[', 'b')
            let start = col('.')
        endif
        " Return to previous column (position)
        exe 'norm ' . previous . '|'
        " Check if the "]" is the current character {{{5
        if strpart(line, previous - 1, 1) == ']'
            let end = col('.')
        else " If it is not the current character, search forward for "]"
            call search(']', '')
            let end = col('.')
        endif
        " Return to previous column (position)
        exe 'norm ' . previous . '|'
        if start != 0 && end != 0
            let itemType = 'l'
        endif
    " Item type undefined
    else
        let itemType = ''
    endif
    " Do actions according to the item type {{{3
    " Item is not undefined {{{4
    if itemType == ''
        " Simply load or reload with current path
        cal g:VeLs()
    " Item is a directory or a file {{{4
    elseif itemType == 'd' || itemType == 'f'
        let fileName = s:GetFileName()
        " Attempt to get the current subdirectory path of a recursive listing that is displayed when the -R option is used 
        let path = s:GetRecursivePath()
        " If a path is found
        if path != ''
            " Set g:VePath to the current subdirectory path of the recursive listing
            let g:VePath = path
        endif
        " Item is a directory {{{5
        if itemType == 'd'
            " Go to the directory
            cal g:VeDirectoryGoto(g:VePath . '/' . fileName)
        " Item is a file open the file {{{5
        elseif itemType == 'f' 
            if a:vSplit == 1
                exe 'vsplit ' g:VePath . '/' . fileName
            else
                exe 'split ' g:VePath . '/' . fileName
            endif
        endif
    " Item is a grep result {{{4
    elseif itemType == 'g'
        " Get the file path from the line
        let path = matchstr(line, '^\zs.*\/.\{-}\ze:[0-9]\+:.*$')
        " Get the line number from the line
        let lineNum = matchstr(line, '^.*\/.\{-}:\zs[0-9]\+\ze:.*$')
        " Open the file to the line number where the match was found
        exe 'split +' . lineNum . ' ' . path 
    " Item is a link {{{4
    elseif itemType == 'l'
        let path = strpart(line, start, abs(end - start) - 1)
        " Check if path exists
        if isdirectory(path) == 1
            " Go to the directory
            cal g:VeDirectoryGoto(path)
        endif
    endif
endfu

" g:VeDirectoryGoto(path) {{{2
" Go to specified directory
fu! g:VeDirectoryGoto(path)
    " Remember cursor line (name) position in that directory {{{
    let fileName = s:GetFileName()
    if fileName != ''
        cal g:CfgSectionSetItem(g:VeCfg, 'cursorPos', g:VePath, fileName)
    endif
    "}}}
    " Save the bars to the config before to clear the buffer
    cal g:VeSaveBar('History')
    cal g:VeSaveBar('Favorites')
    " Change directory
    cal s:ChangeDirectory(a:path)
    " Add the path to the browsing history
    cal g:VeAddToBar('history', s:HistoryMaxLength)
    " List the directory
    cal g:VeLs()
endfu

" g:VeAddToBar() {{{2
" Add the path to one of the bar at the top of the buffer
fu! g:VeAddToBar(barName, barMaxLength)
    " The paths are appended in the reverse order so the newest paths appear first in the list
    let tmp = '[' . g:VePath . ']' . ' ' . g:CfgGetItem(g:VeCfg, a:barName) 
    " Check if favorites dosen't become too much long
    if len(tmp) > a:barMaxLength
        " If bar is more long than max length allowed, then empty it and put the last path inside
        let bar = '[' . g:VePath . ']'
    else
        " If history not too long, then add the last path
        let bar = tmp
    endif
    " Add bar to configuration dictionnary
    cal g:CfgSetItem(g:VeCfg, a:barName, bar)
endfu

" Functions: Directory marks {{{1

" g:VeMarkPath(mark) {{{2
" Mark the current directory with the specified mark, keep the directory in memory
fu! g:VeMarkPath(mark)
    cal g:CfgSectionSetItem(g:VeCfg, 'marks', a:mark, g:VePath)
endfu

" g:VeGotoMark(mark) {{{2
" Change directory according to the path for specified mark
fu! g:VeGotoMark(mark)
    let path = g:CfgSectionGetItem(g:VeCfg, 'marks', a:mark)
    if path != ''
        " Go to the directory
        cal g:VeDirectoryGoto(path)
    endif
endfu

" g:VeShowMarks(sortByPath) {{{2
" Show all marked directories
" Listing may be shown sorted by marks or by path
fu! g:VeShowMarks(sortByPath)
    let marks = g:CfgGetSection(g:VeCfg, 'marks')
    if !empty(marks)
        if a:sortByPath == 0
            for key in sort(keys(marks))
                echo key . ' = ' . marks[key]
            endfor
        else " a:sortByPath == 1
            let sortList = []
            " Put vals and keys to a list for sorting, because in a dictionary its impossible it seems to sort with both key AND val at the same time
            for [key, val] in items(marks)
                call add(sortList, val . ' = ' . key)
            endfor
            " Echo the sorted list
            for val in sort(sortList)
                echo val
            endfor
        endif
        let m = input("Enter mark:" ) 
        if m != ''
            exe "cal g:VeGotoMark('" . m . "')"
        endif
    endif
endfu

" Functions: Directory favorites {{{1
" g:VeFavPath(mark) {{{2
" Put the current directory in the favorites bar
fu! g:VeFavPath()
    cal g:CfgSectionSetItem(g:VeCfg, 'favorites', g:VePath, g:VePath)
endfu


" Functions: Configuration {{{1

" g:VeLoadFromFile() {{{2
" Load configuration from file
fu! g:VeLoadFromFile(restoreLastPath)
    " Load the configuration from a file
    let g:VeCfg = g:CfgLoadFromFile(g:VeCfgFile)
    " The last path is only restore when the plugin is loaded with vim, not when the user load it using the mapping
    if a:restoreLastPath == 1
        " Restore the last accessed path, do <leader>VE to start the plugin using this path
        let g:VePath = g:CfgGetItem(g:VeCfg, 'lastPath')
    endif
    echo 'Configuration loaded from: ' . g:VeCfgFile
endfu

" g:VeSaveToFile() {{{2
" Save configuration to file
fu! g:VeSaveToFile()
    " Add last accessed path so next time <leader>VE will open on that path
    cal g:CfgSetItem(g:VeCfg, 'lastPath', g:VePath)
    " Save the configuration to a file
    cal g:CfgSaveToFile(g:VeCfg, g:VeCfgFile)
    echo 'Configuration saved to: ' . g:VeCfgFile
endfu

" g:VeSaveBar(barName) {{{2
" This function saves the history bar or the favorites bar to the config file. This allows the user to edit these bars and manually (to remove, add or move paths).
fu! g:VeSaveBar(barName)
    " Save cursor position
    let savedPosition = getpos(".")
    " Go to the history bars
    norm gg
    " Check if the bar is found
    if search(a:barName) != 0
        " Get the line
        let line = getline(line('.'))
        " Remove the barName from the line
        let bar = substitute(line, a:barName . ': ', '', '')
        " Add bar to configuration dictionnary
        cal g:CfgSetItem(g:VeCfg, tolower(a:barName), bar)
    endif
    " Go back to previous position
	cal setpos('.', savedPosition)
endfu
" Functions: Configuration Utility: Persistance {{{1

" g:CfgLoadFromFile(file) {{{2
" Load a configuration from file (.vim file) 
fu! g:CfgLoadFromFile(file)
    if filereadable(a:file)
        try
            exe "source " . a:file
            let cfg = deepcopy(g:Cfg)
        catch
            let cfg = {}
        finally
            unlet! g:Cfg " Free memory
            return cfg
        endtry
    else
        return {}
    endif
endfu

" g:CfgSaveToFile(cfg, file) {{{2
" Save a dictionnary to file (.vim file)
fu! g:CfgSaveToFile(cfg, file)
    let file = substitute(a:file, '/', '\', 'g')
    let file = substitute(file, '\', '\\', 'g')
    " Echo the configuration dictionary to file
    exe "redir! > " . file
    silent echo a:cfg
    redir END
    " Read the file back to a variable
    let cfg = readfile(file)
    " Add the global g:Cfg variable name
    let cfg[1] =  'let g:Cfg = ' . cfg[1]
    " Add comment to the config file
    let cfg[0] = '" Configuration file used by vim "vimExplorer.vim" plugin. "g:Cfg" is a global dictionary that is used to load and save configurations from files.'
    cal writefile(cfg, file, 'b')
endfu

" Functions: Configuration Utility: Item {{{1

" g:CfgGetItem(dict, itemKey) {{{2
" Get an item value
fu! g:CfgGetItem(dict, itemKey)
    if has_key(a:dict, a:itemKey)
        return a:dict[a:itemKey]
    else
        return ''
    endif
endfu

" g:CfgSetItem(dict, itemKey, itemValue) {{{2
" Set a value to a item
fu! g:CfgSetItem(dict, itemKey, itemValue)
    let itemValue = a:itemValue
    " Double ' if any because values are delimited by ''
    if stridx(a:itemValue, "'") != -1
       let itemValue = substitute(itemValue, "'", "''", "g") 
    endif
    cal extend(a:dict, {a:itemKey : a:itemValue}, 'force')"
endfu

" Functions: Configuration Utility: Section {{{1

" g:CfgGetSection(dict, sectionKey) {{{2
" Get a entire section
fu! g:CfgGetSection(dict, sectionKey)
    if has_key(a:dict, a:sectionKey)
        return a:dict[a:sectionKey]
    else
        return {}
    endif
endfu

" g:CfgSectionGetItem(dict, sectionKey, itemKey) {{{2
" Get a value from a section
fu! g:CfgSectionGetItem(dict, sectionKey, itemKey)
    if !has_key(a:dict, a:sectionKey)
        return ''
    endif
    if !has_key(a:dict[a:sectionKey], a:itemKey)
        return ''
    endif
    let section = a:dict[a:sectionKey] 
    return section[a:itemKey]
endfu

" g:CfgSectionSetItem(dict, sectionKey, itemKey, itemValue) {{{2
" Set a value to a section
fu! g:CfgSectionSetItem(dict, sectionKey, itemKey, itemValue)
    " Add the section if it dosen't exist
    if !has_key(a:dict, a:sectionKey)
        cal extend(a:dict, {a:sectionKey : {}}, 'force')"
    endif
    " Get the section
    let section = a:dict[a:sectionKey]
    " Set the section item
    cal extend(section, {a:itemKey : a:itemValue}, 'force')"
    " Set the section
    cal extend(a:dict, {a:sectionKey : section}, 'force')"
endfu
" Menu {{{1
" <url:vimscript:echo   'variables'             | exe 'vimgrep /^let.*/gj %' | copen>
" <url:vimscript:echo   'calls'                 | exe 'vimgrep /\\(cal\\|cal\\)\\(!\\|\\s\\).*/gj %' | copen>
" <url:vimscript:echo   'functions'             | exe 'vimgrep /\\(fu\\|fun\\|function\\)\\(!\\|\\s\\).*/gj %' | copen>
