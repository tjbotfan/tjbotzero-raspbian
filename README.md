# TJBot Zero raspbian

## このレポジトリは
このレポジトリはTJBot Zeroハンズオンで使用しているTJBot Zero および TJBotのraspberry pi向けOS raspbianをカスタマイズしたイメージになります。
このイメージの中にはNode-Redを利用したTJBot ZeroおよびTJBotのためのサンプルフローが収録されています。

デフォルトではハンズオン用のWiFi設定が収録されていますが、GUIやSDカードへのファイル書き込み等で、
イメージをお手元のWiFi環境へ接続することが可能です。

※TJBot Zero / TJBotはraspberry piのGPIOやraspberry pi専用カメラインターフェイスを利用した制御が含まれている為、
PCやクラウド上のNode-REDでは正しく動作しないフローが存在します。


## イメージの使用方法
[release](https://github.com/tjbotfan/tjbotzero-raspbian/releases)ページにxz形式でイメージを保管しています。
[balena Etcher](https://www.balena.io/etcher/)を利用することで圧縮状態のままでSDカードへイメージ書き込みが可能です。
標準イメージは8GB相当のSDカードで記録可能ですが、TJBotFan公式では16GB以上のSDカードを推奨しています。

## サポート
- [TJBotFan (facebook)](https://www.facebook.com/groups/547028405784779/)