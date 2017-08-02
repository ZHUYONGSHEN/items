<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>相册管理</title>
    <meta name="decorator" content="admin"/>
    <style>
    	html,body{height:100%}
    </style>
</head>
<body>

<!--上传照片-->

<input type="file" value="323">
<div class="uploadimg_com">
132132
</div>
<script>
/**
 * 获得base64
 * @param {Object} obj
 * @param {Number} [obj.width] 图片需要压缩的宽度，高度会跟随调整
 * @param {Number} [obj.quality=0.8] 压缩质量，不压缩为1
 * @param {Function} [obj.before(this, blob, file)] 处理前函数,this指向的是input:file
 * @param {Function} obj.success(obj) 处理后函数
 * @example
 *
 */
$.fn.localResizeIMG = function(obj) {
    this.on('change', function() {
        var file = this.files[0];
        var URL = window.URL || window.webkitURL;
        var blob = URL.createObjectURL(file);
        // 执行前函数
        if ($.isFunction(obj.before)) {
            obj.before(this, blob, file)
        };
        console.log(file)
        _create(blob, file);
        
        this.value = ''; // 清空临时数据
    });

    /**
     * 生成base64
     * @param blob 通过file获得的二进制
     */
    function _create(blob,amgumentfile) {
        var img = new Image();
        img.src = blob;
        img.onload = function() {
            var that = this;
			var filewidth,fileheight;
            //生成比例
            var w = that.width,
                h = that.height,
                scale = w / h;
            w = obj.width || w;
            h = w / scale;
            filewidth = that.width >= 8192 ? '8192' : that.width;
            fileheight = that.height;
            //生成canvas
            var canvas = document.createElement('canvas');
            var ctx = canvas.getContext('2d');
            $(canvas).attr({
                width: w,
                height: h
            });
            ctx.drawImage(that, 0, 0, w, h);
            /**
             * 生成base64
             * 兼容修复移动设备需要引入mobileBUGFix.js
             */
            var base64 = canvas.toDataURL('image/jpeg', obj.quality || 0.8);
            var result = {
                base64: base64,
                clearBase64: base64.substr(base64.indexOf(',') + 1),
                filewidth:filewidth,
                fileheight:fileheight,
                filename:amgumentfile.name
            };
            // 执行后函数
            obj.success(result);
        };
    }
};

var xhrOnProgress=function(fun) {
	  xhrOnProgress.onprogress = fun; //绑定监听
	  //使用闭包实现监听绑
	  return function() {
	    //通过$.ajaxSettings.xhr();获得XMLHttpRequest对象
	    var xhr = $.ajaxSettings.xhr();
	    //判断监听函数是否为函数
	    if (typeof xhrOnProgress.onprogress !== 'function')
	      return xhr;
	    //如果有监听函数并且xhr对象支持绑定时就把监听函数绑定上去
	    if (xhrOnProgress.onprogress && xhr.upload) {
	      xhr.upload.onprogress = xhrOnProgress.onprogress;
	    }
	    return xhr;
	  }
	}

// 例子

$('input:file').localResizeIMG({
    quality: 0.9,
    success: function (result) {
    	var data
    	data = result.base64.split(',')[1];
        data = window.atob(data);
        var ia = new Uint8Array(data.length);
        for (var i = 0; i < data.length; i++) {
              ia[i] = data.charCodeAt(i);
        };
         //canvas.toDataURL 返回的默认格式就是 image/png
        var blob = new Blob([ia], {
         	type: "image/jpeg",
        });
        var fd = new FormData();
            fd.append('file', blob);
            fd.append('filename', result.filename);
            fd.append('width', result.filewidth);
            fd.append('height', result.fileheight);
        // 生成结果
        $.ajax({
	        type: "POST",
	        url: "${backPath}/pano/scene/fileupload",
	        data: fd,
	        success: function (res) {
	        	console.log(res)
	        },
	        processData: false,
	        contentType: false,
	        xhr:xhrOnProgress(function(e){
	            var percent=e.loaded / e.total;//计算百分比
	            console.log(percent)
	            console.log(e)
	         }),
	        error: function(data) {
	            alert("新增用户失败！");
	         }
	    });
    }
});

</script>
</body>
</html>