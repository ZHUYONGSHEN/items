var HOST_URL, globalVar = false,custom_bottom_bar;

(function () {

    if (!HOST_URL)
        HOST_URL = "";

    function console_assert(bool, msg) {
        if (!bool)
            console.log(msg);
    }
    /*
    SceneItem has three mode: display, fix, edit
    display: move with the scene,
    fix: fix up to the container, like the logo
    'edit': which one now you can drag it
    */
    function SceneItem(pano, nSceneId, elem, pos, mode) {
        if (pos === undefined)
            pos = {
                x: 0,
                y: 0,
                z: 0
            };
        this.nSceneId = nSceneId;
        this.parent = pano;
        this.elem = elem;
        this.pos = pos;
        this.mode = mode;
        this.onDrag = false;
        this.mousedown = null;
        this.dirty = true;

        $(this.elem).appendTo(".leftContainer", "#" + pano.containerId);

        if (mode === 'edit')
            registerSceneItemEvent(this);
    }

    function dragCapture(domElem, mousedown, mousemove, mouseup) {
        var onMouseMoveFunc, onMouseUpFunc;
        var funcMove = mousemove;
        var funcRelease = function (event) {
            if (domElem.releaseCapture) {
                domElem.releaseCapture();
                domElem.removeEventListener('mouseup', funcRelease);
                domElem.removeEventListener('mousemove', funcMove);
            } else {
                window.onmousemove = onMouseMoveFunc;
                window.onmouseup = onMouseUpFunc;
            }
            mouseup(event);
            
        };

        var funcCapture = function (event) {
            if (domElem.setCapture) {
                domElem.setCapture();
                domElem.addEventListener('mouseup', funcRelease);
                domElem.addEventListener('mousemove', funcMove);
            } else {
                window.captureEvents(Event.MOUSEMOVE | Event.MOUSEUP);
                onMouseMoveFunc = window.onmousemove;
                onMouseUpFunc = window.onmouseup;
                window.onmousemove = funcMove;
                window.onmouseup = funcRelease;
            }
            mousedown(event);
        };
        domElem.addEventListener("mousedown", funcCapture);
        return funcCapture; // for remove
    }

    var _OperatorSystem = function () {
        var ua = navigator.userAgent,
            isWindowsPhone = /(?:Windows Phone)/.test(ua),
            isSymbian = /(?:SymbianOS)/.test(ua) || isWindowsPhone,
            isAndroid = /(?:Android)/.test(ua),
            isFireFox = /(?:Firefox)/.test(ua),
            isChrome = /(?:Chrome|CriOS)/.test(ua),
            isTablet = /(?:iPad|PlayBook)/.test(ua) || (isAndroid && !/(?:Mobile)/.test(ua)) || (isFireFox && /(?:Tablet)/.test(ua)),
            isPhone = /(?:iPhone)/.test(ua) && !isTablet,
            isPc = !isPhone && !isAndroid && !isSymbian;
        return {
            isTablet: isTablet,
            isPhone: isPhone,
            isAndroid: isAndroid,
            isPc: isPc
        };
    }();
    

    
    function registerSceneItemEvent(item) {
        var elem = item.elem;
        var pano = item.parent;
        var baseX, baseY, pageX, pageY;
        var mousedown = function (event) {
            if (item.mode != 'edit') {
                return;
            }
            item.onDrag = true;
            item.dirty = true;
            baseX = $(elem).offset().left;
            baseY = $(elem).offset().top;
            pageX = event.pageX;
            pageY = event.pageY;
            
            event.preventDefault();
        };

        var mousemove = function (event) {
            if (item.mode != 'edit') {
                return;
            }
//            var left=$('#point_setting', window.parent.document).offset;
//            if($(elem).offset().left>920||$(elem).offset().left<15||$(elem).offset().top<15||$(elem).offset().top>920){
//            	elem.onmouseup=null;
//            }else{
//            	
//            }
            if (event.pageX !== undefined && event.pageY !== undefined) {
            	
                $(elem).offset({
                    left: baseX + event.pageX - pageX,
                    top: baseY + event.pageY - pageY
                });
                
            } else if (event.distanceX !== undefined && event.distanceY !== undefined) {
                $(elem).offset({
                    left: baseX + event.distanceX,
                    top: baseY + event.distanceY
                });
            }
            item.dirty = true;
            event.preventDefault();
        };

        var mouseup = function (event) {
            if (item.mode != 'edit') {
                return;
            }
            item.onDrag = false;
            item.dirty = true;
            var x = $(elem).position().left + $(elem).width() / 2;
            var y = $(elem).position().top + $(elem).height() / 2;
            var t = pano.vec2ToVec3({
                x: x,
                y: y
            });
            item.pos = {
                x: t.x,
                y: t.y,
                z: t.z
            };
            if (item.onPosChanged) {
                item.onPosChanged();
            }
            event.preventDefault();
        };

        if (_OperatorSystem.isPc) {
            item.mousedown = dragCapture(elem, mousedown, mousemove, mouseup);
        } else {
            touch.on(elem, 'dragstart', mousedown);
            touch.on(elem, 'drag', mousemove);
            touch.on(elem, 'dragend', mouseup);
            touch.on(elem, 'touchstart', function (ev) {
                ev.preventDefault();
            });
        }
    }

    SceneItem.prototype.onDragStat = function () {
        return this.onDrag;
    };

    SceneItem.prototype.setMode = function (mode) {
        if (this.mode == mode)
            return;
        if (this.mode === 'edit' && this.mousedown) {
            this.elem.removeEventListener("mousedown", this.mousedown);
        }
        if (this.mode === 'fix') {
            var pano = this.parent;
            var offset = $(this.elem).offset();
            var t = this.pos = pano.vec2ToVec3({
                x: offset.left + $(this.elem).width() / 2,
                y: offset.top + $(this.elem).height() / 2
            });
            if (t)
                this.pos = {
                    x: t.x,
                    y: t.y,
                    z: t.z
                };
        }
        if (mode === 'edit')
            registerSceneItemEvent(this);
        this.mode = mode;
        this.dirty = true;
    };

    SceneItem.prototype.position = function () {
        return this.pos;
    };

    SceneItem.prototype.info = function () {
        return {
            nSceneId: this.nSceneId,
            position: this.pos
        };
    };

    SceneItem.prototype.gotoItem = function () {
        var pano = this.parent;
        var t = xyz2latlon(this.pos.x, this.pos.y, this.pos.z, 500);
        pano.lat = t.lat;
        pano.lon = t.lon;
        pano.bIsChanged = true;
    };

    var updateImgFunc = null;
    var sceneVersion = 0;

    function update(texture, loader, spinner, fs, len, pano) {
        var idx = 0;
        var bSendEvent = true;
        var bImgShow = false;
        var img = null;

        function updateImg(image) {
            if (image) {
                if (spinner !== null) {
                    spinner.stop();
                    spinner = null;
                }
                $('#pageSpinner').remove();
                if (pano.overLooking === true) {
                    img = image;
                } else {
                    img = null;
                    texture.image = image;
                    texture.image.crossOrigin="Anonymous";
                    texture.needsUpdate = true;
                }
                bImgShow = true;

                pano.bIsChanged = true;
                ++sceneVersion;
                fixPoleShapeChange(pano, fs[idx - 1].oorigin_id, fs[idx - 1].access_url, sceneVersion);
            }
            if (idx < len) {
                loader.setCrossOrigin("Anonymous");
                var _sceneResource = fs[idx++], NUMBER_CHAR = 14, IPHONE_SYSTEM = 9;
                var _idxe=_sceneResource.access_url;
                pano.refreshLikeNum();
                
                if(navigator.userAgent.indexOf('Mobile') > 0){
                	var systemNineDown = navigator.userAgent.indexOf('CPU iPhone OS '), 
                	oneChar = systemNineDown+NUMBER_CHAR, 
                	twoChar = navigator.userAgent.indexOf('_'),
                	numberChar = navigator.userAgent.substring(oneChar,twoChar);
                	var idexarr = _idxe.match(/\.\d+\./g);
                	idexarr = idexarr[0].replace('.','');
                	idexarr = idexarr.replace('.','');
                	if(idexarr > 2048){
                		if(numberChar < IPHONE_SYSTEM){
                    		_idxe = _idxe.replace(/\.\d+\.\d+\d./g,'.2048.1024.');
                        }else{
                    		_idxe = _idxe.replace(/\.\d+\.\d+\d./g,'.4096.2048.');
                    	}
                	}
                	var sceneName = $('.sceneName');
                	if(sceneName.length > 0){
                		for(var p in linkerData.project.groupsIndexMap){
                			if(pano.getCurrScene().sceneGroup.id==p){
                				var _index=linkerData.project.groupsIndexMap[p];
                				sceneName.html(linkerData.project.scene_groups[_index].title);
                			}
                		}
                	}
                }
                loader.load(_idxe, updateImg);
            }
            if (pano.overLooking=="false"||pano.overLooking==false && pano.project.enable_overlook==false) {
                if (img) {
                    texture.image = img;
                    texture.image.crossOrigin="Anonymous";
                    texture.needsUpdate = true;
                    img = null;

                    pano.bIsChanged = true;
                }
                if (bImgShow && bSendEvent) {
                    bSendEvent = false;
                    if(autorotationTypes!=1&&isCarousel==1&&pano.isScenesEdit!==true){
                    	clearTimeout(oTime);
                        countdown(pano,10);
                    }
                    if(pano.isScenesEdit!==true){
                    	$(".banner_bottom").css("display","-webkit-flex");
                        
                        if(linkerData.linkerShare.headImageUrl&&linkerData.linkerShare.fixedName&&linkerData.linkerShare.telephone){
                        	
                        	$("#headimg_wraper").show();
                        }
                    }
                    
                }
            }
            pano.SendFilishEvent();
        }
        updateImg();
        return updateImg;
    }

    function createSceneImg(containerId, res_id, pano) {
        var fs = ResourceMgr.find(res_id);
        var maxSize = {
            width: SLCUtility.webgl.params.MAX_TEXTURE_SIZE,
            height: SLCUtility.webgl.params.MAX_TEXTURE_SIZE
        };

        var opts = spinnerOpts();
        opts.color = '#cccccc';
        $('#pageSpinner').remove();
        var container = $('<div id="pageSpinner"><div id="page-spinner-copy">数据加载中..</div></div>')
        $('#' + containerId).closest('DIV').append(container);
        var spinner = new Spinner(opts).spin(container.get(0));


        var sceneFile = null;

        pano.texture = new THREE.Texture();
        pano.geometry = new THREE.SphereGeometry(500, 60, 40);
        pano.material = new THREE.MeshBasicMaterial({
            map: pano.texture //map: new THREE.TextureLoader().load(texturePath)
        });
        pano.geometry.scale(-1, 1, 1);

        var loader = new THREE.ImageLoader();
        loader.setCrossOrigin("Anonymous");
        var len = 0;
        for (; len < fs.length; len++) {
            if (cmpPictureSize(maxSize, getPicfileSize(fs[len])) < 0)
                break;
        }
        updateImgFunc = update(pano.texture, loader, spinner, fs, len, pano);

        return new THREE.Mesh(pano.geometry, pano.material);
    }

    function latlon2xyz(lat, lon, r) {
        var theta = THREE.Math.degToRad(90 - lat);
        var phi = THREE.Math.degToRad(lon);
        var t = {};
        t.x = r * Math.sin(theta) * Math.sin(phi);
        t.y = r * Math.cos(theta);
        t.z = r * Math.sin(theta) * Math.cos(phi);
        return t;
    }

    function xyz2latlon(x, y, z, r) {
        var phi = Math.atan2(x, z); //(z == 0? 0: x/z);
        if (phi < 0) {
            phi += 2 * Math.PI;
        }
        var t = {};
        var val1,val2;
        var b = Math.sqrt(x * x + z * z);
        if (b == 0) {
            t.lat = y > 0 ? 89.9 : -89.9;
        } else {
            if(y/b>1){
                val1=y/b;
                val2=val1/(val1+1);
                
            }else if(y/b<-1){
                val1=y/b;
                val2=-val1/(val1-1);
            }else{
                val2=y/b;
            }
            var theta = Math.acos(val2);
            t.lat = 90 - THREE.Math.radToDeg(theta);
        }
        t.lon = THREE.Math.radToDeg(phi);
        return t;

    }
    
    
    function sceneIdToGroupidx(pano,idxx){
//    	由场景id找相册位置
    	var start;
    	var id=pano.project.scenes[idxx].id;
    	var groups = pano.project.scene_groups;
    	if(groups.length>1){
    		if(groups[0].scenes.length==0){
    			start=1;
    		}else{
    			start=0;
    		}
    		for(var i=start;i<groups.length;i++){
    			for(var j=0;j<groups[i].scenes.length;j++){
    				if(groups[i].scenes[j].id==id){
    					group=i;
    					if(_group!=group&&_group!=null){
    						selectGroup(pano,group);
    					}
    					_group=group;
    				}
    			}
    		}
    	}
    }
    
    

//    倒计时
    function countdown(pano,iTime) {
        if(iTime<=1){
        	idxx++;
    		if(idxx==pano.project.scenes.length){
    			idxx=0;
    		}
        	pano.loadScene(idxx);
        	console.log(idxx);
        	sceneIdToGroupidx(pano,idxx);
            clearTimeout(oTime);
        }else{
            iTime--;
            console.log(idxx);
            oTime=setTimeout(function () {
                countdown(pano,iTime);
            }, 1000);
        }
    }
    
    function registPanoEvent(pano) {
        pano.isUserInteracting = false;
        var currCameraFov = 0;
        var canvas = pano.renderer.domElement;
        function validPerspective(eventFunc) {
            var v = pano.getCurrScene().visual_angle;
            initVisualAngle(v);
            pano.lat = Math.max(v.min_angle, Math.min(v.max_angle, pano.lat));
            pano.camera.fov = Math.max(v.min_fov, Math.min(v.max_fov, pano.camera.fov));
            
        }
        var quaternion = {};
        var onPointerDownPointerX = null;
        var onPointerDownPointerY = null;
        var preDistanceX = 0;
        var preDistanceY = 0;
        var speedX = 0;
        var speedY = 0;
        var animateId = null;

        function onRenderEleMouseDown(event) {
            event.preventDefault();

            pano.isUserInteracting = true;
            pano.bIsChanged = true;
            onPointerDownPointerX = event.clientX;
            onPointerDownPointerY = event.clientY;
            quaternion = pano.camera.quaternion.clone();

            if (event.target.setCapture)
                event.target.setCapture();
        }

        function onRenderEleMouseMove(event) {
            if (pano.isUserInteracting === true && !pano.overLooking) {
                event.preventDefault();
                var tq = quaternion.clone();
                var difQua = new THREE.Quaternion();
                var rad = THREE.Math.degToRad((event.clientX - onPointerDownPointerX) * 0.1);
                var euler = new THREE.Euler();
                euler.setFromQuaternion(tq, 'YXZ');
                euler.y = euler.y + rad;

                if (pano.ready) {
                    rad = THREE.Math.degToRad((event.clientY - onPointerDownPointerY) * 0.1);
                    euler.x = euler.x + rad;
                    euler.x = Math.min(Math.PI / 2, Math.max(-Math.PI / 2, euler.x));
                }
                tq.setFromEuler(euler);
                pano.camera.quaternion.copy(tq);
                validPerspective();
                pano.bIsChanged = true;
            }
        }

        function onRenderEleMouseUp(event) {
            pano.isUserInteracting = false;
            if (event.target.releaseCapture)
                event.target.releaseCapture();
        }

        function onRenderEleTouchStart(event) {
        	if(autorotationTypes!=1){
        		clearTimeout(oTime);
            }
            $('.guide-wrap').fadeOut();
            pano.isUserInteracting = true;
            pano.controls.pause();
            quaternion = pano.camera.quaternion.clone();
            event.preventDefault();
            if (animateId != null) {
                var cancelAnimationFrame = window.cancelAnimationFrame || window.mozCancelAnimationFrame;
                cancelAnimationFrame(animateId);
                animateId = null;
            }
        }

        function onRenderEleTouchMove(event) {
            if (pano.isUserInteracting && !pano.overLooking) {
                $('#point-title-div').hide();
                event.preventDefault();
                var scale = pano.camera.fov / 90;
                var tq = quaternion.clone();

                var rad = THREE.Math.degToRad(event.distanceX * 0.2) * scale;
                var euler = new THREE.Euler();
                euler.setFromQuaternion(tq, 'YXZ');
                euler.y = euler.y + rad;
                if (pano.ready) {
                    var rad = THREE.Math.degToRad(event.distanceY * 0.2) * scale;
                    euler.x = euler.x + rad;
                    euler.x = Math.min(Math.PI / 2, Math.max(-Math.PI / 2, euler.x));
                }
                tq.setFromEuler(euler);
                pano.camera.quaternion.copy(tq);

                var sx = event.distanceX - preDistanceX;
                var sy = event.distanceY - preDistanceY;
                if (sx != 0) speedX = sx;
                if (sy != 0) speedY = sy;
                preDistanceX = event.distanceX;
                preDistanceY = event.distanceY;
                validPerspective();
                pano.bIsChanged = true;
            }
        }

        function onRenderEleTouchEnd(event) {
        	if(autorotationTypes!=1&&isCarousel==1){
                countdown(pano,10);
            }
            if (pano.isUserInteracting) {
                var requestAnimationFrame = window.requestAnimationFrame || window.mozRequestAnimationFrame ||
                    window.webkitRequestAnimationFrame || window.msRequestAnimationFrame;
                var cancelAnimationFrame = window.cancelAnimationFrame || window.mozCancelAnimationFrame;
                var distanceX = event.distanceX;
                var distanceY = event.distanceY;
                animateId = requestAnimationFrame(slowdownAinmate);
                var scale = 0.5;
                var x = speedX;
                var y = speedY;

                function slowdownAinmate() {
                    scale *= 0.8;
                        
                    pano.bIsChanged = true;                    
                    if (scale > 0.01 && animateId !== null) {
                        distanceX += x * scale;
                        distanceY += y * scale;
                        var tq = quaternion.clone();
                        var rad = THREE.Math.degToRad(distanceX * 0.2) * pano.camera.fov / 90;
                        var euler = new THREE.Euler();
                        euler.setFromQuaternion(tq, 'YXZ');
                        euler.y = euler.y + rad;
                        if (pano.ready) {
                            var rad = THREE.Math.degToRad(distanceY * 0.2) * pano.camera.fov / 90;
                            euler.x = euler.x + rad;
                            euler.x = Math.min(Math.PI / 2, Math.max(-Math.PI / 2, euler.x));
                        }
                        tq.setFromEuler(euler);
                        pano.camera.quaternion.copy(tq);

                        animateId = requestAnimationFrame(slowdownAinmate);
                    } else {
                        cancelAnimationFrame(animateId);
                        animateId = null;
                        pano.isUserInteracting = false;
                        pano.controls.play();
                        validPerspective();
                    }
                }
            }
        }

        function onRenderEleMouseWheel(e) {
        	var theEvent = window.event || e;
            if (pano.vrMode === true) {
                return;
            }
            // WebKit
            if (theEvent.wheelDeltaY) {
                pano.camera.fov -= theEvent.wheelDeltaY * 0.05;
                // Opera / Explorer 9
            } else if (theEvent.wheelDelta) {
                pano.camera.fov -= theEvent.wheelDelta * 0.05;
                // Firefox
            } else if (theEvent.detail) {
                pano.camera.fov += theEvent.detail * 1.0;
            }
            validPerspective();
            pano.camera.updateProjectionMatrix();
            pano.bIsChanged = true;
        }

        function onRenderElePinchstart(event) {
            currCameraFov = pano.camera.fov;
        }

        function onRenderElePinch(event) {
            if (pano.vrMode === true) {
                return;
            }
            pano.camera.fov = currCameraFov + 75 * (1 - event.scale);
            validPerspective();
            pano.camera.updateProjectionMatrix();
            pano.bIsChanged = true;
        }

        function onRenderElePinchend(event) {
            currCameraFov = pano.camera.fov;
            pano.bIsChanged = true;
        }

        function onWindowResize() {
        	$(container).height($(window).height());
        	$(container).width($(window).width());
            pano.bIsChanged = true;
            pano.camera.aspect = $(container).width() / $(container).height();
            pano.camera.updateProjectionMatrix();
            pano.renderer.setSize($(container).width(), $(container).height());
        }

        //dragCapture(canvas, onRenderEleMouseDown, onRenderEleMouseMove, onRenderEleMouseUp);
        canvas.addEventListener('mousewheel', onRenderEleMouseWheel, false);
        canvas.addEventListener('MozMousePixelScroll', onRenderEleMouseWheel, false);

        touch.on("#" + canvas.id, 'dragstart', onRenderEleTouchStart);
        touch.on("#" + canvas.id, 'drag', onRenderEleTouchMove);
        touch.on("#" + canvas.id, 'dragend', onRenderEleTouchEnd);

        touch.on("#" + canvas.id, 'pinchstart', onRenderElePinchstart);
        touch.on("#" + canvas.id, 'pinchend', onRenderElePinchend);
        touch.on("#" + canvas.id, 'pinch', onRenderElePinch);
        var ts = {
            x: 0,
            y: 0
        };
        var dis = 0;
        touch.on("#" + canvas.id, 'touchstart', function (e) {
            if (e.pageX && e.pageY) {
                ts.x = e.pageX;
                ts.Y = e.pageY;
            }
            e.preventDefault();
        });
        touch.on("#" + canvas.id, 'touchmove', function (e) {
            if (e.pageX && e.pageY) {
                dis += Math.abs(e.pageX - ts.x);
                dis += Math.abs(e.pageY - ts.y);
            } else {
                dis += 0.5;
            }

            e.preventDefault();
        });
        touch.on("#" + canvas.id, 'touchend', function (e) {
            if (dis < 1) {
                if (!pano.bIsChanged) {
                    /*$('.custom-bottom-bar .cutover').trigger('click');*/
                }
            }
            dis = 0;
            e.preventDefault();
            
        });

        window.addEventListener('resize', onWindowResize, false);
    }

    function Panorama(containerId) {
        this.containerId = containerId;
        this.camera = null;
        this.lat = 0;
        this.lon = 0;
        this.scene = null;
        this.renderer = null;
        this.vrRenderer = null;
        this.mesh = null;
        this.geometry = null;
        this.material = null;
        this.texture = null;
        this.scenePoints = [];
        this.project = null;
        this.nSceneIdx = null;
        this.externalItem = [];
        this.globalSceneItem = [];
        this.isAnimationRunning = false;
        this.bIsChanged = false;
        this.currScenePointMap = null;
        this.isScenesEdit = false;
        this.loadFilishEvent = [];
        this.overLooking = false;
        this.customSwitchScene = true;
        this.vrMode = false;
        this.sceneChangeFunc = [];
        this.bottom_geometry = null;
        this.bottom_material = null;
        this.bottom_texture = null;
        this.bottom_mesh = null;
        this.top_geometry = null;
        this.top_material = null;
        this.top_texture = null;
        this.top_mesh = null;
        this.bottom_logo_geometry = null;
        this.bottom_logo_material = null;
        this.bottom_logo_texture = null;
        this.bottom_logo_mesh = null;
        this.cosAccessHost=null;
        this.needLike=false;//是否需要爱心点赞
        this.likeEle=null;//点赞元素对象
        this.likeNumEle=null;//点赞数量元素对象
        this.autoPlayState=false;//幻灯片
        this.autoAddNumber=0;//自动切换累加值
        this.autoGetTime=null;//自动切换时间戳
        this.getQuaternionY=null;//自动旋转Y值
        this.hotPointJumpScene=false;//
        
        //resources map
        //this.reset(project, resources, containerId);
    }
    //自动幻灯片
    Panorama.prototype.autoPlay = function (pano){
    	if(pano.autoPlayState == true){
    		console.log(pano.autoPlayState);
    		//存储getQuaternionY值
    		console.log(pano);
    		pano.getQuaternionY = pano.camera.quaternion.y;
    		var sceneLength = pano.project.scenes.length;
        	//当前场景
        	var curScene = pano.getCurrScene();
        	//当前场景索引+1
        	pano.autoAddNumber = pano.project.scenesIndexMap[curScene.id] + 1;
        	//清除时间戳
    		clearTimeout(pano.autoGetTime);
        	//当前场景数据
        	if(!curScene){
        		return false;
        	}
        	function autoTime (){
        		//清除时间戳
        		clearTimeout(pano.autoGetTime);
        		//当前场景
            	var autoPlayCurScene = pano.getCurrScene();
        		//当前场景所在的组id
            	var curSceneGroupId = autoPlayCurScene.sceneGroup.id;
            	var curSceneGroupIndex = pano.project.groupsIndexMap[curSceneGroupId];
            	//当前场景所在的组索引
            	if($('.switch_bar .scene_group_desc.select').index() != curSceneGroupIndex){
            		$('.switch_bar .scene_group_desc').eq(curSceneGroupIndex).trigger('click');
            		console.log(curSceneGroupIndex);
            	}
        		if(pano.autoAddNumber > sceneLength-1){
        			pano.autoAddNumber = 0;
        		}
        		console.log(pano.project.enable_autorotation);
        		if(pano.project.enable_autorotation){
        			pano.autoGetTime = setTimeout(function(){
        				console.log(pano.getQuaternionY.toFixed(4) - (-pano.camera.quaternion.y.toFixed(4)));
        				if(pano.getQuaternionY.toFixed(4) - (-pano.camera.quaternion.y.toFixed(4)) <= 0.0009){
            				pano.loadScene(pano.autoAddNumber);
            				pano.autoAddNumber++;
            			}
	        			autoTime();
	        		},1000/60);
        		} else {
	        		pano.autoGetTime = setTimeout(function(){
	        			pano.loadScene(pano.autoAddNumber);
	        			pano.autoAddNumber++;
	        			autoTime();
	        		},10*1000);
        		}
        		
        	};
    	}
    }
    //注册点赞事件
    Panorama.prototype.registerLikeClickEvent=function(likeEleId,likeNumEleId){
    	this.likeEle=$("#"+likeEleId);
    	this.likeNumEle=$("#"+likeNumEleId);
    	this.needLike=true;
    	var pano=this;
    	$(pano.likeEle).click(function(){
    		var curScene=pano.getCurrScene();
    		if(!curScene.liked){
        		$.post(siteRoot+"/api/pano/scene/like?id="+ curScene.id ,function(result){
    				 if(result.returnCode === 'SUCCESS'){
    					 $(pano.likeEle).css({
    						'background':"url(" + pano.likeImgOn +")",
    		    			'background-size':'contain',
    		    			"height":'0.57rem'
    		    		 });
    					 curScene.liked=true;
    					 curScene.likeNum++;
    					 $(pano.likeNumEle).html(curScene.likeNum);
    				 };
    			});
        	}
    	});
    };
    
    //刷新点赞数量
    Panorama.prototype.refreshLikeNum=function(){
    	var pano=this;
    	if(pano.needLike){
        	var curScene=pano.getCurrScene();
            if(curScene.liked){
            	$(pano.likeEle).css({
					'background':"url(" + pano.likeImgOn +")",
	    			'background-size':'contain',
	    			"height":'0.57rem'
	    		});
            }else{
            	$(pano.likeEle).css({
					'background':"url(" + pano.likeImgOff +")",
	    			'background-size':'contain',
	    			"height":'0.64rem'
	    		 });
            }
        	if(curScene.refreshLikeNum){
        		$(pano.likeNumEle).html(curScene.likeNum);
        		return;
        	}
            $.get(siteRoot+"/api/pano/scene/likeNum",{id:curScene.id},function(data){
            	if(data.returnCode=="SUCCESS"){
            		curScene.refreshLikeNum=true;
            		curScene.likeNum=data.likeNum;
            	}
            	$(pano.likeNumEle).html(curScene.likeNum);
            });
        }
    };

    Panorama.prototype.AddLoadFilishEvent = function (fun) {
        this.loadFilishEvent.push(fun);
    };
    Panorama.prototype.SendFilishEvent = function (pano) {
        if (!pano) {
            pano = this;
        }
        if (!pano.ready) {
            setTimeout(pano.SendFilishEvent, 300, pano);
        } else {
            for (var i = 0; i < pano.loadFilishEvent.length; i++) {
                pano.loadFilishEvent[i]();
            }
        }
    };

    Panorama.prototype.setCustomSwitchScene = function (bValid) {
        this.customSwitchScene = bValid;
        if (bValid)
            $('.switch_bar', '#' + this.containerId).show();
        else
            $('.switch_bar', '#' + this.containerId).hide();
    };

    Panorama.prototype.vec2ToVec3 = function (vec2) {
        var mouse = new THREE.Vector2();
        var raycaster = new THREE.Raycaster();
        var size = this.renderer.getSize();
        mouse.x = (vec2.x / size.width) * 2 - 1;
        mouse.y = -(vec2.y / size.height) * 2 + 1;
        raycaster.setFromCamera(mouse, this.camera);
        var intersects = raycaster.intersectObject(this.mesh);
        if (intersects.length > 0) {
            return intersects[0].point;
        }else{
        	return {x:0,y:-500,z:0};
        }
        
    };

    Panorama.prototype.getViewSize = function () {
        var size = this.renderer.getSize();
        if (this.vrMode) {
            size.width /= 2;
        }
        return size;
    };

    Panorama.prototype.vec3toVec2 = function (camera, vec3) {
        var tmp = vec3.clone();

        var vector = tmp.project(camera);
        var size = this.getViewSize();
        var halfWidth = size.width / 2;
        var halfHeight = size.height / 2;

        var result = {
            x: Math.round(vector.x * halfWidth + halfWidth),
            y: Math.round(-vector.y * halfHeight + halfHeight)
        };
        return result;
    };

    function gainFakeRightItem(item) {
        if (!item.fakeItem) {
            console_assert(item.mode != 'edit', item.mode != 'edit');
            item.fakeItem = new SceneItem(item.parent, item.nSceneId, item.elem.cloneNode(true), item.pos, item.mode);
            item.fakeItem.elem.onclick = function () {
                $(item.elem).trigger('click');
                return false;
            };
            item.fakeItem.dirty = true;
            $(item.fakeItem.elem).appendTo(item.parent.rightContainer());
        }

        return item.fakeItem;
    }

    Panorama.prototype.leftContainer = function () {
        var left = $(".leftContainer", "#" + this.containerId);
        return left;
    };

    Panorama.prototype.rightContainer = function () {
        var right = $(".rightContainer", "#" + this.containerId);
        return right;
    };

    var strVrSetting = '<div class="vr-setting-pane vr-show">    \
    <div class="vr-exit settting-desc">退出全屏</div>    \
    <div class="mask"> </div>\
    <div class="vr-setting">\
    <div class="setting-item device-name">  \
            <p class="settting-desc item-name floatLeft">设备:</p>    \
            <p class="settting-desc item-desc" style="both">Unknown</p>    \
    </div>  \
    <div class="setting-item vr-size" data-property="size">  \
                <p class="settting-desc item-name floatLeft">屏幕尺寸:</p>  \
                <p class="settting-desc item-desc" style="clear:left">5.0 inch</p>   \
    </div>  \
    <div class="setting-item vr-distance" data-property="distance">  \
                <p class="settting-desc item-name floatLeft">瞳距:</p>    \
                <p class="settting-desc item-desc ">63.3 mm</p>    \
    </div>  \
    <div class="setting-select select-left" data-property="size">   \
        <div class="setting-desc-item"> \
                <div class="settting-desc">&lt;</div>    \
        </div>  \
    </div>  \
    <div class="setting-select select-right" data-property="size">   \
        <div class="setting-desc-item"> \
                <div class="settting-desc ">&gt;</div>    \
        </div>  \
    </div>      \
    <div class="settting-decide">  \
        <p class="setting-reset settting-desc floatLeft">重置</p>                 \
        <p class="setting-close settting-desc floatLeft">关闭</p>                 \
    </div>  \
    </div>  \
    <div class="vr-config settting-desc">参数设置</div> \
    </div>';

    function vrSettingSelectChange() {
        var item = $('.vr-size');
        if ($('.select-left').data('property') == 'distance')
            item = $('.vr-distance');
        var top = item.offset().top;
        $('.setting-select').each(function (index, elem) {
            $(elem).offset({
                top: top
            });
        });
    }

    function isFullScreen() {
        var elem = document.fullscreenElement || document.mozFullScreenElement || document.webkitFullscreenElement;
        return !!elem;
    }

    function showVrSettingPane(container, pano) {
        var pane = $(".vr-setting-pane", container);
        if (pane.length === 0) {
            pane = $(strVrSetting).appendTo(container);
            var ua = detectInfo();
            $('.device-name .item-desc').text(ua.device.name);

            function select(elem) {
                return function () {
                    $('.select-left').data('property', $(elem).data('property'));
                    $('.select-right').data('property', $(elem).data('property'));
                    vrSettingSelectChange();
                };
            }

            function setEyeSep(val) {
                var desc = val * 100;
                $('.vr-distance .item-desc').text(desc.toFixed(2) + " mm");
            }

            function setVrSize(val) {
                $('.vr-size .item-desc').text(val + " inch");
            }

            function eyeSep(dir) {
                var offset = 0;
                if (dir > 0)
                    offset += 0.001;
                else
                    offset -= 0.001;
                var val = pano.vrRenderer.getEyeSep();
                val += offset;
                val = pano.vrRenderer.updateEyeSep(val);
                return val;
            }

            function valueChange(property, dir) {
                var val;
                switch (property) {
                    case "distance":
                        val = eyeSep(dir);
                        setEyeSep(val);
                        break;
                    case "size":
                        val = pano.vrRenderer.getScreen() + dir * 0.1;
                        val = Math.round(val * 1e1) / 1e1;
                        pano.vrRenderer.setScreen(val);
                        setVrSize(val);
                        break;
                }
            }
            setEyeSep(pano.vrRenderer.getEyeSep());
            setVrSize(pano.vrRenderer.getScreen());

            function previous() {
                valueChange($('.select-left').data('property'), -1);
            }

            function next() {
                valueChange($('.select-right').data('property'), 1);
            }

            var timer;

            function longTimeTouch(func, time) {
                return function () {
                    func();
                    if (timer)
                        clearInterval(timer);
                    timer = setInterval(func, time);
                    return false;
                };
            }

            function endTouch() {
                if (timer)
                    clearInterval(timer);
            }

            if (_OperatorSystem.isPc) {
                $('.select-left').bind('mousedown', longTimeTouch(previous, 200));
                $('.select-right').bind('mousedown', longTimeTouch(next, 200));

                $('.select-left').bind('mouseup', endTouch);
                $('.select-right').bind('mouseup', endTouch);
            } else {
                touch.on($('.select-left').get(0), 'touchstart', longTimeTouch(previous, 200));
                touch.on($('.select-right').get(0), 'touchstart', longTimeTouch(next, 200));

                touch.on($('.select-left').get(0), 'touchend', endTouch);
                touch.on($('.select-right').get(0), 'touchend', endTouch);
            }

            $('.select-left').bind('mouseup', endTouch);
            $('.select-right').bind('mouseup', endTouch);


            $('.vr-size').bind('click', select($('.vr-size')));
            $('.vr-distance').bind('click', select($('.vr-distance')));

            $('.setting-close').bind('click', function () {
                hideVrSetting(pane);
                pane.hide();
            });

            //$('.setting-save').bind('click', function(){
            //var eyeSep = pano.vrRenderer.getEyeSep();
            //var vrSize = pano.vrRenderer.getScreen();
            //setCookie("eyeSep", eyeSep);
            //setCookie("screen", vrSize);

            //$('.setting-close').trigger('click');
            //});

            $('.setting-reset').bind('click', function () {
                pano.vrRenderer.updateEyeSep(0.064);
                var ua = detectInfo();
                pano.vrRenderer.setScreen(ua.device.screen);
                setEyeSep(pano.vrRenderer.getEyeSep());
                setVrSize(pano.vrRenderer.getScreen());
            });

            $('.vr-exit').bind('click', function () {
                hideVrSetting(pane);
                pane.hide();
                /*$('.custom-bottom-bar').css('bottom','0px')*/
                if(!$('.custom-bottom-bar .switch_bar').is('.unfold')){
                	$('.custom-bottom-bar .switch_bar').removeClass('collapsed').addClass('unfold')
                }
                $('.linkerButtonBelows').css({'bottom':custom_bottom_bar+'px'})
                if (isFullScreen())
                    exitFullscreen();
                else
                    pano.switchVRMode();
            });

            $('.vr-config').bind('click', function () {
                pane.stop(true, false);
                pane.show().animate({
                    opacity: 1
                }, 100);
                showVrSetting(pane);
                return false;
            });

            var top = $('.vr-size').offset().top;
            $('.select-left').offset({
                top: top
            });
            $('.select-right').offset({
                top: top
            });
            $('.vr-setting').hide();
        }

        hideVrSetting(pane);
        pane.stop(true, false);
        pane.show().animate({
            opacity: 1
        }, 200).fadeOut(5000);
    }

    function hideVrSettingPane(container) {
        var pane = $(".vr-setting-pane", container);
        if (pane.length !== 0)
            return pane.hide();
    }

    function showVrSetting(pane) {
        var mask = $('.mask', pane);
        var setting = $('.vr-setting', pane);
        setting.show();
        mask.show();

        var middle = pane.offset().left + pane.width() / 2;

        $('.item-name', setting).each(function (index, element) {
            $(element.parentNode).offset({
                left: middle - $(element).width() - 5
            });
        });

        $('.select-left').offset({
            left: middle - 150
        });

        $('.select-right').offset({
            left: middle + 150
        });
        vrSettingSelectChange();
    }

    function hideVrSetting(pane) {
        $(".vr-setting", pane).hide();
        $('.mask', pane).hide();
    }

    function initVrConfig(vrRenderer) {
        var ua = detectInfo();
        vrRenderer.setScreen(ua.device.screen);
        var eyeSep = getCookie("eyeSep");
        if (eyeSep)
            vrRenderer.updateEyeSep(parseFloat(eyeSep));
        var vrSize = getCookie("screen");
        if (vrSize)
            vrRenderer.setScreen(parseFloat(vrSize));
    }

    Panorama.prototype.switchVRMode = function () {
        var clickCallBack;
        return function () {
            var container = $("#" + this.containerId);
            var pano = this;
            var canvas = pano.renderer.domElement;

            function clickShow(e) {
                if (pano.vrMode === true)
                    showVrSettingPane(container, pano);
            }

            if (this.vrMode === true) {
                if (this.vrRenderer)
                    this.vrRenderer.clear(this.camera);
                this.vrMode = false;
                container.removeClass('vrMode');
                this.leftContainer().children().removeClass('vr-hide');
                container.children().removeClass('vr-hide');
                hideVrSettingPane(container);
                if (clickCallBack) {
                    $(canvas).unbind('click', clickCallBack);
                    touch.unbind(canvas, 'tap', clickCallBack);
                }

                this.controls.disconnect();
                this.controls.adjustMesh(true);
            } else {
                this.renderer.clear();
                if (!this.vrRenderer) {
                    this.vrRenderer = new THREE.StereoEffect(this.renderer);
                    initVrConfig(this.vrRenderer);
                }

                this.vrMode = true;
                container.addClass('vrMode');
                showVrSettingPane(container, this);
                this.leftContainer().children().not('.vr-show').addClass('vr-hide');
                container.children().not('canvas').not('.vr-show').addClass('vr-hide');
                enterFullscreen(container.get(0));
                clickCallBack = clickShow;
                $(canvas).bind('click', clickCallBack);
                touch.bind(canvas, 'tap', clickCallBack);

                function onFullScrenChange() {
                    var fe = document.fullscreenElement || document.mozFullScreenElement || document.webkitFullscreenElement;
                    if (!fe) {
                        pano.switchVRMode();
                        document.removeEventListener("fullscreenchange", onFullScrenChange);
                        document.removeEventListener("webkitfullscreenchange", onFullScrenChange);
                        document.removeEventListener("mozfullscreenchange", onFullScrenChange);
                        document.removeEventListener("MSFullscreenChange", onFullScrenChange);
                    }
                }
                document.addEventListener("fullscreenchange", onFullScrenChange);
                document.addEventListener("webkitfullscreenchange", onFullScrenChange);
                document.addEventListener("mozfullscreenchange", onFullScrenChange);
                document.addEventListener("MSFullscreenChange", onFullScrenChange);
                this.controls.connect();
                this.controls.resetAngle();
                this.controls.adjustMesh(false);
            }
            this.bIsChanged = true;
            this.updateScene();
        }
    }();

    function getSceneGroup(pano) {
        var scene_groups = pano.project.scene_groups;
        if (scene_groups && scene_groups.length > 0) {
            return scene_groups;
        } else {
            var sceneId = [];
            for (var i = 0; i < pano.project.scenes.length; i++)
                sceneId.push(pano.project.scenes[i].id);
            return [{
                title: '',
                scenes: sceneId
            }];
        }
    }

    function selectGroup(pano, nGroupIdx) {
        var groups = getSceneGroup(pano);
        if (nGroupIdx >= groups.length)
            return;
        var group = $(".group-bar", '#' + pano.containerId);
        var list = $(".ul-imgs:first", '#' + pano.containerId);
        if (group.length > 0) {
            list.empty();
            var tmpl = '<li data-idx="{id}" title="{name}"><div><img draggable="false" class="unselectable" crossorigin ="Anonymous" src="{url}"><span class="scene-name unselectable">{name}</span></div></li>';
            var li, len, idx;
            var scenes = pano.project.scenes;
            var sceneIdxs = groups[nGroupIdx].scenes;
            if(sceneIdxs){
            	for (var i = 0, len = sceneIdxs.length; i < len; i++) {
                    idx = sceneIdxById(sceneIdxs[i].id, scenes);
                    if (idx < 0)
                        continue;
                    li = $(tmpl.format({
                        name: scenes[idx].name,
                        url:scenes[idx].thumbnailUrl,
                        id: idx
                    }));
                    if (idx === pano.nSceneIdx){
                    	li.addClass("li-select");
                    	//scenes[idx]scene.sceneGroup.id
                    }
                    	
                        
                    li.appendTo(list);
                }
            	/*list.find("li").eq(0).find("img").click();*/
            	
            }
            if(haveweifenzu){
            	group.find("div").eq(0).css("opacity","0");
            }
            
        }
        $('.scene_group_desc', group).removeClass('select')
            .eq(nGroupIdx).addClass('select');
    }
    

    function initSwitchBar(pano, scenes, parentElem) {
        function hideSwitchBar(switchBar) {
            
            $(parentElem).stop(true, false)
                .animate({
                    /*bottom: -offset*/
                	height:0
                })
                .promise()
                .then($(switchBar).removeClass('unfold').addClass('collapsed'));
        }

        function showSwitchBar(switchBar) {
        	var offset = $(switchBar).height();
            $(parentElem).stop(true, false)
                .animate({
                    /*bottom: 0*/
                	height:offset
                })
                .promise()
                .then($(switchBar).removeClass('collapsed').addClass('unfold'));
        }
        var switchBar = $('.switch_bar', '#' + pano.containerId);
        if (switchBar.length !== 0)
            switchBar.remove();
        switchBar = $("<div class='switch_bar unfold'>    \
        <div class='cutover'><span></span></div>        \
        <div class='group-bar'></div>           \
        <div class='ul-box'>            \
        <ul class='ul-imgs'></ul></div></div>");

        var box = $(".ul-box:first", switchBar);
        var list = $(".ul-imgs:first", switchBar);
        var group_bar = $('.group-bar', switchBar);
        
        
//      新增点击相册名称切换场景功能
		
        switchBar.on("click",".scene_group_desc",function(){
        	var _index=$(this).index();
        	var scene_groups=pano.project.scene_groups;
        	var scenes=pano.project.scenes;
        	//判断是热点跳场景或其他
        	
        	if(!!pano.hotPointJumpScene){
        		pano.hotPointJumpScene = false;
         		return;
        	}
        	for(var j=0;j<scenes.length;j++){
    			if(scene_groups[_index].scenes[0].id==scenes[j].id){
    				//if(xinGroup!=_index){
    					pano.loadScene(j);
    				//}
    				list.find("li").eq(0).addClass("li-select").siblings().removeClass("li-select");
    				idxx1=j;
        		}
    		}
        	xinGroup=_index;
		});
        
        

        var groups = getSceneGroup(pano);
        
        var groupTmpl = '<div class="scene_group_desc"> <p class="ellipsis">{title}</p> </div>';
        var isDefault = true;
        for (var i = 0; i < groups.length; i++) {
            var groupItem;
            if (groups[i].title!="") {
            	/**
            	 * 控制相册标题
            	 * */
            	if(groups.length - 1 == 0 && groups[0].title === "未分组" ){
            		/*$(group_bar).hide();*/
            		$(group_bar).css({"height":".23rem","overflow":"hidden","opacity":"0","display":"block"});
            	}
                groupItem = groupTmpl.format(groups[i]);
                $(groupItem).appendTo(group_bar);
                isDefault = false;
            }
        }
        if (isDefault)
            group_bar.addClass("group-default-padding");

        function sceneSelect(e) {
            if (e.target.tagName != "IMG")
                return false;
            var li = $(e.target).closest('li');
            if (li.length !== 0) {
                var id = li.data("idx");
                idxx=id;
                idxx1=id;
                if(idxx1==pano.project.scenes.length){
                	idxx1=0;
                }
                if(idxx==pano.project.scenes.length){
                	idxx=0;
                }
                if (pano.nSceneIdx !== id) {
                	/*console.log(id);*/
                    pano.loadScene(id);
                    selectThumb(id);
                    if(pano.autoPlayState==true){
                    	//自动幻灯片
                        pano.autoAddNumber = id+1;
//                        pano.autoPlay(pano);
                    }
                }
                e.stopPropagation();
                countUserAction(pano.project.id, 'click');
                return true;
            }
            return false;
        }

        function groupSelect(e) {
            var groupItem = $(e.target).closest('.scene_group_desc');
            if (groupItem.length !== 0) {
                selectGroup(pano, groupItem.index());
                list.css({
                    left: 0
                });
                return true;
            }
            return false;
        }

        $(switchBar).bind('click', function (e) {
            if (groupSelect(e))
                return;
            if (sceneSelect(e)) {
                if (window.parent) {
                    window.parent.postMessage(window.location.href, '*');
                }
                return;
            }
        });
        $('.cutover', switchBar).bind('click', function (e) {
            if (switchBar.hasClass('collapsed')){
                showSwitchBar(switchBar.get(0));
                $('.linkerButtonBelows').stop(true, false).animate({'bottom':custom_bottom_bar+'px'})
                }
            else{
                hideSwitchBar(switchBar.get(0));
                $('.linkerButtonBelows').stop(true, false).animate({'bottom':'0px'})
            }
        });
        switchBar.appendTo($(parentElem));
        custom_bottom_bar = $('.custom-bottom-bar').height()
        if (!pano.customSwitchScene)
            switchBar.hide();

        var move = function (offset, elem) {
            var min = box.width() - elem.outerWidth();
            var max = 0;
            var pos = Math.min(max, Math.max(min, elem.position().left + offset));

            elem.css({
                left: pos
            });
        };

        function mousewheel(elem) {
            return function (event) {
                var detail = 0;
                if (event.wheelDeltaY) {
                    detail -= event.wheelDeltaY / 120;
                    // Opera / Explorer 9
                } else if (event.wheelDelta) {
                    detail -= event.wheelDelta / 120;
                    // Firefox
                } else if (event.detail) {
                    detail += event.detail / 6;
                }
                move(-detail * 100, elem);
                event.stopPropagation();
            };
        }

        var offsetX = 0;

        function dragstart() {
            offsetX = 0;
        }

        function drag(elem) {
            return function (event) {
                event.distanceX -= offsetX;
                move(event.distanceX, elem);
                offsetX += event.distanceX;
            };
        }

        list.get(0).addEventListener('mousewheel', mousewheel(list), false);
        touch.on(list.get(0), 'dragstart', dragstart);
        touch.on(list.get(0), 'drag', drag(list));

        group_bar.get(0).addEventListener('mousewheel', mousewheel(group_bar), false);
        touch.on(group_bar.get(0), 'dragstart', dragstart);
        touch.on(group_bar.get(0), 'drag', drag(group_bar));
        var curScene=pano.project.scenes[pano.nSceneIdx];
        var groupIndex=pano.project.groupsIndexMap[curScene.sceneGroup.id];
        selectGroup(pano, groupIndex);
    }

    function initLogo(pano) {
        var logo = pano.project.logo;
        var tit = pano.getCurrScene().name;
        var tmpl = $('<div><span class="span-name">' + tit + '</span></div>');
        if (logo.res_id) {
            $('.logo-img-cls-wrap').remove();
            var img = new Image();
            img.crossOrigin = "Anonymous";
            var urls = pano.resources[logo.res_id][0].access_url;
            $(img).attr({
                src: urls,
                class: "logo-img-cls"
            });
            var container = $("<a class='logo-img-cls-wrap'></a>");
            if (pano.project.logo_link) {
                container.attr({
                    'href': pano.project.logo_link,
                    "target": "_blank"
                });
                $(img).css({
                    "pointer-events": "auto"
                });
            }
            tmpl.prepend(container.append(img))
        }

        $('#' + pano.containerId + ' .corner-deck').prepend(tmpl);
    }

    Panorama.prototype.reloadProject = function (projectId) {
        var project, resources;
        $.ajax({
            type: "post",
            data: JSON.stringify({
                ids: [projectId],
                decode_res: true
            }),
            url: HOST_URL + "/api/getProject",
            success: function (res) {
                if (res.err_code === 0) {
                    project = res.data.projects[0];
                    resources = res.data.resources[0];

                }

            },
            async: false
        });

        this.reset(project, resources);
        this.run();
    };
    
    //转换数据
    Panorama.prototype.convertData=function(data){
    	var album=data.album;
    	this.cosAccessHost=data.cosAccessHost;
    	var project={};
    	project.id=album.id;
    	project.title=album.name;
    	project.enable_autorotation=true;
    	project.enable_like=false;
    	project.enable_orientation=true;
    	project.enable_overlook=false;
    	project.enable_vr=true;
    	project.background_music = {
	        "title": '',
	        "res_id": ''
        };
    	/*project.sand_table = {
            "points":[],
            "res_id": ''
        };*/
    	var scenes=[];
    	var scenesIndexMap={};
    	var groupsIndexMap={};
    	var sceneNum=0;//场景数量
    	var _arr=[];
        var resources={};
    	for (var i=0; i< album.sceneGroupList.length; i++){
            var group = album.sceneGroupList[i];
            groupsIndexMap[group.id]=i;
            if(group.sceneList){
            	for (var j=0; j< group.sceneList.length; j++){
            		var scene=group.sceneList[j];
            		scene.imgUrl=this.cosAccessHost+scene.imgUrl;
            		scene.thumbnailUrl=this.cosAccessHost+scene.thumbnailUrl;
            		/*if(scene.jump_tags==null){
            			scene.jump_tags=[];
            		}
            		if(scene.hyperlink_tags==null){
            			scene.hyperlink_tags=[];
            		}
            		if(scene.introduce_tags==null){
            			scene.introduce_tags=[];
            		}
            		if(scene.voice_tags==null){
            			scene.voice_tags=[];
            		}
            		if(scene.picture_tags==null){
            			scene.picture_tags=[];
            		}*/
            		scenes.push(scene);
            		scenesIndexMap[scene.id]=sceneNum;
            		sceneNum++;
            		
                    var resource = {
                        'id': scene.id,
                        'access_url': scene.imgUrl,
                        'oorigin_id': scene.id,
                        'likeNum': scene.likeNum,
                        'sceneName': scene.name
                    };
                    resource.file_type="image/"+resource.access_url.substring(resource.access_url.lastIndexOf(".")+1);
                    resources[resource.oorigin_id]=[resource];
                }
            }
            _arr[i] = {
   	              'title': group.name,
   	              'scenes': group.sceneList
   	        };
        }
        this.resources=resources;
    	project.scenes=scenes;
    	project.scenesIndexMap=scenesIndexMap;
    	project.groupsIndexMap=groupsIndexMap;
    	project.scene_groups=_arr;
    	this.project=project;
    };

    Panorama.prototype.reset = function (data) {
    	if(data.album){
    		this.convertData(data);
    	}else{
    		this.project=data.project;
        	this.cosAccessHost=data.cosAccessHost;
        	this.resources=data.project.resources;
    	}
    	
        this.clearCurrScene();
        ResourceMgr.update(this.resources);
        if (this.renderer === null) {
            var container = document.getElementById(this.containerId);
            container.style.overflow = "hidden";
            container.style.position = "relative";

            var shootAnchor = "<div class='anchor vr-show'><div><div class='circle'></div><p class='glyphicon glyphicon-screenshot anchorshot' ></p></div></div>";

            var left = $(".left", $(container));
            if (left.length === 0) {
                left = $("<div class='leftContainer vr-show'><div>");
                left.appendTo($(container));
                $(shootAnchor).appendTo(left);
            }

            var right = $(".right", $(container));
            if (right.length === 0) {
                right = $("<div class='rightContainer vr-show'><div>");
                right.appendTo($(container));
                $(shootAnchor).appendTo(right);
            }

            this.renderer = new THREE.WebGLRenderer({
                preserveDrawingBuffer: true,
                antialias: true
            });
            this.renderer.setPixelRatio(window.devicePixelRatio);
            this.renderer.setSize($(container).width(), $(container).height());

            this.renderer.domElement.id = this.containerId + "_canvas";
            container.appendChild(this.renderer.domElement);
            registPanoEvent(this);
        }

        var parentElem = $('#' + this.containerId);
        $('.custom-btn-preview-mdl', parentElem).remove();
        $('.custom-link-btns', parentElem).remove();
        $('.custom-btns', parentElem).remove();
        $('.custom-btn-preview-mdl', parentElem).remove();
        $('.corner-deck', parentElem).remove();
    };
    //更新沙盘信息
    Panorama.prototype.updateSandtable = function () {
        if (this.spv) {
            var distance = this.lon - this.init_lon;
            var angle = this.spv.init_degree - distance;
            angle = angle % 360;
            angle = (angle < 0) ? angle + 360 : angle;
            this.spv.css('transform', 'rotate(' + angle + 'deg)');
        }
    };

    Panorama.prototype.registScenechange = function (func) {
        this.sceneChangeFunc.push(func);
    };

    Panorama.prototype.unregistScenechange = function (func) {
        for (var i = 0; i < this.sceneChangeFunc.length; i++) {
            if (this.sceneChangeFunc[i] == func) {
                this.splice(i, 1);
                return;
            }
        }
    };

    var monitorFocus = function () {
        function distance(pt1, pt2) {
            return Math.sqrt((pt1.x - pt2.x) * (pt1.x - pt2.x) +
                (pt1.y - pt2.y) * (pt1.y - pt2.y) +
                (pt1.z - pt2.z) * (pt1.z - pt2.z));
        }

        function vrFocus(pano, sceneItem) {
            var anchors = $(".anchor", "#" + pano.containerId);
            if (!sceneItem) {
                anchors.each(function (index, anchor) {
                    $(anchor).removeClass("focus");
                    $(".circle", anchor).circleProgress('clear');
                    $(anchor).data('target', null);
                });
            } else {
                anchors.each(function (index, anchor) {
                    $(anchor).addClass("focus");
                    var instance = $(".circle", anchor).data('circle-progress');
                    $(anchor).data('target', sceneItem.elem);
                    if (!instance) {
                        var process = 0;
                        $(".circle", anchor).circleProgress({
                            value: 1,
                            size: 36,
                            animation: {
                                duration: 5000
                            },
                            fill: {
                                color: 'rgba(255, 255, 255, 1)'
                            },
                            emptyFill: 'rgba(0, 0, 0, .0)'
                        }).on('circle-animation-progress', function (event, val) {
                            process = val;
                        }).on('circle-animation-end', function (event) {
                            if (index === 0 && Math.abs(process - 1) < 0.001) {
                                var elem = $(anchor).data('target');
                                $(elem).trigger('click');
                            }
                        });
                    } else {
                        instance.draw();
                    }
                });
            }
        }

        function toSurfacePos(dir, r) {
            var rOld = Math.sqrt(dir.x * dir.x + dir.y * dir.y + dir.z * dir.z);
            var scale = r / rOld;
            return {
                x: dir.x * scale,
                y: dir.y * scale,
                z: dir.z * scale
            };
        }

        var nearElem = null;
        return function (pano, items) {
            if (!items)
                return;
            var target = toSurfacePos(pano.camera.target, 500);
            var elem;
            var nearDist = Infinity;
            for (var i = 0; i < items.length; i++) {
                var item = items[i];
                if ($(item.elem).is(":hidden")) {
                    continue;
                }
                var pos = item.position();
                var dist = distance(pos, target);
                if (dist < 50) {
                    if (dist < nearDist) {
                        elem = item;
                    }
                }
            }
            if (elem != nearElem) {
                nearElem = elem;
                vrFocus(pano, nearElem);
            }
        };
    }();

    Panorama.prototype.updateScene = function () {
        var forceChange = this.bIsChanged;
        if (this.vrMode === true && this.vrRenderer) {
            this.vrRenderer.render(this.scene, this.camera);
        } else {
            this.renderer.render(this.scene, this.camera);
        }
        if (this.bIsChanged) {
            this.bIsChanged = false;
            var t = this.camera.getWorldDirection();
            this.camera.target = t;
            var lonlat = xyz2latlon(t.x, t.y, t.z, 500);
            this.lat = lonlat.lat;
            this.lon = lonlat.lon;
            this.lon %= 360;
            this.updateSandtable();
        }
        // todo: call adjustScenePointsPos if camera target distance > 1
        // how about fov changed ?
        adjustScenePointsPos(this, this.externalItem[this.nSceneIdx], forceChange);
        adjustScenePointsPos(this, this.globalSceneItem, forceChange);
        adjustScenePointsPos(this, this.scenePoints, forceChange);

        if (this.vrMode) {
            monitorFocus(this, this.scenePoints);
        }
    };

    Panorama.prototype.getCurSceneInfo = function () {
        return {
            projectId: this.project.id,
            sceneId: this.nSceneIdx
        };
    };

    Panorama.prototype.getSceneIndex = function (sceneId) {
        var scenes = this.project.scenes;
        for (var i = 0; i < scenes.length; i++) {
            if (scenes[i].id === sceneId)
                return i;
        }
        return null;
    };

    Panorama.prototype.registerSceneItem = function (elem, nId, pos, mode) {
        var itemList = [];
        if (nId !== undefined && nId !== null) {
            var nIdx = this.getSceneIndex(nId);
            if (nIdx === null) {
                console.log("registerSceneItem:invalid sceneId");
                return;
            }
            if (nIdx !== this.nSceneIdx)
                $(elem).hide();
            if (this.externalItem[nIdx] === undefined)
                this.externalItem[nIdx] = [];
            itemList = this.externalItem[nIdx];
        } else {
            nId = null;
            itemList = this.globalSceneItem;
        }

        if (elem.parentNode == null || elem.parentNode.id !== this.containerId)
            $(elem).appendTo($("#" + this.containerId));
        if (pos === undefined || pos === null) {
            var offset = $(elem).offset();
            var t = this.vec2ToVec3({
                x: offset.left + $(elem).width() / 2,
                y: offset.top + $(elem).height() / 2
            });
            pos = {
                x: t.x,
                y: t.y,
                z: t.z
            };
        }
        var item = new SceneItem(this, nId, elem, pos, mode);
        itemList.push(item);
        return item;
    };

    Panorama.prototype.batchRegisterItems = function (items) {
        var arr = [];
        for (var i = 0, len = items.length; i < len; ++i) {
            var item = this.registerSceneItem(items[i].elem, items[i].nId, items[i].pos, items[i].mode);
            arr.push(item);
        }
        return arr;
    };

    Panorama.prototype.unregisterSceneItem = function (elem) {
        var items = [];
        if (elem.nSceneId !== null && elem.nSceneId !== undefined) {
            var nIdx = this.getSceneIndex(elem.nSceneId);
            if (nIdx === null) {
                console.log("registerSceneItem:invalid sceneId");
            }
            if (this.externalItem[nIdx] === undefined)
                return;
            items = this.externalItem[nIdx];
        } else {
            items = this.globalSceneItem;
        }

        for (var i = 0; i < items.length; i++) {
            if (items[i] == elem) {
                items.splice(i, 1);
                return;
            }
        }
    };

    Panorama.prototype.addPointItem = function (elem, pos, mode, isInVr) {
        if (elem.parentNode == null || elem.parentNode.id !== this.containerId)
            $(elem).appendTo($("#" + this.containerId));
        if (!pos) {
            var offset = $(elem).offset();
            
            var t = this.vec2ToVec3({
                x: offset.left,
                y: offset.top
            });
            pos = {
                x: t.x,
                y: t.y,
                z: t.z
            };
            
        }
        
        var item = new SceneItem(this, this.getCurrScene().id, elem, pos, mode);
        if (isInVr)
            $(elem).addClass('vr-show');
        else if (this.vrMode)
            $(elem).addClass('vr-hide');
        this.scenePoints.push(item);
        return item;
    };

    Panorama.prototype.removePointItem = function (item) {
        for (var i = 0; i < this.scenePoints.length; i++) {
            if (this.scenePoints[i] == item) {
                this.scenePoints.splice(i, 1);
                break;
            }
        }
    };

    Panorama.prototype.getCurrScene = function () {
        return this.project.scenes[this.nSceneIdx];
    };

    function hideSceneItem(pano, nSceneIdx) {
        var items = pano.externalItem[nSceneIdx];
        for (var i in items) {
            $(items[i].elem).hide();
            if (items[i].fakeItem)
                $(items[i].fakeItem.elem).hide();
        }
    }

    function clearScenePoints(pts) {
        for (var i = 0; i < pts.length; i++) {
            $(pts[i].elem).remove();
            if (pts[i].fakeItem)
                $(pts[i].fakeItem.elem).remove();
        }
    }

    Panorama.prototype.clearCurrScene = function () {
        var self = this;

        function disposeEnv(geometry, texture, material, mesh) {
            if (geometry)
                geometry.dispose();
            if (texture)
                texture.dispose();
            if (material)
                material.dispose();
            if (mesh)
                self.scene.remove(mesh);
        }

        clearScenePoints(this.scenePoints);

        disposeEnv(this.geometry, this.texture, this.material, this.mesh);
        disposeEnv(this.bottom_geometry, this.bottom_texture, this.bottom_material, this.bottom_mesh);
        disposeEnv(this.top_geometry, this.top_texture, this.top_material, this.top_mesh);
        disposeEnv(this.bottom_logo_geometry, this.bottom_logo_texture, this.bottom_logo_material, this.bottom_logo_mesh);

        this.texture = null;
        this.geometry = null;
        this.material = null;
        this.mesh = null;
        this.scene = null;

        this.bottom_geometry = null;
        this.bottom_texture = null;
        this.bottom_material = null;
        this.bottom_mesh = null;

        this.top_geometry = null;
        this.top_texture = null;
        this.top_material = null;
        this.top_mesh = null;

        this.bottom_logo_geometry = null;
        this.bottom_logo_texture = null;
        this.bottom_logo_material = null;
        this.bottom_logo_mesh = null;

        if (this.renderer)
            this.renderer.clear();

        this.scenePoints = [];
        this.camera = null;

        if (this.requestId !== null)
            cancelAnimationFrame(this.requestId);
        this.requestId = null;
        this.currScenePointMap = {};
    };

    function itemIsNeedShow(camPos, tarPos, itemPos, vec2, w, h) {
        var v1 = {
            x: tarPos.x - camPos.x,
            y: tarPos.y - camPos.y,
            z: tarPos.z - camPos.z
        };
        var v2 = {
            x: itemPos.x - camPos.x,
            y: itemPos.y - camPos.y,
            z: itemPos.z - camPos.z
        };
        if (v1.x * v2.x + v1.y * v2.y + v1.z * v2.z < 0) {
            return false;
        }
        return true;
    }

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

            var vec3 = new THREE.Vector3(pos.x, pos.y, pos.z);
            var vec2 = pano.vec3toVec2(camera, vec3);
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
            if (itemIsNeedShow(camera.position, camPos, pos, vec2, width, height) === false) {
                elem.hide();
                return false;
            } else {
                elem.show();
            }
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

    function createBottomLogo(pano) {
        var scene = pano.project.scenes[pano.nSceneIdx];
        if(!scene.bottomLogo){
        	return;
        }
        var fs=pano.cosAccessHost+ scene.bottomLogo;
//        if (scene.bottom_logo && scene.bottom_logo.res_id != "")
//            fs = ResourceMgr.find(scene.bottom_logo.res_id);
//        else if (pano.project.bottom_logo)
//            fs = ResourceMgr.find(pano.project.bottom_logo.res_id);
//        if (!fs || fs.length === 0)
//            return;

        var loader = new THREE.ImageLoader();
        loader.setCrossOrigin("Anonymous");
        pano.bottom_logo_texture = new THREE.Texture();
        pano.bottom_logo_material = new THREE.MeshBasicMaterial({
            map: pano.bottom_logo_texture //map: new THREE.TextureLoader().load(texturePath)
        });
        pano.bottom_logo_material.transparent = true;
        loader.load(fs, function (image) {
            pano.bottom_logo_texture.image = image;
            pano.bottom_logo_texture.image.crossOrigin="Anonymous";
            pano.bottom_logo_texture.needsUpdate = true;

            var max = Math.max(image.width, image.height);
            pano.bottom_logo_geometry = new THREE.PlaneGeometry(250 * image.width / max, 250 * image.height / max, 25, 25);
            pano.bottom_logo_geometry.scale(-1, 1, 1);

            pano.bottom_logo_mesh = new THREE.Mesh(pano.bottom_logo_geometry, pano.bottom_logo_material);
            var br = Math.sqrt(image.width * image.width + image.height * image.height) / 2;
            br = Math.min(br, 495);
            pano.bottom_logo_mesh.position.y = Math.max(-Math.sqrt(500 * 500 - br * br), -410);
            pano.bottom_logo_mesh.rotation.x = Math.PI / 2;

            pano.scene.add(pano.bottom_logo_mesh);
        });
    }
    
    function getFileSuffix(filePath){
    	return filePath.substring(filePath.lastIndexOf("."));
    }

    function fixPoleShapeChange(pano, res_id, url, v) {
    	
       // var bottomImg = ResourceMgr.getPoleLogo(res_id, url, 'bottom');
       
        var scene=pano.project.scenes[pano.project.scenesIndexMap[res_id]];
        var suffix=getFileSuffix(scene.imgUrl);
        var bottomImg=scene.imgUrl+".bottom"+suffix;
        if (bottomImg) {
            var loader = new THREE.ImageLoader();
            loader.setCrossOrigin("Anonymous");
            pano.bottom_texture = new THREE.Texture();
            pano.bottom_material = new THREE.MeshBasicMaterial({
                map: pano.bottom_texture //map: new THREE.TextureLoader().load(texturePath)
            });
            pano.bottom_material.transparent = true;

            loader.load(bottomImg, function (image) {
//                if (v != sceneVersion || pano.getCurrScene().res_id != res_id) {
//                    return;
//                }
                pano.bottom_texture.image = image;
                pano.bottom_texture.image.crossOrigin="Anonymous";
                pano.bottom_texture.needsUpdate = true;

                var max = Math.max(image.width, image.height);
                pano.bottom_geometry = new THREE.PlaneGeometry(420, 420, 25, 25);
                pano.bottom_geometry.scale(-1, 1, 1);

                pano.scene.remove(pano.bottom_mesh);
                pano.bottom_mesh = new THREE.Mesh(pano.bottom_geometry, pano.bottom_material);
                pano.bottom_mesh.position.y = -420; //Math.sqrt(500 * 500 - br * br);

                pano.bottom_mesh.rotation.x = Math.PI / 2;
                pano.bottom_mesh.rotation.z = Math.PI / 2;

                pano.scene.add(pano.bottom_mesh);
            });
        }

        //var topImg = ResourceMgr.getPoleLogo(res_id, url, 'top');
        var topImg=scene.imgUrl+".top"+suffix;
        if (topImg) {
            var loader = new THREE.ImageLoader();
            loader.setCrossOrigin("Anonymous");
            pano.top_texture = new THREE.Texture();
            pano.top_material = new THREE.MeshBasicMaterial({
                map: pano.top_texture //map: new THREE.TextureLoader().load(texturePath)
            });
            pano.top_material.transparent = true;

            loader.load(topImg, function (image) {
//                if (v != sceneVersion || pano.getCurrScene().res_id != res_id) {
//                    return;
//                }
                pano.top_texture.image = image;
                pano.top_texture.image.crossOrigin="Anonymous";

                pano.top_texture.needsUpdate = true;

                var max = Math.max(image.width, image.height);
                pano.top_geometry = new THREE.PlaneGeometry(420, 420, 25, 25);
                pano.top_geometry.scale(-1, 1, 1);

                pano.scene.remove(pano.top_mesh);
                pano.top_mesh = new THREE.Mesh(pano.top_geometry, pano.top_material);
                pano.top_mesh.position.y = 420; //Math.sqrt(500 * 500 - br * br);

                pano.top_mesh.rotation.x = -Math.PI / 2;
                pano.top_mesh.rotation.z = -Math.PI / 2;

                pano.scene.add(pano.top_mesh);
            });
        }
    }

    function loadSceneEnv(pano, res_id) {
        pano.clearCurrScene();
        var size = pano.renderer.getSize();

        pano.camera = new THREE.PerspectiveCamera(75, size.width / size.height, 1, 1100);
        pano.camera.focalLength = 2;
        var vis_angle = pano.getCurrScene().visual_angle;
        initVisualAngle(vis_angle);
        var p = vis_angle.init_point;
        var tX = p.x,
            tY = p.y,
            tZ = p.z;

        var t = xyz2latlon(tX, tY, tZ, 500);
        pano.lat = t.lat;
        pano.lon = t.lon;

        pano.camera.target = new THREE.Vector3(tX, tY, tZ);
        pano.camera.lookAt(pano.camera.target);
        pano.bIsChanged = true;

        if (vis_angle.init_fov !== 0) {
            pano.camera.fov = vis_angle.init_fov;
        }
        pano.mesh = createSceneImg(pano.containerId, res_id, pano);

        pano.scene = new THREE.Scene();

        pano.scene.add(pano.mesh);
        var oc = pano.controls;
        pano.controls = new THREE.DeviceOrientationControls(pano, pano.camera, pano.mesh);
        if (oc) {
            pano.controls.adjustMesh(oc.rotateMesh);
            if (!oc.freeze) {
                pano.controls.connect();
            }
            if (oc.freeze_tmp) {
                pano.controls.pause();
            }
        }
        createBottomLogo(pano);
    }
    
    
    
    function loadScenePointMap(pano, scene) {
        function addPointToObject(obj, v, type) {
            for (var i = 0; i < v.length; i++) {
                var key = SLCUtility.getHtmlId();
                obj[key] = {
                    type: type,
                    tag: v[i]
                };
            }
        }
        var obj = {};
        addPointToObject(obj, scene.jump_tags, "jump");
        addPointToObject(obj, scene.hyperlink_tags, "hyperlink");
        addPointToObject(obj, scene.introduce_tags, "introduce");
        addPointToObject(obj, scene.picture_tags, "picture");
        addPointToObject(obj, scene.voice_tags, "voice");
        addPointToObject(obj, scene.mark_tags, "mark");
        pano.currScenePointMap = obj;
    }

    function overLook(pano, cb) {
    	var _mask = $('<div></div>');
    	$('#container').after(_mask);
    	_mask.css({
    		"position": "absolute",
    		"top":0,
    		"right":0,
    		"bottom":0,
    		"left":0,
    		"z-index":99999,
    		"width":"100vw",
    		"height":"100vh"
    	});
        if (!pano) {
            return;
        }
        var camera = pano.camera;
        var target_lon = pano.lon;
        var target_lat = pano.lat;
        var target_fov = pano.getCurrScene().visual_angle.init_fov;
        var from_fov = pano.getCurrScene().visual_angle.max_fov + 20;
        var from_camera_y = 500;
        
        function overlookFrame(camera_y, cb) {
            if (camera_y < 0) {
                camera_y = 0;
            }
            var init_visual = camera_y === from_camera_y;
            if (!init_visual) {
                pano.overLooking = true;
            }

            pano.bIsChanged = true;
            var percent = init_visual ? 1 : camera_y / 500.0;

            var tpx = new THREE.Quaternion();
            tpx.setFromAxisAngle(new THREE.Vector3(1, 0, 0), THREE.Math.degToRad(-90 + (target_lat + 90) * (1 - percent)));
            var tpy = new THREE.Quaternion();
            tpy.setFromAxisAngle(new THREE.Vector3(0, 1, 0), THREE.Math.degToRad(target_lon + 180 * percent+180));
            pano.camera.quaternion.copy(tpy.multiply(tpx));
            camera.position.set(0, camera_y, 0);
            camera.fov = target_fov + (from_fov - target_fov) * percent;
            camera.updateProjectionMatrix();
            if (camera_y > 0) {
                var duration = init_visual ? 3000 : 40;
                window.setTimeout(overlookFrame, duration, camera_y - 8, cb)
            } else {
                pano.overLooking = false;
                cb();
                _mask.hide();
                var sceneName = $('.sceneName');
            	if(sceneName.length > 0){
            		sceneName.show();
            	}
                if (updateImgFunc) {
                    updateImgFunc();
                }
            }
        }
        overlookFrame(from_camera_y, cb);
    }

    function animate(pano) {
        var requestAnimationFrame = window.requestAnimationFrame || window.mozRequestAnimationFrame ||
            window.webkitRequestAnimationFrame || window.msRequestAnimationFrame;
        var cancelAnimationFrame = window.cancelAnimationFrame || window.mozCancelAnimationFrame;
        if (pano.requestId !== null)
            cancelAnimationFrame(pano.requestId);

        if (!pano.renderer || !pano.scene || !pano.camera) {
            pano.isAnimationRunning = false;
            return;
        }

        pano.isAnimationRunning = true;
        
        var tqs=pano.camera.quaternion.clone();
        var eulers=new THREE.Euler();
        eulers.setFromQuaternion(tqs, 'YXZ');
        var starts=eulers.y;

        function reload() {
            if (pano.project.enable_autorotation === true &&
                pano.isUserInteracting !== true &&
                (pano.overLooking !== true) &&
                pano.ready &&
                pano.isScenesEdit !== true &&
                pano.vrMode !== true) {

                var tq = pano.camera.quaternion.clone();
                var euler = new THREE.Euler();
                euler.setFromQuaternion(tq, 'YXZ');
                euler.y = euler.y + THREE.Math.degToRad(-0.05);
                if(starts-euler.y>2*Math.PI){
                	var curSceneId=pano.project.scenes[idxx1].id;
                	var groupIndex=pano.project.groupsIndexMap[pano.project.scenes[idxx1].sceneGroup.id];
                	var curGroupSceneLen = pano.project.scene_groups[groupIndex].scenes.length;
                	var curGroupSceneLastSceneId = pano.project.scene_groups[groupIndex].scenes[curGroupSceneLen-1].id;
                	idxx1++;
                	if(idxx1==pano.project.scenes.length){
                		idxx1=0;
                		var curScene=pano.project.scenes[idxx1];
                        var groupIndex=pano.project.groupsIndexMap[curScene.sceneGroup.id];
                        $('.scene_group_desc').eq(groupIndex).trigger('click');
                	}
                	
                	/*console.log(curGroupSceneLastSceneId,curSceneId);
                	console.log(groupIndex,curGroupSceneLen);*/
                	if(idxx1!=0 && curSceneId == curGroupSceneLastSceneId){
                		$('.scene_group_desc').eq(groupIndex+1).trigger('click');
                	}
                	/*console.log(idxx1);*/
                	pano.loadScene(idxx1);
                	sceneIdToGroupidx(pano,idxx1);
                }
                pano.camera.quaternion.setFromEuler(euler);
                pano.bIsChanged = true;
            }
            pano.controls.update();
            pano.updateScene();
            pano.requestId = requestAnimationFrame(reload);
        }
        reload();
    }

    function selectThumb(pano, nsceneIdx) {
        var list = $(".ul-imgs:first", "#" + pano.containerId);
        if (list.length > 0) {
            var lis = $("li", list);
            $(".li-select", list).removeClass("li-select");
            for (var i = 0; i < lis.length; i++) {
                if (lis.eq(i).data("idx") == nsceneIdx)
                    lis.eq(i).addClass("li-select");
                
            }
        }
    };
    Panorama.prototype.setSceneMap = function(project) {
    	var map={};
        for (var i=0; i< project.sceneGroupList.length; i++){
            var cc = project.sceneGroupList[i];
            if(cc.sceneList){
            	for (var j=0; j< cc.sceneList.length; j++){
            		cc.sceneList[j].visual_angle = {
        				"init_fov": 90,
                        "init_point": {
                            "x": 0,
                            "y": 0,
                            "z": 500
                        },
                        "max_angle":89.9,
                        "max_fov":90,
                        "min_angle":-89.9,
                        "min_fov":40
            		};
                    map[cc.sceneList[j].id]=cc.sceneList[j];
                }
            }
        }
        return map;
    };
    Panorama.prototype.toSceneIdx = function (sceneIdx) {
        var sceneGroup = getSceneGroup(this);
        var tmp = sceneIdx;
        for (var i = 0; i < sceneGroup.length; i++) {
            if (tmp < sceneGroup[i].sceneList.length)
                break;
            tmp -= sceneGroup[i].sceneList.length;
        }

        var sceneId;
        if (i == sceneGroup.length) {
            for (var i = 0; i < sceneGroup.length; i++)
                if (sceneGroup[i].sceneList.length > 0) {
                    sceneId = sceneGroup[i].sceneList[0];
                }
        } else {
            sceneId = sceneGroup[i].sceneList[tmp];
        }
        for(var j = i; j< sceneGroup.length; j++){
            for (var i = 0; i < sceneGroup[j].sceneList.length; i++) {
                if (sceneGroup[j].sceneList[i].id == sceneId)
                    return i;
            }
        }
        var scenes = this.project.scenes;
        for (var i = 0; i < scenes.length; i++) {
            if (scenes[i].id == sceneId)
                return i;
        }
        return 0;
    }

    Panorama.prototype.run = function (sceneIdx) {
    	var that=this;
        if (this.requestId !== null)
            return;
        var nIdx = 0;
        
        if (typeof sceneIdx === "number" && sceneIdx >= 0 && sceneIdx < this.project.scenes.length) {
            nIdx = sceneIdx;
        }
        this.loadScene(nIdx);
        var pano = this;

        var init = function () {
            initCornerDeck(pano, pano.containerId);
            //initLogo(pano);
            initCustombar(pano);
            initGuide(pano);
            if(autorotationTypes!=1&&isCarousel==1){
            	clearTimeout(oTime);
                countdown(pano,10);
            }
            if(that.project.enable_overlook&&pano.isScenesEdit !== true){
            	$(".banner_bottom").css("display","-webkit-flex");
            	if(linkerData.linkerShare.headImageUrl&&linkerData.linkerShare.fixedName&&linkerData.linkerShare.telephone){
                	
                	$("#headimg_wraper").show();
                }
            }
            pano.ready = true;
            $(function () {
                $("audio").on("play", function () {
                    $("audio").not(this).each(function (index, audio) {
                        audio.pause();
                    });
                });
            });
        };
        if (this.project.enable_overlook) {
            overLook(this, init);
        } else {
            init();
        }
    };

    Panorama.prototype.stop = function () {
        if (this.requestId !== null)
            return;
        cancelAnimationFrame(this.requestId);
    };

    Panorama.prototype.getSceneIdlist = function () {
        if (!this.project || !this.project.scenes)
            return [];
        var arr = [];
        var scenes = this.project.scenes;
        for (var i = 0; i < scenes.length; i++)
            arr.push(scenes[i].id);
        return arr;
    };

    Panorama.prototype.setActiveScene = function (nId) {
        if (nId === null)
            console.log("setActiveScene error param");
        var idx = this.getSceneIndex(nId);
        if (this.nSceneIdx && idx == this.nSceneIdx)
            return;
        this.loadScene(idx);
    };

    Panorama.prototype.getActiveSceneId = function () {
        try {
            return this.project.scenes[this.nSceneIdx].id;
        } catch (e) {
            return null;
        }
    };

    function dirtySceneItem(items) {
        if (!items)
            return;
        for (var i = 0; i < items.length; i++) {
            items[i].dirty = true;
        }
    }
    Panorama.prototype.loadScene = function (nId) {
        hideSceneItem(this, this.nSceneIdx);
        this.nSceneIdx = nId;
        var scene = this.project.scenes[nId];
        loadSceneEnv(this, scene.id);
        loadScenePointMap(this, scene);
        dirtySceneItem(this.externalItem[nId]);
        dirtySceneItem(this.globalSceneItem);
        selectThumb(this, nId);
        this.camera.updateProjectionMatrix();
        animate(this);
        this.updateSandPointView();
        this.updateTitle();
        var va = this.getCurrScene().visual_angle;
        initVisualAngle(va);
        var p = va.init_point;
        var t = xyz2latlon(p.x, p.y, p.z, 500);
        var t = xyz2latlon(0, 0, 500, 500);
        
        this.init_lat = t.lat;
        this.init_lon = t.lon;
        $(".songs").css("display","none");
        $(".shapan").hide();
        if(this.isScenesEdit!==true){
        	audio_scene.pause();
//          判断当前场景组是否有沙盘
            if(linkerData.project.sandTableMap){
            	for(var i in linkerData.project.sandTableMap){
            		if(i==scene.sceneGroup.id){
            			$(".shapan").show();
            		}
            	}
            }
            
            
//            判断当前加载的场景是否有语音，有就显示底部的语音按钮，没有不显示
            if(linkerData.linkerYyInfos.length>=1){
            	var hasGroup0=false,pos;
            	linkerData.linkerYyInfos.forEach(function(value,index){
            		if(value.yySyGroupId=='0'){
            			hasGroup0=true;
            			pos=index;
            			return;
            		}
            	})
            	if(hasGroup0){
        			$(".songs").css("display","inline-block");
        			/* 下方语音按钮点击 */
        			audio_scene.src=cdn_url+linkerData.linkerYyInfos[pos].yyUrl;
        			audio_scene.pause();
        		}else{
        			for(var i=0;i<linkerData.linkerYyInfos.length;i++){
                    	if(linkerData.linkerYyInfos[i].yySyGroupId==scene.sceneGroup.id){
                    		if(linkerData.linkerYyInfos[i].yySyScene=='0'){
                    			$(".songs").css("display","inline-block");
                        		audio_scene.src=cdn_url+linkerData.linkerYyInfos[i].yyUrl;
                    			audio_scene.pause();
                    		}else{
                    			if(linkerData.linkerYyInfos[i].yySyScene==scene.id){
                    				$(".songs").css("display","inline-block");
                            		audio_scene.src=cdn_url+linkerData.linkerYyInfos[i].yyUrl;
                        			audio_scene.pause();
                    			}
                    		}
                    	}
                    }
        		}
            }
        }
        

        

        //notify scene change
        for (var i = 0; i < this.sceneChangeFunc.length; i++) {
            this.sceneChangeFunc[i](scene.id);
        }
        
        
        
        /*if(this.project.sandTableMap!=undefined){
        	var loadGetSceneGrounpId = scene.sceneGroup.id;
            var loadStb = this.project.sandTableMap[loadGetSceneGrounpId];
            if(loadStb){
            	$(".sand-table").show();
            }else {
            	$(".sand-table").hide();
            }
        }*/
        
    };
    //沙盘点位视图
    Panorama.prototype.updateSandPointView = function () {
    	
        this.spv = sandPointView(this.getCurrScene().id);
        $('.sandTableView .sand-table-arrow').removeClass("current");
        if (this.spv) {
        	var getSceneGrounpId = this.getCurrScene().sceneGroup.id;
            var stb = this.project.sandTableMap[getSceneGrounpId];
            var points = stb.points;
            for (var i = 0; i < points.length; i++) {
                if (points[i].sceneId == this.getCurrScene().id) {
                    this.spv.init_degree = points[i].angle;
                }
            }
            this.spv.addClass("current");
            this.spv.css('transform', 'rotate(' + this.spv.init_degree + 'deg)');
        }
    };

    Panorama.prototype.updateTitle = function () {
        var tit = this.getCurrScene().name;
        $('.corner-deck .span-name').text(tit);
    }

    function initGuide(pano) {
        var temp = $('<div class="guide-wrap"><img class="guide"></img></div>').appendTo('#' + pano.containerId);
        setTimeout(function () {
            temp.fadeOut();
        }, 5000);
    }

    function initCustombar(pano) {
        var bar = $('<div class="custom-bottom-bar"></div>').appendTo('#' + pano.containerId);
        var ua = detectInfo();
        if (ua && ua.device && ua.device.type == "Mobile")
            bar.addClass("phone");
        //initCustomLinkButton(pano, bar.get(0));
        //initCustomButton(pano, bar.get(0));
        initSwitchBar(pano, pano.project.scenes, bar.get(0));
//        if(pano.project.scene_groups.length==1&&pano.project.scene_groups[0].title=="未分组"){
//        	$(".phone .ul-imgs","#container").css("margin-top",".24rem");
//		}
    }

    /*function initCustomLinkButton(pano, parentElem) {
        var linksElem = $('<div class="custom-link-btns"></div>');

        var links = pano.project.links;
        for (var i = 0; i < links.length; i++) {
            var imgs = ResourceMgr.find(links[i].ico);
            var imgUrl = imgs && imgs.length ? imgs[0].access_url : HOST_URL + '/img/link.png';
            var filter = /^((\+[1-9]{1,4}[ \-]*)|(\([0-9]{2,3}\)[ \-]*)|([0-9]{2,4})[ \-]*)*?[0-9]{3,4}?[ \-]*[0-9]{3,4}?$/;
            var isTel = filter.test(links[i].content);
            var href = isTel ? 'tel:' + links[i].content : links[i].content;
            imgUrl = "white url('" + imgUrl + "')";
            var item = $('<div class="item"></div>');
            $('<a></a>')
                .attr('href', href)
                .attr('target', "_blank")
                .css("background", imgUrl)
                .css({
                    "background-size": "cover"
                })
                .click(function () {
                    countUserAction(pano.project.id, 'click', isTel ? null : href);
                })
                .appendTo(item);
            $('<div></div>').text(links[i].title)
                .attr('title', links[i].title)
                .appendTo(item);
            item.appendTo(linksElem);
        }
        linksElem.appendTo($(parentElem));
    }*/

    function initCustomButton(pano, parentElem) {
        var dialog = '\
    <div id="custom-btn-preview-mdl" class="modal fade"> \
        <div class="modal-dialog"> \
            <div class="modal-content"> \
                <div class="modal-header"> \
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button> \
                    <h4 class="modal-title"></h4> \
                </div> \
                <div class="modal-body clearfix"> \
                </div> \
                <div class="modal-footer"> \
                </div> \
            </div> \
            <!-- /.modal-content --> \
        </div> \
        <!-- /.modal-dialog --> \
    </div> \
    <!-- /.modal --> ';
        var btnsElem = $('<div class="custom-btns"></div>');
        var btns = pano.project.buttons;
        for (var i = 0; i < btns.length; i++) {
            var imgs = ResourceMgr.find(btns[i].ico);
            var imgUrl = imgs && imgs.length ? imgs[0].access_url : HOST_URL + '/img/link.png';
            imgUrl = "white url('" + imgUrl + "')";
            var item = $('<div class="item"></div>');
            $('<span></span>')
                .css("background", imgUrl)
                .css({
                    "background-size": "cover"
                })
                .data('idx', i)
                .click(function () {
                    var idx = $(this).data('idx');
                    var html = btns[idx].content;
                    var title = btns[idx].title;
                    $('#custom-btn-preview-mdl .modal-title').text(title);
                    $('#custom-btn-preview-mdl .modal-body')
                        .empty()
                        .append($('<div>' + html + '</div>'));
                    $('#custom-btn-preview-mdl').modal('show');
                    countUserAction(pano.project.id, 'click');
                })
                .appendTo(item);
            $('<div></div>').text(btns[i].title)
                .attr('title', btns[i].title)
                .appendTo(item);
            item.appendTo(btnsElem);
        }

        if (pano.project.enable_like) {
            var item = $('<div class="item"></div>');
            $('<span></span>')
                .css("background", "white url('" + HOST_URL + "/img/thumb_up.png')")
                .css({
                    "background-size": "cover"
                })
                .click(function () {
                    if ($(this).hasClass('disabled')) {
                        return;
                    }
                    $.ajax({
                        type: "post",
                        data: JSON.stringify({
                            id: pano.project.id,
                            decode_res: true
                        }),
                        url: HOST_URL + "/api/likeIt",
                        success: function (res) {
                            if (res.err_code === 0) {
                                pano.project.like = res.data.like;
                            }
                        }
                    });
                    $(this).addClass('disabled');
                    $(this).css("background", "white url('" + HOST_URL + "/img/thumb_uped.png')")
                        .css({
                            "background-size": "cover"
                        });
                    $(this).siblings('div').text(pano.project.like + 1);
                }).appendTo(item);
            $('<div></div>').text(pano.project.like)
                .appendTo(item);
            item.appendTo(btnsElem);
        }
        $(dialog).appendTo($('#' + pano.containerId));
        btnsElem.appendTo($(parentElem));
    }

    var cornerDeck = '<div class="corner-deck" style="margin:0 auto;"> \
    <div class="sand-table-view"> \
        <img crossorigin ="Anonymous" id="sand-table-pic" class="left"/> \
    </div> \
    <ul>\
        <li class="music"pointsid="sy_yy"></li> \
        <li class="sand-table off"></li> \
        <li class="device-orientation off" pointsid="sy_tly"></li> \
    	<li class="tuoluoyi-title">陀螺仪</li>\
        <li class="auto-rotation off" pointsid="sy_zdxz"></li> \
        <li class="vr-switch" pointsid="sy_vr"></li> \
    	<li class="vr-title">VR</li>\
    	<div class="sandTableView" id="sandTableViewBig"> \
    		<div class="sandTableView-main"> \
    			<div  class="sandTableViewBig"></div> \
    		</div> \
    	</div> \
    </ul>   \
    <audio autoplay class="bg_music_player"></audio> \
    </div>';

    function initCornerDeck(pano, containerId) {
        var cornerElem = $(cornerDeck);
        var music = pano.project.background_music;
        
        /*cornerElem.appendTo('#' + containerId);*/
        $(".banner_right").prepend(cornerElem);
        /*cornerElem.appendTo(".banner_right");*/
        globalVar = true;
        var ua = detectInfo();
        if (ua && ua.device && ua.device.type == "Mobile")
            cornerElem.addClass("phone");

        /*if (music.res_id === "") {
            $(".music", cornerElem).hide();
        } else {
            var urls = pano.resources[music.res_id];
            var audio = $(".bg_music_player", cornerElem).get(0);
            if (urls && urls.length) {
                audio.src = urls[0].access_url;
                $('html').one('touchstart', function () {
                    audio.play();
                });
                $("body").one("touchstart", function () {
                    audio.play();
                });
                $(".music:first", cornerElem).bind('click', function () {
                    var off = $(this).hasClass('off');
                    if (audio.paused) {
                        $(this).removeClass('off');
                        audio.play();
                    } else {
                        $(this).addClass('off');
                        audio.pause();
                    }
                    countUserAction(pano.project.id, 'click');
                });
            } else {
                $(".music", cornerElem).hide();
            }
        }*/

        initSandTable(pano, cornerElem);
        initDeviceOrientation(pano, cornerElem);
        initAutoRotation(pano, cornerElem);
        initVR(pano, cornerElem);
    }

    function initVR(pano, cornerElem) {
        if (!pano.project.enable_vr) {
            $('.vr-switch', cornerElem).hide();
        }
        $('.vr-switch').click(function () {
            pano.switchVRMode();
        });
    }

    function initDeviceOrientation(pano, cornerElem) {
        if (!pano.project.enable_orientation) {
            $('.device-orientation', cornerElem).hide();
        }
        $('.device-orientation', cornerElem).click(function () {
            var off = $(this).hasClass('off');
            if (off) {
            	
                $(this).removeClass('off');
                if (pano.project.enable_autorotation) {
                    $('.auto-rotation', cornerElem).trigger('click');
                }
                pano.controls.connect();
            } else {
            	
                $(this).addClass('off');
                pano.controls.disconnect();
            }
            pano.project.enable_orientation = off;
            countUserAction(pano.project.id, 'click');
        });
    }


    function initAutoRotation(pano, cornerElem) {
        if (!pano.project.enable_autorotation) {
            $('.auto-rotation', cornerElem).hide();
        }
        
        $('.auto-rotation', cornerElem).click(function () {
            var off = $(this).hasClass('off');
            if (off) {
//            	转动
            	idxx1=idxx;
            	autorotationTypes=1;
            	clearTimeout(oTime);
                $(this).removeClass('off');
                if (pano.project.enable_orientation) {
                    $('.device-orientation', cornerElem).trigger('click');
                }
                //增加原来自动旋转状态代码
                pano.project.enable_autorotation = true;
            } else {
            	idxx=idxx1;
            	if(isCarousel==1){
            		clearTimeout(oTime);
                	countdown(pano,10);
            	}
            	autorotationTypes=0;
                $(this).addClass('off');
                //增加原来自动旋转状态代码
                pano.project.enable_autorotation = false;
            }
            //幻灯片
            if(pano.autoPlayState==true){
            	pano.autoPlay(pano);
            }
            //去除原来自动旋转状态代码
            /*pano.project.enable_autorotation = off;*/
            countUserAction(pano.project.id, 'click');
        });
        if (pano.project.enable_orientation) {
            $('.device-orientation', cornerElem).trigger('click');
        }
        pano.project.enable_autorotation = false;
    }
    //初始化沙盘
    function initSandTable(pano, cornerElem) {
    	if(pano.project.sandTableMap==undefined){
    		return;
    	}
    	var getSceneGrounpIdIn = pano.getCurrScene().sceneGroup.id;
        var stbIn = pano.project.sandTableMap[getSceneGrounpIdIn];
    	if(stbIn){
    		/*$(".sand-table", cornerElem).show();*/
    	}
    	
    	var stv = $(".sandTableView", cornerElem);
    	stv.hide();
        $(".sand-table", cornerElem).click(function () {
        	var getSceneGrounpId = pano.getCurrScene().sceneGroup.id;
            var stb = pano.project.sandTableMap[getSceneGrounpId];
            if (stb.imgPath==="") {
                return;
            }
        	$(".sandTableView-main").css({'background':'url('+stb.imgUrl+')no-repeat center center','background-size': 'cover'});
        	$(".sandBigImg-main").css({'background':'url('+stb.imgUrl+')no-repeat center center','background-size': 'contain'});
            if (stv.is(':visible')) {
                $(this).addClass('off');
                stv.hide();
            } else {
                $(this).removeClass('off');
                stv.show();
                $('.sand-table-arrow').remove();
                initStv(stb, $('.sandTableView'));
            }
            
            countUserAction(pano.project.id, 'click');
        }); 
        /*$('.sandTableViewBig').click(function(){
        	var getSceneGrounpId = pano.getCurrScene().sceneGroup.id;
            var stb = pano.project.sandTableMap[getSceneGrounpId];
            $('.sandBigImgMain-points .sand-table-arrow').remove();
        	$('.sandBigImg').fadeIn();
        	var points = stb.points;
            for (var i = 0; i < points.length; ++i) {
            	addSandTablePointBigView($('.sandBigImgMain-points'), points[i]);
            }
            if($('#sandTableViewBig').find('.current').length>0){
            	var ind = $('#sandTableViewBig').find('.current').index(),
            	deg = $('#sandTableViewBig').find('.current')[0].style.cssText.substring($('#sandTableViewBig').find('.current')[0].style.cssText.indexOf('rotate('),$('#sandTableViewBig').find('.current')[0].style.cssText.length-1);;
            	$('.sandBigImgMain-points .sand-table-arrow').eq(ind-1).addClass('current').css('transform',deg).siblings('.sand-table-arrow').removeClass('current');
            }
        	return false;
        });*/

        function initStv(stb, stv) {
            initSandTablePoints($(stv), stb);
            pano.updateSandPointView();
            if (pano.spv) {
                pano.spv.addClass("current");
            }
            $(".sand-table-arrow", stv).click(function (e) {
                var idx = $(this).attr("data-idx");
                if (idx) {
                    var scenes = pano.project.scenes;
                    for (var i = 0; i < scenes.length; i++) {
                        if (scenes[i].id == idx) {
                            pano.loadScene(i);
                            countUserAction(pano.project.id, 'click');
                            break;
                        }
                    }
                }
                e.stopPropagation();
            })
        }
        touch.on(".sandTableView", 'doubletap', function () {
            var stb = pano.project.sand_table;
            if (!stb.res_id) {
                return;
            }
            if (!$('.sandTableView').hasClass('mdl-display')) {
                $('.sandTableView').addClass('mdl-display');
                $('.sand-table-arrow').remove();

                $('#display-point-info-mdl').on('hide.bs.modal', function () {
                    $('.sand-table-arrow').remove();
                    $('.sandTableView').removeClass('mdl-display')
                    $('.corner-deck').prepend($('.sandTableView'));
                    initStv(stb, $('.sandTableView'));
                })
                $('#display-point-info-mdl').on('shown.bs.modal', function () {
                    $('.sand-table-arrow').remove();
                    initStv(stb, $('.sandTableView'));
                })

                baseModle($('.sandTableView').get(0));
                pano.updateSandPointView();
            }
        });
        $(".sandTableView").click();
    }



    var CreatePanorama = function (containerId, projectId) {
        var position = $("#" + containerId).css("position");
        if (position !== 'relateive' || position !== 'absolute')
            $("#" + containerId).css({
                "position": "relative"
            });
        var pano = new Panorama(containerId);
        pano.AddLoadFilishEvent(loadAllPoint(pano));
        pano.reloadProject(projectId);
        return pano;
    };
    window.CreatePanorama = CreatePanorama;
    window.Panorama = Panorama;
    window.xyz2latlon = xyz2latlon;
    window.latlon2xyz = latlon2xyz;

})();