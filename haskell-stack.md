# Haskell Stack Dummy Operator Manual

## Install/Uninstall Stack

1. Download install package. I prefer to use [zip package (Windows 64-bit)](https://get.haskellstack.org/stable/windows-x86_64.zip) , unpack the archive to `%devtools%\stack`
2. Add `%devtools%\stack` to you system PATH variable
3. Set `STACK_ROOT` to user environment variables, maybe point to `%devtools%\stack\stack_root`
4. Run command `stack setup`, this command will install GHC and MSYS2 in *%LocalAppData%/programs/stack/$platform/* for out of project usage.
**But it is still not a global GHC!**
5. Start configuration of Stack, see ***`Config Stack`*** session

## Config Stack

First, add the following to the bottom of the ~/.stack/config.yaml file (for Windows: use the %STACK_ROOT%\config.yaml):  
*Copied from [doc](https://docs.haskellstack.org/en/stable/install_and_upgrade/#china-based-users)*

```yaml
###ADD THIS IF YOU LIVE IN CHINA
setup-info: "http://mirrors.tuna.tsinghua.edu.cn/stackage/stack-setup.yaml"
urls:
  latest-snapshot: http://mirrors.tuna.tsinghua.edu.cn/stackage/snapshots.json
  lts-build-plans: http://mirrors.tuna.tsinghua.edu.cn/stackage/lts-haskell/
  nightly-build-plans: http://mirrors.tuna.tsinghua.edu.cn/stackage/stackage-nightly/
package-indices:
 - name: Tsinghua
   download-prefix: http://mirrors.tuna.tsinghua.edu.cn/hackage/package/
   http: http://mirrors.tuna.tsinghua.edu.cn/hackage/00-index.tar.gz
```

TODO:

- something else here

## Upgrade Stack

**For portable version:**  
Unzip new zip package, replace the old files.  

**For install version:**  
Unnecessary uninstall old version, just reinstall stack-V.E.R-windows-x86_64-installer.exe to the same path (Notice!!! Neither add path nor set %stack_root% during installation if configured before)  

May follow offical [Upgrade](https://docs.haskellstack.org/en/stable/install_and_upgrade/#upgrade), not tried yet.

## Uninstall Stack completely

1. The stack executable itself
2. The stack root, e.g. `$HOME/.stack` on non-Windows systems.  
    • See `stack path --stack-root`  
    • On Windows, you will also need to delete `stack path --programs`
3. Any local `.stack-work` directories inside a project

## Update non-project GHC in Stack

TODO:  

## Environment on WSL

TODO: (try it according to References)  

## References

[The Haskell Tool Stack](https://docs.haskellstack.org/en/stable/README/)  
[Stack in Hackage](http://hackage.haskell.org/package/stack)  
[My Windows + Haskell setup](https://blog.ramdoot.in/my-windows-haskell-setup-6bd769e9c51d)  
[IHaskell on Windows!](https://blog.ramdoot.in/ihaskell-on-windows-c549e6442262)

[**Convention in the document**](convention.md)  
