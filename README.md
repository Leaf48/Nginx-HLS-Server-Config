# Nginx-HLS-Server-Config
Nginxを使ってHLSとRTMPサーバーを建てるマニュアル

# 構成

```mermaid
graph TD
    MainRTMP["メインRTMPサーバー"]
    subgraph サブRTMPサーバー
        ChildRTMP1["サブRTMPサーバー1（IPアドレス1）"]
        ChildRTMP2["サブRTMPサーバー2（IPアドレス2）"]
        ChildRTMP3["サブRTMPサーバー3（IPアドレス3）"]
    end
    subgraph 視聴者
        Viewer1["視聴者"]
        Viewer2["視聴者"]
        Viewer3["視聴者"]
    end

    MainRTMP -->|ストリームを流す| ChildRTMP1
    MainRTMP -->|ストリームを流す| ChildRTMP2
    MainRTMP -->|ストリームを流す| ChildRTMP3

    ChildRTMP1 -->|視聴者に配信| Viewer1
    ChildRTMP2 -->|視聴者に配信| Viewer2
    ChildRTMP3 -->|視聴者に配信| Viewer3
```

# インストール
Nginxをソースからビルドする必要があります。

### 必要Module
- [ ] ngx_http_realip_module
- [ ] nginx-rtmp-module

# サーバーの追加方法
任意のサーバーにNginxをインストールし、child_server.confを追加してください。

`server_name`の部分には、そのサーバーのIPを入力してください。

```
server {
		listen 80;
		# これを起動しているサーバーのIP	
		server_name xxx.xxx.xxx.xxx;
}
```

# サブサーバーで生成されたm3u8にアクセスするには？
`create_symlink_nginx.sh`　を適当なディレクトリに配置してください。

そのスクリプトはm3u8のSymbolic linkを生成し、クライアントがアクセスした際にアクセス可能となります。


# 注意事項
### CloudflareのIPレンジについて

<img width="527" alt="image" src="https://github.com/user-attachments/assets/263a6ca6-1114-455a-aa6b-0ab3b4715a67" />

https://www.cloudflare.com/ja-jp/ips/


これは常に変わる可能性があるため、スクリプトで自動更新をするか手動でアップデートを行う必要があります

```
http {
	# メインサーバー用のNginxコンフィグに設定してください
	set_real_ip_from 173.245.48.0/20;
}
```


