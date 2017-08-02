function regPointEvent(obj) {

}
/*
 top: offset.top + cObj.height()/2,
 left: offset.left + cObj.width()/2,
 */

function onPosChanged(obj) {
    var pointObj = obj;
    return function() {
        var pos = this.position();
        pointObj.x = pos.x;
        pointObj.y = pos.y;
        pointObj.z = pos.z;
    };
}

function createPointImg(pt, isScenesEdit, idx, pano) {
    var div = document.createElement("div");
    var cObj = $("#container");
    var offset = cObj.offset();
    var imgUrl = pt.tag.res_id;
    var img = $("<img crossorigin='Anonymous' />");
    img.appendTo(div);
    img.attr({
        src: imgUrl
    });
    $(div).addClass("hot-point-tag-item");
    $(div).appendTo($("#container"));
    $(div).attr({
        'data-index': idx,
        'draggable': false
    });
    var top = offset.top + cObj.height() / 2;
    var left = offset.left + cObj.width() / 2;
    $(div).offset({
        top: top,
        left: left
    });
    if (pt.tag.name && pt.tag.name !== ""&&pt.tag.titleShow) {
        var tDiv = $.parseHTML('<div class="point-title-div"><p></p></div>');
        $("p:first", $(tDiv)).html(pt.tag.name);
        $(tDiv).appendTo($(div));
        $(tDiv).offset({
            left: left + ($(div).width() - $(tDiv).width()) / 2
        });
    }
    
    var sceneItem1 = pano.addPointItem(div, pt.tag.point, 'display', pt.type == "jump"); //注册在当前场景
    if (pt.tag.point) {
        sceneItem1.pos = pt.tag.point;
    } else {
        pt.tag.point = sceneItem1.position();
        
    }
    if (isScenesEdit) {
        $(div).css({
            opacity: 0.5
        });
        sceneItem1.onPosChanged = onPosChanged(pt.tag.point);
    }
    pt.secen_item = sceneItem1;
    pt.div_item = div;
    return div;
}

var myPano = null;

function loadAllPoint(pano) {
    myPano = pano;
    return function() {
        var ptMap = pano.currScenePointMap;
        for (var k in ptMap) {
            if (ptMap.hasOwnProperty(k) == false) {
                continue;
            }
            var pt = ptMap[k];
            var div = createPointImg(pt, pano.isScenesEdit, k, pano);
            pt.div_item = div;
        }
    };
}

function getImageRelativeSize(iW, iH, mW, mH) {
    if (iW > mW || iH > mH) {
        if (iW / iH > mW / mH) {
            iH = mW * iH / iW;
            iW = mW;
        } else {
            iW = mH * iW / iH;
            iH = mH;
        }
    }
    return {
        w: iW,
        h: iH
    };
}

var MAX_H_MARGIN = 200;
var MAX_V_MARGIN = 100;
if (SLCUtility.browser.versions.mobile) {
    MAX_H_MARGIN = 20;
    MAX_V_MARGIN = 80;
}

function showPictureModal(ptObj) {
    var url = ptObj.tag.other_res_id;
    if (!url) {
        return;
    }
    var mdlObj = $('#display-point-info-mdl');
    mdlObj.empty();
    var img = new Image();
    img.crossOrigin = "Anonymous";
    img.src = url;
    img.onload = function(event) {
        var e = event || window.event;
        var img = e.target;
        var mW = document.documentElement.clientWidth;
        var mH = document.documentElement.clientHeight;
        var s = getImageRelativeSize(img.width, img.height, mW - MAX_H_MARGIN, mH - MAX_H_MARGIN);
        img.width = s.w;
        img.height = s.h;

        $(img).css({
            'margin-left': (mW - s.w) / 2,
            'margin-top': MAX_V_MARGIN
        });
        mdlObj.append(img);
        mdlObj.append('<div class="display-point-info-close"></div>');
        mdlObj.modal();
    };
}

function showIntroduceModal(ptObj) {
    var title = ptObj.tag.name;
    var content = ptObj.tag.content;
    var mdlObj = $('#display-point-info-mdl');
    mdlObj.empty();

    var item = $.parseHTML('<div class="introduce-info-container"><h1>' + title + '</h1>' +
        '<p>' + content + '</p></div>');

    var mW = document.documentElement.clientWidth;
    var mH = document.documentElement.clientHeight;
    mdlObj.append(item);
    mdlObj.append('<div class="display-point-info-close"></div>');
    mdlObj.modal();
}

function animateJumpFunc(ptObj) {
    var sceneIdx = myPano.getSceneIndex(ptObj.tag.scene_id);
    if (sceneIdx === null)
        return;

    if (myPano.overLooking) {
        return;
    } else {
        myPano.overLooking = true;
    }
    var pos = ptObj.secen_item.position();
    var latLon = window.xyz2latlon(pos.x, pos.y, pos.z, 500);
    var target_lat = latLon.lat;
    var target_lon = latLon.lon;
    var v = myPano.getCurrScene().visual_angle;
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
            myPano.hotPointJumpScene = true;
            idxx1 =sceneIdx;
            var curScene=myPano.project.scenes[sceneIdx];
            var groupIndex=myPano.project.groupsIndexMap[curScene.sceneGroup.id];
            $('.scene_group_desc').eq(groupIndex).trigger('click');
            /*var loadGetSceneGrounpId = myPano.project.scenes[sceneIdx].sceneGroup.id;
            var sceneGroundIndex = myPano.project.groupsIndexMap[loadGetSceneGrounpId];
            $('.group-bar .scene_group_desc').eq(sceneGroundIndex).trigger('click');*/
            
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
            window.setTimeout(animateJump, 30, stepPercent + 0.005);
        }
        myPano.bIsChanged = true;
        myPano.camera.updateProjectionMatrix();
    }
    myPano.controls.pause();
    animateJump(0.04);
}
$('#container').on('click', '.hot-point-tag-item', function(e) {
    if (myPano.isScenesEdit) return;

    var obj = $(e.target);
    if (obj.hasClass('hot-point-tag-item') == false) {
        obj = obj.parent('.hot-point-tag-item');
    }
    var idx = obj.attr('data-index');
    var ptMap = myPano.currScenePointMap;
    var ptObj = ptMap[idx];
    if (ptObj === undefined)
        return;
    if (ptObj.type == "jump") {
        animateJumpFunc(ptObj);
    } else if (ptObj.type == "hyperlink") {
        if (ptObj.tag.new_target) {
            parent.window.open(ptObj.tag.link_url);
        } else {
        	parent.window.location.href = ptObj.tag.link_url;
        }
    } else if (ptObj.type == "voice") {
        //var audio = $('#point-muisc-player').get(0);
        var url = ptObj.tag.other_res_id;
        if (!url) {
            return;
        }
        var _music = $('#background_music')[0];
        if(_music&&!_music.paused){
			_music.pause();
			if($('.music')){
				$('.music').css({
	   				'background-image':"url(" + cdn_url + linkerData.linkerLeftButton.yyStopIcon+")"
	 	   		});
			}
			
		}
        if(audio_project&&!audio_project.paused){
			audio_project.pause();
			if($('.gopng_sound')){
				$('.gopng_sound').css({
	   				'background-image':"url("+ cdn_url + linkerData.linkerRightButton.musicEntryIcon+")"
	 	   		});
			}
		}
        if(audio_scene&&!audio_scene.paused){
        	audio_scene.pause();
        	$(".songs_icon").css({"background":'url('+cdn_url+linkerData.linkerRightButton.yyEntryIcon+') no-repeat center',"background-size":"cover"});
        }
        if (audio_point.src == url) {
            if (audio_point.paused) {
                audio_point.play();
            } else {
            	audio_point.pause();
            }
        } else {
        	audio_point.src = url;
        	audio_point.play();
        }
    } else if (ptObj.type == "picture") {
        showPictureModal(ptObj);
    } else if (ptObj.type == "introduce") {
        showIntroduceModal(ptObj);
    }
});
$('#display-point-info-mdl').on('click', '.display-point-info-close', function(e) {
    $('#display-point-info-mdl').modal('hide').empty();
});

function baseModle(content) {

    var mdlObj = $('#display-point-info-mdl');
    mdlObj.empty();
    var mW = document.documentElement.clientWidth;
    var mH = document.documentElement.clientHeight;   
    var wrap = $('<div></div>')
        .append(content)
        .addClass('mdl-content');
        
    mdlObj.append('<div class="display-point-info-close"></div>');
    mdlObj.append(wrap);
    mdlObj.modal('show');
}