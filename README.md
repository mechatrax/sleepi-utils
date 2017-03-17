sleepi-utils
==========

slee-Pi を操作するためのツール類を提供します。

## 提供ファイル
以下のファイルがパッケージに含まれています。

* /usr/sbin/sleepictl  
  slee-Pi を操作するための実行ファイルです。  
  使用可能なオプションを以下に示します。  

  + --get {alarm,button,restart,timeout,voltage}  
    サブオプションの値を取得します。  
    サブオプションには alarm, button, restart, timeout, voltage のいずれか一つを指定します。
    
    - alarm  
      アラームの時刻を取得します。  
      未設定の場合は空の文字列を返します。  

    - button  
      押しボタンのカウント値を表示します。  
      単位は [秒] です。  

    - restart  
      電源再投入動作の状態を表示します。  
      
      0 : 電源の再投入による再起動は行いません。  
      1 : システムの応答がない場合に電源の再投入による再起動を行います。  

    - timeout  
      システムの応答を検知するタイムアウト値を表示します。  
      単位は [秒] です。  
      
      0 : 応答を検知しません。  
      1..255 : タイムアウト値を超えても応答を検知できない場合には応答なしと判断します。  
    
    - voltage  
      電源電圧の値を表示します。  
      単位は [mV] です。  

  + --set {alarm,restart,timeout} [VALUE]  
    サブオプションの値を設定します。  
    サブオプションには alarm, restart, timeout のいずれか一つを指定します。  

    - alarm \<STRING\>  
      アラームの時刻を設定します。  
      
      \<STRING\> : 時刻を指定します。  
      
      指定可能な文字列のフォーマットは date コマンドと同じです。  
      以下に例を示します。  
        1. 2015/04/28 09:30:00 に設定する場合  
        ```
        sleepictl --set alarm "2015/04/28 09:30:00"
        ```
        日時を指定してアラームを設定することができます。  
        時刻のみの指定も可能です。  
        
        2. 五分後に設定する場合  
        ```
        sleepictl --set alarm "+5min"
        ```
        相対値を指定してアラームを設定することができます。  
        year, month, day, hour, min, sec での指定が可能です。  
        
        3. 設定を解除する場合
        ```
        sleepictl --set alarm ""
        ```
        設定を解除する場合には空の文字列を指定します。  
      
    - restart \<0,1\>  
      電源再投入動作の設定をします。  
      
      0 : 電源の再投入による再起動は行いません。  
      1 : システムの応答がない場合に電源の再投入による再起動を行います。  
      
    - timeout \<0..255>  
      システムの応答を検知するタイムアウト値を設定します。  
      単位は [秒] です。  
      
      0 : 応答を検知しません。  
      1..255 : タイムアウト値を超えても応答を検知できない場合には応答なしと判断します。  

  + --help, -h : ヘルプを表示します。   
  
  + --version, -v : バージョンを表示します。   

* /usr/share/doc/sleepi-utils/changelog.Debian.gz  
  パッケージの変更履歴を記録したファイルです。  

* /usr/share/doc/sleepi-utils/copyright  
  ソースの著作権とライセンスを記載したファイルです。  

* /lib/udev/sleepi-utils.sh  
  slee-Pi 認識時に実行されるスクリプトです。  

* /lib/udev/rules.d/85-sleepi-utils.rules  
  slee-Pi のデバイスを定義した設定ファイルです。  

* /etc/default/sleepi-utils  
  slee-Pi の設定を行うためのファイルです。  
  設定可能な項目を以下に示します。  

  + RTC_DEVICE  
    slee-Pi のリアルタイムクロックモジュール部のデバイス名を記述します。  
    デフォルトは rtc0 です。  

  + I2C_ADDRESS  
    slee-Pi のパワーマネージメントモジュール部の I2C アドレスを指定します。  
    デフォルトは 0x69 です。  

  + HCTOSYS  
    システムと slee-Pi の時刻の同期動作を設定します。  
    デフォルトは yes です。  

    yes : 起動時と終了時にシステムと slee-Pi の時刻を同期します。  
    no : システムと slee-Pi の時刻を同期しません。  

* /etc/init.d/sleepi-utils  
  slee-Pi のサービスを稼働させるためのファイルです。  
  システムと slee-Pi 搭載の RTC 間で時刻の同期を行います。  
