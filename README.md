# My-st-config
st terminal config steps in **archlinux**.
---

## Notice 
It is my first time to install `st`. So the steps may be a little messy.
</br>ALSO, I don't know HOW to set **Desktop entry** for `st` in a DE because I use [Awesome WM](https://awesomewm.org/).
</br>PLUS, I don't know HOW to install `st`from `AUR`. If you want to install st from AUR, check [st-Archwiki](https://wiki.archlinux.org/title/st).
</br>**Maybe you can also do more search if you are interested in this**.


## Credits 
- [Arch Linux 下安装 st](https://blog.csdn.net/weixin_44335269/article/details/117848592)
- [mohkale/st](https://github.com/mohkale/st)
- [st-Archwiki](https://wiki.archlinux.org/title/st)
---

## Remembering

**st** use `config.def.h` to set. 
</br>Remember to **re-compile** everytime when you edit `config.def.h`.
</br>Run `rm -rf config.h && sudo make clean install`.

## Steps
---
First, `git clone https://git.suckless.org/st`.  (Assuming you do this in `~`.)
</br>Then, edit `config.mk`.

```
cd st
vim config.mk

```

</br>edit `X11INC = /usr/X11R6/include` → `X11INC = /usr/include/X11` 
</br>edit `X11LIB = /usr/X11R6/lib` → `X11LIB = /usr/lib/X11` 

</br>Then run `sudo make clean install`. After compiling, run `st` in your former terminal.

## Config

By editing `config.def.h` you can config `st`.
</br>Run `rm -rf config.h && sudo make clean install` whenever you edit `config.def.h` or after installing patch for st.

## Patch
### Each patch may need some `Dependencies` to make them work. Check that at [st - simple terminal patches](https://st.suckless.org/patches/). 

Patches I use :
- [st-alpha-20220206-0.8.5.diff](https://st.suckless.org/patches/alpha/st-alpha-20220206-0.8.5.diff)
- [st-scrollback-0.8.5.diff](https://st.suckless.org/patches/scrollback/st-scrollback-0.8.5.diff)
- [st-scrollback-mouse-0.8.2.diff](https://st.suckless.org/patches/scrollback/st-scrollback-mouse-0.8.2.diff)
- [st-w3m-0.8.3.diff](https://st.suckless.org/patches/w3m/st-w3m-0.8.3.diff)

You can use browser's `Save Link As` to save them in your `~/st/patch`.
</br>Then typing below to patch you st.
</br>Remember to `patch` in `~/st`.

### Remember to add this in your `config.def.h`.

For opacity:

```
/* bg opacity */
 float alpha = 0.5;

```

For scroll: 

```
         ...

 static MouseShortcut mshortcuts[] = {
	 /* mask                 button   function        argument       release */
	 { XK_ANY_MOD,           Button4, kscrollup,      {.i = 1},            0,       -1 },
	 { XK_ANY_MOD,           Button5, kscrolldown,    {.i = 1},            0,       -1 },

	 ...

 static Shortcut shortcuts[] = {
	/* mask                 keysym          function        argument */
	{ XK_ANY_MOD,           XK_Break,       sendbreak,      {.i =  0} },
        { TERMMOD,              XK_Prior,       zoom,           {.f = +1} },
        { TERMMOD,              XK_Next,        zoom,           {.f = -1} },
        { TERMMOD,              XK_Home,        zoomreset,      {.f =  0} },

         ... 
	
	{ TERMMOD,              XK_U,           kscrollup,      {.i = +5} },
	{ TERMMOD,              XK_D,           kscrolldown,    {.i = +5} },
	};

         ...
```

### Steps for patch

```
 cd st
 
 patch < patch/st-alpha-20220206-0.8.5.diff
 
 patch < patch/st-scrollback-mouse-0.8.2.diff
 
 patch < patch/st-scrollback-0.8.5.diff
 
 patch < patch/st-w3m-0.8.3.diff

```
After patching, run `rm -rf config.h && sudo make clean install`.

Also, you can check my `config.def.h` if you still have no idea.

---
## Thanks

- [GIN-18](https://github.com/GIN-18)
- [mohkale](https://github.com/mohkale/st)
- [st-Archwiki](https://wiki.archlinux.org/title/st)
