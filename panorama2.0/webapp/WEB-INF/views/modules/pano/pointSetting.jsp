<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en" style="height:100%;">

<head>
	<title>场景设置</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
    <link rel="stylesheet" href="${panoStatic}/js/lib/bootstrap-3.3.6/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${panoStatic}/css/scene-setting.css?v=1.0" type="text/css"/>
    <link rel="stylesheet" href="${panoStatic}/css/main.css" type="text/css">
    <script type="text/javascript">
    	var siteRoot="${siteRoot}";
    	var albumId="${albumId}";
    	var panoStatic="${panoStatic}";
    	var sceneId="${sceneId}";
    	var backPath="${backPath}";
    	var cosAccessHost ="${fns:getCosAccessHost()}";
    	var autorotationTypes='0';
    	var oTime=null;
    	var isCarousel='0';
    	var linkerData;
    	var audio_scene;
    	
    </script>
    <style>input[type=text]:focus{outline: #36aaf6 solid 1px;}</style>
</head>

<body style="width:100%; height:100%">
<div id="alertMask"></div>
<div id="container">
    <div class="visual-angle-frome">
        <div class="visual-angle-1 visual-angle-v"></div>
        <div class="visual-angle-2 visual-angle-v"></div>
        <div class="visual-angle-3 visual-angle-h"></div>
        <div class="visual-angle-4 visual-angle-h"></div>
        <div class="visual-angle-5 visual-angle-h"></div>
        <div class="visual-angle-6 visual-angle-h"></div>
        <div class="visual-angle-7 visual-angle-v"></div>
        <div class="visual-angle-8 visual-angle-v"></div>
        <div class="visual-angle-btn">设为初始视角</div>
    </div>
</div>
<div class="point-right-meun">
	<div id="qqmaplogo"></div>
	<div class="main-btn-type" id="main-close-btn">关闭</div>
	<div class="main-btn-type" id="main-save-btn">保存</div>
	<div class="main-btn-type" id="main-visual-angle-btn"></div>
	<div class="main-btn-type" id="main-hot-point-btn"></div>
</div>
<!--<div class="main-btn-type" id="save-btn"><label for="save-btn">沙盘</label></div>
<div class="main-btn-type" id="save-btn"><label for="save-btn">特效</label></div>
<div class="main-btn-type" id="save-btn"><label for="save-btn">预览</label></div>-->
<div class="setting-pane" id="visual-angle-pane">
    <!-- Nav tabs -->
    <ul class="nav nav-tabs visual-angle-nav" role="tablist">
        <li role="presentation" class="active"><a href="#visual-angle-initial" role="tab" data-toggle="tab">初始视角</a>
        </li>
        <li role="presentation"><a href="#visual-angle-fov" role="tab" data-toggle="tab">FOV设置</a></li>
        <li role="presentation"><a href="#visual-angle-vertical" role="tab" data-toggle="tab">垂直视角</a></li>
    </ul>

    <!-- Tab panes -->
    <div class="tab-content pane-main">
        <div role="tabpanel" class="tab-pane active" id="visual-angle-initial">
            <img id="visual-angle-preview-img" src=""/>
        </div>
        <div role="tabpanel" class="tab-pane" id="visual-angle-fov">
            <div class="fov-value-container" id="fov-value-container-init">
                <div id="fov-value-init"></div>
                <label>初始视角</label>
            </div>
            <div class="max-min-curr-slide" id="fov-value-slide">
                <div class="top-slide-area">
                    <div class="curr-value-slide-body">
                        <div class="curr-value-slide-rectangle"></div>
                        <div class="curr-value-slide-triangle"></div>
                    </div>
                </div>
                <div class="slide-area-line"></div>
                <div class="bottom-slide-area">
                    <div class="min-value-slide-body"></div>
                    <div class="max-value-slide-body"></div>
                </div>
            </div>
            <div class="fov-value-button-container">
                <div class="fov-value-container" id="fov-value-container-min">
                	<label>限制最近</label>
                    <div id="fov-value-min"></div>
                </div>
                <div class="fov-value-container" id="fov-value-container-max">
                	<label>限制最远</label>
                    <div id="fov-value-max"></div>
                </div>
            </div>
        </div>
        <div role="tabpanel" class="tab-pane" id="visual-angle-vertical">
            <div class="visual-angle-vertical-head">垂直视角限制</div>
            <div class="max-min-curr-slide" id="visual-angle-vertical-slide">
                <div class="top-slide-area">
                    <div class="curr-value-slide-body">
                        <div class="curr-value-slide-rectangle"></div>
                        <div class="curr-value-slide-triangle"></div>
                    </div>
                </div>
                <div class="slide-area-line"></div>
                <div class="bottom-slide-area">
                    <div class="min-value-slide-body"></div>
                    <div class="max-value-slide-body"></div>
                </div>
            </div>
            <div class="fov-value-button-container">
                <div class="fov-value-container" id="vis-ang-vert-min-container">
                    <div id="visual-angle-vertical-min"></div>
                    <label>限制最低</label>
                </div>
                <div class="fov-value-container" id="vis-ang-vert-max-container">
                    <div id="visual-angle-vertical-max"></div>
                    <label>限制最高</label>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="setting-pane" id="hot-point-pane">
    <ul class="nav nav-tabs" role="tablist" style="border:0px">
        <li role="presentation" class="active" style="margin-bottom: 0px;border:0px">
        	<a href="#hot-point-tab" role="tab" data-toggle="tab" style="background: rgba(0, 0, 0, 0.6);color:#fff;border:0px;font-size: 16px;font-weight: bold;">热点设置</a>
        	<i style="width: 0;height: 0;border-left: 0px solid transparent;border-right: 32px solid transparent;border-bottom: 42px solid #000;position: absolute;right:-30px;top:0px;opacity:0.6"></i>
        </li>
    </ul>
    <!-- Tab panes -->
    <div class="tab-content pane-main">
        <div role="tabpanel" class="tab-pane active" id="hot-point-tab">
            <div class="hot-point-page-description">根据需求使用不同的热点展示方式</div>
            <button class="btn btn-default hot-point-page-btn" data-type="jump" type="button">全景切换</button>
            <button class="btn btn-default hot-point-page-btn" data-type="hyperlink" type="button">超链接</button>
            <button class="btn btn-default hot-point-page-btn" data-type="picture" type="button">图片展示</button>
            <button class="btn btn-default hot-point-page-btn" data-type="introduce" type="button">文字介绍</button>
            <button class="btn btn-default hot-point-page-btn" data-type="voice" type="button">语音热点</button>
            <button class="btn btn-default hot-point-page-btn" data-type="mark" type="button">文字标记</button>
        </div>
    </div>
    <div id="hot-point-item-container">
        <div id="hot-point-item-container-info">
       		<div id="hot-point-item-info">已添加{len}个{name}热点</div>
            <div id="hot-point-item-description">{desc}</div>
            <div id="hot-point-item-controls">
	        	<div id="location"><span>定位</span></div>
	        	<div id="edit-title"><span>编辑图标</span></div>
	        	<div id="edit-content"><span>编辑内容</span></div>
	        	<div id="delete"><span>删除</span></div>
        	</div>
        </div>
        <button class="btn btn-default" id="add-hot-point-btn" type="button">添加热点</button>
    </div>
</div>

<!-- 添加场景热点对话框 -->
<div id="add-point-mdl" class="modal fade">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true"></span></button><!--右上角的关闭叉叉-->
                <h4 id="add-point-mdl-title" class="modal-title">添加全景切换热点</h4>
            </div>
            <div class="modal-body">
                <!-- Nav tabs -->
                <div id="add-point-centent-pane">
                    <ul class="nav nav-tabs" id="myTab" role="tablist">
                        <li role="presentation" class="active"><a href="#select-icon-adm" aria-controls="icone"
                                                                  role="tab">选择图标样式</a></li>
                        <li role="presentation"><a href="#target-scene-adm" aria-controls="target" role="tab"
                                                   >选择目标场景</a></li>
                        <li role="presentation"><a href="#hyperlink-addr-adm" aria-controls="messages" role="tab"
                                                   >填入超链接地址</a></li>
                        <li role="presentation"><a href="#select-picture-adm" aria-controls="settings" role="tab"
                                                   >选择展示的图片</a></li>
                        <li role="presentation"><a href="#add-text-adm" aria-controls="settings" role="tab"
                                                   >填写文本内容</a></li>
                        <li role="presentation"><a href="#select-music-adm" aria-controls="settings" role="tab"
                                                   >选择音乐</a></li>
                        <li role="presentation"><a href="#add-mark-adm" aria-controls="settings" role="tab"
                                                   >填写点位名称</a></li>
                    </ul>

                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div role="tabpanel" class="tab-pane active add-point-pane" id="select-icon-adm">
                            <!-- <div style="margin-top:10px;margin-left:5px;">
                            	<label for="select-sys-btn" id="select-sys-btn-label">
                            		<input type="radio" name="btn" id="select-sys-btn" value="" /><span>系统图标</span>
                            	</label>
                            	<label for="select-material-btn" id="select-material-btn-label">
                            		<input type="radio" name="btn" id="select-material-btn"/><span>使用素材库</span>
                            	</label>
                            	<button class="btn btn-default" id="select-material-btn">使用素材库</button>
                            </div> -->
                            <div class="select-icon-container">
                            </div>
                            <div class="select-icon-container-mark">
                            </div>
                            <div class="select-material-container" style="display:none;">
                                <div class="pane" style="overflow:hidden">
                                </div>
                                <div class="page" style="float:right; margin-right: 10px;">
                                    <button class="preview"> 上一页 </button>
                                    <span class="cur-page">1/1</span>
                                    <button class="next"> 下一页 </button>
                                    <input class="jump-page"> </input>
                                    <button class="jump-btn">跳转</button>
                                </div>
                            </div>
                            <!-- input id="sys-icon-radio" name="file-select-type" type="radio" checked>系统图标
                            <input id="lib-icon-radio" name="file-select-type" type="radio">从媒体库选择
                            <div class="select-icon-container">
                            </div>
                            <div class="select-icon-from-lib">
                                <div class="select-icon-lib-center">
                                    <img >
                                    <button id="select-icon-lib-btn" type="button" class="btn btn-default">从媒体库中选择</button>
                                    <div>自定义图标尺寸建议为：70 x 70 像素</div>
                                    <div>建议适应带透明背景的图片</div>
                                </div>
                            </div -->
                        </div>
                        <div role="tabpanel" class="tab-pane add-point-pane" id="target-scene-adm">
                        </div>
                        <!--target-scene-adm:里面放所有目标场景-->
                        <div role="tabpanel" class="tab-pane add-point-pane" id="hyperlink-addr-adm">
                            <div class="hyperlink-pane-center">
                                <div>
                                    <label class="hyperlink-label">填入热点名称：</label>
                                    <input class="hyperlink-input" placeholder="填入热点名称" id="hyperlink-name" type="text"/>
                                </div>
                                <div>
                                    <label class="hyperlink-label">请填入链接地址:</label>
                                    <input class="hyperlink-input" id="hyperlink-url"  type="text" placeholder="请填入链接地址">
                                </div>
                                <div>
                                    <input id="hyperlink-checkbox" type="checkbox"/>
                                    <label for="hyperlink-checkbox">新窗口打开</label>
                                </div>
                                <div>
                                	<input id="hyperlink-title-select" class="common-select" type="checkbox"/>
                                    <label for="hyperlink-title-select">全景中显示热点名字</label>
                                </div>
                            </div>
                        </div>
                        <div role="tabpanel" class="tab-pane add-point-pane" id="select-picture-adm">
                            <div>
                                <input id="picture-title-adm" style="padding:5px 10px;" class="left oneline" type="text"
                                       placeholder="图片标题"> </input>
                                <!--<button id="select-picture-lib-btn" class="btn btn-default" type="button">从媒体库选择
                                </button> -->
                                <button id="select-picture-upload-btn" class="btn btn-default" type="button">上传图片
                                </button>
                                <div>
                                	<input id="picture-title-select"  class="common-select" type="checkbox"/>
                                    <label for="picture-title-select">全景中显示热点名字</label>
                                </div>
                                <form>
                                	<input type="hidden" name="type" value="image">
                                	<input id="file-select-picture-adm" class="file-select-hide" type="file" name="file" accept="image/*"/>
                                </form>
                            </div>
                            <div class="select-picture-img-area"></div>
                        </div>
                        <div role="tabpanel" class="tab-pane add-point-pane" id="add-text-adm">
                            <div class="add-text-adm-center">
                                <div>
                                    <label>请填入标题：</label>
                                    <input id="title-introduce-input" type="text"/>
                                </div>
                                <div>
                                    <label>请填入内容：</label>
                                    <textarea id="content-introduce-input"></textarea>
                                </div>
                                <div>
                                	<input id="introduce-title-select"  class="common-select" type="checkbox"/>
                                    <label for="introduce-title-select">全景中显示热点名字</label>
                                </div>
                            </div>
                        </div>
                        <div role="tabpanel" class="tab-pane add-point-pane" id="add-mark-adm">
                            <div style="color:#859dad;margin-top:-34px;margin-left: -150px;width: 300px; height:67px; position: relative;left: 50%;top: 50%;">
                                <div>
                                    <p style="padding:0;">点位名称：</p>
                                    <input id="title-mark-input" maxlength="12" placeholder="输入12字内的点位名称" type="text" style="color:#000; padding:0 10px;  width: 300px; height: 40px;"/>
                                </div>
                            </div>
                        </div>
                        <div role="tabpanel" class="tab-pane add-point-pane" id="select-music-adm">
                            <div>
                                <!-- button id="select-music-lib-btn" class="btn btn-default" type="button">从媒体库选择</1button -->
                                <button id="select-music-upload-btn" class="btn btn-default" type="button">上传音乐</button>
                                <form >
                                	<input type="hidden" name="type" value="audio">
                                	<input id="file-select-music-adm" class="file-select-hide" type="file" name="file" accept="audio/*">
                                </form>
                                
                            </div>
                            <div class="select-music-area">
                                <input id="music-title-adm" class="left oneline" type="text"
                                       placeholder="音乐标题"> </input>
                                <button id="point-muisc-player-btn" class="btn btn-default" type="button">试听</button>
                                <audio id="point-muisc-player" preload='none'></audio>
                            </div>
                            <div>
                            	<input id="music-title-select"  class="common-select" type="checkbox"/>
                                <label for="music-title-select">全景中显示热点名字</label>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="add-point-select-file-pane">
					<!--上传图片至图片库时显示，里面放图片列表-->
                </div>
            </div>
            <div class="modal-footer">
                <!--<button id="cancel-add-point-btn" type="button" class="btn btn-default">取消</button>-->
                <button disabled="disabled" id="nextStep" type="button" class="btn btn-primary">下一步</button>
                <button id="lastStep" type="button" class="btn btn-primary" style="display:none;">上一步</button>
                <button disabled="disabled" style="display: none;" id="save-add-point-btn" type="button" class="btn btn-primary">完成</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->


	<script type="text/javascript" src="${panoStatic}/js/lib/jquery-2.2.3.js"></script>
	<script type="text/javascript" src="${panoStatic}/js/lib/bootstrap-3.3.6/dist/js/bootstrap.js"></script>
	<script type="text/javascript" src="${panoStatic}/js/lib/detect.min.js"></script>
	<script type="text/javascript" src="${panoStatic}/js/lib/touch.baidu/touch-0.2.14.min.js"></script>
	<script type="text/javascript" src="${panoStatic}/js/lib/file-upload/resumable.js"></script>
	<script type="text/javascript" src="${panoStatic}/js/lib/md5/spark-md5.min.js"></script>
	<script type="text/javascript" src="${panoStatic}/js/lib/spin.min.js"></script>
	<script type="text/javascript" src="${panoStatic}/js/lib/three.js"></script>
	<script type="text/javascript" src="${panoStatic}/js/utility.js"></script>
	<script type="text/javascript" src="${panoStatic}/js/lib/vr-base-effect.js"></script>
	<script type="text/javascript" src="${panoStatic}/js/lib/device-orientation-controls.js"></script>
	<script type="text/javascript" src="${panoStatic}/js/load.js"></script>
	<script type="text/javascript" src="${panoStatic}/js/hot-point.js"></script>
	<script type="text/javascript" src="${panoStatic}/js/scene-setting.js?v=1.0"></script>
	<script type="text/javascript" src="${panoStatic}/js/lib/circle-progress.js"></script>
	<script src="${ctxStatic}/jquery/jquery.ui.widget.js" type="text/javascript"></script>
	<script src="${ctxStatic}/jquery/jquery.fileupload.js" type="text/javascript"></script>
</body>
</html>
