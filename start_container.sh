rm -rf ./log && mkdir log
	
docker run -v `pwd`/log:/var/log -p 8080:8080 roverr/rtsp-stream:2