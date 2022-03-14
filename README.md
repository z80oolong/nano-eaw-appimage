# nano-eaw-appimage -- EAW 対応 nano を起動する AppImage パッケージファイル作成用の Vagrantfile

## 概要

[nano 4.9.2][NANO] 以降において、 Unicode の規格における東アジア圏の各種文字のうち、いわゆる "◎" や "★" 等の記号文字及び罫線文字等、 [East_Asian_Width 特性の値が A (Ambiguous) となる文字][EAWA] (以下、 [East Asian Ambiguous Character][EAWA]) が、日本語環境で文字幅を適切に扱うことが出来ずに表示が乱れる問題が発生しています。

また、 [AppImage][APPI] とは、 Linux 系 OS において、各種ディストリビューションの差異に関わらず、如何なる環境においてもアプリケーションの正常な動作を目指したアプリケーションの配布形式の一つです。同様な目的及び目標を持つアプリケーションの配布形式として、 [snap][SNAP] や [Flatpak][FLAT] 等が挙げられます。

[AppImage][APPI] は、 [snap][SNAP] や [Flatpak][FLAT] と異なり、 root 権限を取ること無く、パッケージファイルとして配布されている [AppImage][APPI] ファイルに実行権限を付与し、 [AppImage][APPI] ファイルを直接実行することにより、適切にアプリケーションを実行させることが出来るのが特徴です。

このリポジトリは、軽量な CLI テキストエディタである [nano][NANO] において、Unicode の規格における東アジア圏の各種文字のうち、いわゆる "◎" や "★" 等の記号文字及び罫線文字等、 [East_Asian_Width 特性の値が A (Ambiguous) となる文字][EAWA] (以下、 [East Asian Ambiguous Character][EAWA]) が、日本語環境で文字幅を適切に扱うことが出来ずに表示が乱れる問題を修正した [nano][NANO] を起動する [AppImage パッケージファイル][APPI]を生成するための [vagrant 仮想環境][VAGR]を構築する Vagrantfile 等を含むリポジトリです。

## 使用法

まず最初に、 [nano][NANO] の [AppImage パッケージファイル][APPI]を生成するための端末に [Vagrant 環境][VAGR]を構築します。 Vagrant のインストールにあたっては、以下の web ページを参考にして下さい。

- [Download Vagrant][VDWN]
- [Getting Started | Vagrant][VTUT]

そして、本リポジトリ内のシェルスクリプト ```build-appimage.sh``` を以下の通りに起動します。

```
  $ ./build-appimage.sh
```

シェルスクリプト ```build-appimage.sh``` の起動により、[East Asian Ambiguous Character を全角文字の幅で表示する差分ファイル][GST1]を適用した [nano][NANO] をビルドするための Docker コンテナが構築され、 Docker コンテナ内にて、 [nano][NANO] 及び [nano][NANO] に依存するライブラリ群等がビルドされ、 [nano][NANO] を起動するための [AppImage パッケージファイル][APPI]が生成されます。

そして、シェルスクリプトが正常に終了すると、ディレクトリ ```./opt/releases``` 以下に [AppImage パッケージファイル][APPI] ```nano-eaw-*-x86_64.AppImage``` が生成されます。

## AppImage パッケージファイルの使用法

前述で生成した [AppImage パッケージファイル][APPI] ```nano-eaw-6.2-x86_64.AppImage``` を用いて [nano][NANO] を起動するには、以下の通りにして  [AppImage パッケージファイル][APPI] ```nano-eaw-6.2-x86_64.AppImage``` にファイルの実行権限を付与して環境変数 ```PATH``` が示すディレクトリに配置します。

そして、以下のようにして ```nano-eaw-6.2-x86_64.AppImage``` から ```nano``` へシンボリックリンクを張ると、コマンドラインから ```nano``` と入力することで、 [East Asian Ambiguous Character を全角文字の幅で表示する差分ファイル][GST1]を適用した [nano][NANO] が起動します。

```
  $ cd opt/release
  $ chmod u+x ./nano-eaw-6.2-x86_64.AppImage
  $ sudo cp -pRv ./nano-eaw-6.2-x86_64.AppImage /usr/local/bin    # (一例として /usr/local/bin 以下に導入する場合を示す。)
  $ cd /usr/local/bin
  $ sudo ln -sf nano-eaw-6.2-x86_64.AppImage nano
  ...
  $ nano
  ...
```

ここで、 [East Asian Ambiguous Character を全角文字の幅で表示する差分ファイル][GST1]が適用された [nano][NANO] の使用法の詳細については、 "[nano 2.5 以降において East Asian Ambiguous Character を全角文字の幅で表示する][GST1]" を参照して下さい。

## AppImage パッケージファイルの配布

[East Asian Ambiguous Character を全角文字の幅で表示する差分ファイル][GST1]が適用された [nano][NANO] のビルド済の [AppImage パッケージファイル][APPI]については、以下の URL より配布いたしますので、どうか宜しく御願い致します。

- EAW 対応 nano を起動する AppImage パッケージファイルの配布ページ
    - [https://github.com/z80oolong/nano-eaw-appimage/releases][APPR]

## 謝辞

まず最初に、各種ディストリビューションの差異に関わらず、如何なる環境においてもアプリケーションの正常な動作を目指したアプリケーションの配布形式である [AppImage][APPI] を開発した [AppImage][APPI] の開発コミュニティの各位に心より感謝致します。

そして、 [nano][NANO] に適用するための [East Asian Ambiguous Character を全角文字の幅で表示する差分ファイル][GST1]に関しては、 [Markus Kuhn 氏][DRMK]の協力及びソースコードの参考を得ました。以下の各氏に心より感謝致します。

最後に、 [nano の開発コミュニティ][NANO]及び [nano][NANO] と [AppImage][APPI] に関わる全ての人々に心より感謝致します。

## 使用条件

本リポジトリは、 [East Asian Ambiguous Character を全角文字の幅で表示する差分ファイル][GST1]を適用した端末多重化ソフトウェア [nano][NANO] を起動するための [AppImage パッケージファイル][APPI]を生成するための Vagrant 仮想環境の構築を行う Vagrantfile を含むリポジトリであり、 [Z.OOL. (mailto:zool@zool.jpn.org)][ZOOL] が著作権を有し、 [MIT ライセンス][MITL] に基づいて配布されるものとします。

本リポジトリの使用条件の詳細については、本リポジトリに同梱する ```LICENSE``` を参照して下さい。

<!-- 外部リンク一覧 -->

[NANO]:http://nano.github.io/
[APPI]:https://appimage.org/
[SNAP]:https://snapcraft.io/
[FLAT]:https://flatpak.org/
[VAGR]:https://www.vagrantup.com/
[VDWN]:https://www.vagrantup.com/downloads
[VTUT]:https://learn.hashicorp.com/collections/vagrant/getting-started
[DEBI]:https://www.debian.org/
[BREW]:https://linuxbrew.sh
[DDCK]:https://github.com/z80oolong/debian-linuxbrew-container/
[EAWA]:http://www.unicode.org/reports/tr11/#Ambiguous
[TAPP]:https://github.com/nelsonenzo/nano-appimage
[TMRP]:https://github.com/nano/nano.git
[GST1]:https://github.com/z80oolong/nano-eaw-fix
[APPR]:https://github.com/z80oolong/nano-eaw-appimage/releases
[DCK1]:http://docs.docker.jp/engine/installation/
[DDK1]:https://github.com/z80oolong/debian-linuxbrew-container/blob/master/README.md
[NELS]:https://github.com/nelsonenzo
[NELT]:https://github.com/nelsonenzo/nano-appimage
[KOIE]:https://github.com/koie
[DRMK]:http://www.cl.cam.ac.uk/~mgk25/
[NICM]:https://github.com/nicm
[ZOOL]:http://zool.jpn.org/
[MITL]:https://opensource.org/licenses/mit-license.php
