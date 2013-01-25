" The vimExplorer.vim plugin code is following this code inserted here from the basicXmlParser.vim plugin
" The basicXmlParser.vim plugin is added here before the vimExplorer.vim plugin to ensure compatibility. But it is available also as a separate plugin. If you have basicXmlParser.xml plugin in your plugin directory, you should remove it or it may conflict with this version.
" Documentation {{{1
"
" Name: basicXmlParser.vim
" Version: 1.2
" Description: Plugin create object trees and get them or save them as xml, and to create object trees from a xml files. May be used as an object tree, the xml is the file format for load and save the object tree from and to a file. Serialization to xml is optional, the user is not required to load or to save to xml, the tree may be builded manually or programmatically. This plugin was created as a utility plugin to load and save configuration files. See the usage section on how to use the plugin.
" Author: Alexandre Viau (alexandreviau@gmail.com)
" Installation: Copy the plugin to the vim plugin directory.
" Website: The latest version is found on "vim.org"
"
" Usage: {{{2

" The following examples create, save to file and load from file the following xml tree: {{{3
"
" <root>
"    <Marks>
"       <A>
"          C:\Usb\i_green\apps
"          <myLevel3>
"             myLevel3Value
"             <myLevel4>
"                myLevel4Value
"             </myLevel4>
"          </myLevel3>
"       </A>
"       <B>
"          C:\Users\User\Desktop\
"       </B>
"       <C>
"          C:\
"       </C>
"    </Marks>
"    <LastPath>
"       d:\
"    </LastPath>
" </root>

" <item name="root">
"    <item name="Marks">
"       <item name="A">
"          C:\Usb\i_green\apps
"          <item name="myLevel3">
"             myLevel3Value
"             <item name="myLevel4">
"                myLevel4Value
"             </item>
"          </item>
"       </item>
"       <item name="B">
"          C:\Users\User\Desktop
"       </item>
"       <item name="C">
"          C:\
"       </item>
"    </item>
"    <item name="LastPath">
"       d:\
"    </item>
" </item>
"
"
" Create object trees and get them or save them as xml {{{3
"
" NOTE: Since the objects are really dictionaries, vim offers 2 syntaxes to interact with their content. One is like this for example "myRoot.LastPath.Value" the other is "myRoot['LastPath'].Value", in the following examples the first syntax is used but the second would work too.
"
" Root level
" let myRoot = g:Item.New()

" First level
" cal myRoot.Add(g:Item.New2('LastPath', 'd:\'))
" echo myRoot.LastPath.Value

" cal myRoot.Add(g:Item.New1('Marks'))
" echo myRoot.Marks.Value

" Second level
" cal myRoot.Marks.Add(g:Item.New2('A', 'C:\Usb\i_green\apps'))
" cal myRoot.Marks.Add(g:Item.New2('B', 'C:\Users\User\Desktop'))
" cal myRoot.Marks.Add(g:Item.New2('C', 'C:\'))
" echo myRoot.Marks.A.Value
" echo myRoot.Marks.B.Value
" echo myRoot.Marks.C.Value
" Show how many items there is in the second level
" echo myRoot.Marks.Count()

" Third level
" cal myRoot.Marks.A.Add(g:Item.New2('myLevel3', 'myLevel3Value'))
" echo myRoot.Marks.A.myLevel3.Value
" Show how many items there is in the third level
" echo myRoot.Marks.A.Count()

" Fourth level
" cal myRoot.Marks.A.myLevel3.Add(g:Item.New2('myLevel4', 'myLevel4Value'))
" echo myRoot.Marks.A.myLevel3.myLevel4.Value

" To get the xml as a list
" let myXmlList = myRoot.ToXmlList()
" echo myXmlList

" To save the xml to a file
" cal myRoot.SaveToXml('c:/temp/cfg.xml')

" Remove an item
" cal myRoot.Marks.Remove('A')
" echo myRoot.Marks.A.Value " Should give an error saying that the key cannot be found

" Check for existance of an item
" if myRoot.Marks.Contains('A') == 1
"   echo "Contains the item A"
" else
"   echo "Dosen't contain the item A"
" endif

" Example to copy from third level to a new root. The "Clone()" method does a complete copy of the current item, without cloning, the affected variable becomes a refrence and modifying it would modify the original item as well. So use the "Clone()" methods if an independent copy is needed.
" let myRoot2 = myRoot.Marks.A.myLevel3.Clone()
" Display value from new root, now what was 4th level is now first level
" echo myRoot2.myLevel4.Value

" Create object trees from a xml files {{{3
"
" NOTE: Since the objects are really dictionaries, vim offers 2 syntaxes to interact with their content. One is like this for example "myRoot.LastPath.Value" the other is "myRoot['LastPath'].Value", in the following examples the first syntax is used but the second would work too.
" 
" Load the file created in the previous example
" let myRoot2 = g:Item.LoadFile('c:/temp/cfg.xml')
 
" Show some elements from the loaded xml file
" echo myRoot2.LastPath.Value
" echo myRoot2.Marks.A.Value
" echo myRoot2.Marks.B.Value
" echo myRoot2.Marks.A.myLevel3.Value
" echo myRoot2.Marks.A.myLevel3.myLevel4.Value
" echo myRoot2.Marks.C.Value
" echo myRoot2.Marks.Value
" 
" Create object trees from expressions {{{3
" 
" There is another way of creating the object trees using expressions, the "g:RootItem.LoadFile()" function is an example how to do this. By expressions, I mean that something like exe 'cal items.Items' . level . '.Add(g:Item.New("' . tag . '", ""))' may be used where the "level" variable would contain a string of the path to the items like for example "myItem1.Items.myItem2.Items".
" Todo: {{{2
" Code organization {{{3
" - Add error handling (try..catch), example in the g:Item.Add() function which cannot have a "a:item.GetName()" empty
" Documentation {{{3
" - Give examples how to iterate items in the usage section IF the iterator cannot be realize because of time or functionnality. Add loop examples in the documentation, how to loop sub items in an item. Take example code from vimExplorer.
" Improvements to current features {{{3
" - Automatically put every tag and values each on his own line (it should be like this to be parsed correctly)
" - Get multiline values inside tags
" - Maybe find a way that to get or set a value that does not exist a check and creation would not be needed in the client code (maybe through a function)
" New features {{{3
" - Add some kind of iterator (like in the configuration utility with an ienumerator syntax) to loop the items (without having to check in the client code that the value is a dictionary) See ShowMarks function in vimExplorer where a check for dictionary type is needed and checking if dictionary empty and also a key, value foreach loop dosen't work, the value is not set and there is need to get it using the full g:VeCfg.Mark[key].Value. Or at least find a way to filter out the items that are not dictionaries using the filter command.
"
" Bugs: {{{2
" - No known bugs for now.
"
" History: {{{2
"
" 1.0 {{{3 
" - Initial release
" 1.1 
" - Added a function to remove items from the tree "g:Item.Remove(name)" by specifying its name in parameter
" - Added the "Contains(name)" function to check existance of an item
" - Changed the file format to display the xml tree with each tag being an "item" tag having a name attribute instead of having the name as the tag itself. One avantage of this format is to being able to have a "/" in the tag name. So a xml tree formely in a format like this:
" <root>
"    <Marks>
"       <A>
"          C:\Usb\i_green\apps
"          <myLevel3>
"             myLevel3Value
"             <myLevel4>
"                myLevel4Value
"             </myLevel4>
"          </myLevel3>
"       </A>
"       <B>
"          C:\Users\User\Desktop\
"       </B>
"       <C>
"          C:\
"       </C>
"    </Marks>
"    <LastPath>
"       d:\
"    </LastPath>
" </root>
"
" is now in a format like this:
"
" <item name="root">
"    <item name="Marks">
"       <item name="A">
"          C:\Usb\i_green\apps
"          <item name="myLevel3">
"             myLevel3Value
"             <item name="myLevel4">
"                myLevel4Value
"             </item>
"          </item>
"       </item>
"       <item name="B">
"          C:\Users\User\Desktop
"       </item>
"       <item name="C">
"          C:\
"       </item>
"    </item>
"    <item name="LastPath">
"       d:\
"    </item>
" </item>
" 1.2 
" - Added organization in the todo, bugs and history sections of the documentation
"
" Class Item {{{1

" Define the class as a dictionnary
let g:Item = {}

" Variables {{{2
let s:Level = 0

" Constructors {{{2

" g:Item.New() {{{3
" Constructor for root item
function! g:Item.New() dict
    " Reset the item depth level when the root item is created
    let s:Level = 0
    return g:Item.New2('root', '')
endfunction

" g:Item.New1(name) {{{3
function! g:Item.New1(name) dict
    return g:Item.New2(a:name, '')
endfunction

" g:Item.New2(name, value) {{{3
function! g:Item.New2(name, value) dict
    " Member variables
    " Double the apostrophes because names and values are delimited by single quotes
    let self.name = a:name
    let self.Value = a:value
    let self.level = 0
    " Create the new object
    return deepcopy(self)
endfunction

" Properties {{{2

" g:Item.GetName() {{{3
function! g:Item.GetName() dict
    return self.name
endfunction

" g:Item.GetLevel() {{{3
function! g:Item.GetLevel() dict
    return self.level
endfunction

" g:Item.SetLevel(value) {{{3
function! g:Item.SetLevel(value) dict
    let self.level = a:value
endfu

" g:Item.Count() {{{3
function! g:Item.Count() dict
    let nbItems = 0
    " Count the number items already
    for key in keys(self)
        " If the type is a dictionary. See :h type
        if type(self[key]) == type({})
            let nbItems += 1 
        endif
    endfor
    return nbItems
endfunction

" Methods {{{2

" g:Item.Add(item) {{{3
" Add a new item
function! g:Item.Add(item) dict
    " If this is the first item added, it means it is a new level, so increase the level number.
    if self.Count() == 0
        let s:Level = s:Level + 1
    endif
    " Set the item's level to the current containing item's level + 1 because it is a contained item.
    cal a:item.SetLevel(self.GetLevel() + 1)
    " Add the item (double the apostrophes)
    exe "call extend(self, {'" . substitute(a:item.GetName(), "'", "''", 'g') . "':a:item}, 'force')"
endfunction

" g:Item.Remove(name) {{{3
" Remove an item by passing its name in parameter
function! g:Item.Remove(name) dict
    if has_key(self, a:name)
        cal remove(self, a:name)
    endif
endfunction

" g:Item.RemoveAll() {{{3
" Remove all items
"function! g:Item.RemoveAll() dict
"    for key in keys(self)
"        " If the type is a dictionary
"        if type(self[key]) == type({})
"            cal remove(self, self[key])
"        endif
"    endfor
"endfunction

" g:Item.Contains(name) {{{3
fu! g:Item.Contains(name)
    if has_key(self, a:name)
        return 1
    else
        return 0
    endif
endfu

" g:Item.ToXmlListR(item, xmlList) {{{3
" Recusive function to go through all items levels
function! g:Item.ToXmlListR(item, xmlList)
    for key in keys(a:item)
        " If the type is a dictionary
        if type(a:item[key]) == type({})
            " Get the tabs for indentation
            let tabs = ''
            for i in range(1, a:item[key].GetLevel())
               let tabs .= '   '    
            endfor
            cal add(a:xmlList, tabs . '<item name="' . a:item[key].GetName() . '">')
            if a:item[key].Value != ''
                cal add(a:xmlList, tabs . '   ' . a:item[key].Value)
            endif
            " Recursive call
            cal g:Item.ToXmlListR(a:item[key], a:xmlList)
            cal add(a:xmlList, tabs . '</item>')
        endif
    endfor
endfunction

" g:Item.ToXmlList() {{{3
" To return the items as a list containing xml data
function! g:Item.ToXmlList() dict
    let xmlList = []
    cal add(xmlList, '<item name="' . self.name . '">')
    cal self.ToXmlListR(self, xmlList)
    cal add(xmlList, '</item>')
    return xmlList
endfunction


" g:Item.SaveToXml(file) {{{3
function! g:Item.SaveToXml(file) dict
    cal writefile(self.ToXmlList(), a:file)
endfunction

" g:Item.LoadFile(file) {{{3
" Load items from xml file
function! g:Item.LoadFile(file) dict
    " Check if the file exists {{{4
    if !filereadable(a:file)
        return {}
    endif

    " Load the xml file {{{4
    let xmlList = readfile(a:file)

    " Each new tag encountered is added to this list as a level deeper into the tree {{{4
    let levelTags = []

    " Remove "root" tag in the xml file {{{4
    cal remove(xmlList, len(xmlList) - 1)
    cal remove(xmlList, 0)

    " Put every tag and values each on his own line in the "xmlList" list {{{4
    " Here to put code to automatically put every tag and values each on his own line (it should be like this to be parsed correctly)

    " Create the root item {{{4
    let myRoot = g:Item.New()

    " Parse the xml tree {{{4
    " Go throught all the tags and values contained in the xml tree, each tag and values are on their own line in the "xmlList" list
    for line in xmlList
        " Remove indentation {{{5
        let line = substitute(line, "^\\s\\+", '', '')
        " End tag {{{5
        let tagType = strpart(line, 0, 2)
        if tagType == '</'
             " The last tag added is removed {{{6
             cal remove(levelTags, len(levelTags) - 1)
        else
             " Start tag {{{5
             let tagType = strpart(line, 0, 1)
             if tagType == '<'
                 " Get text inside de tag {{{6
                 "let tag = strpart(line, 1, len(line) - 2)
                 " Get the name attribute example: <item name="MyName">
                 let tag = strpart(line, 12, len(line) - 14)
                 " Add the tag as an item {{{6
                 let level = join(levelTags, '')
                 exe 'cal myRoot' . level . '.Add(g:Item.New1("' . tag . '"))'
                 " Add a level {{{6 
                 cal add(levelTags, '["' . tag . '"]')
             " Data {{{5
             else
                " Set the value of the last item (tag) added {{{6
                " Enclose the value in single quotes in case there is a value containing "\" which is not an escape character using single quotes
                exe 'let myRoot' . level . '["' . tag . '"].Value = ''' . substitute(line, "'", "''", 'g') . "'"
             endif
         endif
    endfor
    " Return the root object {{{4
    return myRoot
endfu

" g:Item.Clone() dict {{{3
" Return a copy of the current item
function! g:Item.Clone() dict
    return deepcopy(self)
endfunction

" Documentation {{{1

" Name: vimExplorer.vim
" Version: 2.3
" Description: Explore directories quickly and operate on files.
" Author: Alexandre Viau (alexandreviau@gmail.com)
" Website: The latest version is found on "vim.org"
"
" About {{{2 
"
" I would like if vimExplorer would become an open source, cross-platform, text and keyboard oriented filemanager alternative. It is now in that direction since version 2.0 vimExplorer is able to open, copy, move, delete, delete, run files and more. Using vim and its amazing text editing power and keyboard mapping habilities as an interface and numerous powerful shell commands for file management makes vimExplorer the ideal solution for fast and flexible file editing and management. I put a lot of thinking to make it as much comfortable, fast and easy to use as possible. With vimExplorer I try also to solve the difficulties (if I may say so) of file system access from vim (to find files, open them for edition, etc). Also to be able to do file management, grepping and searching from within vim without having to use an external program or shell could potentially increase productivity.

" Installation {{{2
"
" - Copy the plugin to the vim plugin directory. 
" - If you use the plugin in Windows, you will have to change the value of the "g:VeLsCmdPath" to that of the path where your ls command is located. Search for the variable using: /let g:VeLsCmdPath (You may also set that variable to 'ls' simply and set the path to the executable using the system %path% variable)
" - There are mappings (<space>9 and <space>0) to switch between the ls command from "UnxUtils" or the ls command from "Cygwin". So you may use both like I do by setting a path for each of these variables "g:VeLsCmdPathU" and "g:VeLsCmdPathC". I personally use the ls command from "UnxUtils" for speed, and the ls command from "Cygwin" to display russian alphabet. I use these mappings to switch from one to another depending if I need they are file and directory names that are written with the russian alphabet.
" - If you use the plugin in Windows, you will have to change also the value of the "g:VeGrepCmdPath" to that of the path where your grep command is located. Search for the variable using: /let g:VeGrepCmdPath (You may also set that variable to 'grep' simply and set the path to the executable using the system %path% variable)
" - vimExplorer requires depends on the "basicXmlParser.vim" plugin which is included at the top of this file to ensure compatibility and presence of the plugin.
"
" Usage {{{2
"
" Mappings: {{{3
"
" Open vimExplorer using the last accessed path {{{4

" <leader>ve Start vimExplorer in the current window
" <leader>vs Start vimExplorer in a new split (horizontal) window
" <leader>vv Start vimExplorer in a new vsplit (vertical) window
" <leader>vt Start vimExplorer in a new tab
"
" <leader>vd Start vimExplorer in double vertical panes (for file copy, move etc)
" <leader>vh Start vimExplorer in double horizontal panes (for file copy, move etc)
" <leader>vf Start vimExplorer with four panes (for file copy, move etc)
" <leader>vx Start vimExplorer with six panes (for file copy, move etc)
"
" NOTE: 1. There are other suggested mappings commented out where the preceding mappings are defined, to open vimExplorer in one key press. See "other suggested mappings" sections below in this documentation section.
"       2. You may create the number of panes vertical or horizontal you want by mixing the VimExplorerT, VimExplorerV and VimExplorerS in a command or a mapping you would add yourself to your vimrc. See the <leader>vd and <leader>vh mappings in this plugin as examples, these only use a combination of VimExplorerT and VimExplorerV or VimExplorers to create the panes. You may even have 4 or 6 panes even, as much as you need.
"
" Open vimExplorer using a the current file's path {{{4

" <leader>VE Start vimExplorer in the current window
" <leader>VS Start vimExplorer in a new split (horizontal) window
" <leader>VV Start vimExplorer in a new vsplit (vertical) window
" <leader>VT Start vimExplorer in a new tab
"
" NOTE: With all directories, files and links (underlined text), all actions like <space>t (open in new tab), <space>v (open in vertical split), <space>s (open in split), <space>r (run), work with them. See "File operations"  section below for more of these actions and their definitions.
"
" Directory browsing {{{4
"
" <space>l Open the selected directory or file (works also in the history bar and favorites bar at the top of the buffer and for grep results)
" <space>h Go to the parent directory
"
" <s-j> (shift-j) To open the next file in the preview window. You may hold the shift key then press many times j to preview one file after another. It will open the file and then pass to the next file, I found it better than to pass to the next file and open it because if you position the cursor on a file you do shift-j instead to have to do <enter> of <space>l to open the file then shift-j for next files.
" <s-k> (shift-k) Go open the previous file in the preview window. You may hold the shift key then press many times k to preview one file after another. It will open the file and then pass to the previous file, I found it better than to pass to the previous file and open it because if you position the cursor on a file you do shift-k instead to have to do <enter> of <space>l to open the file then shift-k for previous files.
"
" <space>a Go to the path at the top of the buffer to edit it. Press <space>l or <enter> (in normal mode) to go the that path once edited.
" <space>f Set filter to show only certain files
" <space>F Remove the filter and show all files
" <space>L Open the selected directory recursively
" <space>o Reload directory
" <space>p Copy path
" <space>P Show current path in different formats and to the clipboard
" <space>x Open directory in external file manager
" <space>X Open current directory with the gvim "browse" command to open a file in the current buffer
" <space>z Return to last path visited (toggle current and last)
" <space>9 If Windows is used to change the ls command for "UnxUtils" ls command
" <space>0 If Windows is used to Change the ls command for "Cygwin" ls command
" NOTE: 1. You may write or edit a path manually in the "Path: " bar at the top of the buffer. Once the path is entered, press <space>l or <enter> to go to that path.
"       2. You may change the path of the external file manager in the <space>x mapping.
"       3. Some file operations mappings work with the directories as well for example: <space>t to open in new tab, <space>x to open in external filemanager (check the "File operations" below)
"
" Browsing history {{{4
"
" <space>l or <enter> Go to one of the history path shown at the top of the buffer, put cursor on one of the paths and execute this mapping.
" <space>; Go to the history list (then do ; or , (from the vim 'f' command) to move forward and backward from one path to another, then when on the desired path, do <space>; to goto the directory.)
" <space>, Go to the end of the history list (then do ; or , (from the vim 'f' command) to move forward and backward from one path to another, then when on the desired path, do <space>, to goto the directory.)
" <space>H Delete the browsing history
" NOTE: 1. You may edit the history bar at the top of the buffer, you may add, remove or move paths on this line, it will be saved automatically when changing directory or doing <space>s to save the configuration or when vim quits if the cursor is in a vimExplorer window.
"       2. The maximum length of the history bar may be changed by setting the "s:HistoryMaxLength" variable
"       3. You may use the "set wrap" command to see all history if the list is long
"       4. Some file operations mappings work with the links in these history links for example: <space>t to open in new tab, <space>r to run, <space>x to open in external filemanager (check the "File operations" below)
"
" Directory bookmarks {{{4
"
" ma to mz Directory marks like similar to marks in vim using the m key but to mark directories instead of positions in files and ' or ` or ; to return to that directory. The maps are automatically activated on a directory listing. For example, press mw to mark the c:\windows directory, then do 'w (or `w or ;w) to return to that directory. All letters may be used from a to z, A to Z and 0 to 9. Press '' to view a list of all the bookmarked directories sorted by mark, or press ;; to view the same list but sorted by paths. When '' or ;; is pressed, the list is shown and a mark is asked as input to goto to its directory, this is another way that marks are used.
" m0 to m9 Same like ma to mz but using numbers as marks
" 'a to 'z or `a to `z To return to the directories marked by ma to mz  
" '0 to '9 or `0 to `9 Same like ma to mz but using numbers as marks
" <space>' Show all marked directories sorted by marks
" <space>` Show all marked directories sorted by marks
" <space>[ Show all marked directories sorted by directories
"
" Directory favorites {{{4
"
" <space>b Add the path to the favorites bar
" <space>B Add the full path with the filename to the favorites bar (this allows to add "shortcuts" to files to run a file or to open a file)
" NOTE: 1. The favorites bar is another way of bookmarking directories. It is independant from the directory bookmarks (marks) showned above. It is a feature on its own.
"       2. You may edit the favorites bar at the top of the buffer, you may add, remove or move paths on this line, it will be saved automatically when changing directory or doing <space>s to save the configuration or when vim quits if the cursor is in a vimExplorer window.
"       3. Some file operations mappings work with the links in these favorites links for example: <space>t to open in new tab, <space>r to run, <space>x to open in external filemanager (check the "File operations" below)
"       4. The favorites bar dosen't have a mapping to delete the bar like the history have <space>H. To delete the favorites bar, simply delete all the links from it and save the configuration (<space>s)
"
" Directory file grep {{{4
"
" <space>g Grep current file/directory or the selected files/directories
" The grep results appear after the file listing in the same buffer. You may position the cursor on a line in these results and press <space>l or <enter> to view it in the preview window.
" NOTE: 1. Some file operations mappings work with the links in these grep results links for example: <space>t to open in new tab, <space>r to run, <space>x to open in external filemanager (check the "File operations" below)
"
" Directory file search {{{4
"
" <space>L  To search files in a directory, open the selected directory recursively using <space>L and then search the buffer for the file using vim's "/" command or use vimgrep.
" NOTE: 1. Some file operations mappings work with the files and directories in these recursive listings for example: <space>t to open in new tab, <space>r to run, <space>x to open in external filemanager (check the "File operations" below)
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
" <space>c Clone file
" <space>d New directory
" <space>D or <delete> Delete current file/directory or selected files/directories
" <space>l or <enter> Open the selected item in preview window
" <space>n New file
" <space>r Run the current file or the selected files
" <space>R Rename file
" <space>s or <enter> Open file in preview window
" <space>t Open current file/directory or selected files/directories in new tab
" <space>v Open file in vertical split window
"
" File selection operations {{{4
"
" Operation that can be done on a group of selected files/directories include for now: copy, move, delete, grep, open in new tab, run and a user defined command that a user can use to put the command he wants inside to execute on the selected files. 
"
" <esc> Remove file selection
" <c-s> Toggle select/deselect selected the file or files (if there are files selected in visual mode) to do an operation on it like copy, move, delete, grep etc
" <c-c> Copy files, toggle select/deselect the file or files (if there are files selected in visual mode) and select the copy command as the command to run 
" <c-x> Move files, toggle select/deselect the file or files (if there are files selected in visual mode) and select the move command as the command to run 
" <c-v> Paste files, RunCommand in the target directory (usually a paste command which is the copy or move itself). The target directory is simply a directory where the user goes after (in another window or in the same window).
" <c-u> Run the user defined command (the user may set a command to it to run on the selected files) See section "How to run user-defined commands on selected files"
"
" NOTE: 1. Set the variable "s:ShowLastCommands" to 1 if you want to see the last commands executed (appended at the end of the buffer after the file listing)
"       2. Since <c-v> is used to paste, use <c-q> to do a block selection in a vimExplorer window.
"
" Shell operations {{{4
"
" <space><esc> Execute a command and insert its output in the buffer
" <space>C Open directory in shell
"
" Configuration file operations {{{4
"
" <space>O Reload configuration from file (useful if the .config.vim file was edited manually and you want to reload it in the vimExplorer window that is currently opened)
" <space>S Save configuration file

" NOTE: 1. The configuration is automatically loaded when vim starts, and it is automatically closed when vim quits.
"       2. You may open the configuration file for edition, and after editing and saving the file, return to a vimExplorer window and do <space>O to reload the new configuration file.
"
" To debug {{{4
"
" <leader>des To inspect the content of the g:VeSelectedFile object
" <leader>dec To inspect the content of the g:VeCommands object
" <leader>der To inspect the content of the g:VeCommandToRun object
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
"
" Open vimExplorer using a path specified on the command line {{{4
"
" VimExplorerBP Start vimExplorer in the current window
" VimExplorerSP Start vimExplorer in a new split (horizontal) window
" VimExplorerVP Start vimExplorer in a new vsplit (vertical) window
" VimExplorerTP Start vimExplorer in a new tab
"
" How to get the current path and filename for usage in external scripts {{{3
"
" If you want to get the current path and filename from vimExplorer first cal the "g:VeGetPath()" then use the following variables as needed.
" These paths variables may be used for example if you do new mappings or some kind of menu to execute operations on the current file or directory.
" Note that the current path and filename are copied when leaving the plugin or any file window for another window so the following variables could be used from there.
" If you don't want to copy the path when leaving any file window, but just when leaving a vimExplorer window, set the variable "s:GetPathOnLeaveAlways" to 0
"
" g:VePaths.FileName  
" g:VePaths.FileNameQ  
" g:VePaths.FileName2Q  
" g:VePaths.PathS  
" g:VePaths.PathSQ  
" g:VePaths.PathS2Q  
" g:VePaths.FullPathS  
" g:VePaths.FullPathSQ  
" g:VePaths.FullPathS2Q  
" g:VePaths.PathB  
" g:VePaths.PathBQ  
" g:VePaths.PathB2Q  
" g:VePaths.FullPathB  
" g:VePaths.FullPathBQ  
" g:VePaths.FullPathB2Q  
" g:VePaths.Path2B  
" g:VePaths.Path2BQ  
" g:VePaths.Path2B2Q  
" g:VePaths.FullPath2B  
" g:VePaths.FullPath2BQ  
" g:VePaths.FullPath2B2Q  
" g:VePaths.DosFileName  
" g:VePaths.DosFileNameQ  
" g:VePaths.DosFileName2Q  
" g:VePaths.DosPathS  
" g:VePaths.DosPathSQ  
" g:VePaths.DosPathS2Q  
" g:VePaths.DosFullPathS  
" g:VePaths.DosFullPathSQ  
" g:VePaths.DosFullPathS2Q  
" g:VePaths.DosPathB  
" g:VePaths.DosPathBQ  
" g:VePaths.DosPathB2Q  
" g:VePaths.DosFullPathB  
" g:VePaths.DosFullPathBQ  
" g:VePaths.DosFullPathB2Q  
" g:VePaths.DosPath2B  
" g:VePaths.DosPath2BQ  
" g:VePaths.DosPath2B2Q  
" g:VePaths.DosFullPath2B  
" g:VePaths.DosFullPath2BQ  
" g:VePaths.DosFullPath2B2Q  
"
" How to open vimExplorer from another script {{{3
"
" Use the VimExplorerE, VimExplorerT, etc and/or other VimExplorer commands to start the plugin.
"
" How to change the colors of the display {{{3
"
" Find the g:VeLs() function in the code and then find the comment section "Set colors on specific items in the window", there you'll find the highlight groups set as the first arguments of the matchadd() function. For example where there is "cal matchadd('htmlLink', '\[\zs.\{-}\ze\]')" you may change "htmlLink" for some other highlight group of you choice.
"
" How to run user-defined commands on selected files {{{3
"
" This is useful if you want to command in batch on all the selected files.
" Use the "ctrl-s" mapping with or without visual selection to select files.
" The command placed in "Step1" contains commands that are run on files, the command placed in "Step2" contains commands that are run on directories.
" You may used all the placeholders found in the g:VeGethPath() function in your commands.
" The values "let g:VeCommands.User.Step1.Command.Value" and/or "let g:VeCommands.User.Step2.Command.Value" have to be initialized to a command or to '' (empty) before to run them using ":VimExplorerUC" or the "ctrl-u" mapping. If initialize to '' (empty) then no command is ran, so if you don't want for example to run a command on directories do this on "Step2": let g:VeCommands.User.Step2.Command.Value = ''
" Here some sample user commands, run the commands using the ":VimExplorerUC" command on the command-line or from a script, or use the "ctrl-u" mapping.
"
" " Show full paths of selected files and directories and their "PathSource" (file or directory)
" let g:VeCommands.User.Step1.Command.Value = 'echo "%SelFullPathS% %SelPathSource%"'
" let g:VeCommands.User.Step2.Command.Value = 'echo "%SelFullPathS% %SelPathSource%"'
"
" " Copy full paths of selected files and directories to the clipboard
" let g:VeCommands.User.Step1.Command.Value = 'echo "%SelFullPathS%" | let @* = "%SelFullPathS%"'
" let g:VeCommands.User.Step2.Command.Value = 'echo "%SelFullPathS%" | let @* = "%SelFullPathS%"'
"
" " Rename files (Step1) (append '.txt' to selected files) (In Windows use "!ren", in Linux "!mv")
" let g:VeCommands.User.Step1.Command.Value = 'cal system("ren \"%SelFileName%\" \"%SelFileName%.txt\"")'
" " Rename directories (Step2) (append '_bkp' to selected directories) (In Windows use "!ren", in Linux "!mv")
" let g:VeCommands.User.Step2.Command.Value = 'cal system("ren \"%SelFileName%\" \"%SelFileName%_bkp\"")'
"
" Other suggested mappings {{{3

" Other suggested mappings to open vimExplorer in one key press (to put in this plugin or in your vimrc) {{{4
" nmap <f2> :VimExplorerS<cr>
" nmap <f3> :VimExplorerV<cr>
" nmap <f4> :VimExplorerT<cr>
" nmap <f5> :VimExplorerE<cr>
" nmap <home> :VimExplorerS<cr>
" nmap <PageUp> :VimExplorerV<cr>
" nmap <PageDown> :VimExplorerT<cr>
" nmap <End> :VimExplorerE<cr>
" " 2 vertical windows
" nmap <s-f2> :exe 'VimExplorerT' \| exe 'VimExplorerV'<cr>
" nmap <s-home> :exe 'VimExplorerT' \| exe 'VimExplorerV'<cr>
" " 4 windows
" nmap <s-f3> :exe 'VimExplorerT' \| exe 'VimExplorerV' \| exe 'VimExplorerS' \| wincmd l \| exe 'VimExplorerS'<cr>
" nmap <s-PageUp> :exe 'VimExplorerT' \| exe 'VimExplorerV' \| exe 'VimExplorerS' \| wincmd l \| exe 'VimExplorerS'<cr>
" " 6 windows
" nmap <s-f4> :exe 'VimExplorerT' \| exe 'VimExplorerV' \| exe 'VimExplorerS' \| exe 'VimExplorerS' \| wincmd l \| exe 'VimExplorerS' \| exe 'VimExplorerS'<cr>
" nmap <s-PageDown> :exe 'VimExplorerT' \| exe 'VimExplorerV' \| exe 'VimExplorerS' \| exe 'VimExplorerS' \| wincmd l \| exe 'VimExplorerS' \| exe 'VimExplorerS'<cr>
"
" Tips {{{2
" - You may use the "set wrap" command to see all history if the list is long.
" - To search files in a directory, open the selected directory recursively using <space>L and then search the buffer for the file using vim's "/" command or use vimgrep.
" - I use also the MRU plugin in combination with vimExplorer to have a list of the last opened files, I find it extremely useful for vim editing.
" - To go quickly to the favorites bar, do <space>; or <space>, which brings the cursor on the history bar, then do "j" to go down one line, then press ";" or "," to go forward and backward on the favorites bar.
" - You may search the history and favorites using the "/" or the "?" command, especially the "?" command as the links are at the top of the file.
"
" Todo {{{2
" Code organization {{{3
" - Check if g:VeFileName occurences really could not be replaced by g:VePaths.FileName
" - Maybe modify the function folds to do like this: fu! g:VeGotoMark(mark) " {{{2 instead of adding the full function name in comments above the function itself, thus if the parameter changed, I will not have to change the comment also.
" - There was a some kind of bug in the g:VeLs() function, that the clear buffer statement was copying all the buffer into the paste register. I backed up the paste register before to execute that statement with 'let tmpReg = @"' then set back the paste buffer. To find a better solution when I have time. Here below is that code to do a better clear buffer:
"       let tmpReg = @"
"       norm ggVGd
"       let @" = tmpReg
" Documentation {{{3
" - Add documentation about user-defined commands
" Improvements to current features {{{3
" - Add pathsources that the user commands can be run onto
" - There are several modifications that could be done to the commands on selected files: grep recursive file/directories results, user command to execute on recursive directories/files and on grep results
" - Improve the run command to make it run asynchronously if possible in Linux
" - Maybe I should remove from selection the files after the command is ran like I did for the run command adding "\| let g:VeSelectedFiles = g:Item.New1('SelectedFiles') \| cal g:VeLs()" to the command
" - Maybe eventually, if it would proove to be better, to replace the ls command by the glob() function and use more the other file functions found in function-list like getftype() for example...but I'd say that ls is faster than glob and that it has dates, sorts etc
" - For now the encoding used for shell commands is 'latin1' which supports french special characters like accents, that makes it possible to run commands or copy (etc) files that have these special characters in their path. But it is not possible for now to run commands on files with other characters than included in 'latin1' encoding, like russian characters, chinese characters etc You may change the 'latin1' by something else if you wish by searching 'latin1' in the code. If I find a solution that works universally for all languages, like the use of utf-8, I will do the modification for it.
" New features {{{3
" - Add commands to copy files, move files etc that can be used from command line and call these from the mappings
" - Add a bar for recent files: (see Mru plugin how its done, maybe use an autocommand on "bufopen") and add to g:VeCfg
" - Add a bar for buffers opened: list buffers (see vimrc <tab>b, add maybe mapping for close buffer maybe so a buffer "link" may be closed
" - Maybe add a function to collect words or strings from selected files, use the collect function from my vimrc and add a collect command
"
" Bugs {{{2
" - If I have 3 split windows with vimExplorer in the middle, and I copy something in the top window, then I pass over the vimExplorer window to go to the bottom window (tab-j 2 times) then the content of the paste buffer is replaced by all the text in the vimExplorer window
" - When opening grep results in new tabs, the g:VeCommandToRun object is used to open the selected files, so the previous g:veCommandToRun which contained the grep command results is replaced by the OpenInNewTab command, that is why when returning to the VimExplorer window after viewing executing this OpenInNewTab on grep results command the previous grep results are not there anymore. This is somehow a limitation, to overcome this there could be an array of g:VeCommandToRun for example, but for now to leave it like this. 
" - When selected files from a recursive listing, if the same filenames appear in other subdirs they are also highlighted (but not added to selection) this is because the highlight is based on the filename... I'm not sure there may be a simple solution to this
" - Cannot execute external commands (copy, delete, etc) on files that contains french accents for example or russian alphabet
"   - the fnamemodify() function with the :8 parameter to obtain dos names dosen't return the dos name if the path is not written in english (containing other characters than english chars) like in french or russian it dosen't work. So get the dos filename from the dir command using the dir /x FullPath command
"   - Wait answer from Xaizek on this, I sent email to him
" - In the sample user commands, the copy to clipboard even with many selected files copies only one file to clipboard (maybe put a <cr> after the command?)
" - When opening a html file with \ww (in my vimrc) in vimExplorer, the color syntax seemed one time to change in the code...to test
" - Cannot run commands on file written with the russian alphabet (see RunCommand() function, exe iconv(command, &enc, 'latin1')) This iconv() conversion works for french but not for russian (latin1 is also what is used in the shell (cp850) so there is not problem there, but with russian even by changing the shell with chcp 855 or chcp 866 and doing after the command with the russian name it dosen't work, for example echo system('chcp 855 & type "' . iconv('c:\temp\Copy of Новый текстовый документ.txt', &enc, 'cp855') . '"')
" - I noticed that the regular expression in g:VeGetPath() function ('[0-9]\s\w\{3\}\s\(\s\|[0-9]\)[0-9]\s\([0-9][0-9]:[0-9][0-9]\|\s[0-9]\{4\}\)\s\zs.*') which gets the filename dosen't work for computers where the information in the listing like the user name or the month is written in russian like for example "drwxrwx---  1 Администратор          0 сен  8 10:13 colors" the "\w" in regular expression don't match characters in the russian alphabet. This seems like a vim limitation, I don't know yet how to solve this, maybe to change the code page of the shell with "chcp" before to issue the "ls" command (in Windows)... Maybe there are unicode matching characters in vim...
" Annoyances {{{3
" - Try to find way not to see the appearing/disapearing taskbar button when cal system('cd "' . path . '"') and exe 'silent r! ls.exe...' are executed
" History {{{2
"
" 1.0 {{{3
" - First release
" 1.1 {{{3
" - Modified the GetFileName() function: when there is very large files with the number of bytes taking much spaces, the filenames may not be aligned, so to find the position of the first filename was not enough, I had to find the position of the filename on the current line, each independently.
" - Added the favorites bar that offers another way of bookmarking directories other than directory marks.
" - Corrected the history bar and favorites bar, the links where not executed when <space>l or <enter> were pressed on the "]" character.
" - Added initialization of the fileName variable to '' in the GetFileName() function
" - Added possibility to edit the history bar and favorites bar. They will be saved when changing directories or when <space>s is pressed, or when vim quits if the cursor is in a vimExplorer window.
" - You may now write or edit a path manually in the "Path: " bar at the top of the buffer. Once the path is entered, press <space>l or <enter> to go to that path.
" - Now use <space>a to go the path at the top of the buffer to edit it. Press <space>l or <enter> (in normal mode) to go the that path once edited.
" - Modified comments: there was <space>g to execute history paths, now <space>l or <enter>. I modified other comments as well.
" 1.2 {{{3
" - Added <space>e (edit) to open files in current buffer.
" - Changed commands VimExplorerB, VimExplorerBF, VimExplorerBP for VimExplorerE, VimExplorerEF, VimExplorerEP 
" - Changed mappings \vb and \VB for \ve and \VE so it is similar to the <space>e command, to keep consistance between mappings.
" - Added very large max length for favorites not to autodelete them if there are too many like with the history bar.
" - Added the possibility to calg:VeGetPath() from any file, not just from a vimExplorer window, to get the multiple path formats to global variables. This allows for example to switch to another window where there would be a menu of links that contains the path variables in commands. One example could be that a code file is in edition, once saved, switch to menu window and execute the commands from the links. If you don't want to get the paths when leaving any files, set the "s:GetPathOnLeaveAlways" variable to 0
" - Modified comments
" 1.3 {{{3
" - Added folds in GetFileName(), VeLs()
" - Modified comments, the \vb and \VB mappings where still in the documentation but they was replaced by \ve and \VE.
" 2.0 {{{3
" - Give same behavior to all paths, this means that links, grep results paths, recursive listing paths all behave the same way like files in the directory listing. So now it is possible for example to open a link in the favorites bar or history bar in another tab using <space>t or to open a grep result in a vertical split window doing <space>v. See the "File operations" section in the documentation usage, to see other possible actions to do on directories, files and links.
" - Now directory may be opened in new tabs or new split etc like any file.
" - The configuration file is now a xml file the previous file format using a dictionary is not compatible anymore. The plugin used for this xml file is "basicXmlParser.vim" which is included in this plugin so that each release will have the corresponding working version of the plugin
" - Copy and move files and directories works in windows (not tested in linux)
" - Now possible to open multiple selected files each in a new tab
" - Added shift-j To open the next file in the preview window, shift-k Go open the previous file in the preview window, and also the default action now to open items is in the preview window
" - It is now possible to add files to the favorites bar using <space>B (<space>b add a directory). This means that the favorites bar can now be used to bookmark directories but also to contain links to files (like shortcuts).
" - Corrected bug in the GetFileName() function when there was a filter set with <space>f, the files could not opened.
" - I removed one function that was not used anymore to add favorites, it was replaced by AddToBar() which is used also for the history bar.
" - Removed the VeGetFileName() function, put its code in the VeGetPath() function  
" - Corrected a bug in the change directory function, now changes directory without interruption
" - Change <space>s (save configuration) for <space>S. <space>s is not used to select a file.  
" - Added <space>X Open current directory with the gvim "browse" command to open a file in the current buffer
" - Changed the fold level for the mappings so they appear at the first level for more easy access
" - Put the matchadd() to set the colors inside try..catch in case the highlight groups defined are not present in the current color scheme. I added a documentation section explaining how to change these colors.
" - Added a new variable to know what was the last history path added not to add the current path multiple times (suggestion from Xaizek)
" - Replaced the fixed value for the starting line of the directory listing by a function called "g:VeGetDirectoryListLineNum()"
" - Removed a "\s" from the regexes to test if the line is a directory or a file ("^d.\{9}\s" or "^-.\{9}\s") because in cygwin there is only one \s but with UnxUtils there are 2. 
" - Changed the variable $home by $HOME because in linux it is case sensitive
" - Removed the option "setlocal nowrap" in the BuildWindow() function, because a user may want always to have the history and favorites bar wrapped
" - Corrected the <leader>VV mapping, it was <leader>VV> and was not executing
" - Corrected/added <space>` to show the marks same like <space>'
" - Added user-commands that can be run on selected files
" - I remove TabEnter/Leave and BufEnter/Leave from the autocommands which call s:OnEnter() and s:OnLeave(), this was causing these functions to be called 3 times thus slowing access to the windows, this removed the necessity for the usage of the variable g:VeAutoRefreshOnEnter that was removed
" - Change map to nmap in mappings to start the plugin
" - Added mappings to inspect the content of the selected files object, the commands object and the command to run object
" - Added operations on selected files in a recursive listing also (ls -R) Copy, move, delete, OpenInNewTab etc
" - Added selection of items in the links bar
" 2.1 {{{3
" - Added "silent" to the <space>x mappings
" - Corrected bug in the s:SetCursorPos(path) (to exit if there are no path)
" - Did testing when there are no VimExplorer.xml file
" - Change suggested mappings (commented out) (f2, f3, ..., Home, PageUp, etc)
" - Modified the installation instructions to indicated that if you use the plugin in Windows, you will have to change the value of the "g:VeLsCmdPath" to that of the path where your ls command is located. Search for the variable using: /let g:VeLsCmdPath
" - Added <space>9 If Windows is used to change the ls command for "UnxUtils" ls command
" - Added <space>0 If Windows is used to Change the ls command for "Cygwin" ls command
" - Modified also the installation instructions to indicated that if you use the plugin in Windows, you will have to change also the value of the "g:VeGrepCmdPath" to that of the path where your grep command is located. Search for the variable using: /let g:VeGrepCmdPath (You may also set that variable to 'grep' simply and set the path to the executable using the system %path% variable)
" - Change the regex so that the cursor position is remembered also when there is a filter: changed "cal search('\([0-9]\s\+\|\/\)\zs\s\+' . g:VeCfg.CursorPos[g:VePath].Value . '$')" to "cal search('[0-9]\zs\s\+' . g:VeCfg.CursorPos[g:VePath].Value . '$')"
" - Changed ! for system() in the <space>c (clone) mapping, not to see the prompt window
" - Changed ! for system() in the <space>R (rename) mapping, not to see the prompt window
" - Changed unlet to unlet! in the <space>R command
" 2.2 {{{3
" - Added many new paths formats for dos, so all the current path formats have their dos equivalent with 8 characters only for directory and file names.
" - Removed some blank spaces that where found after <cr> in some mappings that where "pressing a space" after executing the mapping
" - Improved organization and content in the documentation and remove old items in the documentation
" - Removed file selections after executing the run command
" - Removed the <c-a> mapping to select all files because it was selecting grep results also...
" - changed the default paths for ls.exe and grep.exe from "UnxUtils", they are now in the "$vim" folder this as the benefit of making these command move with the vim folder, so they are always available where the vim folder is copied. This is for "UnxUtils" on Windows, it as no impact on Linux or on Windows if "Cygwin" is used.
" - 23.01.2013 0:34:18 (Ñð) I changed the exe command for Windows in the RunCommand() function by exe iconv(command, &enc, 'latin1') to be able to run commands on file with french accents. In my tests I could do for files with russian alphabet echo system('type "' . iconv('c:\temp\Новый текстовый документ.txt', &enc, 'latin1') . '"') and the content of that file was echoed, but it dosen't work for the run command for example
" 2.3 {{{3
" There was a some kind of bug in the g:VeLs() function, that the clear buffer statement was copying all the buffer into the paste register. I backed up the paste register before to execute that statement with 'let tmpReg = @"' then set back the paste buffer. To find a better solution when I have time.
"
" Variables: Plugin {{{1

" Flag indicating that the plugin is starting for the first time and not already opened and accessed from another window
let g:VeOpening = 0

" To add debug information after a directory listing
let g:Debug = []

" Variables: Configuration {{{1

let g:VeCfgFile = $HOME . '/vimExplorer.xml'

" The declaration of the variable 'g:VeCfg' (in development) is in the g:VeLoadFromFile() function, this is to avoid to erase its content when sourcing (so %) this file.

" Variables: Directory browsing {{{1

" The column position where the file name starts
let s:FileNameColNum = 0

" The maximum lenght for the history bar the top of the buffer
let s:HistoryMaxLength = 1000

" The maximum lenght for the favorites bar the top of the buffer
let g:VeFavoritesMaxLength = 9999999

" Get the multiple path formats of the current file to global variables when leaving any file including the vimExplorer selected file. This is done by calling the g:VeGetPath() function
" If set to 0, then the path formats will be copied only when leaving a vimExplorer window
let s:GetPathOnLeaveAlways = 1

" Used to toggle between the current path and the previous path (different from LastPath which is used to save and retrieve the last path used by VimExplorer)
let g:VePreviousPath = ''
" Variables: Paths {{{2

" The declaration of the variable 'g:VePath' is in the g:VeLoadFromFile() function, this is to avoid to erase its content when developing and sourcing (so %) this file, but otherwise it should be here like this "let g:VePath = ''".
let g:VeFileName = ''
" Dictionary used to contain multiple variants of the current path
let g:VePaths = {}

" Used to know the source from where the path was taken
" Possible values are 'd' (directory in the listing), 'f' (file in the listing), 'g' (a grep result), 'ld' (a link to a directory), 'lf' (a link to a file), 'rd' (subdirectory directory in a recursive listing), 'rf' (subdirectory file in a recursive listing)
let g:VePathSource = ''

let g:VeFileLineNum = 0 " Used to position the cursor when grep results are opened

" Variables: Ls command {{{2

" Default filter (all files)
let g:VeFilter = ''

" Default sorting
let g:VeSort = '-U'
let g:VeSortLabel = 'Name'

" Defaut recursive
let g:VeRecursive = ''

" If the listing is a recursive listing, get the subdirectories listing part into this variable to be displayed again if required
let g:VeRecursiveData = []

" Windows
" NOTE: There are mappings (<space>9 and <space>0) to switch between the ls command from "UnxUtils" or the ls command from "Cygwin". So you may use both like I do by setting a path for each of these variables "g:VeLsCmdPathU" and "g:VeLsCmdPathC". I personally use the ls command from "UnxUtils" for speed, and the ls command from "Cygwin" to display russian alphabet. I use these mappings to switch from one to another depending if I need they are file and directory names that are written with the russian alphabet.
if has('Win32')
    " UnixUtils ls command path (The version I tested dosen't show Windows7 links as links but shows them as regular directories, and it produce an error when changing to it and produces errors if russian directory name. It seems also more faster than cygwin ls but cygwin ls displays everything correctly including russian alphabet but is much slower in Windows.) 
    let g:VeLsCmdPathU = $vim . '\ls.exe'
    " Cygwin ls command
    let g:VeLsCmdPathC = 'c:\cygwin\bin\ls.exe'
    " ls command (default is UnxUtils because it is faster)
    let g:VeLsCmdPath = g:VeLsCmdPathU
" Linux
else
    " ls command
    let g:VeLsCmdPath = 'ls'
endif

" Variables: Directory grep {{{1 

" Windows
if has('Win32')
    " Cygwin grep command
    "let g:VeGrepCmdPath = 'c:\cygwin\bin\grep.exe'
    let g:VeGrepCmdPath = $vim . '\grep.exe'
" Linux
else
    let g:VeGrepCmdPath = 'grep'
endif

" Variables: File selection {{{1

" File selection object that contains information about the selected files
let g:VeSelectedFiles = g:Item.New1('SelectedFiles')

" Commands object that contain information about the commands to run on the selected files
let g:VeCommands = g:Item.New1('Commands')

" Command to run
let g:VeCommandToRun = g:Item.New() 

" To show last command executed on selected files after the file listing
let s:ShowLastCommands = 0

" Autocommands {{{1

au! VimEnter * cal g:VeLoadFromFile(1)
au! VimLeave * if s:IsPluginWindow() == 1 | cal g:VeSaveBar('History') | cal g:VeSaveBar('Favorites') | endif | cal g:VeSaveToFile() 
au! WinEnter * cal s:OnEnter()
au! WinLeave * cal s:OnLeave()

" Mappings: To start the plugin {{{1

" Open vimExplorer using the last accessed path {{{2

" Create the window in the current window
nmap <silent> <leader>ve :VimExplorerE<cr>
" Create the window in a new split (horizontal) window
nmap <silent> <leader>vs :VimExplorerS<cr>
" Create the window in a new vsplit (vertical) window
nmap <silent> <leader>vv :VimExplorerV<cr>
" Create the window in a new tab
nmap <silent> <leader>vt :VimExplorerT<cr>

" Start vimExplorer in double vertical panes (for file copy, move etc)
nmap <silent> <leader>vd :exe 'VimExplorerT' \| exe 'VimExplorerV'<cr>
" Start vimExplorer in double horizontal panes (for file copy, move etc)
nmap <silent> <leader>vh :exe 'VimExplorerT' \| exe 'VimExplorerS'<cr>
" Start vimExplorer with four panes (for file copy, move etc)
nmap <silent> <leader>vf :exe 'VimExplorerT' \| exe 'VimExplorerV' \| exe 'VimExplorerS' \| wincmd l \| exe 'VimExplorerS'<cr>
" Start vimExplorer with six panes (for file copy, move etc)
nmap <silent> <leader>vx :exe 'VimExplorerT' \| exe 'VimExplorerV' \| exe 'VimExplorerS' \| exe 'VimExplorerS' \| wincmd l \| exe 'VimExplorerS' \| exe 'VimExplorerS'<cr>

" Open vimExplorer using a the current file's path {{{2

" Create the window in the current window
nmap <silent> <leader>VE :VimExplorerEF<cr>
" Create the window in a new split (horizontal) window
nmap <silent> <leader>VS :VimExplorerSF<cr>
" Create the window in a new vsplit (vertical) window
nmap <silent> <leader>VV :VimExplorerVF<cr>
" Create the window in a new tab
nmap <silent> <leader>VT :VimExplorerTF<cr>

" Commands: To start the plugin {{{1

" Open vimExplorer using the last accessed path {{{2

" Create the window in the current window
command! -nargs=0 VimExplorerE :let g:VeOpening = 1 | cal g:BuildWindow('e') | cal g:VeGetPath() | cal g:VeDirectoryGoto(g:VeCfg.LastPath.Value) | let g:VeOpening = 0
" Create the window in a new split (horizontal) window
command! -nargs=0 VimExplorerS :let g:VeOpening = 1 | cal g:BuildWindow('s') | cal g:VeGetPath() | cal g:VeDirectoryGoto(g:VeCfg.LastPath.Value) | let g:VeOpening = 0
" Create the window in a new vsplit (vertical) window
command! -nargs=0 VimExplorerV :let g:VeOpening = 1 | cal g:BuildWindow('v') | cal g:VeGetPath() | cal g:VeDirectoryGoto(g:VeCfg.LastPath.Value) | let g:VeOpening = 0
" Create the window in a new tab
command! -nargs=0 VimExplorerT :let g:VeOpening = 1 | cal g:BuildWindow('t') | cal g:VeGetPath() | cal g:VeDirectoryGoto(g:VeCfg.LastPath.Value) | let g:VeOpening = 0

" Open vimExplorer using a the current file's path {{{2

" Create the window in the current window
command! -nargs=0 VimExplorerEF :let g:VeOpening = 1 | let p = expand('%:p:h') | cal g:BuildWindow('e') | cal g:VeDirectoryGoto(p) | let g:VeOpening = 0
" Create the window in a new split (horizontal) window
command! -nargs=0 VimExplorerSF :let g:VeOpening = 1 | let p = expand('%:p:h') | cal g:BuildWindow('s') | cal g:VeDirectoryGoto(p) | let g:VeOpening = 0
" Create the window in a new vsplit (vertical) window
command! -nargs=0 VimExplorerVF :let g:VeOpening = 1 | let p = expand('%:p:h') | cal g:BuildWindow('v') | cal g:VeDirectoryGoto(p) | let g:VeOpening = 0
" Create the window in a new tab
command! -nargs=0 VimExplorerTF :let g:VeOpening = 1 | let p = expand('%:p:h') | cal g:BuildWindow('t') | cal g:VeDirectoryGoto(p) | let g:VeOpening = 0

" Open vimExplorer using a path specified on the command line {{{2

" Create the window in the current window
command! -nargs=1 VimExplorerEP :let g:VeOpening = 1 | cal g:BuildWindow('e') | cal g:VeDirectoryGoto(<f-args>) | let g:VeOpening = 0
" Create the window in a new split (horizontal) window
command! -nargs=1 VimExplorerSP :let g:VeOpening = 1 | cal g:BuildWindow('s') | cal g:VeDirectoryGoto(<f-args>) | let g:VeOpening = 0
" Create the window in a new vsplit (vertical) window
command! -nargs=1 VimExplorerVP :let g:VeOpening = 1 | cal g:BuildWindow('v') | cal g:VeDirectoryGoto(<f-args>) | let g:VeOpening = 0
" Create the window in a new tab
command! -nargs=1 VimExplorerTP :let g:VeOpening = 1 | cal g:BuildWindow('t') | cal g:VeDirectoryGoto(<f-args>) | let g:VeOpening = 0

" Commands: File Selection {{{1

" Run a user defined command
command! -nargs=0 VimExplorerUC cal g:VeSelectFile('s') | let g:VeCommandToRun = g:VeCommands.User.Clone() | cal g:VeRunCommand() | let g:VeSelectedFiles = g:Item.New1('SelectedFiles') | cal g:VeLs()

" File Selection: Build commands {{{1
" Build the commands used to do operations on selected files
" To view the commands and inspect them do: enew | cal append(0, g:VeCommands.ToXmlList())

" Copy command {{{2
cal g:VeCommands.Add(g:Item.New1('Copy'))
" Execute the command for each file in the selection
cal g:VeCommands.Copy.Add(g:Item.New2('ExeForEachFile', 1))
" Windows {{{3
if has('Win32')
    " Step1: Create destination directories {{{4
    cal g:VeCommands.Copy.Add(g:Item.New2('Step1', 'Create destination directories'))
    cal g:VeCommands.Copy.Step1.Add(g:Item.New2('Command', 'cal mkdir("%CurPathS%/%SelFileName%")'))
    cal g:VeCommands.Copy.Step1.Add(g:Item.New2('PathSource', 'd'))
    " Step2: Copy directories {{{4
    cal g:VeCommands.Copy.Add(g:Item.New2('Step2', 'Copy directories'))
    cal g:VeCommands.Copy.Step2.Add(g:Item.New2('Command', "cal system('xcopy /E /H /R /Y %SelFullPath2B2Q% \"%CurPath2B%\\%SelFileName%\"')"))
    cal g:VeCommands.Copy.Step2.Add(g:Item.New2('PathSource', 'd'))
    " Step3: Copy files {{{4
    cal g:VeCommands.Copy.Add(g:Item.New2('Step3', 'Copy files'))
    cal g:VeCommands.Copy.Step3.Add(g:Item.New2('Command', "cal system('xcopy /H /R /Y %SelFullPath2B2Q% %CurPath2B2Q%')"))
    cal g:VeCommands.Copy.Step3.Add(g:Item.New2('PathSource', 'f'))
    " Step4: Create destination directories for recursive listing {{{4
    cal g:VeCommands.Copy.Add(g:Item.New2('Step4', 'Create destination for recursive listing directories'))
    cal g:VeCommands.Copy.Step4.Add(g:Item.New2('Command', 'cal mkdir("%CurPathS%/%SelFileName%")'))
    cal g:VeCommands.Copy.Step4.Add(g:Item.New2('PathSource', 'rd'))
    " Step5: Copy recursive listing directories {{{4
    cal g:VeCommands.Copy.Add(g:Item.New2('Step5', 'Copy recursive listing directories'))
    cal g:VeCommands.Copy.Step5.Add(g:Item.New2('Command', "cal system('xcopy /E /H /R /Y %SelFullPath2B2Q% \"%CurPath2B%\\%SelFileName%\"')"))
    cal g:VeCommands.Copy.Step5.Add(g:Item.New2('PathSource', 'rd'))
    " Step6: Copy recursive listing files {{{4
    cal g:VeCommands.Copy.Add(g:Item.New2('Step6', 'Copy files'))
    cal g:VeCommands.Copy.Step6.Add(g:Item.New2('Command', "cal system('xcopy /H /R /Y %SelFullPath2B2Q% %CurPath2B2Q%')"))
    cal g:VeCommands.Copy.Step6.Add(g:Item.New2('PathSource', 'rf'))
" Linux {{{3
else
    " Step1: Copy directories {{{4
    cal g:VeCommands.Copy.Add(g:Item.New2('Step1', 'Copy directories'))
    cal g:VeCommands.Copy.Step1.Add(g:Item.New2('Command', "cal system('cp -rf %SelFullPath2B2Q% %CurPath2B2Q%')"))
    cal g:VeCommands.Copy.Step1.Add(g:Item.New2('PathSource', 'd'))
    " Step2: Copy files {{{4
    cal g:VeCommands.Copy.Add(g:Item.New2('Step2', 'Copy directories'))
    cal g:VeCommands.Copy.Step2.Add(g:Item.New2('Command', "cal system('cp -f %SelFullPath2B2Q% %CurPath2B2Q%')"))
    cal g:VeCommands.Copy.Step2.Add(g:Item.New2('PathSource', 'f'))
    " Step2: Copy recursive listing directories {{{4
    cal g:VeCommands.Copy.Add(g:Item.New2('Step2', 'Copy directories'))
    cal g:VeCommands.Copy.Step2.Add(g:Item.New2('Command', "cal system('cp -rf %SelFullPath2B2Q% %CurPath2B2Q%')"))
    cal g:VeCommands.Copy.Step2.Add(g:Item.New2('PathSource', 'rd'))
    " Step3: Copy recursive listing files {{{4
    cal g:VeCommands.Copy.Add(g:Item.New2('Step3', 'Copy directories'))
    cal g:VeCommands.Copy.Step3.Add(g:Item.New2('Command', "cal system('cp -f %SelFullPath2B2Q% %CurPath2B2Q%')"))
    cal g:VeCommands.Copy.Step3.Add(g:Item.New2('PathSource', 'rf'))
endif

" Move command {{{2
cal g:VeCommands.Add(g:Item.New1('Move'))
" Execute the command for each file in the selection
cal g:VeCommands.Move.Add(g:Item.New2('ExeForEachFile', 1))
" Windows {{{3
if has('Win32')
    " Step1: Move directories {{{4
    cal g:VeCommands.Move.Add(g:Item.New2('Step1', 'Move directories'))
    cal g:VeCommands.Move.Step1.Add(g:Item.New2('Command', "cal system('move %SelFullPath2B2Q% %CurPath2B2Q%')"))
    cal g:VeCommands.Move.Step1.Add(g:Item.New2('PathSource', 'd'))
    " Step2: Move files {{{4
    cal g:VeCommands.Move.Add(g:Item.New2('Step2', 'Move files'))
    cal g:VeCommands.Move.Step2.Add(g:Item.New2('Command', "cal system('move %SelFullPath2B2Q% %CurPath2B2Q%')"))
    cal g:VeCommands.Move.Step2.Add(g:Item.New2('PathSource', 'f'))
    " Step3: Move recursive listing directories {{{4
    cal g:VeCommands.Move.Add(g:Item.New2('Step3', 'Move recursive listing directories'))
    cal g:VeCommands.Move.Step3.Add(g:Item.New2('Command', "cal system('move %SelFullPath2B2Q% %CurPath2B2Q%')"))
    cal g:VeCommands.Move.Step3.Add(g:Item.New2('PathSource', 'rd'))
    " Step4: Move recursive listing files {{{4
    cal g:VeCommands.Move.Add(g:Item.New2('Step4', 'Move recursive listing files'))
    cal g:VeCommands.Move.Step4.Add(g:Item.New2('Command', "cal system('move %SelFullPath2B2Q% %CurPath2B2Q%')"))
    cal g:VeCommands.Move.Step4.Add(g:Item.New2('PathSource', 'rf'))
" Linux {{{3
else
    " Step1: Move directories {{{4
    cal g:VeCommands.Move.Add(g:Item.New2('Step1', 'Move directories'))
    cal g:VeCommands.Move.Step1.Add(g:Item.New2('Command', "cal system('mv %SelFullPath2B2Q% %CurPath2B2Q%')"))
    cal g:VeCommands.Move.Step1.Add(g:Item.New2('PathSource', 'd'))
    " Step2: Move files {{{4
    cal g:VeCommands.Move.Add(g:Item.New2('Step2', 'Move files'))
    cal g:VeCommands.Move.Step2.Add(g:Item.New2('Command', "cal system('mv %SelFullPath2B2Q% %CurPath2B2Q%')"))
    cal g:VeCommands.Move.Step2.Add(g:Item.New2('PathSource', 'f'))
    " Step3: Move recursive listing directories {{{4
    cal g:VeCommands.Move.Add(g:Item.New2('Step3', 'Move recursive listing directories'))
    cal g:VeCommands.Move.Step3.Add(g:Item.New2('Command', "cal system('mv %SelFullPath2B2Q% %CurPath2B2Q%')"))
    cal g:VeCommands.Move.Step3.Add(g:Item.New2('PathSource', 'rd'))
    " Step4: Move recursive listing files {{{4
    cal g:VeCommands.Move.Add(g:Item.New2('Step4', 'Move recursive listing files'))
    cal g:VeCommands.Move.Step4.Add(g:Item.New2('Command', "cal system('mv %SelFullPath2B2Q% %CurPath2B2Q%')"))
    cal g:VeCommands.Move.Step4.Add(g:Item.New2('PathSource', 'rf'))
endif

" Delete command {{{2
cal g:VeCommands.Add(g:Item.New1('Delete'))
" Execute the command for each file in the selection
cal g:VeCommands.Delete.Add(g:Item.New2('ExeForEachFile', 1))
" Windows {{{3
if has('Win32')
    " Step1: Delete directories {{{4
    cal g:VeCommands.Delete.Add(g:Item.New2('Step1', 'Delete directories'))
    cal g:VeCommands.Delete.Step1.Add(g:Item.New2('Command', "cal system('rmdir /S/Q %SelFullPath2B2Q%')"))
    cal g:VeCommands.Delete.Step1.Add(g:Item.New2('PathSource', 'd'))
    " Step2: Delete files {{{4
    cal g:VeCommands.Delete.Add(g:Item.New2('Step2', 'Delete files'))
    cal g:VeCommands.Delete.Step2.Add(g:Item.New2('Command', "cal system('del /S/Q %SelFullPath2B2Q%')"))
    cal g:VeCommands.Delete.Step2.Add(g:Item.New2('PathSource', 'f'))
    " Step3: Delete recursive listing directories {{{4
    cal g:VeCommands.Delete.Add(g:Item.New2('Step3', 'Delete recursive listing directories'))
    cal g:VeCommands.Delete.Step3.Add(g:Item.New2('Command', "cal system('rmdir /S/Q %SelFullPath2B2Q%') \| let g:VeRecursive = '-R'"))
    cal g:VeCommands.Delete.Step3.Add(g:Item.New2('PathSource', 'rd'))
    " Step4: Delete recursive listing files {{{4
    cal g:VeCommands.Delete.Add(g:Item.New2('Step4', 'Delete recursive listing files'))
    cal g:VeCommands.Delete.Step4.Add(g:Item.New2('Command', "cal system('del /S/Q %SelFullPath2B2Q%') \| let g:VeRecursive = '-R'"))
    cal g:VeCommands.Delete.Step4.Add(g:Item.New2('PathSource', 'rf'))
" Linux {{{3
else
    " Step1: Delete directories {{{4
    cal g:VeCommands.Delete.Add(g:Item.New2('Step1', 'Delete directories'))
    cal g:VeCommands.Delete.Step1.Add(g:Item.New2('Command', "cal system('rm -rf %SelFullPath2B2Q%')"))
    cal g:VeCommands.Delete.Step1.Add(g:Item.New2('PathSource', 'd'))
    " Step2: Delete files {{{4
    cal g:VeCommands.Delete.Add(g:Item.New2('Step2', 'Delete files'))
    cal g:VeCommands.Delete.Step2.Add(g:Item.New2('Command', "cal system('rm -f %SelFullPath2B2Q%')"))
    cal g:VeCommands.Delete.Step2.Add(g:Item.New2('PathSource', 'f'))
    " Step3: Delete recursive listing directories {{{4
    cal g:VeCommands.Delete.Add(g:Item.New2('Step3', 'Delete recursive listing directories'))
    cal g:VeCommands.Delete.Step3.Add(g:Item.New2('Command', "cal system('rm -rf %SelFullPath2B2Q%') \| let g:VeRecursive = '-R'"))
    cal g:VeCommands.Delete.Step3.Add(g:Item.New2('PathSource', 'rd'))
    " Step4: Delete recursive listing files {{{4
    cal g:VeCommands.Delete.Add(g:Item.New2('Step4', 'Delete recursive listing files'))
    cal g:VeCommands.Delete.Step4.Add(g:Item.New2('Command', "cal system('rm -f %SelFullPath2B2Q%') \| let g:VeRecursive = '-R'"))
    cal g:VeCommands.Delete.Step4.Add(g:Item.New2('PathSource', 'rf'))
endif

" Grep command {{{2
cal g:VeCommands.Add(g:Item.New1('Grep'))
" Execute the command once for all selected files
cal g:VeCommands.Grep.Add(g:Item.New2('ExeForEachFile', 0))
" Path where the command was executed, used to know if the results are to be shown after changing directory
cal g:VeCommands.Grep.Add(g:Item.New1('PathWhereExe'))
" Show results after changing directory
cal g:VeCommands.Grep.Add(g:Item.New2('AfterCdShowResults', 0))
" Step1: Grep the selected files {{{4
cal g:VeCommands.Grep.Add(g:Item.New2('Step1', 'Grep the selected files'))
cal g:VeCommands.Grep.Step1.Add(g:Item.New2('Command', "let g:VeCommandToRun.Step1.Result.Value .= system('" . g:VeGrepCmdPath . " -n -i -H \"%Keywords%\" %SelFileName2Q%')"))
cal g:VeCommands.Grep.Step1.Add(g:Item.New2('Result', "Grep files result\n"))
cal g:VeCommands.Grep.Step1.Add(g:Item.New2('PathSource', 'f'))
" Step2: Grep the selected directories {{{4
cal g:VeCommands.Grep.Add(g:Item.New2('Step2', 'Grep the selected files'))
cal g:VeCommands.Grep.Step2.Add(g:Item.New2('Command', "let g:VeCommandToRun.Step2.Result.Value .= system('" . g:VeGrepCmdPath . " -n -i -H -r \"%Keywords%\" %SelFullPathS2Q%')"))
cal g:VeCommands.Grep.Step2.Add(g:Item.New2('Result', "Grep directories result\n"))
cal g:VeCommands.Grep.Step2.Add(g:Item.New2('PathSource', 'd'))

" OpenInNewTab command {{{2
cal g:VeCommands.Add(g:Item.New1('OpenInNewTab'))
" Execute the command for each file in the selection
cal g:VeCommands.OpenInNewTab.Add(g:Item.New2('ExeForEachFile', 1))
" Step1: Open files in new tab {{{3
cal g:VeCommands.OpenInNewTab.Add(g:Item.New2('Step1', 'Open files in new tab'))
cal g:VeCommands.OpenInNewTab.Step1.Add(g:Item.New2('Command', "tabe %SelFullPathS%"))
cal g:VeCommands.OpenInNewTab.Step1.Add(g:Item.New2('PathSource', 'f'))
" Step2: Open directories in vimExplorer in a new tab {{{3
cal g:VeCommands.OpenInNewTab.Add(g:Item.New2('Step2', 'Open directories in vimExplorer in a new tab'))
cal g:VeCommands.OpenInNewTab.Step2.Add(g:Item.New2('Command', "VimExplorerTP %SelFullPathS%"))
cal g:VeCommands.OpenInNewTab.Step2.Add(g:Item.New2('PathSource', 'd'))
" Step3: Open recursive listing files in new tab {{{3
cal g:VeCommands.OpenInNewTab.Add(g:Item.New2('Step3', 'Open recursive listing files in new tab'))
cal g:VeCommands.OpenInNewTab.Step3.Add(g:Item.New2('Command', "tabe %SelFullPathS%"))
cal g:VeCommands.OpenInNewTab.Step3.Add(g:Item.New2('PathSource', 'rf'))
" Step4: Open recursive listing directories in new tab {{{3
cal g:VeCommands.OpenInNewTab.Add(g:Item.New2('Step4', 'Open recursive listing directories in new tab'))
cal g:VeCommands.OpenInNewTab.Step4.Add(g:Item.New2('Command', "VimExplorerTP %SelFullPathS%"))
cal g:VeCommands.OpenInNewTab.Step4.Add(g:Item.New2('PathSource', 'rd'))
" Step5: Open grep file results in new tab {{{3
" NOTE: When opening grep results in new tabs, the g:VeCommandToRun object is used to open the selected files, so the previous g:veCommandToRun which contained the grep command results is replaced by the OpenInNewTab command, that is why when returning to the VimExplorer window after viewing executing this OpenInNewTab on grep results command the previous grep results are not there anymore. This is somehow a limitation, to overcome this there could be an array of g:VeCommandToRun for example, but for now to leave it like this. 
cal g:VeCommands.OpenInNewTab.Add(g:Item.New2('Step5', 'Open grep file results in new tab'))
cal g:VeCommands.OpenInNewTab.Step5.Add(g:Item.New2('Command', "exe 'tabe +%FileLineNum% %SelFullPathS%'"))
cal g:VeCommands.OpenInNewTab.Step5.Add(g:Item.New2('PathSource', 'gf'))
" Step6: Open grep directory results in new tab {{{3
" NOTE: When opening grep results in new tabs, the g:VeCommandToRun object is used to open the selected files, so the previous g:veCommandToRun which contained the grep command results is replaced by the OpenInNewTab command, that is why when returning to the VimExplorer window after viewing executing this OpenInNewTab on grep results command the previous grep results are not there anymore. This is somehow a limitation, to overcome this there could be an array of g:VeCommandToRun for example, but for now to leave it like this. 
cal g:VeCommands.OpenInNewTab.Add(g:Item.New2('Step6', 'Open grep directory results in new tab'))
cal g:VeCommands.OpenInNewTab.Step6.Add(g:Item.New2('Command', "exe 'tabe +%FileLineNum% %SelFullPathS%'"))
cal g:VeCommands.OpenInNewTab.Step6.Add(g:Item.New2('PathSource', 'gd'))
" Step7: Open link bar files in new tab {{{3
cal g:VeCommands.OpenInNewTab.Add(g:Item.New2('Step7', 'Open link bar files in new tab'))
cal g:VeCommands.OpenInNewTab.Step7.Add(g:Item.New2('Command', "tabe %SelFullPathS%"))
cal g:VeCommands.OpenInNewTab.Step7.Add(g:Item.New2('PathSource', 'lf'))
" Step8: Open link bar directories in new tab {{{3
cal g:VeCommands.OpenInNewTab.Add(g:Item.New2('Step8', 'Open link bar directories in new tab'))
cal g:VeCommands.OpenInNewTab.Step8.Add(g:Item.New2('Command', "VimExplorerTP %SelFullPathS%"))
cal g:VeCommands.OpenInNewTab.Step8.Add(g:Item.New2('PathSource', 'ld'))

" Run command {{{2
cal g:VeCommands.Add(g:Item.New1('Run'))
" Execute the command for each file in the selection
cal g:VeCommands.Run.Add(g:Item.New2('ExeForEachFile', 1))
" Step1: Run the file {{{3
cal g:VeCommands.Run.Add(g:Item.New2('Step1', 'Run the file'))
" Windows
if has('Win32')
    " Start the command asynchronously and closes the black dos prompt windows that are opened, silent is used not to have to press a key to continue
    cal g:VeCommands.Run.Step1.Add(g:Item.New2('Command', "cal g:VeGetPath() \| exe 'silent !start cmd /c %SelFullPath2B2Q%' \| exe 'silent !cmd /c taskkill /F /IM cmd.exe' \| let g:VeSelectedFiles = g:Item.New1('SelectedFiles') \| cal g:VeLs()"))
" Linux
else
    " Not asynchronous for now
    cal g:VeCommands.Run.Step1.Add(g:Item.New2('Command', "cal g:VeGetPath() \| system('%SelFullPathS2Q%')"))
endif
cal g:VeCommands.Run.Step1.Add(g:Item.New2('PathSource', 'f'))
" Step2: Run the file that is part of a recursive listing {{{3
cal g:VeCommands.Run.Add(g:Item.New2('Step2', 'Run the file that is part of a recursive listing'))
" Windows
if has('Win32')
    " Start the command asynchronously and closes the black dos prompt windows that are opened, silent is used not to have to press a key to continue
    cal g:VeCommands.Run.Step2.Add(g:Item.New2('Command', "cal g:VeGetPath() \| exe 'silent !start cmd /c %SelFullPath2B2Q%' \| exe 'silent !cmd /c taskkill /F /IM cmd.exe' \| let g:VeRecursive = '-R' \| let g:VeSelectedFiles = g:Item.New1('SelectedFiles') \| cal g:VeLs()"))
" Linux
else
    " Not asynchronous for now
    cal g:VeCommands.Run.Step2.Add(g:Item.New2('Command', "cal g:VeGetPath() \| system('%SelFullPathS2Q%') \| let g:VeRecursive = '-R' \| let g:VeSelectedFiles = g:Item.New1('SelectedFiles') \| cal g:VeLs()"))
endif
cal g:VeCommands.Run.Step2.Add(g:Item.New2('PathSource', 'rf'))
" Step3: Run the file that is a link {{{3
cal g:VeCommands.Run.Add(g:Item.New2('Step3', 'Run the file that is a link'))
" Windows
if has('Win32')
    " Start the command asynchronously and closes the black dos prompt windows that are opened, silent is used not to have to press a key to continue
    cal g:VeCommands.Run.Step3.Add(g:Item.New2('Command', "cal g:VeGetPath() \| exe 'silent !start cmd /c %SelFullPath2B2Q%' \| exe 'silent !cmd /c taskkill /F /IM cmd.exe' \| let g:VeSelectedFiles = g:Item.New1('SelectedFiles') \| cal g:VeLs()"))
" Linux
else
    " Not asynchronous for now
    cal g:VeCommands.Run.Step3.Add(g:Item.New2('Command', "cal g:VeGetPath() \| system('%SelFullPathS2Q%') \| let g:VeSelectedFiles = g:Item.New1('SelectedFiles') \| cal g:VeLs()"))
endif
cal g:VeCommands.Run.Step3.Add(g:Item.New2('PathSource', 'lf'))

" User command {{{2
cal g:VeCommands.Add(g:Item.New1('User'))
" Execute the command for each file in the selection
cal g:VeCommands.User.Add(g:Item.New2('ExeForEachFile', 1))
" Step1: Run on selected files {{{4
cal g:VeCommands.User.Add(g:Item.New2('Step1', 'Run on selected files'))
cal g:VeCommands.User.Step1.Add(g:Item.New1('Command'))
cal g:VeCommands.User.Step1.Add(g:Item.New2('PathSource', 'f'))
" Step2: Run on selected directories {{{4
cal g:VeCommands.User.Add(g:Item.New2('Step2', 'Run on selected directories'))
cal g:VeCommands.User.Step2.Add(g:Item.New1('Command'))
cal g:VeCommands.User.Step2.Add(g:Item.New2('PathSource', 'd'))

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

" -- Autocommands functions: OnEnter() {{{1
fu! s:OnEnter()
    " If not re-entering a vimExplorer window but when creating the window then do nothing here, exit
    if g:VeOpening == 1
        return
    endif
    " The window is not a vimExplorer window then exit {{{3
    if s:IsPluginWindow() == 0
        return
    endif
    " Get the instance path {{{3
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
    " Go back to previous position {{{3
    cal setpos('.', savedPosition)
    " Change to this instance path directory {{{3
    cal s:ChangeDirectory(path)
    " In case the files where modified while outside the window {{{3
    cal g:VeLs()
endfu

" -- Autocommands functions: OnLeave() {{{1
fu! s:OnLeave()
    " Keep a copy of the current path and filename variables to use from another window, even if the current window is not a vimExplorer window. {{{3
    " This allows for example to switch to another window where there would be a menu of links that contains the path variables in commands.
    " One example could be that a code file is in edition, once saved, switch to menu window and execute the commands from the links.
    " If you don't want to get the paths when leaving any files, set the "s:GetPathOnLeaveAlways" variable to 0
    if s:GetPathOnLeaveAlways == 1 || s:IsPluginWindow() == 1
        cal g:VeGetPath()
        " If it is not a plugin window, exit
        if s:IsPluginWindow() == 0
            return
        endif
        " Don't remember the cursor's position when it is a link
        if g:VePathSource == 'ld'
            return
        endif
        " Remember the cursor position before when leaving a window, this is useful when having for example two windows side-by-side to move or copy files, the position of the cursor will be remembered when leaving the window and the cursor positionned where it was when returning to the window  
        cal s:SetCursorPos(g:VePath)
    endif
endfu

" -- BuildWindow() (window creation, options and mappings) {{{1
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

    " -- Mappings: Common to all OSes {{{1

    " <s-j> (shift-j) To open the next file in the preview window. You may hold the shift key then press many times j to preview one file after another. It will open the file and then pass to the next file, I found it better than to pass to the next file and open it because if you position the cursor on a file you do shift-j instead to have to do <enter> of <space>l to open the file then shift-j for next files.
    nmap <silent> <buffer> <s-j> :cal g:VeGetPath() \| exe 'pedit ' . g:VePaths.FullPathS \| exe 'normal j'<cr>
    " <s-k> (shift-k) Go open the previous file in the preview window. You may hold the shift key then press many times k to preview one file after another. It will open the file and then pass to the previous file, I found it better than to pass to the previous file and open it because if you position the cursor on a file you do shift-k instead to have to do <enter> of <space>l to open the file then shift-k for previous files.
    nmap <silent> <buffer> <s-k> :cal g:VeGetPath() \| exe 'pedit ' . g:VePaths.FullPathS \| exe 'normal k'<cr>

    " <space><esc> Execute a command and insert its output in the buffer
    nmap <buffer> <space><esc> :let f = input('r! ', '') \| if f != '' \| exe 'norm G' \| exe 'r! ' . f \| endif<cr>
    " <space>l or <enter> Open the selected item in preview window
    nmap <silent> <buffer> <enter> :cal g:VeGetPath() \| cal g:VeOpenItem('')<cr>
    " <space><backspace> Go to the parent directory
    nmap <silent> <buffer> <backspace> :cal g:VeGetPath() \| cal g:VeDirectoryGoto('..')<cr>
    " <space>' Show all marked directories sorted by marks
    nmap <buffer> <space>' :cal g:VeShowMarks(0)<cr>
    " <space>` Show all marked directories sorted by marks
    nmap <buffer> <space>` :cal g:VeShowMarks(0)<cr>
    " <space>[ Show all marked directories sorted by directories
    nmap <buffer> <space>[ :cal g:VeShowMarks(1)<cr>
    " <space>; Go to the history list (then do ; or , (from the vim 'f' command) to move forward and backward from one path to another, then when on the desired path, do <space>; to goto the directory.)
    nmap <silent> <buffer> <space>; :exe 'norm gg' \| cal search('History') \| exe 'norm f['<cr>
    " <space>, Go to the end of the history list (then do ; or , (from the vim 'f' command) to move forward and backward from one path to another, then when on the desired path, do <space>, to goto the directory.)
    nmap <silent> <buffer> <space>, :exe 'norm gg' \| cal search('History') \| exe 'norm $f[' \| norm ,<cr>
    " <space>1 Sort by name
    nmap <silent> <buffer> <space>1 :let g:VeSort = '-U' \| let g:VeSortLabel = 'Name' \| cal g:VeLs()<cr>
    " <space>2 Sort by type
    nmap <silent> <buffer> <space>2 :let g:VeSort = '-X' \| let g:VeSortLabel = 'Type' \| cal g:VeLs()<cr>
    " <space>3 Sort by size
    nmap <silent> <buffer> <space>3 :let g:VeSort = '-S' \| let g:VeSortLabel = 'Size' \| cal g:VeLs()<cr>
    " <space>4 Sort by date
    nmap <silent> <buffer> <space>4 :let g:VeSort = '-t' \| let g:VeSortLabel = 'Date' \| cal g:VeLs()<cr>
    " <space>a Go to the path at the top of the buffer to edit it. Press <space>l or <enter> (normal mode) to go the that path once edited.
    nmap <silent> <buffer> <space>a :exe 'norm gg' \| cal search('Path') \| exe 'norm f]h'<cr>
    " <space>b Add the directory to the favorites bar
    nmap <silent> <buffer> <space>b :cal g:VeAddToBar('Favorites', g:VePath, g:VeFavoritesMaxLength) \| cal g:VeLs()<cr>
    " <space>B Add the full path with the filename to the favorites bar (this allows to add "shortcuts" to files to run a file or to open a file)
    nmap <silent> <buffer> <space>B :cal g:VeGetPath() \| cal g:VeAddToBar('Favorites', g:VePaths.FullPathS, g:VeFavoritesMaxLength) \| cal g:VeLs()<cr>
    " <space>d New directory
    nmap <silent> <buffer> <space>d :let d = input('Directory name: ') \| cal mkdir(d) \| cal g:VeLs() \| cal search(d)<cr>
    " <space>D Delete current file/directory or selected files/directories
    nmap <silent> <buffer> <space>D :cal g:VeSelectFile('s') \| let g:VeCommandToRun = g:VeCommands.Delete.Clone() \| cal g:VeRunCommand() \| let g:VeSelectedFiles = g:Item.New1('SelectedFiles') \| cal g:VeLs()<cr>
    vmap <silent> <buffer> <space>D :cal g:VeSelectFile('s') \| let g:VeCommandToRun = g:VeCommands.Delete.Clone() \| cal g:VeRunCommand() \| let g:VeSelectedFiles = g:Item.New1('SelectedFiles') \| cal g:VeLs()<cr>
    " <delete> Delete current file/directory or selected files/directories
    nmap <silent> <buffer> <delete> :cal g:VeSelectFile('s') \| let g:VeCommandToRun = g:VeCommands.Delete.Clone() \| cal g:VeRunCommand() \| let g:VeSelectedFiles = g:Item.New1('SelectedFiles') \| cal g:VeLs()<cr>
    vmap <silent> <buffer> <delete> :cal g:VeSelectFile('s') \| let g:VeCommandToRun = g:VeCommands.Delete.Clone() \| cal g:VeRunCommand() \| let g:VeSelectedFiles = g:Item.New1('SelectedFiles') \| cal g:VeLs()<cr>
    " <space>e Open file in new buffer
    nmap <silent> <buffer> <space>e :cal g:VeGetPath() \| cal g:VeOpenItem('e')<cr>
    " <space>f Set filter to show only certain files
    nmap <silent> <buffer> <space>f :let g:VeFilter = input('Filter: ', g:VeFilter) \| cal g:VeLs()<cr>
    " <space>F Remove the filter and show all files
    nmap <silent> <buffer> <space>F :let g:VeFilter = '' \| cal g:VeLs()<cr>
    " <space>g Grep current file/directory or the selected files/directories
    nmap <silent> <buffer> <space>g :cal g:VeSelectFile('s') \| let k = input('grep keywords: ') \| if k != '' \| let g:VeCommandToRun = g:VeCommands.Grep.Clone() \| let g:VeCommandToRun.Step1.Command.Value = substitute(g:VeCommandToRun.Step1.Command.Value, '%Keywords%', k, '') \| let g:VeCommandToRun.Step2.Command.Value = substitute(g:VeCommandToRun.Step2.Command.Value, '%Keywords%', k, '') \| cal g:VeRunCommand() \| cal g:VeShowCommandResults() \| exe 'let @/="' . k . '"' \| let g:VeSelectedFiles = g:Item.New1('SelectedFiles') \| cal g:VeLs() \| endif<cr>
    vmap <silent> <buffer> <space>g :cal g:VeSelectFile('s') \| let k = input('grep keywords: ') \| if k != '' \| let g:VeCommandToRun = g:VeCommands.Grep.Clone() \| let g:VeCommandToRun.Step1.Command.Value = substitute(g:VeCommandToRun.Step1.Command.Value, '%Keywords%', k, '') \| let g:VeCommandToRun.Step2.Command.Value = substitute(g:VeCommandToRun.Step2.Command.Value, '%Keywords%', k, '') \| cal g:VeRunCommand() \| cal g:VeShowCommandResults() \| exe 'let @/="' . k . '"' \| let g:VeSelectedFiles = g:Item.New1('SelectedFiles') \| cal g:VeLs() \| endif<cr>
    " <space>h Go to the parent directory
    nmap <silent> <buffer> <space>h :cal g:VeDirectoryGoto('..')<cr>
    " <space>l Open the selected item in preview window
    nmap <silent> <buffer> <space>l :cal g:VeGetPath() \| cal g:VeOpenItem('')<cr>
    " <space>L Open the selected item recursively (only the directory will open recursively, if the item is a file it will be opened like with <leader>l)
    nmap <silent> <buffer> <space>L :let g:VeRecursive = '-R' \| cal g:VeGetPath() \| cal g:VeOpenItem('')<cr>
    " <space>n New tab
    nmap <silent> <buffer> <space>n :tabnew<cr>
    " <space>o Reload directory
    nmap <silent> <buffer> <space>o :cal g:VeLs()<cr>
    " <space>o Reload configuration from file (useful if the .config.vim file was edited manually and you want to reload it in the vimExplorer window that is currently opened)
    nmap <silent> <buffer> <space>O :cal g:VeLoadFromFile(0) \| echo 'Configuration loaded from: ' . g:VeCfgFile<cr>
    " <space>P Show current path
    nmap <silent> <buffer> <space>P :pwd<cr>
    " <space>r Run the current file or the selected files
    nmap <silent> <buffer> <space>r :cal g:VeSelectFile('s') \| let g:VeCommandToRun = g:VeCommands.Run.Clone() \| cal g:VeRunCommand() \| let g:VeSelectedFiles = g:Item.New1('SelectedFiles')<cr>
    vmap <silent> <buffer> <space>r :cal g:VeSelectFile('t') \| let g:VeCommandToRun = g:VeCommands.Run.Clone() \| cal g:VeRunCommand() \| let g:VeSelectedFiles = g:Item.New1('SelectedFiles')<cr>
    " <space>s Open the selected item (in horizontal split window)
    nmap <silent> <buffer> <space>s :cal g:VeGetPath() \| cal g:VeOpenItem('s')<cr>
    " <space>t Open current file/directory or selected files/directories in new tab
    nmap <silent> <buffer> <space>t :cal g:VeSelectFile('s') \| let g:VeCommandToRun = g:VeCommands.OpenInNewTab.Clone() \| cal g:VeRunCommand() \| let g:VeSelectedFiles = g:Item.New1('SelectedFiles')<cr>
    vmap <silent> <buffer> <space>t :cal g:VeSelectFile('t') \| let g:VeCommandToRun = g:VeCommands.OpenInNewTab.Clone() \| cal g:VeRunCommand() \| let g:VeSelectedFiles = g:Item.New1('SelectedFiles')<cr>
    " <space>v Open the selected item (in vertical split window)
    nmap <silent> <buffer> <space>v :cal g:VeGetPath() \| cal g:VeOpenItem('v')<cr>
    " <space>S Save configuration file
    nmap <silent> <buffer> <space>S :cal g:VeSaveBar('History') \| cal g:VeSaveBar('Favorites') \| cal g:VeSaveToFile() \| echo 'Configuration saved to: ' . g:VeCfgFile<cr>
    " <space>H Delete the browsing history
    nmap <silent> <buffer> <space>H :let g:VeCfg.History.Value = '' \| cal g:VeLs()<cr>
    " <space>X Open current directory with the gvim "browse" command to open a file in the current buffer
    nmap <silent> <buffer> <space>X :cal g:VeGetPath() \| exe 'browse e ' . g:VePath<cr>
    " <space>z Return to last path visited (toggle current and previous)
    nmap <silent> <buffer> <space>z :cal g:VeDirectoryGoto(g:VePreviousPath)<cr>
    " -- Mappings: Windows specific {{{1
    if has('Win32') == 1
        " <space>c Clone file
        nmap <silent> <buffer> <space>c :cal g:VeGetPath() \| let t = g:VeFileName . '_' . substitute(strftime('%x_%X'), ':', '-', 'g') \| cal system('copy ' . g:VePaths.FileName2Q . ' "' . t . '"') \| cal g:VeLs() \| cal search(t)<cr>
        " <space>C Open directory in shell
        nmap <silent> <buffer> <space>C :silent exe '!start cmd /k'<cr>
        " <space>p Copy path to clipboard
        nmap <silent> <buffer> <space>p :cal g:VeGetPath() \| let @* = g:VePaths.FullPathB \| echo 'Path copied to clipboard: ' . g:VePaths.FullPathB \| echo ' Path source: ' . g:VePathSource<cr>
        " <space>R Rename file
        nmap <silent> <buffer> <space>R :cal g:VeGetPath() \| unlet! t \| let t = input('rename to: ', g:VeFileName) \| cal system('ren ' . g:VePaths.FileName2Q . ' "' . t . '"') \| cal g:VeLs() \| cal search(t)<cr>
        " <space>x Open directory in windows explorer
        nmap <silent> <buffer> <space>x :cal g:VeGetPath() \| exe 'silent !start explorer.exe ' . g:VePaths.PathB2Q<cr>
        " <space>9 Change the ls command for "UnxUtils" ls command
        nmap <silent> <buffer> <space>9 :let g:VeLsCmdPath = g:VeLsCmdPathU \| cal g:VeLs()<cr>
        " <space>0 Change the ls command for "Cygwin" ls command
        nmap <silent> <buffer> <space>0 :let g:VeLsCmdPath = g:VeLsCmdPathC \| cal g:VeLs()<cr>
    " -- Mappings: Linux specific {{{1
    else
        " <space>C Open directory in shell
        nmap <silent> <buffer> <space>C :sh<cr>") 
        " <space>c Clone file
        nmap <silent> <buffer> <space>c :cal g:VeGetPath() \| let t = g:VeFileName . '_' . substitute(strftime('%x_%X'), ':', '-', 'g') \| cal system('cp ' . g:VePaths.FileName2Q . ' "' . t . '"') \| cal g:VeLs() \| cal search(t)<cr>
        " <space>p Copy path
        nmap <silent> <buffer> <space>p :cal g:VeGetPath() \| let @* = g:VePaths.FullPathS \| echo "Path copied to clipboard: ' . g:VePaths.FullPathS<cr>') 
        " <space>R Rename file
        nmap <silent> <buffer> <space>R :cal g:VeGetPath() \| unlet! t \| let t = input("rename to: ', g:VeFileName) \| cal system('mv ' . g:VePaths.FileName2Q . ' "' . t . '"') \| cal g:VeLs() \| cal search(t)<cr>
        " <space>x Open directory in thunar
        nmap <silent> <buffer> <space>x :cal g:VeGetPath() \| exe "silent !thunar ' . g:VePaths.PathS2Q<cr>
    endif

    " -- Mappings: For marks (bookmarks) {{{1
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

    " -- Mappings: File selection {{{1
    " <esc> Remove file selection
    nmap <silent><buffer> <esc> :let g:VeSelectedFiles = g:Item.New1('SelectedFiles') \| cal g:VeLs()<cr>
    " <c-c> Copy files, toggle select/deselect the file or files (if there are files selected in visual mode) and select the copy command as the command to run 
    nmap <silent> <buffer> <c-c> :cal g:VeSelectFile('t') \| let g:VeCommandToRun = g:VeCommands.Copy.Clone()<cr>
    vmap <silent> <buffer> <c-c> :cal g:VeSelectFile('t') \| let g:VeCommandToRun = g:VeCommands.Copy.Clone()<cr>
    " <c-x> Move files, toggle select/deselect the file or files (if there are files selected in visual mode) and select the move command as the command to run 
    nmap <silent> <buffer> <c-x> :cal g:VeSelectFile('t') \| let g:VeCommandToRun = g:VeCommands.Move.Clone()<cr>
    vmap <silent> <buffer> <c-x> :cal g:VeSelectFile('t') \| let g:VeCommandToRun = g:VeCommands.Move.Clone()<cr>
    " <c-s> Toggle select/deselect selected the file or files (if there are files selected in visual mode) to do an operation on it like copy, move, delete, grep etc
    nmap <silent> <buffer> <c-s> :cal g:VeSelectFile('t')<cr>
    vmap <silent> <buffer> <c-s> :cal g:VeSelectFile('t')<cr>
    " <c-v> Paste files, runCommands in the target window (usually a paste command which is the copy or move itself)
    nmap <silent> <buffer> <c-v> :cal g:VeGetPath() \| cal g:VeRunCommand() \| let g:VeSelectedFiles = g:Item.New1('SelectedFiles') \| cal g:VeLs()<cr>
    " <c-u> Run the user defined command (the user may set a command to it to run on the selected files) See section "How to run user-defined commands on selected files"
    nmap <silent> <buffer> <c-u> :VimExplorerUserCommand
endfu

" Mappings: To debug {{{1

" <leader>des To inspect the content of the g:VeSelectedFile object
nmap <silent> <leader>des :new \| cal append(0, g:VeSelectedFiles.ToXmlList())<cr>

" <leader>dec To inspect the content of the g:VeCommands object
nmap <silent> <leader>dec :new \| cal append(0, g:VeCommands.ToXmlList())<cr>

" <leader>der To inspect the content of the g:VeCommandToRun object
nmap <silent> <leader>der :new \| cal append(0, g:VeCommandToRun.ToXmlList())<cr>

" Functions: Directory browsing {{{1

" s:SetCursorPos(path) {{{2
" Remember cursor position using the filename or the cursor coordinates
" The "path" parameter indicates to which directory the cursor position is remembered, it is the key
fu! s:SetCursorPos(path)
    " Exit if no path, for example for the first path browse there is not path where to set cursor
    if a:path == ''
        return
    endif
    " To get the "g:VePaths.FileName" and the "g:VePathSource" {{{3
    cal g:VeGetPath()
    " If the key "a:path" dosen't exist {{{3
    if g:VeCfg.CursorPos.Contains(a:path) == 0
        " Use the filename (default value) to go to position if it is a PathSource 'd' or 'f' (directory or file) that are inside the directory listing {{{4
        if g:VePathSource == 'd' || g:VePathSource == 'f'
            cal g:VeCfg.CursorPos.Add(g:Item.New2(a:path, g:VePaths.FileName))
        " Use the coordinates to go to the position if the position  {{{4
        else
            " A join is done to make the array into a string, not to have a string inside the object tree
            cal g:VeCfg.CursorPos.Add(g:Item.New2(a:path, join(getpos('.'))))
        endif
    else " If it exists, set its value {{{3
        " Use the filename (default value) to go to position if it is a PathSource 'd' or 'f' (directory or file) that are inside the directory listing {{{4
        if g:VePathSource == 'd' || g:VePathSource == 'f'
            let g:VeCfg.CursorPos[a:path].Value = g:VePaths.FileName
        " Use the coordinates to go to the position if the position  {{{4
        else
            " A join is done to make the array into a string, not to have a string inside the object tree
            let g:VeCfg.CursorPos[a:path].Value = join(getpos('.'))
        endif
    endif
    " Remember the PathSource also to know how to interpret the value {{{3
    if g:VeCfg.CursorPos[a:path].Contains('PathSource') == 0
        cal g:VeCfg.CursorPos[a:path].Add(g:Item.New2('PathSource', g:VePathSource))
    else
        let g:VeCfg.CursorPos[a:path].PathSource.Value = g:VePathSource
    endif
endfu

" s:ChangeDirectory(path) {{{2
" Change directory
fu! s:ChangeDirectory(path)
    " Used to toggle between the current path and the previous path (different from LastPath which is used to save and retrieve the last path used by VimExplorer)
    let g:VePreviousPath = g:VePath
    " Put the path is a modifiable variable
    let path = a:path
    " If the path contains double / in case of root paths (c:/, d:/ etc) where usually paths don't end with a trailling /, root paths always have trailling /, so they may be one to many 
    if has("Win32") && len(path) == 4
        let path = substitute(path, '//', '/', 'g')
    endif
    " Change to the directory in vim (if the VimExplorer.xml is deleted and VimExplorerE is called when vim is starting up, there will be an echo of the path after the following instruction)
    exe 'cd ' . path
    " Get real path from vim without /../.. etc
    let path = getcwd()
    " Change to the directory in shell
    cal system('cd "' . path . '"')
    " If the path is with "\" the change them for "/"
    if stridx(path, '\') != -1
        let path = substitute(path, '\', '/', 'g')
    endif
    " Set the global path
    let g:VePath = path
endfu

" g:VeGetPath() {{{2
" To get the paths for external use
" It may be called to get path formats from a file in edition as well
fu! g:VeGetPath()
    " If the window is a vimExplorer window {{{3
    if s:IsPluginWindow() == 1
        " Get the line to check for fileName and path patterns
        let line = getline(line('.'))
        " Get the file name on the current line {{{4
        " Check if currently inside the directory listing {{{5
        " If the line is before the first line of the directory listing, don't get the filename
        if line('.') >= g:VeGetDirectoryListLineNum()
            " Set the patterns to get the fileName {{{5
            " Check if there is a "/" on the line, if yes then it means a filter is used, if no then use the normal pattern for when there are no filters. The ls adds the path of the file when a filter is used
            " No filter used {{{6
            if stridx(line, '/') == -1
                " -rw-r--r-- 1 User None 40960 Dec  7 14:46 vimExplorer.vim
                " Test from here ------------^ until here -^
                let pattern = '[0-9]\s\w\{3\}\s\(\s\|[0-9]\)[0-9]\s\([0-9][0-9]:[0-9][0-9]\|\s[0-9]\{4\}\)\s\zs.*'
            " A filter is used {{{6
            else
                " -rwxr-xr-x 1 User None  536064 Feb  3  2009 C:/Usb/z_white/Apps/Portable/CmdUtils/7z.exe
                "^----- Test from here until here -------------------------------------------------^
                let pattern = '^.*\/\zs.*$'
            endif
            " Get the fileName {{{5
            let g:VeFileName = matchstr(line, pattern)
        endif
        " Variables to check for paths {{{4
        let path = ''
        let g:VeFileLineNum = 0
        let g:VePathSource = ''
        " Attempt to get the path from a directory in a directory listing {{{4
        " Example: 'drwxrwxrwx ' 
        if line =~ '^d.\{9}\s' 
            " Indicate that the path was taken from a directory in a directory listing
            let g:VePathSource = 'd'
        " Attempt to get the path from a file in a directory listing {{{4
        " Example: '-rwxrwxrwx ' 
        elseif line =~ '^-.\{9}\s' 
            " Indicate that the path was taken from a file in a directory listing
            let g:VePathSource = 'f'
        " Attempt to get the path from a grep result {{{4
        " Example: 'C:/vim/vim73/plugin/dbext.vim:66:command! -range -nargs=0 DBExecRangeSQL <line1>,<line2>caldbext#DB_execRangeSql()'
        elseif line =~ '^.\{-}:[0-9]\+:.*$'
            " Get the file path from the line
            let path = matchstr(line, '^\zs.*.\{-}\ze:[0-9]\+:.*$')
            " Extract the filename from the path
            let g:VeFileName = fnamemodify(path, ':t')
            " Extract the directory from the path
            let path = substitute(fnamemodify(path, ':p:h'), '\', '/', 'g')
            " Get the line number from the line
            let g:VeFileLineNum = matchstr(line, '^.*.\{-}:\zs[0-9]\+\ze:.*$')
            " Indicate that the path was taken from a grep result
            if path == g:VePath
                " If the path taken from the grep result is the same as the current path, then it is a file grep result
                let g:VePathSource = 'gf'
            else
                " If the path taken from the grep result is not the same as the current path, then it is a directory grep result
                let g:VePathSource = 'gd'
            endif
        " Attempt to get the path from for a link {{{4
        " Example of links are the path bar, history bar or the favorites bar at the top of the buffer, it contains the visited paths each one enclosed in []. These links could be elsewhere.
        " Example: ' [C:/Temp] [C:/vim/vim73/plugin]'
        elseif line =~ '\s\[.\{-}/.\{-}]'
            " Variables used to check for a link
            let start = 0
            let end = 0
            " Save cursor postion
            let previous = col('.')
            " Check if the "[" is the current character {{{5
            if strpart(line, previous - 1, 1) == '['
                let start = col('.')
            else " If it is not the current character, search backwards for "["
                cal search('[', 'b')
                let start = col('.')
            endif
            " Return to previous column (position)
            exe 'norm ' . previous . '|'
            " Check if the "]" is the current character {{{5
            if strpart(line, previous - 1, 1) == ']'
                let end = col('.')
            else " If it is not the current character, search forward for "]"
                cal search(']', '')
                let end = col('.')
            endif
            " Return to previous column (position)
            exe 'norm ' . previous . '|'
            if start != 0 && end != 0
                " Get the path
                let path = strpart(line, start, abs(end - start) - 1)
                " If it is a link to file 
                if filereadable(path) == 1
                    " Extract the filename from the path
                    let g:VeFileName = fnamemodify(path, ':t')
                    " Extract the directory from the path
                    let path = fnamemodify(path, ':p:h')
                    " Indicate that the path was taken from a link
                    let g:VePathSource = 'lf'
                " If it is a link to a directory
                elseif isdirectory(path) == 1
                    " Indicate that the path was taken from a link
                    let g:VePathSource = 'ld'
                    " Empty the file name variable not to have the filename of another path with this path
                    let g:VeFileName = ''
                else
                    let path = ''
                endif
            endif
        endif
        " Attempt to get the current subdirectory path of a recursive listing that is displayed when the -R option is used {{{4
        if g:VePathSource == 'd' || g:VePathSource == 'f'
            " Remember current position
            norm m'
            " Search backwards if there is a place where there is a recusive path
            let match = search('^.*=:$', 'bW')
            " Found
            if match != 0
                " Backup register "
                let tmpReg = @" 
                " Copy the path to the " register
                norm yt=
                " Replace the "\" because in windows the recursive paths are displayed with mixed "/" and "\" (at least with the UnxUtils ls command)
                let path = substitute(@", '\', '/', 'g')
                " Set back register "
                let @" = tmpReg
                " Go back to previous position
                norm ''
                " Indicate that the path was taken from a subdirectory in a recursive listing
                " Since it is still a directory or a file but in a recursive listing, append "r" to the g:VePathSource
                let g:VePathSource = 'r' . g:VePathSource
            endif
        endif
        if path == ''
            " If root path in windows example c:/, then remove trailing slash, other paths don't have trailing slashes
            if has("Win32") && len(g:VePath) == 3
                let path = strpart(g:VePath, 0, 2)
            else
                let path = g:VePath
            endif
        endif
        " Get the path dictionary containing the multiple path formats {{{4
        let g:VePaths = s:GetPathFormats(path, g:VeFileName)
        " Set the current path
        "let g:VePath = path
    " If the window is not a vimExplorer window (like a file in edition for example) {{{3
    else
        " Get the path and file name for the current file {{{4
        let path = substitute(expand("%:p:h"), '\', '/', 'g')
        let fileName = substitute(expand("%:t"), '\', '/', 'g')
        " Get the path dictionary containing the multiple path formats
        let g:VePaths = s:GetPathFormats(path, fileName)
        " Set the current path
        "let g:VePath = path
    endif
endfu

" g:VeLs() {{{2
" List the directory
fu! g:VeLs() 
    " If the current path is not the same as the last path visited {{{3
    if g:VePath != g:VeCfg.LastPath.Value
        " Add the path to the browsing history
        cal g:VeAddToBar('History', g:VePath, s:HistoryMaxLength)
        let g:VeCfg.LastPath.Value = g:VePath
        " Reinitialize the subdirectories listing part
        let g:VeRecursiveData = []
    endif
    " Clear buffer {{{3
    let tmpReg = @"
    norm ggVGd
    let @" = tmpReg
    " List the directory {{{3
    " If not root path c:\ or another root, add quotes. Root path quoted ("c:\") will give an error. 
    " Or if there is a filter, then don't put quotes, quotes don't work in a filter
    " Silent is used to prevent message if error listing directories for example if directories are written in russian for example (if ls from UnxUtils is used), ls will say for example that c:/temp/???????: No such file or directory then say error messages that shell return 1 and how many lines else to show
    if (has("Win32") && len(g:VePath) == 3) || g:VeFilter != ''
        " Set filter
        let filter = ''
        if g:VeFilter != ''
            let filter = '/' . g:VeFilter
        endif
        exe 'silent r! ' . g:VeLsCmdPath . ' -al ' . g:VeSort . ' ' . g:VeRecursive . ' ' . g:VePath . filter
    else
        " Don't use g:VePathS2Q here because the paths in g:VeGetPath() are not updated at this point, the listing as to be completed first because the function attempts to get the recursive paths is any
        exe 'silent r! ' . g:VeLsCmdPath . ' -al ' . g:VeSort . ' ' . g:VeRecursive . ' "' . g:VePath . '"'
    endif
    " Add items at the top of the buffer {{{3
    " Show the plugin name to identify the window as a vimExplorer window (the name could be shown in the status bar doing split vimExplorer but then a enew after it would remove the name, and without enew only two or more vimExplorer window would display the same content at the same time, being refreshed at the same time)
    cal append(0, 'vimExplorer')
    " Show path at the top of the buffer
    cal append(1, 'Path: [' . g:VePath . ']')
    " Show the history bar
    cal append(2, 'History: ' . g:VeCfg.History.Value)
    " Show the favorites bar
    cal append(3, 'Favorites: ' . g:VeCfg.Favorites.Value)
    " Show the current sort order
    cal append(4, 'Sorted by: ' . g:VeSortLabel)
    " Go to first directory or first file
    exe 'norm gg' . g:VeGetDirectoryListLineNum() . 'j'
    " Set colors on specific items in the window {{{3 

    " To remove file highlighting (selection)
    cal clearmatches()

    " The color constants are defined in the selected colorscheme. If the color is not defined then it will raise an error so not to show error a try..catch is used.
    try
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
        " Grep files results
        cal matchadd('Constant', '^Grep files result')
        " Grep directories results
        cal matchadd('Constant', '^Grep directories result')
    catch
    endtry

    try
        " Sort order
        cal matchadd('Comment', '^Sorted by: \zs.\{-}\ze$')
    catch
    endtry

    try
        " Directories
        cal matchadd('Directory', '^d.*$')
    catch
    endtry

    try
        " Grep results
        "cal matchadd('htmlLink', '^.*\/.\{-}:[0-9]\+:\ze.*$')
        cal matchadd('htmlLink', '^.*.\{-}:[0-9]\+:\ze.*$')
        " Links
        cal matchadd('htmlLink', '\[\zs.\{-}\ze\]')
    catch
    endtry

    " Some files colors
    try
        cal matchadd('Number', '^.\{-}.\(exe\|EXE\)$')
    catch
    endtry

    try
        cal matchadd('Statement', '^.\{-}.\(txt\|TXT\)$')
    catch
    endtry
    " If there are previously selected files in that directory, highlight them {{{3
    cal g:VeHighlightSelectedFiles()

   " If the listing is a recursive listing, get the subdirectories listing part into a variable to be displayed again if required {{{3
   if g:VeRecursive != ''
       " Find the blank line separating the listing and the recursive data
       let start = search('^$', 'n')
       " The last line in the buffer
       let end = line('$')
       " Copy everything below that line until the end of the buffer to the variable
       let g:VeRecursiveData = getline(start, end)
   endif

    " Add the recursive listing data to the current listing if it was kept from a previous listing  {{{3
    if len(g:VeRecursiveData) > 0
        cal append('$', g:VeRecursiveData)
    endif

    " Show again the last ran command's results {{{3
    cal g:VeShowCommandResults() 
    " Find remembered cursor line position in that directory and position the cursor there {{{3
    if g:VeCfg.CursorPos.Contains(g:VePath) == 1
        if g:VeCfg.CursorPos[g:VePath].Contains('PathSource') == 1
            " Use the filename (default value) to go to position if it is a PathSource 'd' or 'f' (directory or file) that are inside the directory listing {{{4
            if g:VeCfg.CursorPos[g:VePath].PathSource.Value == 'd' || g:VeCfg.CursorPos[g:VePath].PathSource.Value == 'f'
                " Match the full name and not only part of the name which could put the cursor on the wrong file, so match from the last number of the preceding column and spaces after until the end of line $
                cal search('\([0-9]\s\+\|\/\)\zs' . g:VeCfg.CursorPos[g:VePath].Value . '$')
                normal l
            " Use the coordinates to go to the position if the position  {{{4
            else
                " Do a split to put the string into an array like the initial getpos('.')
                cal setpos('.', split(g:VeCfg.CursorPos[g:VePath].Value))
            endif
        endif
   endif
    " Reinitialize the recursive option {{{3
    let g:VeRecursive = ''
    " Append debug info at the end of buffer {{{3
    cal append(line('$'), g:Debug)
    " Reinitialize the g:Debug variable
    let g:Debug = []
endfu

" g:VeOpenItem(vSplit) {{{2
" Selects a default opening action according to the path source
fu! g:VeOpenItem(winType)
    let winType = a:winType
    " No path source {{{3
    " Simply load or reload with current path
    if g:VePathSource == ''
        cal g:VeLs()
    " Path source is a directory {{{3
    elseif g:VePathSource == 'd' || g:VePathSource == 'rd' || g:VePathSource == 'ld'
        " Get the path according to the PathSource {{{4
        let path = ''
        if g:VePathSource == 'd' || g:VePathSource == 'rd' 
            let path = g:VePaths.FullPathS
        elseif g:VePathSource == 'ld'
            let path = g:VePaths.PathS
        endif
        " If no winType specified, use a default winType {{{4
        if winType == ''
            let winType = 'e'    
        endif
        " Open in the current window {{{4
        if winType == 'e'
            cal g:VeDirectoryGoto(path) 
        " Open in a new split (horizontal) window {{{4
        elseif winType == 's'
            exe 'VimExplorerSP ' . path
        " Open in a new vsplit (vertical) window {{{4
        elseif winType == 'v'
            exe 'VimExplorerVP ' . path
        " Open in a new tab {{{4
        elseif winType == 't'
            exe 'VimExplorerTP ' . path
        endif
    " Path source is a file {{{3
    elseif g:VePathSource == 'f' || g:VePathSource == 'gf' || g:VePathSource == 'gd' || g:VePathSource == 'lf' || g:VePathSource == 'rf'
        " Don't remember the cursor's position when it is a link
        if g:VePathSource != 'lf'
            " Remember the cursor position before opening the item {{{4
            cal s:SetCursorPos(g:VePath)
        endif
        " Open in the current window {{{4
        if winType == 'e'
            exe 'edit +' . g:VeFileLineNum . ' ' . g:VePaths.FullPathS
        " Open in a new split (horizontal) window {{{4
        elseif winType == 's'
            exe 'split +' . g:VeFileLineNum . ' ' . g:VePaths.FullPathS
        " Open in a new vsplit (vertical) window {{{4
        elseif winType == 'v'
            exe 'vsplit +' . g:VeFileLineNum . ' ' . g:VePaths.FullPathS
        " Open in a new tab {{{4
        elseif winType == 't'
            exe 'tabe +' . g:VeFileLineNum . ' ' . g:VePaths.FullPathS
        " If no winType specified, use the preview window 
        else
            exe 'pedit +' . g:VeFileLineNum . ' ' . g:VePaths.FullPathS
        endif
    endif
endfu

" g:VeDirectoryGoto(path) {{{2
" Go to specified directory
fu! g:VeDirectoryGoto(path)
    " Don't remember the cursor's position when it is a link
    if g:VePathSource != 'ld'
        " Remember the cursor position before opening the item {{{3
        cal s:SetCursorPos(g:VePath)
    endif
    " Save the bars to the config before to clear the buffer {{{3
    cal g:VeSaveBar('History')
    cal g:VeSaveBar('Favorites')
    " Change directory {{{3
    cal s:ChangeDirectory(a:path)
    " List the directory {{{3
    cal g:VeLs()
endfu

" g:VeAddToBar() {{{2
" Add the path to one of the bar at the top of the buffer
fu! g:VeAddToBar(barName, path, barMaxLength)
    " The paths are appended in the reverse order so the newest paths appear first in the list
    let tmp = '[' . a:path . ']' . ' ' . g:VeCfg[a:barName].Value
    " Check if bar dosen't become too much long
    if len(tmp) > a:barMaxLength
        " If bar is more long than max length allowed, then empty it and put the last path inside
        let bar = '[' . a:path . ']'
    else
        " If history not too long, then add the last path
        let bar = tmp
    endif
    " Add bar to configuration dictionnary
    let g:VeCfg[a:barName].Value = bar
endfu

" g:VeGetDirectoryListLineNum() {{{2
" Get the line number where the directory listing is starting
fu! g:VeGetDirectoryListLineNum()
    let lastPosition = getpos('.')
    norm gg
    cal search('^total\s[0-9]\+')
    let lineNum = line('.')
    call setpos('.', lastPosition)
    return lineNum
endfunction

" Functions: Directory marks {{{1

" g:VeMarkPath(mark) {{{2
" Mark the current directory with the specified mark, keep the directory in memory
fu! g:VeMarkPath(mark)
    " Check if mark exists
    if g:VeCfg.Marks.Contains(a:mark) == 0
        " If the mark dosen't exists yet, create it
        cal g:VeCfg.Marks.Add(g:Item.New2(a:mark, g:VePath))
    else
        " If the mark exists, set it to the new value
        let g:VeCfg.Marks[a:mark].Value = g:VePath
    endif
endfu

" g:VeGotoMark(mark) {{{2
" Change directory according to the path for specified mark
fu! g:VeGotoMark(mark)
    " Check if mark exists, change to its path only if exists
    if g:VeCfg.Marks.Contains(a:mark) == 1
        let path = g:VeCfg.Marks[a:mark].Value
        cal g:VeGetPath()
        " Go to the directory
        cal g:VeDirectoryGoto(path)
    endif
endfu

" g:VeShowMarks(sortByPath) {{{2
" Show all marked directories
" Listing may be shown sorted by marks or by path
fu! g:VeShowMarks(sortByPath)
    if !empty(g:VeCfg.Marks)
        if a:sortByPath == 0
            for key in sort(keys(g:VeCfg.Marks))
                " If the type is a dictionary. See :h type
                if type(g:VeCfg.Marks[key]) == type({})
                    echo key . ' = ' . g:VeCfg.Marks[key].Value
                endif
            endfor
        else " a:sortByPath == 1
            let sortList = []
            " Put vals and keys to a list for sorting, because in a dictionary its impossible it seems to sort with both key AND val at the same time
            for key in keys(g:VeCfg.Marks)
                " If the type is a dictionary. See :h type
                if type(g:VeCfg.Marks[key]) == type({})
                    cal add(sortList, g:VeCfg.Marks[key].Value . ' = ' . key)
                endif
            endfor
            " Echo the sorted list
            for val in sort(sortList)
                echo val
            endfor
        endif
        let m = input("Enter mark:" ) 
        if m != ''
            cal g:VeGotoMark(m)
        endif
    endif
endfu

" Functions: File selection {{{1

" g:VeHighlightFile(pathSource, path, fileName, line) {{{2
" Highlight the specified file
fu! s:HighlightFile(pathSource, path, fileName, line)
    " If the pathSource is a link to a file
    if a:pathSource == 'lf' 
        let pattern = '\[' . a:path . '/' . a:fileName . '\]'
    " If the pathSource is a link to a directory
    elseif a:pathSource == 'ld'
        let pattern = '\[' . a:path . '\]'
    " If the pathSource is a grep file result
    elseif a:pathSource == 'gf'
        let pattern = '^.\{-}' . a:fileName . '\ze:[0-9]\+:.*$'
    " If the pathSource is a grep directory result
    elseif a:pathSource == 'gd'
        let pattern = '^.\{-}' . a:path . '/' . a:fileName . '\ze:[0-9]\+:.*$'
    else
        " No filter used {{{3
        if stridx(a:line, '/') == -1
            " -rw-r--r-- 1 User None 40960 Dec  7 14:46 vimExplorer.vim
            " Test from here ------------^ until here -^
            let pattern = '^.*[0-9]\s\w\{3\}\s\(\s\|[0-9]\)[0-9]\s\([0-9][0-9]:[0-9][0-9]\|\s[0-9]\{4\}\)\s' . a:fileName . '$'
        " A filter is used {{{3
        else
            " -rwxr-xr-x 1 User None  536064 Feb  3  2009 C:/Usb/z_white/Apps/Portable/CmdUtils/7z.exe
            "^----- Test from here until here -------------------------------------------------^
            let pattern = '^.*\/' . a:fileName . '$'
        endif
    endif
    return matchadd('search', pattern)
endfu

" g:VeSelectFile(mode) {{{2
" Select/deselect the file to do a batch operation on it
" Select/deselect visual mode selected lines to do a batch operation the files (if there is a visual selection)
" To inspect content of g:VeSelectedFile, do: enew | cal append(0, g:VeSelectedFiles.ToXmlList())
fu! g:VeSelectFile(mode) range
    "Step through each line in the range {{{3
    for lineNum in range(a:firstline, a:lastline)
        " Remember column position, because the next instruction "Go to the line number" will put cursor on position 1 on the line, and in case of links we need more accurate column position
        let colPos = col('.')
        " Go to the line number
        exe 'norm ' . lineNum . 'G'
        " Go back to column position
        exe 'norm ' . colPos . '|'
        " Get the path of the current line
        cal g:VeGetPath()
        " Check if path already selected {{{4
        let matchId = ''
        " Get the match id of the selected file {{{4
        if g:VeSelectedFiles.Contains(g:VePaths.FullPathS) == 1
            let matchId = g:VeSelectedFiles[g:VePaths.FullPathS].MatchId.Value
        endif
        " If select mode and path not already selected {{{4
        if (a:mode == 's' || a:mode == 't') && matchId == ''
            let line = getline(line('.'))
            let matchId = s:HighlightFile(g:VePathSource, g:VePaths.PathS, g:VePaths.FileName, line)
            " Add the path and file name to the selected files {{{5
            " g:VeFullPathS is not used because with it there may be a confusion between the path and the filename if the path and file name are extracted later using fnamemodify(":p:h") and fnamemodify(":t"), and also because the path source is included to know if it is a file or a directory
            cal g:VeSelectedFiles.Add(g:Item.New1(g:VePaths.FullPathS))
            cal g:VeSelectedFiles[g:VePaths.FullPathS].Add(g:Item.New2('Line', line))
            cal g:VeSelectedFiles[g:VePaths.FullPathS].Add(g:Item.New2('Path', g:VePaths.PathS))
            cal g:VeSelectedFiles[g:VePaths.FullPathS].Add(g:Item.New2('FileName', g:VePaths.FileName))
            cal g:VeSelectedFiles[g:VePaths.FullPathS].Add(g:Item.New2('PathSource', g:VePathSource))
            cal g:VeSelectedFiles[g:VePaths.FullPathS].Add(g:Item.New2('MatchId', matchId))
            cal g:VeSelectedFiles[g:VePaths.FullPathS].Add(g:Item.New2('FileLineNum', g:VeFileLineNum))
        " Path already selected {{{4
        elseif a:mode == 'd' || a:mode == 't' 
            " Delete highlighting for this filename {{{5
            try
                cal matchdelete(matchId)
            catch
            endtry
            " Remove the item from the selected files {{{5
            cal g:VeSelectedFiles.Remove(g:VePaths.FullPathS)
        endif
    endfor
endfu

" g:VeHighlightSelectedFiles() {{{2
" Highlight files that are in the selected files object 
fu! g:VeHighlightSelectedFiles()
    " Loop all selected files in the selected files {{{3
    for key in keys(g:VeSelectedFiles)
        " If the type is a dictionary. See :h type
        if type(g:VeSelectedFiles[key]) != type({})
            continue
        endif
        cal s:HighlightFile(g:VeSelectedFiles[key].PathSource.Value, key, g:VeSelectedFiles[key].FileName.Value, g:VeSelectedFiles[key].Line.Value) 
    endfor  
endfu

" g:VeRunCommand() {{{2
" Run a command on selected files
" You may use at least one of the following placeholders in the command where needed: %FullPath%, %Path%, %FileName%, %FullPaths%, %Paths%, %FileNames%, and most of the path variables set in the "g:VeGetPath()" function, some like g:FileName or g:FullPathS etc are not needed because it is the destination path that is needed here.
" The placeholders in the command must be cased exactly (sensitive)
fu! g:VeRunCommand()
    " Check if the user has selected files, if not then show error and exit
    if g:VeSelectedFiles.Count() == 0
        echo 'No files selected.'
        return
    endif
    " Remember the path where the command was executed
    if g:VeCommandToRun.Contains('PathWhereExe') == 1
        let g:VeCommandToRun.PathWhereExe.Value = g:VePath
    endif
    " Need to initialize these variable in case they would be empty after looping the selected files and trying to access them to replace the placeholders (the variable would not be declared)
    let selPaths = {}
    let curPaths = {}
    " Loop the keys of the commands (at the level for example of the "ExeForEachFile" key, or the "Step1", "Step2", etc. keys {{{3
    for stepKey in keys(g:VeCommandToRun)
        " If the type is not a dictionary. See :h type {{{4
        if type(g:VeCommandToRun[stepKey]) != type({})
            continue
        endif
        " If the key is not a command "Step" then continue, only command "Steps" are executed such as "Step1", "Step2" etc. {{{4
        if stepKey !~ 'Step'
            continue
        endif
        " Check if the "Step" "Command" is not empty 
        if g:VeCommandToRun[stepKey].Command.Value == '' 
            return
        endif
        " Execute the command for each file {{{5
        if g:VeCommandToRun['ExeForEachFile'].Value == 1
            " Loop each selected file and execute the command on each {{{6
            for selFileKey in keys(g:VeSelectedFiles)
                " If the type is not a dictionary. See :h type {{{7
                if type(g:VeSelectedFiles[selFileKey]) != type({})
                    continue
                endif
                " Execute the command only if the path source of the file is the same as the path source specified for the command parameters. This way we may indicate that the command for example would be run only if the file is a directory, like for a mkdir command for example. {{{7
                if g:VeSelectedFiles[selFileKey].PathSource.Value != g:VeCommandToRun[stepKey].PathSource.Value
                    continue
                endif
                " Put the command in a temporary variable because its placeholders will be replaced {{{7
                let command = g:VeCommandToRun[stepKey].Command.Value
                " Replace the selected placeholders {{{7
                " Get the path formats for the selected full path
                let selPaths = s:GetPathFormats(g:VeSelectedFiles[selFileKey].Path.Value, g:VeSelectedFiles[selFileKey].FileName.Value)
                for [placeholder, pathFormat] in items(selPaths)
                    let command = substitute(command, '%Sel' . placeholder . '%', pathFormat, 'g')
                endfor
                " Replace the selected file "PathSource" {{{7
                let command = substitute(command, '%SelPathSource%', g:VeSelectedFiles[selFileKey].PathSource.Value, 'g')
                " Replace the current directory placeholders {{{7
                " Get the path formats for the current directory
                let curPaths = s:GetPathFormats(g:VePath, g:VeFileName)
                for [placeholder, pathFormat] in items(curPaths)
                    let command = substitute(command, '%Cur' . placeholder . '%', pathFormat, 'g')
                endfor
                " Replace the "Step" "PathSource" {{{7
                let command = substitute(command, '%StepPathSource%', g:VeCommandToRun[stepKey].PathSource.Value, 'g')
                " Replace the "FileLineNum" {{{7
                let command = substitute(command, '%FileLineNum%', g:VeSelectedFiles[selFileKey].FileLineNum.Value, 'g')
                " Execute the command {{{7
                " Leave this echo command, it shows a progression if there are many files to copy or move for example
                "echo command
                " For now the encoding used for shell commands is 'latin1' which supports french special characters like accents, that makes it possible to run commands or copy (etc) files that have these special characters in their path. But it is not possible for now to run commands on files with other characters than included in 'latin1' encoding, like russian characters, chinese characters etc You may change the 'latin1' by something else if you wish. If I find a solution that works universally for all languages, like the use of utf-8, I will do the modification for it.
                " Windows
                if has('Win32')
                    exe iconv(command, &enc, 'latin1')
                " Linux
                else
                    exe command
                endif
                " To show last command executed on selected files after the file listing {{{7
                if s:ShowLastCommands == 1
                    cal add(g:Debug, 'Command: ' . command)
                endif
            endfor
        " Execute the command one time on all the files {{{3
        else
            " To count the number of files that pass the PathSource check, because for example if only files are selected and no directories but there is a command "Step2" with the PathSource = 'd' the command should not be executed so count how many pass the test and execute only if the count is greater than zero
            " It is necessary to count here because the "exe command" is not inside the selected files loop and would be executed even if no files passed the "PathSource" check
            let nbSelFile = 0
            " Put the command in a temporary variable because its placeholders will be replaced {{{4
            let command = g:VeCommandToRun[stepKey].Command.Value
            " Loop each selected file and execute the command on each {{{4
            for selFileKey in keys(g:VeSelectedFiles)
                " If the type is not a dictionary. See :h type {{{7
                if type(g:VeSelectedFiles[selFileKey]) != type({})
                    continue
                endif
                " Execute the command only if the path source of the file is the same as the path source specified for the command parameters. This way we may indicate that the command for example would be run only if the file is a directory, like for a mkdir command for example. {{{5
                if g:VeSelectedFiles[selFileKey].PathSource.Value != g:VeCommandToRun[stepKey].PathSource.Value
                    continue
                endif
                " How many files passed the preceding "PathSource" check
                let nbSelFile = nbSelFile + 1
                " Replace the selected placeholders {{{5
                " Get the path formats for the selected full path
                let selPaths = s:GetPathFormats(g:VeSelectedFiles[selFileKey].Path.Value, g:VeSelectedFiles[selFileKey].FileName.Value)
                " Replace the placeholder but add the same placeholder to the right of the replace value with a space between as a file separator. This new placeholder will be replaced by the next file and so on.
                for [placeholder, pathFormat] in items(selPaths)
                    let command = substitute(command, '%Sel' . placeholder . '%', pathFormat . ' %Sel' . placeholder . '%', '')
                endfor
                " Replace the current directory placeholders {{{5
                " Get the path formats for the current directory
                let curPaths = s:GetPathFormats(g:VePath, g:VeFileName)
                " Replace the placeholder but add the same placeholder to the right of the replace value with a space between as a file separator. This new placeholder will be replaced by the next file and so on.
                for [placeholder, pathFormat] in items(curPaths)
                    let command = substitute(command, '%Cur' . placeholder . '%', pathFormat . ' %Cur' . placeholder . '%', '')
                endfor
                " Replace the selected file "PathSource" {{{4
                let command = substitute(command, '%SelPathSource%', g:VeSelectedFiles[selFileKey].PathSource.Value, '')
                " Replace the "Step" "PathSource" {{{4
                let command = substitute(command, '%StepPathSource%', g:VeCommandToRun[stepKey].PathSource.Value, '')
                " Replace the "FileLineNum" {{{4
                let command = substitute(command, '%FileLineNum%', g:VeSelectedFiles[selFileKey].FileLineNum.Value, 'g')
            endfor
            " If no files passed the "PathSource" check, exit
            if nbSelFile == 0
                return
            endif
            " Remove the last placeholder {{{4
            " Get the path formats for the selected full path
            for placeholder in keys(selPaths)
                let command = substitute(command, '%Sel' . placeholder . '%', '', 'g')
            endfor
            " Remove the last current directory placeholder {{{4
            " Get the path formats for the current directory
            for placeholder in keys(curPaths)
                let command = substitute(command, '%Cur' . placeholder . '%', '', 'g')
            endfor
            " Execute the command {{{4
            " Leave this echo command, it shows a progression if there are many files to copy or move for example
            "echo command
            "exe command
            " For now the encoding used for shell commands is 'latin1' which supports french special characters like accents, that makes it possible to run commands or copy (etc) files that have these special characters in their path. But it is not possible for now to run commands on files with other characters than included in 'latin1' encoding, like russian characters, chinese characters etc You may change the 'latin1' by something else if you wish. If I find a solution that works universally for all languages, like the use of utf-8, I will do the modification for it.
            " Windows
            if has('Win32')
                exe iconv(command, &enc, 'latin1')
            " Linux
            else
                exe command
            endif
            " To show last command executed on selected files after the file listing {{{7
            if s:ShowLastCommands == 1
                cal add(g:Debug, 'Command: ' . command)
            endif
        endif
    endfor
endfu

" g:VeShowCommandResults() {{{2
" Show the last ran command's results (if any) that are kept in the "Result" item of each command "Step"
" An example of results kept is the "Grep" command define above
fu! g:VeShowCommandResults()
    " These if-endif instructions will allow the results to still be shown after changing directories if specified by AfterCdShowResults being set to 1 {{{3
    if g:VeCommandToRun.Contains('PathWhereExe') == 0
        return
    endif
    if g:VeCommandToRun.Contains('AfterCdShowResults') == 0
        return
    endif
    " If the current directory is not the same as the directory where the command was executed
    if g:VeCommandToRun.PathWhereExe.Value != g:VePath
        " Quit if the variable "AfterCdShowResults" is not set to 1 indicating to show results if the current directory is not the same as the directory where the command was ran
        if g:VeCommandToRun.AfterCdShowResults.Value == 0
            return
        endif
    endif
    " Loop the steps {{{3
    for stepKey in keys(g:VeCommandToRun)
        " If the type is not a dictionary. See :h type {{{4
        if type(g:VeCommandToRun[stepKey]) != type({})
            continue
        endif
        " If the key is not a command "Step" then continue, only command "Steps" are executed such as "Step1", "Step2" etc. {{{4
        if stepKey !~ 'Step'
            continue
        endif
        if g:VeCommandToRun[stepKey].Contains('Result') == 1
            " Before showing Step1, add a blank line to do separation from the listing
            if stepKey == 'Step1'
                norm Go
            endif
            " Append the result
            cal append(line('$'), split(g:VeCommandToRun[stepKey].Result.Value, '\n'))
        endif
    endfor
endfu

" Functions: Utility {{{1

" s:GetPathFormats(path, fileName) {{{2
" Function to return a dictonnary containing a variety of path formats from a full path passed in parameters
fu! s:GetPathFormats(path, fileName)
    " Formats dictionary to fill and return {{{3
    let formats = {
        \'FileName' : ''
        \, 'FileNameQ' : ''
        \, 'FileName2Q' : ''
        \, 'PathS' : ''
        \, 'PathSQ' : ''
        \, 'PathS2Q' : ''
        \, 'FullPathS' : ''
        \, 'FullPathSQ' : ''
        \, 'FullPathS2Q' : ''
        \, 'PathB' : ''
        \, 'PathBQ' : ''
        \, 'PathB2Q' : ''
        \, 'FullPathB' : ''
        \, 'FullPathBQ' : ''
        \, 'FullPathB2Q' : ''
        \, 'Path2B' : ''
        \, 'Path2BQ' : ''
        \, 'Path2B2Q' : ''
        \, 'FullPath2B' : ''
        \, 'FullPath2BQ' : ''
        \, 'FullPath2B2Q' : ''
        \, 'DosFileName' : ''
        \, 'DosFileNameQ' : ''
        \, 'DosFileName2Q' : ''
        \, 'DosPathS' : ''
        \, 'DosPathSQ' : ''
        \, 'DosPathS2Q' : ''
        \, 'DosFullPathS' : ''
        \, 'DosFullPathSQ' : ''
        \, 'DosFullPathS2Q' : ''
        \, 'DosPathB' : ''
        \, 'DosPathBQ' : ''
        \, 'DosPathB2Q' : ''
        \, 'DosFullPathB' : ''
        \, 'DosFullPathBQ' : ''
        \, 'DosFullPathB2Q' : ''
        \, 'DosPath2B' : ''
        \, 'DosPath2BQ' : ''
        \, 'DosPath2B2Q' : ''
        \, 'DosFullPath2B' : ''
        \, 'DosFullPath2BQ' : ''
        \, 'DosFullPath2B2Q' : ''
    \}
    " FileName {{{3
    let formats.FileName = a:fileName
    let formats.FileNameQ = "'" . formats.FileName . "'"
    let formats.FileName2Q = '"' . formats.FileName . '"'
    " With / {{{3
    let formats.PathS = a:path
    let formats.PathSQ = "'" . formats.PathS . "'"
    let formats.PathS2Q = '"' . formats.PathS . '"'
    let formats.FullPathS = formats.PathS . '/' . formats.FileName
    let formats.FullPathSQ = "'" . formats.FullPathS . "'"
    let formats.FullPathS2Q = '"' . formats.FullPathS . '"'
    " With \ {{{3
    let formats.PathB = substitute(formats.PathS, '/', '\', 'g')
    let formats.PathBQ = "'" . formats.PathB . "'"
    let formats.PathB2Q = '"' . formats.PathB . '"'
    let formats.FullPathB = formats.PathB . '\' . formats.FileName
    let formats.FullPathBQ = "'" . formats.FullPathB . "'"
    let formats.FullPathB2Q = '"' . formats.FullPathB . '"'
    " With \\ {{{3
    let formats.Path2B = substitute(formats.PathS, '/', '\\\\', 'g')
    let formats.Path2BQ = "'" . formats.Path2B . "'"
    let formats.Path2B2Q = '"' . formats.Path2B . '"'
    let formats.FullPath2B = formats.Path2B . '\\' . formats.FileName
    let formats.FullPath2BQ = "'" . formats.FullPath2B . "'"
    let formats.FullPath2B2Q = '"' . formats.FullPath2B . '"'
    " Dos variants of paths containing a ~ if the directory or filename is longer than 8 characters
    if has('Win32')
        " DosFileName {{{3
        let formats.DosFileName = fnamemodify(a:fileName, ":8")
        let formats.DosFileNameQ = "'" . formats.FileName . "'"
        let formats.DosFileName2Q = '"' . formats.FileName . '"'
        " With / {{{3
        let formats.DosPathS = fnamemodify(a:path, ":8")
        let formats.DosPathSQ = "'" . formats.DosPathS . "'"
        let formats.DosPathS2Q = '"' . formats.DosPathS . '"'
        let formats.DosFullPathS = formats.DosPathS . '/' . formats.DosFileName
        let formats.DosFullPathSQ = "'" . formats.DosFullPathS . "'"
        let formats.DosFullPathS2Q = '"' . formats.DosFullPathS . '"'
        " With \ {{{3
        let formats.DosPathB = substitute(formats.DosPathS, '/', '\', 'g')
        let formats.DosPathBQ = "'" . formats.DosPathB . "'"
        let formats.DosPathB2Q = '"' . formats.DosPathB . '"'
        let formats.DosFullPathB = formats.DosPathB . '\' . formats.DosFileName
        let formats.DosFullPathBQ = "'" . formats.DosFullPathB . "'"
        let formats.DosFullPathB2Q = '"' . formats.DosFullPathB . '"'
        " With \\ {{{3
        let formats.DosPath2B = substitute(formats.DosPathS, '/', '\\\\', 'g')
        let formats.DosPath2BQ = "'" . formats.DosPath2B . "'"
        let formats.DosPath2B2Q = '"' . formats.DosPath2B . '"'
        let formats.DosFullPath2B = formats.DosPath2B . '\\' . formats.DosFileName
        let formats.DosFullPath2BQ = "'" . formats.DosFullPath2B . "'"
        let formats.DosFullPath2B2Q = '"' . formats.DosFullPath2B . '"'
    endif
     " Return {{{3
    return formats
endfu

" Functions: Configuration {{{1

" g:VeLoadFromFile(restoreLastPath) {{{2
" Load configuration from file
fu! g:VeLoadFromFile(restoreLastPath)
    " Configuration object used to contain several configuration items loaded from a xml file and saved as a xml file {{{3
    if filereadable(g:VeCfgFile)
        " If the file is found, load it
        let g:VeCfg = g:Item.LoadFile(g:VeCfgFile)
    else
        " If the file is not found, create a new configuration object
        let g:VeCfg = g:Item.New()
    endif
    " Check existence of some configuration items {{{3
    if g:VeCfg.Contains('History') == 0
        cal g:VeCfg.Add(g:Item.New1('History'))
    endif
    if g:VeCfg.Contains('Favorites') == 0
        cal g:VeCfg.Add(g:Item.New1('Favorites'))
    endif
    if g:VeCfg.Contains('Marks') == 0
        cal g:VeCfg.Add(g:Item.New1('Marks'))
    endif
    if g:VeCfg.Contains('LastPath') == 0
        cal g:VeCfg.Add(g:Item.New1('LastPath'))
    endif
    if g:VeCfg.Contains('CursorPos') == 0
        cal g:VeCfg.Add(g:Item.New1('CursorPos'))
    endif
    " The last path is only restore when the plugin is loaded with vim, not when the user load it using the mapping {{{3
    if a:restoreLastPath == 1
        " Restore the last accessed path, do <leader>VE to start the plugin using this path
        let g:VePath = g:VeCfg.LastPath.Value
    endif
endfu

" g:VeSaveToFile() {{{2
" Save configuration to file
fu! g:VeSaveToFile()
    " Add last accessed path so next time <leader>VE will open on that path
    let g:VeCfg.LastPath.Value = g:VePath
    " Save the configuration to a file
    cal g:VeCfg.SaveToXml(g:VeCfgFile)
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
        " Add bar to configuration dictionary
        let g:VeCfg[a:barName].Value = bar
    endif
    " Go back to previous position
    cal setpos('.', savedPosition)
endfu
