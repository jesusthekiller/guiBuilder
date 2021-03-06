Gui Builder
===========
Main repo for GuiBuilder and Gui API

Documentation
-------------
Updated documentation is avaliable online [here](https://rawgithub.com/jesusthekiller/guiBuilder/master/doc/index.html)

### Generate doc ###
**Requred tools:**
* lua 
* [luarocks](http://luarocks.org/)
* LDoc (`luarocks install ldoc`)
* markdown (`luarocks install markdown`)

**Generate:**  
`ldoc .` in main directory.  
Using `ldoc --tags todo,fixme,warning .` will also print out tags `@warning`, `@todo` and `@fixme`.

How to load API
---------------
	dofile("path/to/bootstrap.lua")

License
-------
<a rel="license" href="http://creativecommons.org/licenses/by/4.0/deed.en_US"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">Gui builder and Gui API</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/jesusthekiller/guiBuilder" property="cc:attributionName" rel="cc:attributionURL">jesusthekiller</a> are licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/deed.en_US">Creative Commons Attribution 4.0 International License</a>.
