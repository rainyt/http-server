package;

import utils.Log;
import sys.FileSystem;
import haxe.io.Path;
import http.HTTPServer;

class Main {
	static function main() {
		// 启动一个服务器
		Log.info("启动服务器");
		var ip:String = "0.0.0.0";
		var port = 5555;
		var http = new HTTPServer(ip, port, true);
		http.start();
		http.onConnectRequest = (http) -> {
			var path = http.getLocalFilePath();
			if (FileSystem.exists(path)) {
				http.sendFile(http.path);
			} else
				http.send("hello world! File is not found: " + http.path);
		}
		// 路由功能测试
		http.route.addRoute("/", (http) -> {
			trace("访问到了/路由", http.path);
			return true;
		});

		http.route.addRoute("/index.html", (http) -> {
			trace("访问到了/index.html路由", http.path);
			return true;
		});
	}
}
