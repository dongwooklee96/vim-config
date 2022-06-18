### CSCOPE 설정 방법

```
$ vi mkcscope
rm -rf cscope.files cscope.files
find $(pwd) \( -name '*.c' -o -name '*.cpp' -o -name '*.cc' -o -name '*.h' -o -name '*.s' -o -name '*.S' \) -print > cscope.files
cscope -i cscope.files

$ chmod 775 mkcscope && mv mkcscope /usr/bin or /usr/local/bin

$ vi ~/.vimrc
set csprg=/usr/bin/cscope
set csto=0
set cst
set nocsverb
  if filereadable("./cscope.out")
    cs add ./cscope.out
elseif filereadable("../cscope.out")
    cs add ../cscope.out
elseif filereadable("../../cscope.out")
    cs add ../../cscope.out
elseif filereadable("../../../cscope.out")
    cs add ../../../cscope.out
elseif filereadable("../../../../cscope.out")
    cs add ../../../../cscope.out
endif
set csverb

$ mkcscope & ctrl + d
// 원하는 디렉터리에서 mkcscope을 수행하고 빌드가 완료되면 ctrl + d 로 종료
```
- `mkscope` 스크립트

### CSCOPE 플러그인
---

```
$ wget http://cscope.sourceforge.net/cscope_maps.vim
$ mkdir ~/.vim/plugin
$ mv cscope_maps.vim ~/.vim/plugin

단축키 : Ctrl + \ + query_type
```
- 검색을 편리하게 해주는 플러그인을 설치하면 편리하게 사용 가능하다.

### 참고
---

- [Vim 개발 환경 구축 및 사용법](https://dhkoo.github.io/2019/09/22/vim/)

