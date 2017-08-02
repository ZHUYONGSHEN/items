/*
 * Created by shiyong on 5/1/16.
 */

//增加一个字符串格式化的函数，主要是给模板用
//console.log("my name is {name}".format({ name: '顺其自然' }));
if (!String.prototype.format) {
    String.prototype.format = function () {
        var hash = arguments[0];
        return this.replace(/{(\w+)}/g, function (match, item) {
            return typeof hash[item] != 'undefined' ? hash[item] : match;
        });
    };
}

if (!String.prototype.endWith) {
    String.prototype.endWith = function (str) {
        if (str === null || str === "" || this.length === 0 || str.length > this.length)
            return false;
        if (this.substring(this.length - str.length) == str)
            return true;
        else
            return false;
    };
}
var SLCUtility = {};

var __support_device_info = {
    "MI NOTE LTE": {
        screen: 5.7
    }
}

SLCUtility.browser = {
    versions: function () {
        var u = navigator.userAgent,
            app = navigator.appVersion;
        return {
            trident: u.indexOf('Trident') > -1, //IE内核
            presto: u.indexOf('Presto') > -1, //opera内核
            webKit: u.indexOf('AppleWebKit') > -1, //苹果、谷歌内核
            gecko: u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1, //火狐内核
            mobile: !!u.match(/AppleWebKit.*Mobile.*/), //是否为移动终端
            ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
            android: u.indexOf('Android') > -1 || u.indexOf('Linux') > -1, //android终端或者uc浏览器
            iPhone: u.indexOf('iPhone') > -1, //是否为iPhone或者QQHD浏览器
            iPad: u.indexOf('iPad') > -1, //是否iPad
            webApp: u.indexOf('Safari') == -1 //是否web应该程序，没有头部与底部
        };
    }(),
    language: (navigator.browserLanguage || navigator.language).toLowerCase()
};

SLCUtility.getHtmlId = function () {
    var nCount = 1;
    return function () {
        nCount = nCount + 1;
        return nCount.toString();
    }
}();

SLCUtility.getParentIdByClassId = function (event, clsId) {
    var e = event || window.event;
    var src = e.srcElement || e.target;
    if ($(src).hasClass(clsId) === false) {
        src = $(src).parent("." + clsId);
    }
    var id = $(src).attr("id");
    if (id) return id;
    return null;
};

SLCUtility.getClientPoint = function () {
    if (document.compatMode === "BackCompat") {
        return {
            width: document.body.clientWidth,
            height: document.body.clientHeight
        };
    } else {
        return {
            width: document.documentElement.clientWidth,
            height: document.documentElement.clientHeight
        };
    }
};
SLCUtility.getHttpObj = function () {
    var xhr = null;
    if (window.ActiveXObject) {
        try {
            xhr = new ActiveXObject("Microsoft.XMLHTTP");
        } catch (e) {
            try {
                xhr = new ActiveXObject("Msxml2.XMLHTTP");
            } catch (e) {
                xhr = null;
            }
        }
    }
    if (xhr === null && window.XMLHttpRequest) {
        xhr = new XMLHttpRequest();
    }
    return xhr;
};

SLCUtility.getResoultJsonObj = function (jsonTest) {
    var jsonObj = null;
    try {
        jsonObj = eval('(' + jsonTest + ')');
        var a = 0;
        a = 1;
    } catch (e) {
        return null;
    }
    return jsonObj;
}

SLCUtility.callFunc = function (method, urlfunc, param) {
    var xhr = SLCUtility.getHttpObj();
    var result = null;
    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4) {
            result = SLCUtility.getResoultJsonObj(xhr.responseText);
        }
    };
    var host = window.location.host;
    xhr.open(method, "http://" + host + "/api/" + urlfunc, false);
    var paraText = JSON.stringify(param);
    xhr.send(paraText);
    return result;
};

function getCookie(name) {
    var re = new RegExp(name + "=([^;]+)");
    var value = re.exec(document.cookie);
    return (value != null) ? unescape(value[1]) : null;
}

function setCookie(name, value) {
    document.cookie = "" + name + "=" + value + ";"
}

function getJsonFromUrl() {
    var query = location.search.substr(1);
    var result = {};
    query.split("&").forEach(function (part) {
        var item = part.split("=");
        result[item[0]] = decodeURIComponent(item[1]);
    });
    return result;
}

function checkAuth(autoLogin) {
    var authed = getCookie("USERID") != null && getCookie("SESSION") != null && getCookie("EXPIRETIME") != null;
    if (authed) {
        authed = Number(getCookie("EXPIRETIME")) > (Date.now() / 1000);
    }
    if (!authed && autoLogin) {
        var host = window.location.hostname;
        var login = "http://" + host + "/login/index.html?from=" + window.location;
        window.open("http://app.hiweixiao.com/Proxy/Public/login?token_msg=123", "_self");
    }

    return authed;
}

function collectUnKnowRes(elem, ids, resources) {
    var key, val;
    if (elem instanceof Array) {
        for (key in elem)
            collectUnKnowRes(elem[key], ids, resources);
    } else if (typeof (elem) === "object") {
        for (key in elem) {
            val = elem[key];
            if (key.endWith("res_id") && resources[val] === undefined)
                ids.push(val);
            else
                collectUnKnowRes(val, ids, resources);
        }
    }
}

function validResMap(fs, resources) {
    for (var key in fs) {
        var id = fs[key].oorigin_id;
        if (resources[id] === undefined)
            resources[id] = [];
        resources[id].push(fs[key]);
    }
}

function fileMd5(file, cb) {
    var fileReader = new FileReader();
    fileReader.onload = function (e) {
        if (file.size != e.target.result.length) {
            isError = true;
        } else {
            var md5 = SparkMD5.hashBinary(e.target.result);
            file.md5 = md5
            if ($.isFunction(cb)) {
                cb(md5)
            }
        }
    };
    fileReader.onerror = function () {};
    fileReader.readAsBinaryString(file);
};

(function () {
    var getShaderPrecisions = function (ctx) {
        var getFormat, getStageFormat;
        getFormat = function (stage, type) {
            var format;
            format = ctx.getShaderPrecisionFormat(stage, type);
            return {
                rangeMin: format.rangeMin,
                rangeMax: format.rangeMax,
                precision: format.precision
            };
        };
        getStageFormat = function (stage) {
            return {
                LOW_FLOAT: getFormat(stage, ctx.LOW_FLOAT),
                MEDIUM_FLOAT: getFormat(stage, ctx.MEDIUM_FLOAT),
                HIGH_FLOAT: getFormat(stage, ctx.HIGH_FLOAT),
                LOW_INT: getFormat(stage, ctx.LOW_INT),
                MEDIUM_INT: getFormat(stage, ctx.MEDIUM_INT),
                HIGH_INT: getFormat(stage, ctx.HIGH_INT)
            };
        };
        return {
            VERTEX_SHADER: getStageFormat(ctx.VERTEX_SHADER),
            FRAGMENT_SHADER: getStageFormat(ctx.FRAGMENT_SHADER)
        };
    };

    var getParams = function (ctx, names) {
        var enumValue, name, param, paramItem, params, _i, _len;
        params = {};
        for (_i = 0, _len = names.length; _i < _len; _i++) {
            name = names[_i];
            enumValue = ctx[name];
            if (enumValue != null) {
                param = ctx.getParameter(enumValue);
                if (param instanceof Float32Array || param instanceof Int32Array) {
                    params[name] = (function () {
                        var _j, _len1, _results;
                        _results = [];
                        for (_j = 0, _len1 = param.length; _j < _len1; _j++) {
                            paramItem = param[_j];
                            _results.push(paramItem);
                        }
                        return _results;
                    })();
                } else {
                    params[name] = param;
                }
            }
        }
        return params;
    };
    var getExtensions = function (ctx) {
        var capabilities, ext, extname, supported, _i, _len;
        supported = ctx.getSupportedExtensions();
        capabilities = {};
        for (_i = 0, _len = supported.length; _i < _len; _i++) {
            extname = supported[_i];
            if (extname.match('texture_filter_anisotropic')) {
                ext = ctx.getExtension(extname);
                capabilities[extname] = {
                    MAX_TEXTURE_MAX_ANISOTROPY_EXT: ctx.getParameter(ext.MAX_TEXTURE_MAX_ANISOTROPY_EXT)
                };
            } else if (extname.match('OES_standard_derivatives')) {
                ext = ctx.getExtension(extname);
                capabilities[extname] = {
                    FRAGMENT_SHADER_DERIVATIVE_HINT_OES: ctx.getParameter(ext.FRAGMENT_SHADER_DERIVATIVE_HINT_OES)
                };
            } else if (extname.match('WEBGL_draw_buffers')) {
                ext = ctx.getExtension(extname);
                capabilities[extname] = {
                    MAX_COLOR_ATTACHMENTS_WEBGL: ctx.getParameter(ext.MAX_COLOR_ATTACHMENTS_WEBGL),
                    MAX_DRAW_BUFFERS_WEBGL: ctx.getParameter(ext.MAX_DRAW_BUFFERS_WEBGL)
                };
            } else if (extname.match('WEBGL_debug_renderer_info')) {
                ext = ctx.getExtension(extname);
                if (ext != null) {
                    capabilities[extname] = {
                        UNMASKED_VENDOR_WEBGL: ctx.getParameter(ext.UNMASKED_VENDOR_WEBGL),
                        UNMASKED_RENDERER_WEBGL: ctx.getParameter(ext.UNMASKED_RENDERER_WEBGL)
                    };
                }
            }
        }
        return {
            supported: supported,
            capabilities: capabilities
        };
    };

    var getContext = function (info, canvas, name) {
        var ctx;
        try {
            ctx = canvas.getContext(name, {
                stencil: true
            });
            if (ctx != null) {
                info.name = name;
                info.supported = true;
            }
            return ctx;
        } catch (_error) {
            return null;
        }
    };
    var getContextByName = function (info, canvas, name) {
        var ctx;
        ctx = getContext(info, canvas, name);
        if (ctx == null) {
            ctx = getContext(info, canvas, 'experimental-' + name);
        }
        return ctx;
    };

    var getWebglInfo = function (name, paramNames) {
        var canvas, ctx, info;
        canvas = document.createElement('canvas');
        info = {
            supported: false
        };
        if ((canvas != null) && (canvas.getContext != null)) {
            ctx = getContextByName(info, canvas, name);
            if (ctx != null) {
                ctx.enable(ctx.SAMPLE_ALPHA_TO_COVERAGE);
                ctx.enable(ctx.SAMPLE_COVERAGE);
                info.params = getParams(ctx, paramNames);
                info.extensions = getExtensions(ctx);
                if (ctx.getShaderPrecisionFormat != null) {
                    info.shaderPrecision = getShaderPrecisions(ctx);
                } else {
                    info.shaderPrecision = null;
                }
            }
        }
        return info;
    };
    var webglparamNames = 'ALIASED_LINE_WIDTH_RANGE\nALIASED_POINT_SIZE_RANGE\nALPHA_BITS\nBLUE_BITS\nDEPTH_BITS\nGREEN_BITS\nMAX_COMBINED_TEXTURE_IMAGE_UNITS\nMAX_CUBE_MAP_TEXTURE_SIZE\nMAX_FRAGMENT_UNIFORM_VECTORS\nMAX_RENDERBUFFER_SIZE\nMAX_TEXTURE_IMAGE_UNITS\nMAX_TEXTURE_SIZE\nMAX_VARYING_VECTORS\nMAX_VERTEX_ATTRIBS\nMAX_VERTEX_TEXTURE_IMAGE_UNITS\nMAX_VERTEX_UNIFORM_VECTORS\nMAX_VIEWPORT_DIMS\nRED_BITS\nSAMPLE_COVERAGE_VALUE\nSAMPLES\nSTENCIL_BITS\nSUBPIXEL_BITS\nVENDOR\nRENDERER\nVERSION\nSHADING_LANGUAGE_VERSION\nCOMPRESSED_TEXTURE_FORMATS\nSAMPLE_BUFFERS'.split('\n');
    SLCUtility.webgl = getWebglInfo('webgl', webglparamNames);
    var ua = detectInfo();
    if (ua && ua.device && ua.os &&
        ua.device.name === 'iPhone' &&
        ua.os.family === 'iOS' &&
        ua.os.major === 8) {
        SLCUtility.webgl.params.MAX_TEXTURE_SIZE /= 2;
    }
}).call(this);

function spinnerOpts() {
    var opts = {
        lines: 13, // The number of lines to draw
        length: 20, // The length of each line
        width: 7, // The line thickness
        radius: 30, // The radius of the inner circle
        scale: 0.5, // Scales overall size of the spinner
        corners: 1, // Corner roundness (0..1)
        color: '#000', // #rgb or #rrggbb or array of colors
        opacity: 0.25, // Opacity of the lines
        rotate: 17, // The rotation offset
        direction: 1, // 1: clock, -1: counterclockwise
        speed: 1.1, // Rounds per second
        trail: 42, // Afterglow percentage
        fps: 20, // Frames per second when using setTimeout() as a fallback for CSS
        zIndex: 2e9, // The z-index (defaults to 2000000000)
        className: 'spinner', // The CSS class to assign to the spinner
        shadow: false, // Whether to render a shadow
        hwaccel: false, // Whether to use hardware acceleration
    }

    return Object.create(opts);
}

function createUploadFileObj(uploadCompleted, triggerUpload, circleFather, isPanoramaPic,onUploadCancel) {
    var r = new Resumable({
        target: '',
        chunkSize: 1 * 1024 * 1024,
        simultaneousUploads: 4,
        testChunks: false,
        throttleProgressCallbacks: 1,
        generateUniqueIdentifier: function (f) {
            return f.md5Identifier;
        },
        query: {
            resumableIsPanorama: isPanoramaPic | false
        }
    });

    if (circleFather) {
        r.circleWidget = $('<div><strong style="position: absolute;top: 0px;left: 0;width: 100%;text-align: center;line-height: 80px;font-size: 20px;">0.0<i>%</i></strong></div>')
        r.circleWidget.circleProgress({
            value: 0,
            size: 80,
            animation: {
                duration: 100
            }
        });
        r.circleWidget.digit = function (v) {
            r.circleWidget.find('strong').html((100 * v).toFixed(1) + '<i>%</i>');
            console.log('set progress vlalue', v);
        }
        var x = (circleFather.width() - 80) / 2;
        var y = (circleFather.height() - 80) / 2;
        r.circleWidget.css('position', 'absolute')
            .css('left', x + 'px')
            .css('top', y + 'px')
            .appendTo(circleFather);
    };

    if (!r.support) {
        return;
    }
    r.on('fileAdded', function (file) {
        triggerUpload.trigger();
        if (r.circleWidget) {
            var v = r.circleWidget.circleProgress('value') + 0.02;
            v = v < 0.1 ? v : 0.1;
            r.circleWidget.circleProgress('value', v);
            r.circleWidget.digit(v);
        }
        console.log("fileAdded", file.fileName);
    });
    r.on('pause', function () {});
    r.on('complete', function () {
        if (r.circleWidget) {
            r.circleWidget.remove();
        }
        console.log("file complete", "xxx");
        uploadCompleted();
    });
    r.on('fileSuccess', function (file, message) {
        console.log("fileSuccess", file.fileName);
    });
    r.on('fileError', function (file, message) {
        if (r.circleWidget) {
            r.circleWidget.remove();
        }
    });
    r.on('fileProgress', function (file) {
        if (r.circleWidget) {
            var v = r.progress(true);
            v = 0.1 + v * 0.88;
            r.circleWidget.circleProgress('value', v)
            r.circleWidget.digit(v);
        }
    });
    r.on('cancel', function () {
        if (r.circleWidget) {
            r.circleWidget.remove();
        }
        onUploadCancel();
    });
    r.on('uploadStart', function () {
        if (r.circleWidget) {
            r.circleWidget.circleProgress('value', 0.1);
            r.circleWidget.digit(0.1);
        }
    });
    return r;
}

function addSandTablePoint(sandTableView, point) {
    var width = $('.sandTableView').width(),
    	proportion = width / 329;
    console.log(proportion);
    var x = point.x / proportion;
    var y = point.y / proportion;
    var pv = $('<div></div>').addClass('sand-table-arrow')
        .attr('data-idx', point.sceneId)
        .css('position', 'absolute')
        .css('left', x)
        .css('top', y)
        .css('transform', 'rotate(' + point.angle + 'deg)')
        .appendTo(sandTableView);
    return pv;
}
function addSandTablePointBigView(sandTableView, point) {
	var width = $('.sandBigImg-main').width(),
		height = $('.sandBigImg-main').height();
    var x = point.x*(width/329);
    var y = point.y*(height/329);
    var pv = $('<div></div>').addClass('sand-table-arrow')
        .attr('data-idx', point.sceneId)
        .css('position', 'absolute')
        .css('left', x)
        .css('top', y)
        .css('transform', 'rotate(' + point.angle + 'deg)')
        .appendTo(sandTableView);
    return pv;
}

function initSandTablePoints(sandTableView, sand_table) {
    var points = sand_table.points;
    for (var i = 0; i < points.length; ++i) {
        addSandTablePoint(sandTableView, points[i]);
    }
}

function sandPointView(scene_id) {
    var res = undefined;
    $('.sandTableView .sand-table-arrow').each(function (i, item) {
            if (scene_id === $(item).attr("data-idx")) {
                res = $(item);
                return false;
            }
        })
       
    return res;
}

var cameraMaxFov = 90;
var cameraMinFov = 40;

function initVisualAngle(va) {
    if (va.max_fov === 0 && va.min_fov === 0 && va.max_angle === 0 && va.init_fov === 0) {
        va.max_fov = cameraMaxFov;
        va.min_fov = cameraMinFov;
        va.max_angle = 89.9;
        va.min_angle = -89.9;
        va.init_fov = 90;
        va.init_point = {
            x: 0,
            y: 0,
            z: 500
        };
    } else if (va.max_angle >= 90) {
        va.max_angle = 89.99;
    } else if (va.min_angle <= -90) {
        va.min_angle = -89.99;
    }
    
    
}

function getPicfileSize(f) {
    var exep = /\.(original|[0-9]+)\.(original|[0-9]+)\.[^\.]+$/;
    var res = exep.exec(f.id);
    if (res === null)
        return {
            width: 0,
            height: 0
        };
    var width = isNaN(parseInt(res[1])) ? res[1] : parseInt(res[1]);
    var height = isNaN(parseInt(res[2])) ? res[2] : parseInt(res[1]);
    return {
        width: width,
        height: height
    };
}

function cmpPictureSize(s1, s2) {
    if (s1.width == "original")
        return 1;
    if (s2.width == "original")
        return -1;
    if (s1.width == s2.width)
        return s1.height - s2.height;
    return s1.width - s2.width;
}

function gainCanvasBlob(canvas, onBlob) {
    function dataURItoBlob(dataURI) {
        // convert base64 to raw binary data held in a string
        // doesn't handle URLEncoded DataURIs - see SO answer #6850276 for code that does this
        var byteString = atob(dataURI.split(',')[1]);

        // separate out the mime component
        var mimeString = dataURI.split(',')[0].split(':')[1].split(';')[0];

        // write the bytes of the string to an ArrayBuffer
        var ab = new ArrayBuffer(byteString.length);
        var ia = new Uint8Array(ab);
        for (var i = 0; i < byteString.length; i++) {
            ia[i] = byteString.charCodeAt(i);
        }

        // write the ArrayBuffer to a blob, and you're done
        var blob = new Blob([ab], {
            type: mimeString
        });
        return blob;
    }
    f = navigator.userAgent.search("Firefox");
    if (f > -1) {
        canvas.toBlob(onBlob, "image/jpeg");
    } else {
        blob = dataURItoBlob(canvas.toDataURL("image/jpeg"));
        onBlob(blob);
    }
}

// call df.resolve(blob, md5)
function getBlobMd5(df, blob) {
    if (!blob) {
        df.resolve();
        return;
    }
    var r = new FileReader();
    r.onload = function (e) {
        var md5 = SparkMD5.hashBinary(e.target.result);
        df.resolve(blob, md5);
    };
    r.readAsDataURL(blob);
}


// call dfd.resolve(md5)
function uploadBlob(dfd, blob, md5, fileName) {
    if (!blob) {
        dfd.resolve();
        return;
    }
    var f = navigator.userAgent.search("Firefox");
    var rst_file
    if (f > -1) {
        rst_file = new File([blob], fileName, {
            type: "image/jpeg"
        });
    } else {
        rst_file = blob;
    }
    rst_file.md5 = md5;

    function completed() {
        dfd.resolve(md5);
    }
    var triggerUpload = {
        "trigger": function () {
            resum.upload();
        }
    };
    var resum = createUploadFileObj(completed, triggerUpload);
    rst_file.md5Identifier = md5 + ".jpg";
    resum.addFile(rst_file);
}

var ResourceMgr = {
    resources: {},
    poleLogo: {},

    update: function (res) {
        function sortCmp(f1, f2) {
            return cmpPictureSize(getPicfileSize(f1), getPicfileSize(f2));
        }

        function classificationPic(key, fs) {
            var bottomReg = RegExp("bottom.jpg" + "$");
            var topReg = RegExp("top.jpg" + "$");
            var polePic = [],
                normalPic = [];
            for (var i = 0; i < fs.length; i++) {
                if (bottomReg.test(fs[i].id) || topReg.test(fs[i].id)) {
                    polePic.push(fs[i]);
                } else {
                    normalPic.push(fs[i]);
                }
            }
            if (normalPic.length > 0) {
                normalPic.sort(sortCmp);
                ResourceMgr.resources[key] = normalPic;
            }
            if (polePic.length > 0) {
                ResourceMgr.poleLogo[key] = polePic;
            }
        }
        for (var key in res) {
            var files = res[key];
            if (files && files.length > 0)
                if (files[0].file_type.indexOf("image") >= 0) {
                    classificationPic(key, files);
                } else {
                    ResourceMgr.resources[key] = files;
                }
        }
    },

    getResUrlList: function (res_id) {
        var fs = ResourceMgr.resources[res_id];
        var urls = new Array(fs.length);
        fs.sort(cmpPictureSize);
        for (var i = 0; i < fs.length; i++)
            urls[i] = fs[i].access_url;
        return urls;
    },

    decodeRes: function (res_id) {
        var fs = ResourceMgr.resources[res_id];
        if (!fs || fs.length === 0) {
            return null;
        }
        return fs[0].thumbnailUrl;
    },

    decodePic: function (res_id, size) {
        var fs = ResourceMgr.resources[res_id];
        if (!fs || fs.length === 0)
            return null;
        if (size === undefined)
            return fs[fs.length - 1];
        var idx = 0;
        for (idx; idx < fs.length; idx++) {
            if (cmpPictureSize(getPicfileSize(fs[idx]), size) > 0)
                break;
        }
        idx = Math.max(0, idx - 1);
        return fs[idx].access_url;
    },

    getPoleLogo: function (res_id, access_url, type) {
        var fs = ResourceMgr.poleLogo[res_id];
        if (!fs || fs.length == 0)
            return null;
        var target = access_url + '.' + type + '.jpg';
        for (var i = 0; i < fs.length; i++) {
            if (fs[i].access_url == target)
                return fs[i].access_url;
        }
        return null;
    },

    find: function (res_id) {
        return ResourceMgr.resources[res_id];
    }
};

function detectInfo() {
    var ua = window.detect.parse(navigator.userAgent);
    var extInfo = __support_device_info[ua.device.name];
    if (!extInfo) {
        extInfo = {
            screen: 5.5
        };
    }
    if (extInfo.screen === undefined) {
        extInfo.screen = 5.5;
    }
    if (ua.device.name === undefined) {
        ua.device.name = 'Unknown';
    }
    ua.device.screen = extInfo.screen;
    return ua;
}

var __start = new Date();

function countUserAction(projectId, action, toUrl) {
    /*function dateToString(date) {
        var iso = date.toISOString();
        iso.replace('T', ' ');
        iso = iso.replace('T', ' ');
        iso = iso.replace('Z', '');
        var idx = iso.indexOf('.');
        iso = iso.substring(0, idx);
        return iso;
    }
    $.get("http://ipinfo.io", function (response) {
        var ua = detectInfo();
        var data = "productId=1" +
            "&objectId=1" +
            "&fromUrl=" + window.location.href +
            (toUrl ? "&toUrl=" + toUrl : "") +
            "&fromUrlTime=" + dateToString(__start) +
            (toUrl ? "&toUrlTime=" + dateToString(new Date()) : "") +
            "&action=" + action +
            "&userIp=" + response.ip +
            "&browser=" + ua.browser.name;

        var isPc = ua.device.type !== "Mobile";
        var urlMethod='http://hongbao.szzunhao.com/dct/datacount/InsertDataCountForPC.sys';
        $.ajax({
            type: "GET",
            url: urlMethod,
            data: data,
            dataType: "jsonp",
            jsonp: "callbackparam",
            success: function () {
                console.log("数据成功写入");
            },
            error: function () {
                console.log("页面加载失败！");
                return;
            }
        });
    }, "jsonp");*/
}

function getFileList(category, tag) {
    var query = {};
    if (category)
        query.category = category;
    //if (tag)
    //    query.tags = tag;
    var filelist = [];
    $.ajax({
        type: "post",
        data: JSON.stringify(query),
        url: "/api/filelist",
        success: function (res) {
            filelist = res.data || [];
        },
        async: false
    });
    return filelist;
}

function updateIdsFileToResourceMgr(ids) {
    if (ids.length !== 0) {
//        $.ajax({
//            type: "post",
//            data: JSON.stringify(ids),
//            url: "/api/getFiles",
//            success: function (res) {
//                var resource = {};
//
//                validResMap(res.data, resource);
//                ResourceMgr.update(resource);
//            },
//            async: false
//        });
    }
}

function validFileInfoResource(fileList, idx, len) {
    var unknown = [];
    len = Math.min(fileList.length - idx);
    for (var i = 0; i < len; i++) {
        if (fileList[idx + i].oorigin_id === "")
            continue;
        var fs = ResourceMgr.find(fileList[idx + i].oorigin_id);
        if (!fs)
            unknown.push(fileList[idx + i].oorigin_id);
    }
    updateIdsFileToResourceMgr(unknown);
}

function updateResourceFromIds(ids) {
    var unknown = [];
    for (var i = 0; i < ids.length; i++) {
        var fs = ResourceMgr.find(ids[i]);
        if (!fs) {
            unknown.push(ids[i]);
        }
    }
    updateIdsFileToResourceMgr(unknown);
}

function addfileinfo(fileinfo) {
    var ret = null;
    $.ajax({
        type: "POST",
        data: JSON.stringify(fileinfo),
        url: "/api/addFileinfo",
        success: function (res) {
        	console.log(res);
            if (res.err_code === 0) {
                ret = res.data;
            }
        },
        async: false
    });
    return ret;
}

var htmlFileItemStr = '<div style="float:left;">    \
            <div class="img-cls">   \
                <img crossorigin ="Anonymous"/>  \
                <div class="file-name"></div> \
            </div>  \
            <div style="clear:left;">   \
            </div> \
            </div>';

function getFileItemPageSize(pane, lineCnt) {
    var isHidden = false;
    if ($(pane).is(":hidden")) {
        $(pane).show();
        isHidden = true;
    }
    var tmplItem = $(htmlFileItemStr);
    tmplItem.appendTo($(pane));
    var itemWidth = tmplItem.width();
    tmplItem.remove();
    var pageCnt = Math.floor($(pane).width() / itemWidth) * lineCnt;
    if (isHidden)
        $(pane).hide();
    return pageCnt;
}

function refreshFileListItem(pane, fileList, idx, len) {
    validFileInfoResource(fileList, idx, len);
    $(pane).empty();
    var items = [];
    var len = Math.min(fileList.length - idx, len);
    for (var i = 0; i < len; i++) {
        var elem = $(htmlFileItemStr);
        var input = $("input:first", elem);
        var img = $("img:first", elem);
        var p = $(".file-name", elem);
        var files = ResourceMgr.find(fileList[idx + i].oorigin_id);
        var imgUrl = "";
        if (files && files.length > 0) {
            file = files[0];
            if (file.file_type.indexOf('image') == 0) {
                imgUrl = file.access_url;
            } else if (file.file_type.indexOf('audio') == 0) {
                imgUrl = "/img/audio.jpg";
            }
            p.text(file.name);
            p.attr('title', file.name);
        }
        img.attr('src', imgUrl);
        elem[0].dataSrc = fileList[idx + i];
        elem.appendTo($(pane));
        items.push(elem[0]);
    }
    return items;
}

function filter(arr, func) {
    var res = [];
    for (var i = 0; i < arr.length; i++) {
        if (func(arr[i]))
            res.push(arr[i]);
    }
    return res;
}

function initFileListPane(paneElem, filelist, lineCnt, itemClickFunc) {
    var preview = $(".preview", paneElem);
    var page = $(".page", paneElem);
    var curpage = $(".cur-page", paneElem);
    var next = $(".next", paneElem);
    var pane = $(".pane", paneElem);
    var jump_page = $(".jump-page", paneElem);
    var jump = $(".jump-btn", paneElem);
    var const_page_size = getFileItemPageSize(paneElem, lineCnt);
    var is_unique = $(".is-show-unique", paneElem);
    if (is_unique[0])
        is_unique[0].checked = true;

    function filterSamePicFileInfo(arr) {
        var map = {};

        function unappear(item) {
            var tag = "";
            if (item.tags && item.tags.length > 0) {
                tag = item.tags[0];
            }
            if (map[item.oorigin_id + tag] === undefined) {
                map[item.oorigin_id + tag] = true;
                return true;
            }
            return false;
        }
        return filter(arr, unappear);
    }

    function updateShowList(arr) {
        var showList = [];
        if (is_unique.length != 0 && is_unique[0].checked == false) {
            showList = [].concat(paneElem.filelist);
        } else {
            showList = filterSamePicFileInfo(paneElem.filelist);
        }
        return showList;
    }

    paneElem.index = 0;
    paneElem.selected = [];
    paneElem.filelist = filelist;
    var showList = updateShowList(filelist);

    var onclick = function (elem) {
        return function (event) {
            if (elem == event.target)
                return; // 选中大的容器
            var val = elem.dataSrc;
            if ($(elem).hasClass("selected")) {
                $(elem).removeClass("selected")
                paneElem.selected.splice(jQuery.inArray(val, paneElem.selected), 1);
            } else {
                $(elem).addClass("selected");
                paneElem.selected.push(val);
            }
            if (itemClickFunc)
                itemClickFunc(elem);
        };
    };

    function checkSelect(elem) {
        var val = elem.dataSrc;
        for (var i = 0; i < paneElem.selected.length; i++) {
            if (val == paneElem.selected[i])
                break;
        }
        if (i < paneElem.selected.length) {
            $(elem).addClass("selected");
        }
    }

    paneElem.update = function (bSrcChange) {
        if (bSrcChange)
            showList = updateShowList(paneElem.filelist);
        if (!showList || showList.length == 0) {
            page.hide();
            pane.empty();
            $("<p>没有对应资源</p>").appendTo(pane);
            return;
        }
        page.show();
        var total = Math.max(1, Math.ceil(showList.length / const_page_size));
        items = refreshFileListItem(pane[0], showList, paneElem.index * const_page_size, const_page_size);
        $.each(items, function () {
            $(this).click(onclick(this));
            checkSelect(this);
        });
        curpage.text("" + (paneElem.index + 1) + "/" + total);
    };

    preview.unbind('click');
    preview.click(function () {
        if (paneElem.index == 0)
            return;
        paneElem.index--;
        paneElem.update();
    });

    next.unbind('click');
    next.click(function () {
        var total = Math.max(1, Math.ceil(showList.length / const_page_size));
        if (paneElem.index + 1 == total)
            return;
        paneElem.index++;
        paneElem.update();
    });

    if (jump_page.length > 0) {
        jump.unbind('click');
        jump.click(function () {
            if (Number(jump_page.val()) != parseInt(jump_page.val()))
                return;
            var src = parseInt(jump_page.val()) - 1;
            var total = Math.max(1, Math.ceil(showList.length / const_page_size));
            var val = Math.min(total - 1, src);
            val = Math.max(0, val);
            if (src != val)
                return;
            jump_page.val("");
            if (val == paneElem.index)
                return;
            paneElem.index = val;
            paneElem.update();
        });
    }

    if (is_unique.length > 0) {
        is_unique.unbind('change');
        is_unique.change(function () {
            initFileListPane(paneElem, filelist, lineCnt, itemClickFunc);
        });
    }

    paneElem.update();
}

function filterFile(fileInfos, type) {
    var arr = [];
    if (!type)
        arr = arr.concat(fileInfos);
    else {
        validFileInfoResource(fileInfos, 0, fileInfos.length);
        for (var i = 0; i < fileInfos.length; i++) {
            if (fileInfos.oorigin_id == "")
                continue;
            var fs = ResourceMgr.find(fileInfos[i].oorigin_id);
            if (!fs || fs.length == 0)
                continue;
            if (fs[0].file_type.indexOf(type) == 0) {
                arr.push(fileInfos[i]);
            }
        }
    }
    return arr;
}

function sceneIdxById(id, scenes) {
    for (var i = 0; i < scenes.length; i++) {
        if (id == scenes[i].id) {
            return i;
        }
    }

    return -1;
}

function sceneImageView(scene) {
    var res_id = scene.thumbnail_res_id;
    if (res_id == '') {
        res_id = scene.res_id;
    }
    var view = $('<div class="img-cls">   \
                    <img crossorigin ="Anonymous"/>  \
                    <div class="file-name"></div> \
                    </div> ').data('_id', scene.id);
    var fs = ResourceMgr.find(res_id);
    $('img', view).attr('src', (fs && fs.length > 0 ? fs[0].access_url : ''));
    $('.file-name', view).text(scene.name);
    return view;
}

function enterFullscreen(domElem) {
    if (domElem.requestFullscreen) {
        domElem.requestFullscreen();
    } else if (domElem.webkitRequestFullscreen) {
        domElem.webkitRequestFullscreen();
    } else if (domElem.mozRequestFullScreen) {
        domElem.mozRequestFullScreen();
    } else if (domElem.msRequestFullscreen) {
        domElem.msRequestFullscreen();
    }
}

function exitFullscreen() {
    if (document.exitFullscreen) {
        document.exitFullscreen();
    } else if (document.msExitFullscreen) {
        document.msExitFullscreen();
    } else if (document.mozCancelFullScreen) {
        document.mozCancelFullScreen();
    } else if (document.webkitExitFullscreen) {
        document.webkitExitFullscreen();
    }
}


var accelerationIncludingGravity = {
    x: 0,
    y: -1,
    z: 0
};
window.addEventListener("devicemotion", function (event) {
    accelerationIncludingGravity = event.accelerationIncludingGravity;
});

function horizontalRotateAngle() {
    if (Math.abs(accelerationIncludingGravity.z) >
        (Math.abs(accelerationIncludingGravity.x) + Math.abs(accelerationIncludingGravity.y)) * 5) //接近水平平放
        return 0;
    var angle = 0;
    var orient = window.orientation || 0;
    var bVertical = (orient % 180) == 0;
    if (bVertical && accelerationIncludingGravity.y !== 0)
        angle = Math.atan(accelerationIncludingGravity.x / accelerationIncludingGravity.y);
    else if (!bVertical && accelerationIncludingGravity.x !== 0)
        angle = -Math.atan(accelerationIncludingGravity.y / accelerationIncludingGravity.x);

    return angle * 180 / Math.PI;
}

function validPointtitle(chars) {
    return textLenght(chars) <= 20;
}

function textLenght(chars) {
    var sum = 0;
    for (var i = 0; i < chars.length; i++) {
        var c = chars.charCodeAt(i);
        if ((c >= 0x0001 && c <= 0x007e) || (0xff60 <= c && c <= 0xff9f)) {
            sum++;
        } else {
            sum += 1.6;
        }
    }
    return sum;
}