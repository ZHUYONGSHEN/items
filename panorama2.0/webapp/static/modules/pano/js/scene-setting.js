var project,pro;
var resources;
var linkerId;
var changed=false;
window.parent.document.body.onmousewheel = null;
$.get(siteRoot+"/pano/"+albumId,function(data){
	SceneSetting(data, sceneId);//在SceneSetting方法中初始化热点设置页面;需要的参数为当前项目的project，当前场景id，resources;
	var scene = SLCSceneSetting.pano.getCurrScene();
    var initPos = scene.visual_angle.init_point;
});

window.addEventListener('message', function (e) {
	if (e.source != window.parent) return;
	linkerId=e.data.linkerId;
}, false);

$('#main-save-btn').click(function (event) {
	
    var dfFile = jQuery.Deferred();
    var dfUpload = jQuery.Deferred();
    var dfMd5 = jQuery.Deferred();

    var opts = spinnerOpts();
    var container = $("body:first");
    var spinner = new Spinner(opts).spin(container.get(0));
    $("#mask").css('display', 'block');

    var scene = SLCSceneSetting.pano.getCurrScene();

    function finish() {
        spinner.stop();
        $("#mask").css('display', 'none');
        var prj_idx = SLCSceneSetting.pano.project.id;
        var id = prj_idx + "_" + SLCSceneSetting.pano.getCurrScene().id;
        if (SLCSceneSetting.editPoints && id in SLCSceneSetting.editPoints) {
            SLCSceneSetting.pano.currScenePointMap = SLCSceneSetting.editPoints[id];//所有热点在一进入点位管理界面后就全部赋给它
            delete SLCSceneSetting.editPoints[id];
        }
        $("#alertMask").css("display","block").append("<div class='yesOrno preservation'></div>");
        hidePrompt();
    }
    try {
        //generate blob -> md5->upload file -> updateScene
        dfFile.done(function (blob) {
            getBlobMd5(dfMd5, blob);
        });
        dfMd5.done(function (blob, md5) {
            uploadBlob(dfUpload, blob, md5, scene.name);
        });
        dfUpload.done(updateScene)
            .done(finish);
    } catch (e) {
        finish();
        window.console("update scene error");
    }

    generateThumb(dfFile, 256, 128);
});

SLCSceneSetting = {
    bNeedChangePreviewImg: true,
    bChangeThumb: false,
    fovSlideObj: null,
    vertialSlideObj: null,
    pano: null,
};
$(function () {
    $('body').width(document.documentElement.clientWidth);
    $('body').height(document.documentElement.clientHeight);
    $(window).resize(function (e) {
        $('body').width(document.documentElement.clientWidth);
        $('body').height(document.documentElement.clientHeight);
    });
});

$('#main-close-btn').click(function (event) {
    var idx = SLCSceneSetting.pano.getCurrScene().id;
    if (!SLCSceneSetting.editPoints) {
        SLCSceneSetting.editPoints = {};
    }
    var prj_idx = SLCSceneSetting.pano.project.id;
    SLCSceneSetting.editPoints[prj_idx + "_" + idx] = SLCSceneSetting.pano.currScenePointMap;
    window.parent.document.getElementById("point_setting").style.display="none";
    window.parent.document.getElementsByClassName("mask")[0].style.display="none";
    window.parent.document.body.style.overflow="initial";
});

function generateThumb(df, w, h) {
    if (!SLCSceneSetting.bChangeThumb) {
        df.resolve();
        return;
    }

    SLCSceneSetting.bChangeThumb = false;

    function onBlob(blob) {
        df.resolve(blob);
    }
    var canvas = document.createElement('canvas');
    canvas.width = w;
    canvas.height = h;

    var context = canvas.getContext('2d');
    var img = $('#visual-angle-preview-img').get(0);
    context.drawImage(img, 0, 0, w, h);
    gainCanvasBlob(canvas, onBlob);
}

function updatePointTag() {
    var scene = SLCSceneSetting.pano.getCurrScene();
    scene.jump_tags = [];
    scene.picture_tags = [];
    scene.hyperlink_tags = [];
    scene.voice_tags = [];
    scene.introduce_tags = [];
    scene.mark_tags = [];
    for (var k in SLCSceneSetting.pano.currScenePointMap) {
        var pt = SLCSceneSetting.pano.currScenePointMap[k];
        switch (pt.type) {
            case 'jump':
                scene.jump_tags.push(pt.tag);
                break;
            case 'hyperlink':
                scene.hyperlink_tags.push(pt.tag);
                break;
            case 'voice':
                scene.voice_tags.push(pt.tag);
                break;
            case 'introduce':
                scene.introduce_tags.push(pt.tag);
                break;
            case 'picture':
                scene.picture_tags.push(pt.tag);
                break;
            case 'mark':
                scene.mark_tags.push(pt.tag);
                break;
        }
    }
}

function updateScene(md5) {
    if (md5) {
        SLCSceneSetting.pano.getCurrScene().thumbnail_res_id = md5;
        updateResourceFromIds([md5]);
    }
    updatePointTag();
//    var jsonObj = {
//        albumId: SLCSceneSetting.pano.project.id,
//        scene: SLCSceneSetting.pano.getCurrScene()
//    };
    var scene=SLCSceneSetting.pano.getCurrScene();
    scene.linkerId=linkerId;
    scene.formchanged=changed;
    console.log(scene);
    $.ajax({  
        url : backPath+"/pano/point/save",
        type : 'POST',  
        data : JSON.stringify(scene),
        dataType : 'json',  
        contentType : 'application/json;charset=utf-8',  
        success : function(data, status, xhr) {
        	changed=false;
        },  
        error : function(xhr, error, exception) {
        }  
    }); 
    //SLCUtility.callFunc("POST", "updateScene", jsonObj);
}
function hidePrompt (){
	var clearTime = setTimeout(function(){
		$("#alertMask").fadeOut();
		$("#alertMask").html("");
		clearTimeout(clearTime);
	},1500);
}


function SceneSetting(data, sceneId) {//nSceneIdx:代表第几个场景
    var ids = [];
    //collectUnKnowRes(data.album, ids, resources);
//    if (ids.length !== 0) {
//        $.ajax({
//            type: "post",
//            data: JSON.stringify(ids),
//            url: "/api/getFiles",
//            success: function (res) {
//                var fs = res.data;
//                validResMap(fs, resources);
//            },
//            async: false
//        });
//    }
    if (SLCSceneSetting.pano === null) {
        SLCSceneSetting.pano = new Panorama("container");
        SLCSceneSetting.pano.ready = true;
        SLCSceneSetting.pano.AddLoadFilishEvent(loadAllPoint(SLCSceneSetting.pano));
    }

    SLCSceneSetting.pano.isScenesEdit = true;
    SLCSceneSetting.pano.reset(data);//此处在load.js中有ajax请求;父窗口更新project与resources后传给点位管理界面;
    var scenesIndexMap=SLCSceneSetting.pano.project.scenesIndexMap;
    var nSceneIdx=scenesIndexMap[sceneId];
    SLCSceneSetting.pano.loadScene(nSceneIdx);
    
    var scene = SLCSceneSetting.pano.project.scenes[nSceneIdx];
    var prj_idx = SLCSceneSetting.pano.project.id;
    var id = prj_idx + "_" + scene.id;
    if (SLCSceneSetting.editPoints && id in SLCSceneSetting.editPoints) {
        SLCSceneSetting.pano.currScenePointMap = SLCSceneSetting.editPoints[id];//更新点位对象;
        delete SLCSceneSetting.editPoints[id];
    }
    
}

function clearCurrScene() {
	
    $('a[href="#visual-angle-initial"]').tab('show');
    $('#visual-angle-pane').hide();
    $('.visual-angle-frome').hide();
    $('#hot-point-item-container').hide();
    $('.hot-point-page-btn').removeClass('selected');
    SLCSceneSetting.bNeedChangePreviewImg = true;
    if (SLCSceneSetting.fovSlideObj) {
        SLCSceneSetting.fovSlideObj.releaseObj();
        SLCSceneSetting.fovSlideObj = null;
    }
    if (SLCSceneSetting.vertialSlideObj) {
        SLCSceneSetting.vertialSlideObj.releaseObj();
        SLCSceneSetting.vertialSlideObj = null;
    }
    showSetttingPane('');
}






var showSetttingPane = (function () {
    var paneMap = {
        'visual-angle-pane': {
            showDone: function () {//显示后执行此回调
                $('a[href="#visual-angle-initial"]').click();
                showPhotoFrome(document.documentElement.clientWidth, document.documentElement.clientHeight);
                generatePreviewImg();
            },
            hideDone: function () {
                $('.visual-angle-frome').hide();
            }
        },
        'hot-point-pane': {
            showDone: function () {

            },
            hideDone: function () {

            }
        }
    };
    return function (pane) {
        for (var k in paneMap) {
            if (paneMap.hasOwnProperty(k) == false) continue;
            if (pane === k) {
                $('#' + k).show({
                    complete: paneMap[k].showDone//显示完的回调
                });
            } else {
                $('#' + k).hide({
                    complete: paneMap[k].hideDone
                });
            }
        }
    };
})();

$('#main-visual-angle-btn').click(function (e) {
	changed=true;
    var pano = SLCSceneSetting.pano;
    if (pano === null)
        return;
    initVisualAngle(pano.getCurrScene().visual_angle);
    showSetttingPane('visual-angle-pane');
    $('#main-hot-point-btn').removeClass('btncur')
    if(!$('#visual-angle-initial').is(':hidden')){
    	$(this).addClass('btncur')
    }else{
    	$(this).removeClass('btncur')
    }
});

function showPhotoFrome(w, h) {
    if (w < 250 || h < 150) return;

    var divW = 600,
        divH = 350;
    if (w / h > 700 / 400) {
        if (h < 400) {
            divH = h - 50;
            divW = divH * 600 / 350;
        }
    } else {
        if (w < 700) {
            divW = w - 100;
            divH = divW * 350 / 600;
        }
    }
    $('.visual-angle-frome').css({
        'top': (h - divH) / 2,
        'left': (w - divW) / 2,
        'width': divW,
        'height': divH
    });
    $('.visual-angle-frome').show();
}

function generatePreviewImg() {
    if (SLCSceneSetting.bNeedChangePreviewImg === false) return;

    SLCSceneSetting.bChangeThumb = true;
    SLCSceneSetting.bNeedChangePreviewImg = false;
    var c = $('#' + SLCSceneSetting.pano.containerId).children('canvas')[0];
    var url = c.toDataURL('image/jpeg', 0.5);
    $('#visual-angle-preview-img').attr('src', url);
}

$('a[href="#visual-angle-initial"]').on('shown.bs.tab', function (e) {
    showPhotoFrome(document.documentElement.clientWidth, document.documentElement.clientHeight);
});

$('a[href="#visual-angle-fov"]').on('shown.bs.tab', function (e) {
    if (SLCSceneSetting.fovSlideObj == null) {
        var va = SLCSceneSetting.pano.getCurrScene().visual_angle;
        var currMax = va.max_fov,
            currMin = va.min_fov,
            currVal = va.init_fov;
        var obj = new MySlideObj($('#fov-value-slide'), cameraMaxFov, cameraMinFov, 1, currMax, currMin, currVal);
        obj.maxValueChange = function (val) {
            $('#fov-value-max')[0].innerHTML = val;
            va.max_fov = val;
        }
        obj.minValueChange = function (val) {
            $('#fov-value-min')[0].innerHTML = val;
            va.min_fov = val;
        }
        obj.currValueChange = function (val) {
            $('#fov-value-init')[0].innerHTML = val;
            va.init_fov = val;
            SLCSceneSetting.pano.camera.fov = val;
            SLCSceneSetting.pano.camera.updateProjectionMatrix();
        }
        $('#fov-value-max')[0].innerHTML = currMax;
        $('#fov-value-min')[0].innerHTML = currMin;
        $('#fov-value-init')[0].innerHTML = currVal;
        SLCSceneSetting.fovSlideObj = obj;
    }
});

$('a[href="#visual-angle-vertical"]').on('shown.bs.tab', function (e) {
    currVal = SLCSceneSetting.pano.lat;
    if (SLCSceneSetting.vertialSlideObj == null) {
        var va = SLCSceneSetting.pano.getCurrScene().visual_angle;
        var currMax = va.max_angle,
            currMin = va.min_angle;
        var currVal = SLCSceneSetting.pano.camera.rotation.x;
        
        currVal = THREE.Math.radToDeg(currVal);
        var obj = new MySlideObj($('#visual-angle-vertical-slide'), 90, -90, 1, currMax, currMin, currVal);
        obj.maxValueChange = function (val) {
            $('#visual-angle-vertical-max')[0].innerHTML = val;
            va.max_angle = val;
        }
        obj.minValueChange = function (val) {
            $('#visual-angle-vertical-min')[0].innerHTML = val;
            va.min_angle = val;
        }
        obj.currValueChange = function (val) {
            SLCSceneSetting.pano.camera.rotation.x = THREE.Math.degToRad(val);
            var scene = SLCSceneSetting.pano.getCurrScene();
            if (!scene.pos_seted) {
                var initPos = scene.visual_angle.init_point;
                initPos.x = SLCSceneSetting.pano.camera.target.x;
                initPos.y = SLCSceneSetting.pano.camera.target.y;
                initPos.z = SLCSceneSetting.pano.camera.target.z;
            };
            SLCSceneSetting.pano.bIsChanged = true;
        }
        $('#visual-angle-vertical-max')[0].innerHTML = currMax;
        $('#visual-angle-vertical-min')[0].innerHTML = currMin;
        SLCSceneSetting.vertialSlideObj = obj;
    }
});

$('a[href="#visual-angle-initial"]').on('hide.bs.tab', function (e) {
    $('.visual-angle-frome').hide();
});

$('.visual-angle-btn').click(function (e) {
    e.stopPropagation();
    e.preventDefault();
    SLCSceneSetting.pano.getCurrScene().visual_angle.init_point = {
        x: SLCSceneSetting.pano.camera.target.x,
        y: SLCSceneSetting.pano.camera.target.y,
        z: SLCSceneSetting.pano.camera.target.z
    };
    SLCSceneSetting.bNeedChangePreviewImg = true;
    generatePreviewImg();
    var scene = SLCSceneSetting.pano.getCurrScene();
    scene.pos_seted = true;
});

function DrogObj(obj, currX, minX, maxX, stepLen, onChange, isMaxObj) {
	changed=true;
    this.minX = minX;
    this.maxX = maxX;
    var M = false;
    var Rx;
    var t = $(obj);
    var that = this;

    if (isMaxObj) {
        currX += 6;
    }
    t.css('left', currX);
    this.onMousedown = function (event) {

        Rx = event.pageX - (parseInt(t.css("left")) || 0);
        t.css('cursor', 'move').fadeTo(20, 0.5);
        M = true;
    };
    this.onMouseup = function (event) {

        if (M) {
            M = false;
            t.fadeTo(20, 1);
        }
    };
    this.onMousemove = function (event) {

        if (!M) {
            return;
        }

        var mX = event.pageX - Rx;
        mX = Math.round(mX / stepLen) * stepLen;
        mX = Math.max(mX, that.minX);
        mX = Math.min(mX, that.maxX);
        if (parseInt(t.css("left")) === mX) {
            return;
        }
        if (isMaxObj) {
            t.css({
                left: mX + 6
            });
        } else {
            t.css({
                left: mX
            });
        }
        if (onChange) {
            onChange(mX);
        }
    };
    this.addEvent = function () {
        t.bind('mousedown', this.onMousedown);
        t.bind('mouseup', this.onMouseup);
        $(document).bind('mousemove', this.onMousemove);
        $(document).bind('mouseup', this.onMouseup);
    };
    this.removeEvent = function () {
        t.unbind('mousedown', this.onMousedown);
        t.unbind('mouseup', this.onMouseup);
        $(document).unbind('mousemove', this.onMousemove);
        $(document).unbind('mouseup', this.onMouseup);
    };
    this.releaseObj = function () {
        this.removeEvent();
    }
    this.addEvent();
}

function MySlideObj(obj, max, min, step, currMax, currMin, currVal) {

    var that = this;
    var t = $(obj);
    var w = parseInt(t.children('.slide-area-line').width());
    var nW = Math.abs(Math.ceil((max - min) / step));
    var stepLen = w / nW;

    function slideVal2userVal(val) {//滑块距离最左边的像素值转化成fov值
        return Math.round(step * val / stepLen) + min;
    }

    function userVal2slideVal(val) {
        return (val - min) / step * stepLen;
    }

    this.onMinChange = function (nVal) {
        that.currObj.minX = nVal;//最小值滑动时，currObj的minX实时变化
        if (that.minValueChange) {
            var ret = slideVal2userVal(nVal);
            that.minValueChange(ret);
        }
    };
    this.onMaxChange = function (nVal) {
        that.currObj.maxX = nVal;
        if (that.maxValueChange) {
            var ret = max;
            if (nVal < w) {
                ret = slideVal2userVal(nVal);
            }
            that.maxValueChange(ret);
        }
    };
    this.onCurrChange = function (nVal) {
        that.minObj.maxX = nVal;//minObj里面放的最小值和当前值，当前值作为最大值存入minObj对象
        that.maxObj.minX = nVal;
        if (that.currValueChange) {
            var ret = max;
            if (nVal < w) {
                ret = slideVal2userVal(nVal);
            }
            that.currValueChange(ret);
        }
    };
    var nC = userVal2slideVal(currVal);//currVal：当前fov值
    var nMx = Math.min(userVal2slideVal(currMax), w);//currMax：fov当前最大值
    var nMn = userVal2slideVal(currMin);//currMin：fov当前最小值
    var currDoc = t.children('.top-slide-area').children('.curr-value-slide-body');
    var maxDoc = t.children('.bottom-slide-area').children('.max-value-slide-body');
    var minDoc = t.children('.bottom-slide-area').children('.min-value-slide-body');
    this.currObj = new DrogObj(currDoc, nC, nMn, nMx, stepLen, this.onCurrChange);//当前值对象
    this.maxObj = new DrogObj(maxDoc, nMx, nMn, w, stepLen, this.onMaxChange, true);//最大值对象
    this.minObj = new DrogObj(minDoc, nMn, 0, nC, stepLen, this.onMinChange);//最小值对象

    this.releaseObj = function () {
        this.currObj.releaseObj();
        this.maxObj.releaseObj();
        this.minObj.releaseObj();
    };
}


(function () {
    function initSceneList() {
        var objContainer = $('#target-scene-adm');
        objContainer.empty();
        var scenes = SLCSceneSetting.pano.project.scenes;
        for (var i = 0; i < scenes.length; i++) {
            var scene = scenes[i];
//            var res_id = scene.thumbnailUrl;
//            if (res_id == '') {
//                res_id = scene.res_id;
//            }
//            var fs = ResourceMgr.find(res_id);
//            if (!fs) continue;
            var item = $.parseHTML(
                '<div class="select-scene-item" data-scene-id="' + scene.id + '"> \
                    <img crossorigin="Anonymous" src="' + scene.thumbnailUrl + '"/> \
                    <div>' + scene.name + '</div> \
                </div>');
            objContainer.append(item);
        }
    }
    var initIconList = (function () {
        var isInit = false;
        var iconPath= cosAccessHost+"/material/sys/pano/point/";
        var fileList = [iconPath+'front.gif', iconPath+'down.gif', iconPath+'left.gif', iconPath+'left-up.gif', iconPath+'right.gif', iconPath+'right-up.gif', iconPath+'touch.gif',
            iconPath+'position.gif', iconPath+'position2.gif', iconPath+'reading-glass.gif', iconPath+'add.gif', iconPath+'airplane.gif'
        ];
        var markfileList = [iconPath+'round-bule.png',iconPath+'round-green.png',iconPath+'round-yellow.png',iconPath+'round-violet.png',iconPath+'round-red.png',
                            iconPath+'map-blue.png',iconPath+'map-green.png',iconPath+'map-yellow.png',iconPath+'map-violet.png',iconPath+'map-red.png',
                            iconPath+'arrow-blue.png',iconPath+'arrow-green.png',iconPath+'arrow-yellow.png',iconPath+'arrow-violet.png',iconPath+'arrow-red.png',
                            iconPath+'rounds-blue.png',iconPath+'rounds-green.png',iconPath+'rounds-yellow.png',iconPath+'rounds-violet.png',iconPath+'rounds-red.png',iconPath+'rounds-while.png'
                            ];
        return function () {
            if (isInit) {
                return;
            }
            isInit = true;
            for (var i = 0; i < fileList.length; i++) {
                var url = fileList[i];
                $('.select-icon-container').append('<img crossorigin="Anonymous" class="icon-img-item" src="' + url + '" data-res-id="' + url + '">');
            }
            for (var j = 0; j < markfileList.length; j++) {
                var url = markfileList[j];
                $('.select-icon-container-mark').append('<img crossorigin="Anonymous" class="icon-img-item" src="' + url + '" data-res-id="' + url + '">');
            }
        };
    })();

    function onPosChanged(obj) {
        var pointObj = obj;
        return function () {
            var pos = this.position();
            pointObj.x = pos.x;
            pointObj.y = pos.y;
            pointObj.z = pos.z;
        };
    }
    function adjustPicSize(img, url, loadFunc) {
        $(img).css('display', 'none');
        img.src = url;
        img.onload = function (event) {
            var e = event || window.event;
            var img = e.target;
            if (loadFunc && loadFunc(img) == false) {
                return;
            }
            var s = getImageRelativeSize(img.width, img.height, 860, 320);
            img.width = s.w;
            img.height = s.h;
            $(img).css('display', '');
        };
    }

    function addPointListItem(funObj, pts, t) {
        var name = funObj.getItemName();
        var desc = funObj.getDescription();
        var strPoints = '';
        len = 0;
        $(".hot-point-item-elems").remove();
        var cObj = $('#hot-point-item-container-info');
        var itemsElem = $('<div class="hot-point-item-elems"></div>');
        for (var k in pts) {
            if (pts.hasOwnProperty(k) == false) {
                continue;
            }
            if (pts[k].type != t) {
                pts[k].edit_item = null;
                continue;
            }
            len += 1;
            var pointInfo = pts[k].tag;
            var imgUrl = ResourceMgr.decodeRes(pointInfo.res_id);
            if (!imgUrl) {
                imgUrl = pointInfo.res_id;
            }
            
//          <div class="hot-point-item-edit">编辑</div> \
//			<div class="hot-point-item-delete">删除</div>\
            
            var item = $.parseHTML('<div class="hot-point-item" data-index="' + k + '"> \
                                    <img crossorigin="Anonymous" src="' + imgUrl + '" /> \
                                    <p>' + pointInfo.name + ' </p>  \
                                </div>');
            itemsElem.append(item);
            pts[k].edit_item = item[0];
        }
        cObj.append(itemsElem);
        $('#hot-point-item-info').html('已添加' + len + '个' + name + '热点');
        $('#hot-point-item-description').html(desc);
    }
    
    $('#hot-point-item-container').on("mouseenter",".hot-point-item",function(){
    	$("#hot-point-item-controls").css({"display":"block"});
    })
    
    function switchActivePoint(currPointMap, activePtIdx, oldIdx) {//高亮显示不同类型的现存点位;activePtIdx:添加的新热点的id；现存的热点的id对象；
        if (!currPointMap) {
            return;
        }
        var olePtObj = null;
        if (oldIdx in currPointMap) {
            olePtObj = currPointMap[oldIdx];
        }
        activePtObj = currPointMap[activePtIdx];
        if(!activePtObj) return;
        if (!olePtObj || activePtObj.type != olePtObj.type) {
            $('.hot-point-page-btn[data-type="' + activePtObj.type + '"]').click();
        }

        if (olePtObj) {
            $(olePtObj.div_item).css({
                opacity: 0.5
            });
            if (olePtObj.edit_item)
                $(olePtObj.edit_item).css({
                    'border-color': ''
                });
            olePtObj.secen_item.setMode('display');
        }

        $(activePtObj.div_item).css({
            opacity: 1
        });
        if (activePtObj.edit_item)
            $(activePtObj.edit_item).css({
                'border-color': '#009bff'
            });
        activePtObj.secen_item.setMode('edit');
    }

    function addPointToMap(type, tag) {
        var pt = {
            type: type,
            tag: tag
        };
        var idx = SLCUtility.getHtmlId();
        SLCSceneSetting.pano.currScenePointMap[idx] = pt;
        var div = createPointImg(pt, true, idx, SLCSceneSetting.pano);
        $(div).css({
            opacity: 1
        });
        addPointListItem(funMap[type], currPointMap, type);
        return idx;
    }
  
    
    

    function sceneUploadFile(f) {
        if (!f) return;

        var opts = spinnerOpts();
        var spinner = new Spinner(opts).spin($("#add-point-mdl").get(0));
        var buttons = $('#add-point-mdl .modal-dialog button');

        var md5CallbackFunc = function (md5) {
            var strName = f.name;
            var pos = strName.lastIndexOf('.');
            var ext = strName.substr(pos);
            f.md5Identifier = f.md5 + ".original.original" + ext;

            var afterUploaded = function () {
                var fileinfo = {
                    oorigin_id: f.md5,
                    category: "material"
                };
                addfileinfo(fileinfo);
                updateResourceFromIds([f.md5]);
                buttons.each(function () {
                    $(this).removeAttr("disabled");
                });

                $(".spinner").remove();
            };
            var triggerUpload = {
                "size": 1,
                "currtent": 0,
                "trigger": function () {
                    triggerUpload.currtent += 1;
                    if (triggerUpload.currtent == triggerUpload.size) {
                        uploader.upload();
                    }
                },
            };
            var uploader = createUploadFileObj(afterUploaded, triggerUpload, $('#add-point-mdl .modal-dialog'));
            uploader.addFile(f);

        };
        fileMd5(f, md5CallbackFunc);
        buttons.each(function () {
            $(this).attr("disabled", true);
        });
    }

    function generaterFileList(picFileList, beginIdx, pageCount, preFunc, nextFunc) {
    	
        var containerObj = $('#add-point-select-file-pane');
        containerObj.empty();
        for (var i = beginIdx; i < picFileList.length && i < beginIdx + pageCount; i++) {
            var f = picFileList[i];
            var res_id = f.oorigin_id;
            var fs = ResourceMgr.find(res_id);
            var url = ResourceMgr.decodeRes(res_id);
            if (!fs || fs.length == 0 || !url) {
                continue;
            }
            var name = fs[0].name;
            var item = $.parseHTML('<div class="add-point-file-item" data-res-id="' + res_id + '"> \
                            <img crossorigin="Anonymous" src="' + url + '" /> \
                            <div class="select-file-title">' + name + '</div> \
                        </div>');

            containerObj.append(item);
        }
        var str = '';
        str += Math.ceil(beginIdx / pageCount) + 1;
        str += '/';
        str += Math.ceil(picFileList.length / pageCount);
        var pagebtn = $.parseHTML('<div class="add-point-file-page-ctrl"> \
                                        <button id="add-point-file-pre">上一页</button> \
                                        <span>' + str + '</span> \
                                        <button id="add-point-file-next">下一页</button> \
                                    </div>');
        containerObj.append(pagebtn);
        $('#add-point-file-pre').click(preFunc);
        $('#add-point-file-next').click(nextFunc);
    }

    function initPictureLibItem() {
        var picFileList = getFileList("material");
        validFileInfoResource(picFileList, 0, picFileList.length);

        for (var i = picFileList.length - 1; i >= 0; i--) {
            var f = picFileList[i];
            var fs = ResourceMgr.find(f.oorigin_id);
            if (!fs || fs[0].file_type.indexOf('image') < 0) {
                picFileList.splice(i, 1);
            }
        }
        return picFileList;
    }

    function selectLibFile() {
        var fileList = initPictureLibItem();
        var nPageCount = 10;
        var nBeginIdx = 0;
        var nextFunc = function () {
            if (nBeginIdx + nPageCount > fileList.length) {
                return;
            }
            nBeginIdx += 10;
            generaterFileList(fileList, nBeginIdx, nPageCount, preFunc, nextFunc);
        };
        var preFunc = function () {
            if (nBeginIdx - nPageCount < 0) {
                return;
            }
            nBeginIdx -= 10;
            generaterFileList(fileList, nBeginIdx, nPageCount, preFunc, nextFunc);
        };
        generaterFileList(fileList, nBeginIdx, nPageCount, preFunc, nextFunc);
    }

    function updateIconImg(ptObj, res_id) {
        var tid = ResourceMgr.decodeRes(res_id);
        if (!tid) {
            tid = res_id;
        }
        $(ptObj.div_item).children('img').attr('src', tid);
        $(ptObj.edit_item).children('img').attr('src', tid);
        $(ptObj.edit_item).children('p').html(ptObj.tag.name);
        $('p', ptObj.div_item).html(ptObj.tag.name);
    }
    var activePtObj='';
    var clickTagIndex='';
    var clickIndex='';
    var idx='';
	var ptObj='';
    var titleShow='';
    var len;
    var listIndex;
	var isIntroduceContentChange=false;
    var pt_type = '';
    var scene_id = '';
    var scene_elem = null;
    var icon_res_id = '';
    var icon_elem = null;
    var currSceneObj = null;
    var activePtIdx = 0;
    var currPointMap = null;
    var fileObj = null;
    var edit_pt_idx = '';
    var bIsSelectFileLib = false;
    var select_file_res_id = '';
    var select_file_elem = null;
    var select_file_icon_id = '';
    var bSelectIcon = false;

    var showTabs = (function () {
        var tabVec = ['a[href="#target-scene-adm"]',
            'a[href="#hyperlink-addr-adm"]',
            'a[href="#select-picture-adm"]',
            'a[href="#add-text-adm"]',
            'a[href="#select-music-adm"]',
            'a[href="#add-mark-adm"]'
        ];

        return function (tabId) {
            for (var i = 0; i < tabVec.length; i++) {
                if (tabId == tabVec[i]) {
                    $(tabVec[i]).parent().show();
                } else {
                    $(tabVec[i]).parent().hide();
                }
            }
        };
    })();
    
    //点击添加热点后，会跳出相应热点类型的模态框
    var funMap = {
        jump: {
            showEvent: function () {//显示哪种界面
                showTabs('a[href="#target-scene-adm"]');//showTabs:此方法就在784行
                initSceneList();
                if (edit_pt_idx !== '') {
                    var ptObj = currPointMap[edit_pt_idx];
                    icon_res_id = ptObj.tag.res_id;
                    $('.select-scene-item').each(function () {
                        if ($(this).attr('data-scene-id') == ptObj.tag.scene_id) {
                            $(this).click();
                            return false;
                        }
                    });
                }
            },
            doneEvent: function () {
                if (icon_res_id === '' || scene_id === '') {
                    $("#alertMask").css("display","block").append("<div class='yesOrno'><div class='top'></div><div class='middle'>请选择显示的图标和需要跳转的场景!</div><div class='foot'><button class='btn3'>确定</button></div></div>");
                    return false;
                }
                var sceneIdx = SLCSceneSetting.pano.project.scenesIndexMap[scene_id];
                //var sceneIdx = SLCSceneSetting.pano.getSceneIndex(parseInt(scene_id));
                var name = SLCSceneSetting.pano.project.scenes[sceneIdx].name;
                idx = edit_pt_idx;
                if (edit_pt_idx === '') {
                    var jump_point = {
                		titleShow:true,
                        point: null,
                        res_id: icon_res_id,
                        name: name,
                        scene_id: scene_id
                    };
                    currSceneObj.jump_tags.push(jump_point);
                    idx = addPointToMap('jump', jump_point);
                } else {
                    ptObj = currPointMap[edit_pt_idx];
                    ptObj.tag.name = name;
                    ptObj.tag.scene_id = scene_id;
                    ptObj.tag.res_id = icon_res_id;
                    ptObj.tag.titleShow=true;
                    updateIconImg(ptObj, icon_res_id);
                }
                switchActivePoint(currPointMap, idx, activePtIdx);
                activePtIdx = idx;
                return true;
            },
            getPointTags: function () {
                return currSceneObj.jump_tags;
            },
            getItemName: function () {
                return '全景切换';
            },
            getDescription: function () {
                return '在全景中加入一个可以跳转到其它景点的热点';
            }
        },
        hyperlink: {
            showEvent: function () {
                if (edit_pt_idx === '') {
                    $('#hyperlink-name').val('');
                    $('#hyperlink-url').val('');
                    $('#hyperlink-checkbox').attr('checked', true);
                } else {
                    var tag = currPointMap[edit_pt_idx].tag;
                    icon_res_id = tag.res_id;
                    $('#hyperlink-name').val(tag.name);
                    $('#hyperlink-url').val(tag.link_url);
                    $('#hyperlink-checkbox').attr('checked', tag.new_target);
                }
                showTabs('a[href="#hyperlink-addr-adm"]');
            },
            doneEvent: function () {
                var name = $('#hyperlink-name').val();
                var url = $('#hyperlink-url').val();
                var reg=/^http/ig;
                var bNewTarget = $('#hyperlink-checkbox').is(':checked');
                if (icon_res_id === '' || name === '' || url === '') {
                    $("#alertMask").css("display","block").append("<div class='yesOrno'><div class='top'></div><div class='middle'>请选择显示的图标和需要跳转的超链接信息!</div><div class='foot'><button class='btn3'>确定</button></div></div>");
                    return false;
                }
                if (!validPointtitle(name)) {
                    $("#alertMask").css("display","block").append("<div class='yesOrno'><div class='top'></div><div class='middle'>标题中汉字字符不能超过10个，英文字符不能超过20个。</div><div class='foot'><button class='btn3'>确定</button></div></div>");
                    return false;
                }
                if(!url.match(reg)){
                	 $("#alertMask").css("display","block").append("<div class='yesOrno'><div class='top'></div><div class='middle'>请以http://或者https://开头!</div><div class='foot'><button class='btn3'>确定</button></div></div>");
                	return false;
                }
                idx = edit_pt_idx;
                titleShow=$("#hyperlink-title-select").is(':checked');
                if (edit_pt_idx === '') {
                    var hyperlink_point = {
                		titleShow:titleShow,
                        point: null,
                        res_id: icon_res_id,
                        name: name,
                        link_url: url,
                        new_target: bNewTarget
                    };
                    console.log(hyperlink_point);
                    currSceneObj.hyperlink_tags.push(hyperlink_point);
                    idx = addPointToMap('hyperlink', hyperlink_point);
                } else {
                    ptObj = currPointMap[edit_pt_idx];
                    ptObj.tag.name = name;
                    ptObj.tag.res_id = icon_res_id;
                    ptObj.tag.link_url = url;
                    ptObj.tag.new_target = bNewTarget;
                    ptObj.tag.titleShow=titleShow;
                    updateIconImg(ptObj, icon_res_id);
                }
                switchActivePoint(currPointMap, idx, activePtIdx);
                activePtIdx = idx;
                return true;
            },
            getPointTags: function () {
                return currSceneObj.hyperlink_tags;
            },
            getItemName: function () {
                return '超链接';
            },
            getDescription: function () {
                return '在全景中加入一个可以跳转到网页的热点';
            }
        },
        introduce: {
            showEvent: function () {
                if (edit_pt_idx === '') {
                    $('#title-introduce-input').val('');
                    $('#content-introduce-input').val('');
                } else {
                    var tag = currPointMap[edit_pt_idx].tag;
                    icon_res_id = tag.res_id;
                    $('#title-introduce-input').val(tag.name);
                    $('#content-introduce-input').val(tag.content);
                }
                showTabs('a[href="#add-text-adm"]');
            },
            doneEvent: function () {
                var title = $('#title-introduce-input').val();
                var content = $('#content-introduce-input').val();
                if (icon_res_id === '' || title === '' || content === '') {
                   
                    $("#alertMask").css("display","block").append("<div class='yesOrno'><div class='top'></div><div class='middle'>请选择显示的图标，填写描述的标题和内容</div><div class='foot'><button class='btn3'>确定</button></div></div>");
                    return false;
                }
                if (!validPointtitle(title)) {
                    $("#alertMask").css("display","block").append("<div class='yesOrno'><div class='top'></div><div class='middle'>标题中汉字字符不能超过10个，英文字符不能超过20个。</div><div class='foot'><button class='btn3'>确定</button></div></div>");
                    return false;
                }
                idx = edit_pt_idx;
                
                titleShow=$("#introduce-title-select").is(':checked');
                if (edit_pt_idx === '') {
                    var introduce_point = {
                		titleShow:titleShow,
                        point: null,
                        res_id: icon_res_id,
                        name: title,
                        content: content
                    };
                    currSceneObj.introduce_tags.push(introduce_point);
                    currSceneObj.introduce_tags;
                    idx = addPointToMap('introduce', introduce_point);
                } else {
                    ptObj = currPointMap[edit_pt_idx];
                    ptObj.tag.res_id = icon_res_id;
                    ptObj.tag.name = title;
                    ptObj.tag.content = content;
                    ptObj.tag.titleShow=titleShow;
                    updateIconImg(ptObj, icon_res_id);
                }
                switchActivePoint(currPointMap, idx, activePtIdx);
                activePtIdx = idx;
                return true;
            },
            getPointTags: function () {
                return currSceneObj.introduce_tags;
            },
            getItemName: function () {
                return '文字内容';
            },
            getDescription: function () {
                return '在全景中加入一个可以描述当前信息的热点';
            }
        },
        picture: {
            showEvent: function () {
                if (edit_pt_idx !== '') {
                    var ptObj = currPointMap[edit_pt_idx];
                    icon_res_id = ptObj.tag.res_id;
                    select_file_res_id = ptObj.tag.other_res_id;
                    $('#picture-title-adm').val(ptObj.tag.name);
                    var obj = $('.select-picture-img-area');
                    obj.empty();
                    var img = new Image();
                    $(img).attr('crossorigin', 'Anonymous');
                    adjustPicSize(img, ptObj.tag.other_res_id);
                    obj.append(img).append("<div class='img-mask'>删除</div>").css("display","block");
                    
                }
                showTabs('a[href="#select-picture-adm"]');
            },
            doneEvent: function () {
                var title = $('#picture-title-adm').val();
                if (icon_res_id === '' || title === '' || !(fileObj || select_file_res_id !== '')) {

                    $("#alertMask").css("display","block").append("<div class='yesOrno'><div class='top'></div><div class='middle'>请选择显示的图标，图片标题和对应的图片文件</div><div class='foot'><button class='btn3'>确定</button></div></div>");
                    return false;
                }
                if (!validPointtitle(title)) {

                    $("#alertMask").css("display","block").append("<div class='yesOrno'><div class='top'></div><div class='middle'>标题中汉字字符不能超过10个，英文字符不能超过20个。</div><div class='foot'><button class='btn3'>确定</button></div></div>");
                    return false;
                }
                idx = edit_pt_idx;
                titleShow=$("#picture-title-select").is(':checked');
                var md5 = select_file_res_id;
                if (md5 === '') {
                    md5 = fileObj.md5;
                }
                if (edit_pt_idx === '') {
                    var picture_point = {
                		titleShow:titleShow,
                        point: null,
                        res_id: icon_res_id,
                        name: title,
                        other_res_id: md5
                    };
                    currSceneObj.picture_tags.push(picture_point);
                    idx = addPointToMap('picture', picture_point);
                } else {
                    ptObj = currPointMap[edit_pt_idx];
                    ptObj.tag.res_id = icon_res_id;
                    ptObj.tag.name = title;
                    ptObj.tag.other_res_id = md5;
                    ptObj.tag.titleShow=titleShow;
                    updateIconImg(ptObj, icon_res_id);
                }
                switchActivePoint(currPointMap, idx, activePtIdx);
                activePtIdx = idx;
                return true;
            },
            getPointTags: function () {
                return currSceneObj.picture_tags;
            },
            getItemName: function () {
                return '图片浏览';
            },
            getDescription: function () {
                return '在全景中加入一个可以显示图片的热点';
            }
        },
        voice: {
            showEvent: function () {
                if (edit_pt_idx !== '') {
                    var ptObj = currPointMap[edit_pt_idx];
                    icon_res_id = ptObj.tag.res_id;
                    $('#music-title-adm').val(ptObj.tag.name);

                    var audio = $("#point-muisc-player").get(0);
                    audio.pause();
                    audio.src = ptObj.tag.other_res_id;
                }
                showTabs('a[href="#select-music-adm"]');
            },
            doneEvent: function () {
                var title = $('#music-title-adm').val();
                var fileMd5 = null;
                if (fileObj) {
                    fileMd5 = fileObj.md5;
                } else if (edit_pt_idx !== '') {
                    var ptObj = currPointMap[edit_pt_idx];
                    fileMd5 = ptObj.tag.other_res_id;
                }
                
                if (icon_res_id === '' || title === '' ) {

                    $("#alertMask").css("display","block").append("<div class='yesOrno'><div class='top'></div><div class='middle'>请选择显示的图标，音乐标题和对应的音乐文件</div><div class='foot'><button class='btn3'>确定</button></div></div>");
                    return false;
                }
                if (!validPointtitle(title)) {
                    $("#alertMask").css("display","block").append("<div class='yesOrno'><div class='top'></div><div class='middle'>标题中汉字字符不能超过10个，英文字符不能超过20个。</div><div class='foot'><button class='btn3'>确定</button></div></div>");
                    return false;
                }
                idx = edit_pt_idx;
                titleShow=$("#music-title-select").is(':checked');
                if (edit_pt_idx === '') {
                    var voice_point = {
                		titleShow:titleShow,
                        point: null,
                        res_id: icon_res_id,
                        name: title,
                        other_res_id: select_file_res_id
                    };
                    currSceneObj.voice_tags.push(voice_point);
                    idx = addPointToMap('voice', voice_point);
                } else {
                    ptObj = currPointMap[edit_pt_idx];
                    ptObj.tag.res_id = icon_res_id;
                    ptObj.tag.name = title;
                    ptObj.tag.titleShow=titleShow;
                    ptObj.tag.other_res_id = select_file_res_id;
                    updateIconImg(ptObj, icon_res_id);
                }
                switchActivePoint(currPointMap, idx, activePtIdx);
                activePtIdx = idx;
                return true;
            },
            getPointTags: function () {
                return currSceneObj.voice_tags;
            },
            getItemName: function () {
                return '音频';
            },
            getDescription: function () {
                return '在全景中加入一个可以播放语音的热点';
            }
        },
        mark: {
            showEvent: function () {
                if (edit_pt_idx === '') {
                    $('#title-mark-input').val('');
                } else {
                    var tag = currPointMap[edit_pt_idx].tag;
                    icon_res_id = tag.res_id;
                    $('#title-mark-input').val(tag.name);
                }
                showTabs('a[href="#add-mark-adm"]');
            },
            doneEvent: function () {
                var title = $('#title-mark-input').val();
                if (icon_res_id === '' || title === '') {
                   
                    $("#alertMask").css("display","block").append("<div class='yesOrno'><div class='top'></div><div class='middle'>请选择显示的图标，填写描述的标题</div><div class='foot'><button class='btn3'>确定</button></div></div>");
                    return false;
                }
                if (!validPointtitle(title)) {
                    $("#alertMask").css("display","block").append("<div class='yesOrno'><div class='top'></div><div class='middle'>标题中汉字字符不能超过10个，英文字符不能超过20个。</div><div class='foot'><button class='btn3'>确定</button></div></div>");
                    return false;
                }
                idx = edit_pt_idx;
                
                if (edit_pt_idx === '') {
                    var mark_point = {
                		titleShow:true,
                        point: null,
                        res_id: icon_res_id,
                        name: title,
                    };
                    console.log(currSceneObj)
                    currSceneObj.mark_tags.push(mark_point);
                    currSceneObj.mark_tags;
                    idx = addPointToMap('mark', mark_point);
                } else {
                    ptObj = currPointMap[edit_pt_idx];
                    ptObj.tag.res_id = icon_res_id;
                    ptObj.tag.name = title;
                    ptObj.tag.titleShow=true;
                    updateIconImg(ptObj, icon_res_id);
                }
                switchActivePoint(currPointMap, idx, activePtIdx);
                activePtIdx = idx;
                return true;
            },
            getPointTags: function () {
                return currSceneObj.mark_tags;
            },
            getItemName: function () {
                return '文字标记';
            },
            getDescription: function () {
                return '在全景中加入一个可以描述当前信息的热点';
            }
        }
    };











    function switch2LibSelectFile(bLibSelectFile) {
        if (bLibSelectFile) {
            $('#add-point-centent-pane').hide();
            $('#add-point-select-file-pane').show();
            bIsSelectFileLib = true;

            //$('#save-add-point-btn').html('确定');
            $('#cancel-add-point-btn').html('返回');
        } else {
            $('#add-point-centent-pane').show();
            $('#add-point-select-file-pane').hide();
            bIsSelectFileLib = false;
            $('#cancel-add-point-btn').html('取消');
        }
    }
    $('#main-hot-point-btn').click(function (e) {//点击热点按钮的时候弹出设置盘面
        currSceneObj = SLCSceneSetting.pano.getCurrScene();
        currPointMap = SLCSceneSetting.pano.currScenePointMap;
        console.log(currSceneObj)
        showSetttingPane('hot-point-pane');
        $('#main-visual-angle-btn').removeClass('btncur')
        if(!$('#hot-point-pane').is(':hidden')){
        	$(this).addClass('btncur')
        }else{
        	$(this).removeClass('btncur')
        }
    });
    $('#add-point-mdl').on('hidden.bs.modal', function (e) {
        scene_id = '';
        scene_elem = null;
        edit_pt_idx = '';
        icon_res_id = '';
        select_file_res_id = '';
        $(".select-picture-img-area").empty();
        $("#picture-title-adm").val("");
        if (select_file_elem) {
            select_file_elem.css('border', 'none');
            select_file_elem = null;
        }
        if (icon_elem) {
            $(icon_elem).css('border', 'none');
            icon_elem = null;
        }
        fileObj = null;
        $(".tab-content").find("div").eq(listIndex).find(".common-select").attr("checked",false);
        $("#lastStep").css("display","none");
        $("#select-material-btn").removeAttr("checked");
        $("#point-muisc-player").get(0).pause();
        $("#point-muisc-player-btn").html("试听");
        $('#music-title-adm').val('');
    }).on('show.bs.modal', function (e) {
    	
    	
        switch2LibSelectFile(false);
        initIconList();
        $('a[href="#select-icon-adm"]').tab('show');

        //add
        $(".common-select").attr("checked","checked");
        $(".select-icon-container").show();
		$(".select-material-container").hide();
        $("#select-sys-btn").attr("checked",true);
		$("#save-add-point-btn").css({"display":"none"});
		$("#nextStep").css({"display":"block"});
		$("#nextStep").attr("disabled", true);
		$("#save-add-point-btn").attr("disabled", true);
		
		//定义按钮点击后页面切换 
		$("#nextStep").click(function(){
				$("#lastStep").css("display","block");
				$("#myTab>li").eq(listIndex).find('a').tab('show');
    			$("#nextStep").css({"display":"none"});
    			$("#save-add-point-btn").css({"display":"block"});
				
		  });
		
		$("#lastStep").click(function(){
			$(this).css("display","none");
			$("#myTab>li").eq(0).find('a').tab('show');
			$("#nextStep").css({"display":"block"});
			$("#save-add-point-btn").css({"display":"none"});
		});
        //add
        
        
        
        
        if (pt_type in funMap) {//为一个对象，标识为何种热点
            var tp = funMap[pt_type];
            tp.showEvent();
            $('#add-point-mdl-title').html('添加' + tp.getItemName() + '热点');
        }
        if($('.hot-point-page-btn[data-type="mark"]').is('.selected')){
    		$('.select-icon-container').hide();
    		$('.select-icon-container-mark').show();
    	}else{
    		$('.select-icon-container').show();
    		$('.select-icon-container-mark').hide();
    	}
    });
    
    
    $('.select-icon-container').on('click', '.icon-img-item', function (e) {
    	//使下一步按钮恢复效果
    	$("#nextStep").removeAttr("disabled");
        if (e.target == icon_elem) {
            return;
        }
        icon_res_id = $(e.target).attr('data-res-id');
        $(e.target).css('border', '2px solid #009bff');
        if (icon_elem) {
            $(icon_elem).css('border', '');
        }
        icon_elem = e.target;
    });
    $('.select-icon-container-mark').on('click', '.icon-img-item', function (e) {
    	//使下一步按钮恢复效果
    	$("#nextStep").removeAttr("disabled");
        if (e.target == icon_elem) {
            return;
        }
        icon_res_id = $(e.target).attr('data-res-id');
        $(e.target).css('border', '2px solid #009bff');
        if (icon_elem) {
            $(icon_elem).css('border', '');
        }
        icon_elem = e.target;
    });
     
    $('#target-scene-adm').on('click', '.select-scene-item', function (e) {
        var obj = $(e.target);
        $("#save-add-point-btn").removeAttr("disabled");
        if (obj.hasClass('select-scene-item') == false) {
            obj = obj.parent('.select-scene-item');
        }
        var d = obj.attr('data-scene-id');
        if (d) {
            obj.css('border-color', '#8C5B32').siblings().css('border-color', '');
//            if (scene_elem) {
//                scene_elem.css('border', '');
//            }
            scene_elem = obj;
            scene_id = d;
        }
    });
    $('.hot-point-page-btn').click(function (e) {
    	listIndex=$(this).index();
        var t = $(e.target).attr('data-type');
        if (t !== pt_type || $('#hot-point-item-container').is(":hidden")) {
            if (pt_type != '') {//全 局
                $('.hot-point-page-btn[data-type="' + pt_type + '"]').removeClass('selected');
            }
            pt_type = t;
            $('#hot-point-item-container').hide({
                duration: 400,
                queue: true,
                complete: function () {
                    var funObj = funMap[pt_type];
                    var pts = SLCSceneSetting.pano.currScenePointMap;
                    addPointListItem(funObj, pts, pt_type);//增加热点下对应的列表
                }
            }).show({
                duration: 400,
                queue: true,
                complete: function () {
                    activePtObj = currPointMap[activePtIdx];
                    $("#hot-point-item-controls").css("display","none");
                    if (!activePtObj || activePtObj.type != pt_type) {
                        return;
                    }
                    if (activePtObj.edit_item)
                        $(activePtObj.edit_item).css({
                            'border-color': '#009bff'
                        });
                }
            });
            $('.hot-point-page-btn[data-type="' + pt_type + '"]').addClass('selected');
        }
    });
    
	$("#location").on("click",function(){
		if(typeof(activePtObj) == 'undefined'){
			$("#alertMask").css("display","block").append("<div class='yesOrno'></div>");
			hidePrompt();
		}else{
			if($(activePtObj.edit_item).css("border-color")=="rgb(0, 155, 255)"){
		        animateJumpFunc1(activePtObj);
			}else{
				$("#alertMask").css("display","block").append("<div class='yesOrno'></div>");
			}
		}
	});
	$('#alertMask').on('click','.deleteIconClose',function(){
		$('#alertMask .btn2').trigger('click');
	});
	$("#delete").on('click',function(e){
		if(typeof(activePtObj) == 'undefined'){
    		$("#alertMask").css("display","block").append("<div class='yesOrno'></div>");
    		hidePrompt();
    	}else{
    		if($(activePtObj.edit_item).css("border-color")=="rgb(0, 155, 255)"){
            	$("#alertMask").css("display","block").append("<div class='yesOrno deleteIcon'><div class='top'><i class='deleteIconClose'></i><h4>提示</h4></div><div class='middle'>确定删除?</div><div class='foot'><button class='btn1'>确定</button><button class='btn2'>取消</button></div></div>");
            	$("#alertMask").on("click",".btn2",function(){
            		$("#alertMask").css("display","none");
            		$(".yesOrno").css("display","none");
            	});
            	
              $("#alertMask").on("click",".btn1",function(){
              SLCSceneSetting.pano.removePointItem(ptObj.secen_item);
              $(ptObj.div_item).remove();

              function removeFromVector(v, item) {
                  for (var i = 0; i < v.length; i++) {
                      if (v[i] == item) {
                          v.splice(i, 1);
                          break;
                      }
                  }
              }
              removeFromVector(currSceneObj.jump_tags, ptObj.tag);
              removeFromVector(currSceneObj.hyperlink_tags, ptObj.tag);
              removeFromVector(currSceneObj.introduce_tags, ptObj.tag);
              removeFromVector(currSceneObj.picture_tags, ptObj.tag);
              removeFromVector(currSceneObj.voice_tags, ptObj.tag);
              removeFromVector(currSceneObj.mark_tags, ptObj.tag);
              
              delete currPointMap[idx];
              addPointListItem(funMap[pt_type], currPointMap, pt_type);
              if(len==0){
              	$("#hot-point-item-controls").css("display","none");
              }
              e.stopPropagation();
              
              
    		  $("#alertMask").css("display","none");
    		  $(".yesOrno").css("display","none");
    		  ptObj="";
    		  idx="";
    		  activePtObj='';
        	})}else{
    			$("#alertMask").css("display","block").append("<div class='yesOrno'></div>");
    			hidePrompt();
    		}
    	}
		
	});

	/*$("#edit-title").on('click',function(e){
		if ($(".hot-point-item").css("border-color")!="rgb(0, 155, 255)") {
			$("#alertMask").css("display","block").append("<div class='yesOrno'></div>");
		}
	});*/
	
	$("#edit-content").on('click',function(e){
		if ($(".hot-point-item").css("border-color")!="rgb(0, 155, 255)") {
			$("#alertMask").css("display","block").append("<div class='yesOrno'></div>");
			hidePrompt();
		}
	});
	$("#edit-title").off().on("click",function(e){
		edit_pt_idx = ''
		$('.hot-point-item').each(function(){
			if ($(this).css("border-color")=="rgb(0, 155, 255)"){
				edit_pt_idx = $(this).attr('data-index');
			}
		})
    	if(typeof(currPointMap[edit_pt_idx])=="undefined"){
        	$("#alertMask").css("display","block").append("<div class='yesOrno'></div>");
        	hidePrompt();
        	edit_pt_idx='';
        	return "";
        }
		$('#add-point-mdl').modal();
		$("#save-add-point-btn").removeAttr("disabled");
		$("#lastStep").css("display","none");
		e.stopPropagation();
	});
	
	$("#edit-content").off().on("click",function(e){
		edit_pt_idx = ''
		$('.hot-point-item').each(function(){
			if ($(this).css("border-color")=="rgb(0, 155, 255)"){
				edit_pt_idx = $(this).attr('data-index');
			}
		})
		if(typeof(currPointMap[edit_pt_idx])=="undefined"){
        	$("#alertMask").css("display","block").append("<div class='yesOrno'></div>");
        	hidePrompt();
        	edit_pt_idx='';
        	return "";
        }
		
		$('#add-point-mdl').modal();
		$("#save-add-point-btn").css("display","block");
		$("#save-add-point-btn").removeAttr("disabled");
		$("#lastStep").css("display","block");
		$("#nextStep").css("display","none");
		$("#myTab>li").eq(listIndex).find('a').tab('show');
		e.stopPropagation();
	});
    $('#hot-point-item-container-info').on('click', '.hot-point-item', function (e) {//点击热点烈表时
    	clickIndex=$(this).index();
        var obj = $(e.target);
        if (obj.hasClass('hot-point-item') == false) {
            obj = obj.parent('.hot-point-item');
        }
        idx = obj.attr('data-index');
        ptObj = currPointMap[idx];
        switchActivePoint(currPointMap, idx, activePtIdx);
        activePtIdx = idx;
        ptObj.secen_item.gotoItem();

//        $("#location").off().click(function(e){
//		    if (ptObj === undefined)
//		        return;
//	        animateJumpFunc1(ptObj);
//        });
		

    }).on('click', '.hot-point-item-edit', function (e) {
        var obj = $(e.target);
        if (obj.hasClass('hot-point-item') == false) {
            obj = obj.parent('.hot-point-item');
        }
        edit_pt_idx = '';
        $('.hot-point-item').each(function(){
			if ($(this).css("border-color")=="rgb(0, 155, 255)"){
				edit_pt_idx = $(this).attr('data-index');
			}
		})
        $('#add-point-mdl').modal();

        e.stopPropagation();
    });
    
    function animateJumpFunc1(ptObj) {
	    var sceneIdx = myPano.getSceneIndex(ptObj.tag.scene_id);
	    var pos = ptObj.secen_item.position();
	    var latLon = window.xyz2latlon(pos.x, pos.y, pos.z, 500);
	    var target_lat = latLon.lat;
	    var target_lon = latLon.lon;
	    var v = ptObj.secen_item.position();
	    var minFov = v.minFov ? v.minFov : 20;
	    var distance_fov = myPano.camera.fov - minFov;
	    var distance_lon = (target_lon - myPano.lon) % 360;
	    if (distance_lon > 180) {
	        target_lon -= 360;
	        distance_lon -= 360;
	    } else if (distance_lon < -180) {
	        target_lon += 360;
	        distance_lon += 360;
	    }
	    var pre_update_point_percent = 0;
	    distance_lon = Math.round(distance_lon * 100) / 100;
	    var distance_lat = Math.round((target_lat - myPano.lat) * 100) / 100;
	    var finished = 0;
	
	    function animateJump(stepPercent) {
	        var fov = myPano.camera.fov;
	        if (fov == minFov && finished >= 1) {
	            myPano.overLooking = false;
	            myPano.controls.play();
	            myPano.loadScene(sceneIdx);
	            return;
	        }
	        if (finished < 1) {
	            var duration = 30;
	            if (distance_lon && Math.abs((target_lon - myPano.lon) % 360 / distance_lon) > stepPercent) {
	                var tpx = new THREE.Quaternion();
	                tpx.setFromAxisAngle(new THREE.Vector3(0, 1, 0), THREE.Math.degToRad(distance_lon * stepPercent));
	                myPano.camera.quaternion.multiply(tpx);
	            }
	            if (distance_lat && Math.abs((target_lat - myPano.lat) / distance_lat) > stepPercent) {
	                var tpy = new THREE.Quaternion();
	                tpy.setFromAxisAngle(new THREE.Vector3(1, 0, 0), THREE.Math.degToRad(distance_lat * stepPercent));
	                myPano.camera.quaternion.multiply(tpy);
	            }
	            finished += stepPercent;
	            if (finished >= 1) {
	                duration = 600;
	                stepPercent = 0.01;
	                finished = 1;
	            }
	            window.setTimeout(animateJump, duration, stepPercent + 0.005);
	        } else if (fov != minFov) {
	            fov -= stepPercent * distance_fov;
	            if (fov < minFov) {
	                fov = minFov;
	            }
	            myPano.camera.fov = fov;
	           // window.setTimeout(animateJump, 30, stepPercent + 0.005);
	        }
	        myPano.bIsChanged = true;
	        myPano.camera.updateProjectionMatrix();
	    }
	    myPano.controls.pause();
	    animateJump(0.04);
    }

    $('#container').on('click', '.hot-point-tag-item', function (e) {
        var obj = $(e.target);
        if (obj.hasClass('hot-point-tag-item') == false) {
            obj = obj.parent('.hot-point-tag-item');
        }
        idx = obj.attr('data-index');
        if (idx == activePtIdx||!(!!currPointMap)) return;
        ptObj = currPointMap[idx];
        
        switchActivePoint(currPointMap, idx, activePtIdx);
        activePtIdx = idx;
		$("#edit-title").off().on("click",function(e){
			edit_pt_idx = obj.attr('data-index');
			if(typeof(currPointMap[edit_pt_idx])=="undefined"){
            	$("#alertMask").css("display","block").append("<div class='yesOrno'><div class='top'></div><div class='middle'>请先选择热点!</div><div class='foot'><button class='btn3'>确定</button></div></div>");
            	edit_pt_idx='';
            	return "";
            }
			$('#add-point-mdl').modal();
			$("#save-add-point-btn").removeAttr("disabled");
			$("#lastStep").css("display","none");
			e.stopPropagation();
		});
		
		$("#edit-content").off().on("click",function(e){
			edit_pt_idx = obj.attr('data-index');
			if(typeof(currPointMap[edit_pt_idx])=="undefined"){
            	$("#alertMask").css("display","block").append("<div class='yesOrno'><div class='top'></div><div class='middle'>请先选择热点!</div><div class='foot'><button class='btn3'>确定</button></div></div>");
            	edit_pt_idx='';
            	return "";
            }
			$('#add-point-mdl').modal();
			$("#save-add-point-btn").css("display","block");
			$("#save-add-point-btn").removeAttr("disabled");
			$("#lastStep").css("display","block");
			$("#nextStep").css("display","none");
			$("#myTab>li").eq(listIndex).find('a').tab('show');
			e.stopPropagation();
		});
    });

    $('#add-hot-point-btn').click(function (e) {
        $('#add-point-mdl').modal();
    });

    $('#select-picture-upload-btn').click(function (e) {
        $('#file-select-picture-adm').click();
    });

    $('#select-picture-lib-btn').click(function (e) {
        bSelectIcon = false;
        selectLibFile();
        switch2LibSelectFile(true);
    });
    
    var jqXHR =null;

    $('#file-select-picture-adm').change(function (e) {
        var files = e.target.files;
        if (!files || files.length == 0) return;

        fileObj = files[0];
        var img = new Image();
        adjustPicSize(img, URL.createObjectURL(fileObj), function () {
//            console.log(img.width, ";", img.height);
            if (img.width > 1920 || img.height > 1080) {
                $("#alertMask").css("display","block").append("<div class='yesOrno'><div class='top'></div><div class='middle'>设置失败！展示的图片不能大于1920*1080!</div><div class='foot'><button class='btn3'>确定</button></div></div>");
    			
                fileObj = null;
                return false;
            }
            select_file_res_id = '';
            var title = $('#picture-title-adm').val();
            if (!title) {
                $('#picture-title-adm').val(fileObj.name);
            }
            //sceneUploadFile(fileObj);
            var obj = $('.select-picture-img-area');
            obj.empty();
            obj.append(img).append("<div class='img-mask'>删除</div>").css("display","block");
            if(jqXHR!=null){
            	jqXHR.submit();
            }
            return true;
        });
    });
    $(function(){
    	$("#file-select-picture-adm").fileupload({
    		url : backPath+"/pano/uploadfile",
    		dataType : 'json',
    		autoUpload: false,
    		add : function(e, data) {
    			jqXHR=data;
    		},
    		start: function (e) {
    		   // $("#progress").show();
    		},
    		done : function(e, data) {
    		    //$("#progress").hide();
    		    var result=data.result;
    		    if(result.returnCode=="SUCCESS"){
    		    	select_file_res_id=result.cosData.access_url;
    		    	var buttons = $('#add-point-mdl .modal-dialog button');
    		    	buttons.each(function () {
                        $(this).removeAttr("disabled");
                    });
    		    }else{
    		    	alert(result.returnMsg);
    		    }
    		},
    		progressall: function (e, data) {
    			var progress = parseInt(data.loaded / data.total * 100, 10);
    		   // $('#progress .bar').css('width',progress + '%');
    		}
    	});
    });
    $('#add-point-select-file-pane').on('click', '.add-point-file-item', function (e) {
        var obj = $(e.target);
        if (obj.hasClass('add-point-file-item') == false) {
            obj = obj.parent('.add-point-file-item');
        }
        select_file_res_id = obj.attr('data-res-id');
        obj.css('border-color', '#009bff');
        if (select_file_elem) {
            select_file_elem.css('border-color', '');
        }
        select_file_elem = obj;

    });

    $('#select-music-upload-btn').click(function (e) {
        $('#file-select-music-adm').click();
    });

    $('#file-select-music-adm').change(function (e) {
        var files = e.target.files;
        if (!files || files.length == 0) return;

        fileObj = files[0];
        var title = $('#music-title-adm').val();
        if (!title) {
            $('#music-title-adm').val(fileObj.name);
        }
        //sceneUploadFile(fileObj);

        var fileURL = URL.createObjectURL(fileObj);
        var audio = $("#point-muisc-player").get(0);
        audio.pause();
        audio.src = fileURL;
    });
    
    $(function(){
    	$("#file-select-music-adm").fileupload({
    		url : backPath+"/pano/uploadfile",
    		dataType : 'json',
    		autoUpload: false,
    		add : function(e, data) {
    			if(data.files[0].size>5242880){
    				$("#alertMask").css("display","block").append("<div class='yesOrno'><div class='top'></div><div class='middle'>音乐文件不能超过5M!</div><div class='foot'><button class='btn3'>确定</button></div></div>");
    				$("#music-title-adm").val("");
    			}else{
    				data.submit();
    			}
    		},
    		start: function (e) {
    		   // $("#progress").show();
    		},
    		done : function(e, data) {
    		    //$("#progress").hide();
    		    var result=data.result;
    		    if(result.returnCode=="SUCCESS"){
    		    	select_file_res_id=result.cosData.access_url;
    		    	var buttons = $('#add-point-mdl .modal-dialog button');
    		    	buttons.each(function () {
                        $(this).removeAttr("disabled");
                    });
    		    }else{
    		    	alert(result.returnMsg);
    		    }
    		},
    		progressall: function (e, data) {
    			var progress = parseInt(data.loaded / data.total * 100, 10);
    		   // $('#progress .bar').css('width',progress + '%');
    		}
    	});
    });

    $('#point-muisc-player-btn').click(function (e) {
        var audio = $("#point-muisc-player").get(0);
        if (audio.paused) {
            audio.play();
            $("#point-muisc-player-btn").html("暂停");
        } else {
            audio.pause();
            $("#point-muisc-player-btn").html("试听");
        }
    });

    $('#save-add-point-btn').click(function (e) {
    	changed=true;
        if (bIsSelectFileLib) {
            if (select_file_res_id === '') {
                $("#alertMask").css("display","block").append("<div class='yesOrno'><div class='top'></div><div class='middle'>请选择需要显示的图片!</div><div class='foot'><button class='btn3'>确定</button></div></div>");
                return;
            }
            if (select_file_elem) {
                select_file_elem.css('border-color', '');
                select_file_elem = '';
            }
            var obj = $('.select-picture-img-area');
            obj.empty();
            var img = new Image();
            $(img).attr('crossorigin', 'Anonymous');
            adjustPicSize(img, select_file_res_id);
            obj.append(img);
            switch2LibSelectFile(false);
            var title = $('#music-title-adm').val();
            if (!title) {
                var fs = ResourceMgr.find(select_file_res_id);
                $('#music-title-adm').val(fs[0].name);
            }
        } else {
            var isOk = false;
            if (pt_type in funMap) {
                isOk = funMap[pt_type].doneEvent();
            }
            if (isOk) {
                $('#add-point-mdl').modal('hide');
            }
        }
    
    });
    $('#cancel-add-point-btn').click(function (e) {
        select_file_res_id = '';
        select_file_icon_id = '';
        if (select_file_elem) {
            select_file_elem.css('border-color', '');
            select_file_elem = '';
        }
        if (bIsSelectFileLib) {
            switch2LibSelectFile(false);
        } else {
            $('#add-point-mdl').modal('hide');
        }
    });

    function showMaterial() {
        var pane = $(".pane", ".select-material-container");
        var filelist = filterFile(getFileList("material"), "image");
        var select = null;

        var click = function (elem) {
            var val = elem.dataSrc;
            if (select == val) {
                $(elem).removeClass("selected");
                icon_res_id = val.oorigin_id;
                select = null;
                pane.selected = [val];
            } else {
                $(elem).addClass("selected");
                select = val;
                icon_res_id = val.oorigin_id;
                pane.selected = [];
            }
            $(elem).siblings(".selected").removeClass("selected");
        }
        initFileListPane($(".select-material-container")[0], filelist, 2, click);
    }

//  $("#select-material-btn").click(function (e) {
//      if ($("#select-material-btn").data("material") == true) {
//          $(".select-icon-container").show();
//          $(".select-material-container").hide();
//          $("#select-material-btn").data("material", false);
//          $("#select-material-btn").text("使用素材库");
//      } else {
//          $(".select-icon-container").hide();
//          $(".select-material-container").show();
//          showMaterial();
//          $("#select-material-btn").data("material", true);
//          $("#select-material-btn").text("系统图标");
//      }
//  });

	$("#select-material-btn").click(function(){
		$(".select-icon-container").hide();
		$(".select-material-container").show();
	});

	$("#select-sys-btn").click(function(){
		$(".select-icon-container").show();
		$(".select-material-container").hide();
	});

    $('#sys-icon-radio').change(function (e) {
        $('.select-icon-from-lib').hide();
        $('.select-icon-container').show();
    });
    $('#lib-icon-radio').change(function (e) {
        $('.select-icon-container').hide();
        $('.select-icon-from-lib').show();
    });
    $('#select-icon-lib-btn').click(function (e) {
        bSelectIcon = true;
        selectLibFile();
        switch2LibSelectFile(true);
    });
})();


//*****************************change********************
for(var i=0;i<$(".visual-angle-nav>li").length;i++){
	$(".visual-angle-nav>li").eq(i).click(function(){
		$(this).css({"background":"rgba(0, 0, 0, 0.6)"});
		$(this).siblings().css({"background":"rgba(0, 0, 0, 0.6)"});
	});
}

$(".slide-area-line").append("<div class='left-line'></div>");
$(".min-value-slide-body").mousedown(function(){
	$(".left-line").css({"left":$(".slide-area-line").position().left+"px","top":$(".slide-area-line").position().top+"px","margin-left":"6px"});
	$(this).mousemove(function(){
//		$(".left-line").css({"width":$(this).position().left+"px"});
	});
});

$(".slide-area-line").append("<div class='right-line'></div>");
$(".max-value-slide-body").mousedown(function(){
	$(".right-line").css({"left":$(".slide-area-line").position().left+$(".slide-area-line").width()+"px","top":$(".slide-area-line").position().top+"px","border-top":"2px solid #ccc"});
	$(this).mousemove(function(){
//		$(".left-line").css({"left":$(this).position().left+"px","width":$(".slide-area-line").width()-$(this).position().left+"px"});
	});
});


$("#add-text-adm").on("focus","#content-introduce-input",function(){
	$("#save-add-point-btn").removeAttr("disabled");
});

$("#add-mark-adm").on("focus","#title-mark-input",function(){
	$("#save-add-point-btn").removeAttr("disabled");
});

$("#hyperlink-addr-adm").on("focus","#hyperlink-url",function(){
	$("#save-add-point-btn").removeAttr("disabled");
});






function adjustScenePointsPos(pano, externalItems, bForceRefresh) {
        function cameraDir(camera) {
            var vector = new THREE.Vector3(0, 0, -1);
            vector.applyMatrix4(camera.matrixWorld);
            return vector;
        }
        function rotateItem(item, angle) {
            $(item.elem).css({
                '-webkit-transform': 'rotate(' + angle + 'deg)',
                '-moz-transform': 'rotate(' + angle + 'deg)',
                '-ms-transform': 'rotate(' + angle + 'deg)',
                '-o-transform': 'rotate(' + angle + 'deg)',
                'transform': 'rotate(' + angle + 'deg)'
            });
            if (item.fakeItem) {
                $(item.fakeItem.elem).css({
                    '-webkit-transform': 'rotate(' + angle + 'deg)',
                    '-moz-transform': 'rotate(' + angle + 'deg)',
                    '-ms-transform': 'rotate(' + angle + 'deg)',
                    '-o-transform': 'rotate(' + angle + 'deg)',
                    'transform': 'rotate(' + angle + 'deg)'
                });
            }
        }

        function adjustPosition(camera, item) {
            item.dirty = false;
            var elem = $(item.elem);
            var pos = item.position();
            var camPos = camera.target || cameraDir(camera);
            var vec3 = new THREE.Vector3(pos.x, pos.y, pos.z);//转换成在球面的坐标;
            var vec2 = pano.vec3toVec2(camera, vec3);//三维球面坐标转化成可以绝对定位在屏幕上的二维坐标;
            var width = elem.data('width');
            var height = elem.data('height');
            if (typeof left !== 'number' || typeof top !== 'number') {
                width = elem.width();
                height = elem.height();
                elem.data('width', width);
                elem.data('height', height);
            }
            vec2.x -= width / 2;
            vec2.y -= height / 2;
//          if (itemIsNeedShow(camera.position, camPos, pos, vec2, width, height) === false) {
//              elem.hide();
//              return false;
//          } else {
                elem.show();
//          }
            var left = elem.data('left');
            var top = elem.data('top');
            var origin = {
                left: left,
                top: top
            };
            if (typeof left !== 'number' || typeof top !== 'number') {
                origin = elem.position();
                
            }
            if (Math.abs(origin.left - vec2.x) > 1 || Math.abs(origin.top - vec2.y) > 1) {
                var old = elem.offset();
                elem.css({
                    top: vec2.y,
                    left: vec2.x
                });
                elem.data('left', vec2.x);
                elem.data('top', vec2.y);
            }
            elem.hide().show(0);
            return true;
        }
        if (externalItems === undefined)
            return false;
        var hasAdjust = false;
        for (var i = 0; i < externalItems.length; i++) {
            if (pano.vrMode || pano.project.enable_orientation) {
                var angle = horizontalRotateAngle();
                rotateItem(externalItems[i], angle);
            } else {
                rotateItem(externalItems[i], 0);
            }
            if (externalItems[i].mode == 'fix' || externalItems[i].onDragStat())
                continue;

            if (!bForceRefresh && !externalItems[i].dirty)
                continue;

            if ($(externalItems[i].elem).hasClass('vr-hide'))
                continue;
            var cameraL = pano.vrMode ? pano.vrRenderer.stereo.cameraL : pano.camera;

            hasAdjust |= adjustPosition(cameraL, externalItems[i]);
            if (pano.vrMode) {
                var size = pano.getViewSize();
                hasAdjust |= adjustPosition(pano.vrRenderer.stereo.cameraR, gainFakeRightItem(externalItems[i]));
            }
        }
        return hasAdjust;
    }

$("#alertMask").on("click",".btn3",function(){
	$("#alertMask").css("display","none");
	$(".yesOrno").css("display","none");
});

$(".select-picture-img-area").mouseover(function(){
	$(".img-mask").css({"display":"block","cursor":"pointer"});
	$(".img-mask").click(function(){
		$("#alertMask").css("display","block").append("<div class='yesOrno'><div class='top'></div><div class='middle'>确定删除?</div><div class='foot'><button class='btn1 btn4'>确定</button><button class='btn2 btn5'>取消</button></div></div>");
		$("#alertMask").on("click",".btn4",function(){
			$(".select-picture-img-area").empty();
			$("#picture-title-adm").val("");
			$("#alertMask").css("display","none");
    		$(".yesOrno").css("display","none");
		});
		$("#alertMask").on("click",".btn5",function(){
			$("#alertMask").css("display","none");
    		$(".yesOrno").css("display","none");
		});
	});
});
$(".select-picture-img-area").mouseleave(function(){
	$(".img-mask").css("display","none");
});



