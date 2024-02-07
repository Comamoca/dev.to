---
title: Create Vim/Nvim Plugin with Deno
description: Overview of denops.vim and how to create a simple plugin.
tags: vim, neovim, deno
cover_image: ''
canonical_url: null
published: false
---

Hello devs!

In this article writing about **How to create Vim/Nvim dual support plugin with Deno**.


There was a denops.vim session In VinConf 2023.

- [YouTube](https://www.youtube.com/watch?v=hu9EN7jl2kA)
- [Slide](https://docs.google.com/presentation/d/1d9eXGTQZcPXGXrR-xr-4TVh5l609zNJXX6seaZih_ik/edit?usp=sharing)

## Recentry situation in Vim/Nvim plugin ecosystem

In recentry, create Vim/Nvim plugin can go by below way.

In Vim:
 - Vim script(Transitional)
 - job API

In Neovim:
 - Vim script
 - Lua(Most popular)
 - RemotePlugin


In Lua and RemotePlugin have below pros and cons.

👍 Pros:
 - Very fast than Vim script
 - Easy to get used then Vim script
 - Great ecosystem

👎 Cons:
 - No Vim compatiablities


If you not use vim from now on, those way shound good.
But Vim user and both user (It's like me 😀) be troubled.
Moreover, Vim and Nvim API are getting farther apart. Wonder if there isn't effesient way?


## Problem to solved by denops.vim

denops.vim is Vim/Nvim plugin ecosystem using [Deno](https://deno.com/).
Run plugin on Deno running on other process.
It's like to [coc.nvim](https://github.com/neoclide/coc.nvim). But more versatile.


In denops.vim have below pros and cons.

👍 Pros:
 - Fast than Vim script  
   Because Deno is execute scripts on V8

 - Auto resolved dependencies  
   You can use Deno and npm package!

 - Async run  
   Non Blocking✨

 - Vim/Nvim compatiablities  
   denops.vim can use Vim/Nvim both!


👎 Cons:
 - Increased dependence  
   You must install [denops.vim](https://github.com/vim-denops/denops.vim)

 - Smaller ecosystem than Lua(But growing now)
 - Lack of english text contents than other way


## Examples of plugins using denops.vim

- ddu.vim  
repo: https://github.com/Shougo/ddu.vim  
The Dark deno-powered UI framework.  
Flexible and customaizable to Source, Filter and UI.

- bufpreview.vim  
repo: https://github.com/kat0h/bufpreview.vim  
Fast asynchronous update and multi Pratform Support markdown previewer.

- denops-docker.vim  
repo: https://github.com/skanehira/denops-docker.vim  
Manage Docker in Vim/Neovim.


## Create first denops.vim plugin

From here on, Vim plugin that use denops.vim we call to **denops plugin**.

denops.vim required Deno. if you haven't Deno, install Deno [here](https://docs.deno.com/runtime/manual).
Aftor, install [denops.vim](https://github.com/vim-denops/denops.vim).

denops plugin really Vim plugin. So you must place denops plugin on Vim runtimepath.

```vimscript
set runtimepath^=~/path/to/denops/plugin/dir
```

Then, you configure directories structure like below.

```
.
├── deno.json
├── deno.lock
├── denops
│   └── plugin
│       └── main.ts
└── deps.ts
```

Use [denops.init](https://github.com/comamoca/denops.init), you take to configure directoriese it easy a bit 😀  
`deno run --allow-write --allow-run https://raw.githubusercontent.com/Comamoca/denops.init/main/online.ts`


🚨 Attention:  
denops.vim use [dynamic import](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/import) in load denops plugin.
So can't use [import maps](https://docs.deno.com/runtime/manual/basics/import_maps) for manage dependencies.
Use [Re-export](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/export#re-exporting_aggregating).


Then, write below scripts to `main.ts` and `deps.ts`.

main.ts:
```ts
import { Denops, ensure, execute, is } from "../../deps.ts";

export async function main(denops: Denops): Promise<void> {
  // Write the plugin processing here.
  console.log("Hello Denops!");

  denops.dispatcher = {
    async echo(text: unknown): Promise<unknown> {
      ensure(text, is.String);
      return await Promise.resolve(text);
    },
  };

  await execute(
    denops,
    `command! -nargs=1 HelloWorldEcho echomsg denops#request('${denops.name}', 'echo', [<q-args>])`,
  );
}
```

deps.ts:
```ts
export { type Denops } from "https://deno.land/x/denops_std@v6.0.1/mod.ts";
export { execute } from "https://deno.land/x/denops_std@v6.0.1/helper/mod.ts";
export { ensure } from "https://deno.land/x/unknownutil@v3.14.1/mod.ts";
export { is } from "https://deno.land/x/unknownutil@v3.14.1/mod.ts";
```

Restart Vim, Vim displayed "[denops] Hello Denops!" messeage on startup when load success denops.vim and yor plugin.
Then you can execute `:HelloWorldEcho hello`, show "hello" messeage.



## Interop to Vim script


## Helpful resources for create denops plugin
