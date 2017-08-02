<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
	    <meta name='apple-mobile-web-app-capable' content='yes' />
	    <meta content="black" name="apple-mobile-web-app-status-bar-style" />
	    <meta content="telephone=no" name="format-detection" />
	    <title>房源详情</title>
	    <meta name="keywords" content="" />
	    <link type="text/css" href="${backStatic}/css/common_app.css" rel="stylesheet">
	    <link type="text/css" href="${backStatic}/css/styleyc.css" rel="stylesheet">
		<link rel="stylesheet" href="${backStatic}/css/photoswipe.css"> 
		<link rel="stylesheet" href="${backStatic}/css/default-skin/default-skin.css"> 
		<style>
			body{background:#fff!important;}
	    	.alert-main {background: rgba(0, 0, 0, .56);text-align: center;display: none;position: fixed;z-index: 5;left: 0;top: 0;width: 100%;height: 100%;}
	
			.alert-box {display: inline-block;position: relative;margin-top: 20vh;}
	
			.at-alert {background: #FFF;border-radius: 2vh;width: 72vw;}
	
			.at-alert span {color: #2196F3;font-size: 16px;line-height: 1.5;display: block;padding: 4.5vw;}
	
			.at-alert .close {color: #333;font-size: 15px;line-height: 5.6vh;border-top: 1px solid #EEE;display: block;height: 5.6vh;}
	
			.w_header_bg {background: url('${backStatic}/images/icon_to720.png') no-repeat center;background-size:contain;position: absolute;bottom: 20px;right:20px;width: 0.8rem;height: 0.8rem;}
	
			.dbox {background: #FFF !important;border-radius: 10px !important;overflow: hidden !important;position: relative !important;margin: 15px auto !important;}
	
			.dbox .tbar {color: #333 !important;font-size: 16px !important;text-indent: 15px !important;line-height: 10.5vw !important;border-bottom: 1px solid #F0F0F0 !important;height: 10.5vw !important;}
	
			.dbox .cont {font-size: 14px !important;line-height: 20px !important;overflow: hidden !important;transition: all .3s !important;/*margin-top: 10px !important;*/margin-bottom: 40px;min-height: 2.5rem;max-height: 2.5rem !important;height: auto !important;}
	
			.dbox .cont1{font-size: 14px !important;line-height: 20px !important;overflow: hidden !important;transition: all .3s !important;/*margin-top: 10px !important;*/margin-bottom: 40px !important;min-height: 125px !important;max-height: 125px !important;height: auto !important;}
			
			.dbox .cont.show ,.cont1.show{transition: all 3s !important;max-height: 12.5rem !important;}
			.dbox #box2.cont {max-height: 3.2rem !important;}
			.dbox #box2.cont.show {transition: all 3s !important;max-height: 12.5rem !important;}
			.dbox .more,.more-fangyuan-tese {background: #FFF;color: #7B7E7E !important;line-height: .88rem !important;text-align: center !important;position: absolute !important;left: 0 !important;bottom: .52rem !important;padding: 0 !important;width: 100% !important;height: .88rem !important;}
			
			
			
			
			.dbox .more a:nth-child(2) {display: none;}
			.pnav{margin-top:30px;text-align:center;line-height:24px; font-size:16px}
			.pnav a{padding:4px}
			.pnav a.cur{background:#007bc4;color:#fff;}
			.demo{width:80%; margin:10px auto}
			
			/* 新增样式 */
			.loupan_name{height:26px;font-size:18px;padding-left:.3rem;overflow:hidden;}
			.more{width:90%;background:#f5f7f9!important;border-radius:6px;}
			.loupan_name{font-weight:600;font-size:22px;color:#333333;}
			.toMpas{display:block;width:0.3rem;height:0.3rem;background:url('${backStatic}/images/icon_arrow_right.png') no-repeat center;background-size:contain;margin-top:0.2rem;margin-left:4.5rem;}
			.hide_com{display:none;}
			
			/*必要样式*/
			#photos{width:150px; border:1px solid #d3d3d3;margin:20px auto; text-align:center;padding:4px;cursor:pointer;position:relative}
			#photos p{position:absolute; bottom:0;left:0;padding:4px;background:#000;color:#fff}
			.my-gallery {width: 100%;float: left;}
			.my-gallery img {width: 100%;height: auto;}
			.my-gallery figure {display: block;float: left;margin: 0 5px 5px 0;width: 150px;}
			.my-gallery figcaption {display: none;}
	    </style>
	   
	    <script type="text/javascript" src="${backStatic}/js/jquery.min.2.2.2.js"></script>
		<script type="text/javascript" src="${backStatic}/js/common1.js"></script>
		<script type="text/javascript" src="${backStatic}/js/rem.js"></script>
		<script type="text/javascript" src="${backStatic}/js/tracker.js"></script>
		<script type="text/javascript"  src="${backStatic}/js/highcharts.js"></script>
		<script type="text/javascript"  src="${backStatic}/js/touch.min.js"></script>
		<script type="text/javascript"  src="${backStatic}/js/alert-box.js"></script>
		
		<script type="text/javascript" src="http://cdn.szzunhao.com/hongbao/js/jweixin-1.0.0.js"></script>
	</head>
	<body style="background:#f6fafb" pageId="ZH_H5_PS0002" unitId="ZH_H5_L02001">
	<script charset="utf-8" src="http://map.qq.com/api/js?v=2.exp&key=3GJBZ-3SURO-6DVWN-SK5WL-YOG6H-3SF3H"></script>
    	<div class="w_header_img">
			<!--<a class="w_go-back" href='javascript:window.history.go(-1)'>
				<img src="./images/w_go_back.png" />
			</a>
			<img src="./images/w_header_img.png" />
			<a class="w_music" >
				<img src="./images/w_music.png" />
				<audio controls="controls" id="audio"   loop="loop"  style="display:none"   >
                   <source  src="" type="audio/mpeg"  />
                </audio> 
			</a>
			<img class="w_beijing" src="./images/w_beijing.png" />
			<p class="w_mian_ch_left_name">
					深圳湾1号
			</p>
			|
			<span>在售</span>
			<a class="w_kanfang">
				<img src="./images/w_kanfang.png" />
			</a>-->
		</div>
		<div class="w_mian_sj dbox loupan" style="margin-bottom: 0!important;height: auto; padding-bottom: .94rem;margin-top: .4rem !important;border-radius: 0 !important;box-shadow: 0px 3px 5px #ececec;">
			<div class="w_mian_ch_mian">
				<div class="loupan_name" style="margin-bottom:.24rem;">
					<span class="fl"></span>
					<img class="renzheng fl" src="${backStatic}/images/icon_tencent.png" style="width:80px;margin-top:7px;margin-left:8px;"/>
				</div>
				<div class="w_mian_ch_main_biaoqian" style="padding-left:.3rem;margin-bottom:.2rem;">
					<!-- <span>学区房</span>
					<span>学区房</span>
					<span>学区房</span> -->
				</div>
				<c:if test="${fyType==0 }">
					<p class="w_mian_ch_money wid" style="margin-bottom: .1rem;">
						<img class="w_jisuanqi" src="${backStatic}/images/w_jisuanqi.png" style="margin-top:.11rem;margin-left:.44rem;"/>
						<span style="margin-top:.13rem;position: relative;bottom: -2px;">均价：</span>
						<span style="color:red;font-size:.5rem!important;" class="junjia"></span>
					</p>
				</c:if>
			</div>
			
			<!-- 下面是二手房的 -->
			<c:if test="${fyType==1 }">
				<div class="ershoufangjieshao">
					<div class="ershoufangjieshao-title">
						<div class="fl" style="-webkit-flex: 1;height:1rem;border-right:1px solid #e6e6e6;">
							<div style="text-align:center;color:#999;margin-bottom:6px;font-size:.32rem;">总价</div>
							<div style="text-align:center;color:#f54346;font-weight:600;font-size:.32rem;" class="totalMoney"></div>
						</div>
						<div class="fl" style="-webkit-flex: 1;height:1rem;border-right:1px solid #e6e6e6;">
							<div style="text-align:center;color:#999;margin-bottom:6px;font-size:.32rem;">房型</div>
							<div style="text-align:center;color:#f54346;font-weight:600;font-size:.32rem;" class="fangxing"></div>
						</div>
						<div class="fl" style="-webkit-flex: 1;height:1rem;">
							<div style="text-align:center;color:#999;margin-bottom:6px;font-size:.32rem;">面积</div>
							<div style="text-align:center;color:#f54346;font-weight:600;font-size:.32rem;" class="mianji"></div>
						</div>
					</div>
					
					
					
					<ul class="ershoufangjieshao-content">
						<li>
							<p class="w_mian_ch_money wid">
								<img class="w_jisuanqi"  src="${backStatic}/images/w_jisuanqi.png" style="margin-left:.7rem;" />
								<span style="font-size:.32rem;">单价：</span>
								<span style="color:red;margin-right:30px;font-size:.32rem;" class="junjia"></span>
							</p>
						</li>
						<li style="display:none;margin-bottom:8px;" class="chaoxaing-louceng">
							<div class="fl chaoxiang-parent" style="-webkit-flex: 1;margin-left:14px;display:none;">
								<span class="wid" style="color: #999;margin-right:4px;font-size:.32rem;">朝向:</span>
								<span class="chaoxiang" style="font-size:.32rem;"></span>
							</div>
							<div class="fl louceng-parent" style="-webkit-flex: 1;display:none;">
								<span class="wid" style="color: #999;margin-right:4px;margin-left:14px;">楼层:</span>
								<span class="louceng" ></span>
							</div>
						</li>
						<li style="display:none;margin-bottom:8px;" class="niandai-zhuangxiu">
							<div class="zhuangxiu-niandai-con" style="padding-left:14px;-webkit-flex:1 ;display: -webkit-flex;">
								<div class="fl niandai-parent" style="-webkit-flex: 1;display:none;">
									<span class="wid" style="color: #999;margin-right:4px;font-size:.32rem;">年代:</span>
									<span class="niandai" style="font-size:.32rem;"></span>
								</div>
								<div class="fl zhuangxiuzhuangkuang-parent hide_com" style="-webkit-flex: 1;">
									<span class="wid" style="color: #999;margin-right:4px;font-size:.32rem;margin-left:14px;">装修:</span>
									<span class="zhuangxiuzhuangkuang" style="font-size:.32rem;"></span>
								</div>
							</div>
						</li>
						<li style="margin-bottom:8px;display:none;" class="quyu-parent">
							<span class="wid fl" style="margin-left:14px;margin-right:8px;color: #999;font-size:.32rem;">区域:</span>
							<span class="quyu" style="font-size:.32rem;"></span>
						</li>
						<li style="margin-bottom:8px;display:none;" class="xiaoqu-parent">
							<span class="wid fl" style="margin-left:14px;margin-right:8px;color: #999;font-size:.32rem;">小区:</span>
							<span class="xiaoqu" style="font-size:.32rem;"></span>
						</li>
					</ul>
				</div>
			</c:if>
			
			<c:if test="${fyType==1 }">
				<div class="w_mian_jj fyts" style="display:none;">
					<div class="w_mian_jj_xumu tbar" style="color:#333;font-weight:600;">
						房源特色
					</div>
					<div class="w_mian_jj_neirong">
						<p id="box" class="cont" style="font-size:.32rem!important;"></p>
						
					</div>
					<p class="more fyts-more" style="width:93%!important;margin-left:14px;">
						<a unitId="ZH_H5_C02012">查看更多</a>
						<a>收起</a>
					</p>
				</div>
			</c:if>
			
			
			<!-- 下面是新房的 -->
			<c:if test="${fyType==0 }">
				<div class="w_mian_sj_neirong" >
				<ul id="box1" class="cont">
					<li class="clear hide_com kaipanshijian">
						<div class="fl hide_com kaipans-parent" style="margin-right:20px;">
							<span style="padding-left:14px;color:#999;">开盘:</span>
							<span class="kaipans"></span>
						</div>
						<div class="fl hide_com yujijiaofang-parent" style="margin-left:14px;">
							<span style="color:#999;">预计交房:</span>
							<span class="yujijiaofang"></span>
						</div>
					</li>
					<li class="clear hide_com w_mian_jj_neirong_right01-parent">
						<span class="wid fl">地址:</span>
						<span class="w_mian_jj_neirong_right01 fl"></span>
					</li>
					<li class="clear hide_com zhuangxiuzhuangkuang-parent">
						<span class="wid fl">装修情况:</span>
						<span class="w_mian_jj_neirong_right zhuangxiuzhuangkuang fl"></span>
					</li>
					<li class="clear hide_com zhandimianjis-parent">
						<span class="wid fl">占地面积:</span>
						<span class="w_mian_jj_neirong_right zhandimianjis fl"></span>
					</li>
					<li class="clear hide_com jianzhumianji-parent">
						<span class="wid fl">建筑面积:</span>
						<span class="w_mian_jj_neirong_right jianzhumianji fl"></span>
					</li>
					<li class="clear hide_com zhuhushus-parent">
						<span class="wid fl">住户数:</span>
						<span class="w_mian_jj_neirong_right zhuhushus fl"></span>
					</li>
					<li class="clear hide_com rongjilv-parent">
						<span class="wid fl">容积率:</span>
						<span class="w_mian_jj_neirong_right rongjilv fl"></span>
					</li>
					<li class="clear hide_com lvhualv-parent">
						<span class="wid fl">绿化率:</span>
						<span class="w_mian_jj_neirong_right lvhualv fl"></span>
					</li>
					<li class="clear hide_com tingchewei-parent">
						<span class="wid fl">停车位:</span>
						<span class="w_mian_jj_neirong_right tingchewei fl"></span>
					</li>
					<li class="clear hide_com chanquannianxian-parent">
						<span class="wid fl">产权年限:</span>
						<span class="w_mian_jj_neirong_right chanquannianxian fl"></span>
					</li>
					<li class="clear hide_com wuyeleixing-parent">
						<span class="wid fl">物业类型:</span>
						<span class="w_mian_jj_neirong_right wuyeleixing fl"></span>
					</li>
					
					<li class="clear hide_com kaifashang-parent">
						<span class="wid fl">开发商:</span>
						<span class="w_mian_jj_neirong_right kaifashang fl"></span>
					</li>
					<li class="clear hide_com wuyegongsi-parent">
						<span class="wid fl">物业公司:</span>
						<span class="w_mian_jj_neirong_right wuyegongsi fl"></span>
					</li>
					<li class="clear hide_com wuyefei-parent">
						<span class="wid fl">物业费:</span>
						<span class="w_mian_jj_neirong_right wuyefei fl"></span>
					</li>
				</ul>
				<p class="more" style="width:6.9rem!important;margin-left:.3rem">
					<a unitId="ZH_H5_C02013">查看更多</a>
					<a>收起</a>
				</p>
			</div>
			
			</c:if>
		</div>
		<div style="height:.24rem;background:#f5f5f5;background:url(${backStatic}/images/icon_banners.png) no-repeat center"></div>
		<div class="w_mian_xm" style="display:none;">
			<!--<div class="w_mian_xm_mu">
				<div class="w_mian_xm_one">
					<a><img src="./images/w_daohang.png" /></a>
					<p>我要看房</p>
				</div>
				<div class="w_mian_xm_one">
					<a><img src="./images/w_zhuanqian.png" /></a>
					<p>推荐赚拥</p>
				</div>
				<div class="w_mian_xm_one">
					<a><img src="./images/w_hongbao.png" /></a>
					<p>我要红包</p>
				</div>
				<div class="w_mian_xm_one">
					<a><img src="./images/w_xiaoxi.png" /></a>
					<p>微聊</p>
				</div>
			</div>-->
		</div>
		
		<c:if test="${fyType==0 }">
			<div class="w_mian_sj" id="n_video_demo" style="display:none; height: auto; margin-top:.2rem;">
				<div class="w_mian_sj_xumu tbar">
					视频欣赏
				</div>
				<div class="w_mian_sj_neirong" style=" padding-bottom:.52rem!important;">
					<video x-webkit-airplay="true" width="100%" poster="${linkerStatic}/img/videoImg.png"  webkit-playsinline="true" id="newf_video" preload="true" controls="controls" src=""></video>
					<iframe frameborder="0" width="100%" style="display:none;"  id="newf_videos" src="" allowfullscreen></iframe>
				</div>
			</div>
		</c:if>
		<c:if test="${fyType==0 }">
			<div class="w_mian_js dbox" id="w_mian_js" style="display:none; padding-left:.3rem; margin-top:.2rem!important;margin-bottom: 0!important; padding-bottom: .94rem;width: 7.5rem;margin-right: 0!important;border-radius:0!important;">
				<div class="w_mian_js_xumu">
					主力户型
				</div>
				<div class="w_mian_jj_huxing">
					<ul id="box2" class="cont" style="min-height: 3.2rem;">
						
					</ul>
					<p class="more zhulihuxing-more" style="width:6.88rem!important; margin-left:.3rem;">
						<a>查看更多</a>
						<a>收起</a>
					</p>
				</div>
			</div>
		</c:if>
		<c:if test="${fyType==0 }">
			<div class="w_mian_sl zaishou_loudong" style="display:none; height: auto; margin-top:.2rem!important; margin-bottom:0!important; height:6rem; overflow:hidden; border-radius: 0;">
				<div class="w_mian_sl_xumu">
					在售楼栋
				</div>
				<div class="w_mian_sl_huxing" style="/* box-shadow: rgb(236, 236, 236) 0px 3px 5px; */ padding-bottom:.52rem;">
				    <a class="w_lianjie" unitId="ZH_H5_C02015">
					    <img class="w_loucen">
				    </a>
				</div>
	
			</div>
		</c:if>
	<article class="jun-newconnector-mian">
		<article class="jun-newconnector-modu">
			<h1 class="title h1tomap">
				<span class="fl">位置及周边</span>
				<!-- <i class="toMpas fl"></i> -->
			</h1>
			<section class="mian map-parent">
				
				<div class="daohang">
					<i class="daohang-icon fl"></i>
					<span class="fl">导航</span>
				</div>
				<a href="javascript:void(0)" unitId="ZH_H5_C02016" id="jun-newconnector-map-a"><div id="jun-newconnector-map" class="jun-newconnector-map"><div class="loupanmingziss"><span></span><i></i></i></div></div></a>
				<!-- <ul class="jun-map-list clear" id="jun-newconnector-map-alist">
					<li class="fl"><a href="" unitId="ZH_H5_C02017" style="color:#222323"><i class="icon-jun-bg icon-jun-bus fl"></i><span id="bus">0</span><b style="font-weight: 100;">个交通站点</b></a></li>
					<li class="fl"><a href="" unitId="ZH_H5_C02018" style="color:#222323"><i class="icon-jun-bg icon-jun-school fl"></i><span id="school">0</span>个教育机构</a></li>
					<li class="fl"><a href="" unitId="ZH_H5_C02019" style="color:#222323"><i class="icon-jun-bg icon-jun-hospai fl"></i><span id="yin">0</span>个医疗机构</a></li>
					<li class="fl"><a href="" unitId="ZH_H5_C02020" style="color:#222323"><i class="icon-jun-bg icon-jun-shop fl"></i><span id="sops">0</span>个购物场所</a></li>
				</ul> -->
				<div class="map_results">
					<div class="zhoubianjiaotong hide_com">
						<div class="zhoubianjiaotong-title">周边交通</div>
						<div class="zhoubianjiaotong-content" style="width:100%;word-wrap:break-word;word-break:break-all; font-size: .32rem;line-height: .5rem; margin-top: -.09rem;"></div>
					</div>
					<div class="zhoubianyiyuan hide_com">
						<div class="zhoubianyiyuan-title">周边医院</div>
						<div class="zhoubianyiyuan-content" style=" font-size: .32rem;line-height: .5rem;margin-top: -.09rem;"></div>
					</div>
					<div class="zhoubianshangye hide_com">
						<div class="zhoubianshangye-title">周边商业</div>
						<div class="zhoubianshangye-content"></div>
					</div>
				</div>
			</section>
		</article>
		<div style="height:.24rem;background:url('${backStatic}/images/icon_banners.png')#f5f5f5 no-repeat center;background-size:cover;"></div>
		<!-- <article class="jun-newconnector-modu dbox">
			<h1 class="title">公共交通</h1>
			<section class="mian">
				<ul class="jun-bus-info cont" id="jun-bus-info">
					<li>
						<h1 class="clear">海上世界南<span class="fr">64米</span></h1>
						<p>
							<span>19路,</span><span>22路,</span><span>79路,</span><span>80路</span>
						</p>
					</li>
					<li>
						<h1>海上世界南<span class="fr">64米</span></h1>
						<p>
							<span>19路,</span><span>22路,</span><span>79路,</span><span>80路</span>
						</p>
					</li>
					<li>
						<h1>海上世界南<span class="fr">64米</span></h1>
						<p>
							<span>19路,</span><span>22路,</span><span>79路,</span><span>80路</span>
						</p>
					</li>
				</ul>
				 <p class="more">
					<a unitId="ZH_H5_C02021"><i class="jun-arrow-bottom"></i>查看更多</a>
					<a><i class="jun-arrow-up"></i>收起</a>
				</p> 
			</section>
		</article> -->
		<c:if test="${fyType==1 }">
			<div class="w_mian_sl" style="height:180px;">
					<div class="w_mian_sl_xumu" style="border-bottom:1px solid #e6e6e6;line-height:37px;font-size:.32rem;">
						房贷参考
					</div>
					<div class="w_mian_sl_huxing" style="height:172px;position:absolute;">
					    <div class="fl" id="container12" style="width: 240px; height: 175px;margin-left:14px;">
				
						</div>
						<div class="cankaoyugong fl">
							<p style="font-size:12px;color:#999;">参考月供</p>
							<p style="font-size:12px;"><span class="yuegongsss">1000</span><span>元/月</span></p>
						</div>
						<div style="width:170px;height:120px;position:absolute;top:35px;right:-99px;overflow:hidden;">
							<h2 style="font-weight:600;text-align:left;">总价:<span class="zongjiass">0</span>万</h2>
							<div style="color:#999;text-align:left;">贷款年限:30年</div>
							<div style="color:#999;text-align:left;"><i style="display:inline-block;width:10px;height:10px;background:#50aff3;"></i>首付:<span class="shoufuss">0</span>万 (三成)</div>
							<div style="color:#999;text-align:left;"><i style="display:inline-block;width:10px;height:10px;background:#ffd25b;"></i>商贷:<span class="daikuanss">0</span>万</div>
							<div style="color:#999;text-align:left;"><i style="display:inline-block;width:10px;height:10px;background:#38d4df;"></i>利息:<span class="lixiss">0</span>万</div>
						</div>
					</div>
		
			</div>
			
		</c:if>
		<article class="jun-newconnector-modu" id="containers_mian" style="display:none;">
			<h1 class="title" style="width:100%;margin:0 auto; border-bottom:1px solid #e9e9e9;">成交价走势</h1>
			<section class="mian" unitId="ZH_H5_C02022" id="containers" style="height:220px;">
			</section>
		</article>
		<!-- <article class="jun-newconnector-modu" id="container_mian">
			<h1 class="title">成交量走势</h1>
			<section class="mian" unitId="ZH_H5_C02023" id="container" style="height:220px;">
			</section>
		</article> -->
		
		<!-- 更多房源 -->
		<%-- <div style="height:.24rem;background:#f5f5f5;background:url(${backStatic}/images/icon_banners.png) no-repeat center"></div> --%>
		<div class="more_houses" style="display:none;">
			<div class="more_houses_title">
				<h2 class="fl">更多房源</h2>
				<div style="float:right;"></div>
			</div>
			<ul class="more_houses_content">
				<!-- <li>
					<div class="more_houses_content_div1 fl"></div>
					<div class="more_houses_content_div2 fl" style="font-size:16px;">嘉诚新航域 3房2厅 500万</div>
				</li>
				<li></li>
				<li></li> -->
			</ul>
		</div>
		
		
		
		<!-- <article class="jun-newconnector-modu" id="nos_recommend" style="display:none;">
			<h1 class="title">我的推荐</h1>
			<article class="recommend" >
			<article id="new-recommend">
				<a href="more_house.html?agentId=251&user_type=1"><section class="clear jun-recommend-list">
					<li class="fl jun-li-one">
						<img src="./images/demo.jpg">
						<span class="jun-diya">20万抵40万</span>
					</li>
					<li class="fl jun-li-two">
						<p class="jun-city">深圳</p>
						<p class="jun-area">南山</p>
						<p class="jun-area">80~124㎡</p>
						<p class="jun-bit"><span class="bg-16bd98">普通住宅</span><span class="bg-1b53c7">精装修</span><span class="bg-00ccff">车位充足</span></p>
					</li>
					<li class="fl jun-money">
						12000元/㎡
					</li>
				</section></a>
				<a href="more_house.html?agentId=251&user_type=1"><section class="clear jun-recommend-list">
					<li class="fl jun-li-one">
						<img src="./images/demo.jpg">
						<span class="jun-diya">20万抵40万</span>
					</li>
					<li class="fl jun-li-two">
						<p class="jun-city">深圳</p>
						<p class="jun-area">南山</p>
						<p class="jun-area">80~124㎡</p>
						<p class="jun-bit"><span class="bg-16bd98">普通住宅</span><span class="bg-1b53c7">精装修</span><span class="bg-00ccff">车位充足</span></p>
					</li>
					<li class="fl jun-money">
						12000元/㎡
					</li>
				</section></a>
				</article>
				<a href="" unitId="ZH_H5_C02024" id="move-recommend-a"><p class="jun-tx-center jun-click-arrow"><i class="jun-arrow-bottom"></i><span>查看更多</span></p></a>
			</article>
		</article>
		<p class="jun-bottom-tx clear" style="display:none;">
			<span>阅读 <i id="jun-browse-num">0</i></span><span class="jun-dianzan" action="like" unitId="ZH_H5_C02029"><i class="jun-icon-zan"></i><i id="jun-like-num">1</i></span><a href="" unitId="ZH_H5_C02025" id="pinlun" style="color:#777a77"><span><i class="jun-icon-liu"></i><i id="new-pl">0</i></span></a>
			<a href="" unitId="ZH_H5_C02026" id="jun-tousu" style="color:#777a77"><em class="fr">投诉</em></a>
		</p>
		<div class="position-relative jun-tx-center">
			<p class="jun-title-border"></p>
			<span class="jun-title-liu">精彩留言</span>
		</div> -->
		<div class="jincailiuyans">
			<div class="jincailiuyans-titles">
				<div class="fl jincailiuyans-left">
					<h2 style="font-size:16px;font-weight:600;color:#333;" class="fl">精彩留言</h2>
					<span class="fl" style="margin-top:-1px;">(</span>
					<span class="fl mcount">0</span>
					<span class="fl" style="margin-top:-1px;">)</span>
				</div>
				<div class="jincailiuyans-right xieliuyan">
					<i></i>
					<span>写留言</span>
				</div>
			</div>
			<div id="messageContent">
				<div class="MCList">
					
				</div>	
			</div>
			<div class="jincailiuyans-more" style="display:none;">查看更多</div>
		</div>
		
		
		
		<article id="jun-liu-mian">
			<!--<section class="jun-liu-list">
				<header class="clear">中原大侠<span class="fr">2016-02-03</span></header>
				<p>房子不错,地段不错,很不错</p>
					<ul>
						<li>
							<header class="clear">中原大侠<span class="fr">2016-02-03</span></header>
							<p>房子不错,地段不错,很不错</p>
						</li>
					</ul>
			</section>
			<section class="jun-liu-list">
				<header class="clear">中原大侠<span class="fr">2016-02-03</span></header>
				<p>房子不错,地段不错,很不错</p>
			</section>
			<section class="jun-liu-list">
				<header class="clear">中原大侠<span class="fr">2016-02-03</span></header>
				<p>房子不错,地段不错,很不错</p>
			</section>-->
		</article>
	</article>
	<article class="details-img" style="display:none">
		<article id="details-img" class="clear">
		</article>
	</article>
	<div id="jun-bgo" style="background:#000;position:fixed;width:100%;height:100%;top:0px;z-index:666;display:none">
	</div>
	<!-- <div id="jun-2" style="position:fixed;z-index:666;top:0.25rem;left:0.25rem;z-index:668;display:none"><img src="./images/go-back1.png" style="width:60%" ></div> -->
	<div id="jun-1" class="clear" style="display:none;padding:0px 0.2rem;position:fixed;z-index:666;bottom:0px;left:0px;z-index:668;width:100%;height:0.8rem;font-size:0.3rem;color:#fff;background:#000;opacity:0.7;line-height:0.8rem;">
		<p  class="fl" id="hx_tx">户型图</p><p class="fr"><span id="ju-nums" style="color:#00ccff">1</span>/<span id="jun-cns">18</span></p>
	</div>
	<!-- <div class="jun-height-44"></div> -->
	<div style="height:.24rem;background:#f5f5f5;background:url(${backStatic}/images/icon_banners.png) no-repeat center"></div>
	<div class="lijilianxi">
		<div class="touxiang fl">
			<c:if test="${headType == 1}">
				<div style="background:url(${fns:getCosAccessHost()}${headImg}) no-repeat center;background-size:cover;"></div>
			</c:if>
			<c:if test="${headType == 0}">
				<div style="background:url(${headImg}) no-repeat center;background-size:cover;"></div>
			</c:if>
		</div>
		<div class="chuangjianren fl">
			<div class="chuangjianren-name" style="margin-bottom: .02rem;"><span style="font-size:.32rem;font-weight:600;color:#333;margin-right: .1rem;">${nickName}</span><i>[</i><i>创建人</i><i>]</i></div>
			<div class="chuangjianren-phone" style="color:#f64f52;font-size:16px;">${phone}</div>
		</div>
		<div class="dianhua fl">
			<a href="tel:${phone}"></a>
		</div>
	</div>
	
	
	<footer class="jun-newconnector-footer clear" style="z-index:1000;">
		 <c:if test="${fyType==0 }">
			<li class="jun-newconnector-footer-two fl baozhengjins" style="font-size:14px;width:2rem;height:100%;">
				<!-- <i unitId="ZH_H5_C02009" class="jun-icon-share"></i> -->
				<i class="icon_zhifus" style="display:block;width:1rem;height:1rem;background:url('${backStatic}/images/icon_zhifus.png') no-repeat center;background-size:contain;margin:0 auto;"></i>
				<!-- <span style="color:#90a4ae;">支付保证金</span> -->
			</li>
		</c:if> 
		<li class="jun-newconnector-footer-one fl yuyue" style="background:#ff9f17;font-size:.34rem;color:#fff;width:3.51rem; padding-top: .2rem;-webkit-flex: 1;margin-right:.165rem;">
			<!-- <i unitId="ZH_H5_C02008" class="jun-icon-shou"></i> -->
			预约看房
		</li>
		<!-- <li class="jun-newconnector-footer-three fl"><a href="sms:13000000000" unitId="ZH_H5_C02010" id="duxn" style="color:#00ccff"><i class="jun-icon-p "></i>发送短信</a></li> -->
		<li class="jun-newconnector-footer-last fl" style="width:3.51rem;-webkit-flex: 1;margin-right:.165rem;">
			<a href="tel:${phone}" unitId="ZH_H5_C02011" id="dinah" style="color:#fff;display:block;height:100%;">
				<!-- <i class="jun-icon-d "></i> -->电话咨询
			</a>
		</li>
	</footer>
	
	
	<!-- <div class="w_fenxiang" style="display: none;">
		<img src="./images/w_shoucang.png" />
	</div>
	
	<div class="w_shoucang" style="display: none;">
		<img src="./images/w_zhuanfa .png" />
	</div>
	
	<div class="w_hongtan" style="display: none;">
		<div class="w_hongtan_bac">
			<img src="./images/w_hongb.png" />
			<p>查看更多红包火热来袭，尽情期待</p>
			<a class="w_hong_queding">确&nbsp;&nbsp;定 </a>
		</div>
	</div>
	
	<div style="display:none;">
		<div class="at-alert zhaofang-app">
			<span>查看更多专属服务，请下载安装找房APP</span>
			<a class="close" href="http://a.app.qq.com/o/simple.jsp?pkgname=com.xingongchang.zhaofang">确定</a>
		</div>
	</div> -->
	<div class="pswp" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="pswp__bg"></div>
		<div class="pswp__scroll-wrap">
			<div class="pswp__container">
				<div class="pswp__item"></div>
				<div class="pswp__item"></div>
				<div class="pswp__item"></div>
			</div>
			<div class="pswp__ui pswp__ui--hidden">
				<div class="pswp__top-bar">
					<div class="pswp__counter"></div>
					<button class="pswp__button pswp__button--close" id="clcllca"></button>
					<div class="pswp__preloader">
						<div class="pswp__preloader__icn">
							<div class="pswp__preloader__cut">
								<div class="pswp__preloader__donut"></div>
							</div>
						</div>
					</div>
				</div>
				<div class="pswp__share-modal pswp__share-modal--hidden pswp__single-tap">
					<div class="pswp__share-tooltip"></div> 
				</div>
				<div class="pswp__caption">
					<div class="pswp__caption__center"></div>
				</div>
			</div>
		</div>
	</div>
	<script>
		var siteRoot="${siteRoot}";
		var objectId="${objectId}";
		var cdn_url = '${fns:getCosAccessHost()}';
		var backStatic='${backStatic}';
		var linkerName = "${linkerName}";
		var itemssa_img =[];
		var fyType="${fyType}";
	</script>
	
	<script type="text/javascript" src="${backStatic}/js/commonn.js"></script>
	<script type="text/javascript"  src="${backStatic}/js/Details.js"></script>
	<script src="${backStatic}/js/photoswipe.min.js"></script> 
	<script src="${backStatic}/js/photoswipe-ui-default.min.js"></script>
	<script type="text/javascript" src="${backStatic}/js/doT.min.js"></script>
	<script type="text/javascript" src="${backStatic}/js/echarts-all.js"></script>
	<script type="text/template" id="templete">
	 {{for(var i=0;i < it.length;i++){}}	
			<div class="jincailiuyans-contents">
				<div class="tops">
					<div class="tops-profile fl" style="background:url({{=it[i].headImgUrl}}) no-repeat center;background-size:cover;"></div>
					<div class="tops-content fl">
						<div>{{=it[i].nickname}}</div>
						<div class="times">{{=it[i].createTime}}</div>
					</div>
				</div>
				<div class="bottoms">
					{{=it[i].content}}
				</div>
			</div>
     {{}}}
	</script>
	<script>
	
	$('body').on('click','.w_honb',function(){
		$('.w_hongtan').css('display','block')
	})
	
	$('.w_hong_queding').click(function(){
		$('.w_hongtan').css('display','none')
	})
	$('body').on('click','.yuyue',function(){
		window.location.href = "./toAddAppointmentData?linkerId="+ objectId + "&linkerName=" + linkerName +"&targetMobile=${phone}";
	})
    $(".more_houses_title").click(function(){
		window.location.href = "./toMoreFy?fyType=${fyType}";
    })
	$(".jincailiuyans-more").click(function(){
		window.location.href = "./toMessage?linkerId=" + objectId;
    })
  //			保证金跳转
	$(".baozhengjins").click(function(){
		window.location.href="./toXiaoQ?linkerId="+ objectId;
	});
    $(".xieliuyan").click(function(){
		window.location.href = "./toAddMessage?linkerId=" + objectId;
    })
    $(".w_jisuanqi").click(function(){
		window.location.href = "./toNewcalculator?linkerName=" + linkerName;
    })
	$('.jun-newconnector-footer-one').click(function(){
		$('.w_fenxiang').css('display','block')
	})
	
	$(".daohang").click(function(){
		window:location.href='./toNavigation?linkerId='+ objectId;
	});
	
	$('.w_fenxiang').click(function(){
		$('.w_fenxiang').css('display','none')
	})
	
	$('.jun-newconnector-footer-two').click(function(){
		$('.w_shoucang').css('display','block')
	})
	
	$('.w_shoucang').click(function(){
		$('.w_shoucang').css('display','none')
	})
	
	$("body").on("click",".w_header_bg",function(){
		window.history.go(-1);
	})
	
	/* $("#newf_video").attr("src",'${backStatic}/js/re.mp4'); */
	
	var searchService,maparrs=[];
	//map init
	$('#duxn').attr('href','sms:'+getUrlParam('mobile')+'')
	//$('#dinah').attr('href','tel:'+getUrlParam('mobile')+'')
	
	//推荐列表
	var LUrl=window.location.href.split("#")[window.location.href.split("#").length-1];
	
	$('#pinlun').attr('href','pinglun.html?hid='+getUrlParam('hid')+'&user_id='+getUrlParam('user_id')+'&activityId='+getUrlParam('activityId')+'&user_type='+getUrlParam('user_type')+'&hbTypeForConnection='+getUrlParam('hbTypeForConnection')+'&loupan_name='+getUrlParam('loupan_name')+'&cover_path='+getUrlParam('cover_path')+'&xiangmu_intro='+getUrlParam('xiangmu_intro')+'#'+LUrl)
	$('#jun-tousu').attr('href','complain_from.html?hid='+getUrlParam('hid')+'&user_id='+getUrlParam('user_id')+'&activityId='+getUrlParam('activityId')+'&user_type='+getUrlParam('user_type')+'&hbTypeForConnection='+getUrlParam('hbTypeForConnection')+'&loupan_name='+getUrlParam('loupan_name')+'&cover_path='+getUrlParam('cover_path')+'&xiangmu_intro='+getUrlParam('xiangmu_intro')+'#'+LUrl)
	
	if("${fyType}"=="1"){
		$(".junjia").css("color","#333");
	}
	
	//图表
	function echarsmap(xAxis,series,mapliao,maptxa,mapx){
			var title = {
			  text: ''   
		   };
		   var subtitle = {
			  text: mapliao
		   };
		   var  xAxis= xAxis;
		   var series= series;
		  /*  var xAxis = {
			  categories: ['2016-02', '2016-03', '2016-04', '2016-05', '2016-06', '2016-07']
		   }; */
		   var yAxis = {
			  tickInterval: 10000,
			  title: {
				 text: '元/㎡'
			  },
			  min:0,
			  labels:{
				 formatter : function () {
					 /* console.log(this.value) */
					/* if (this.value >= 1000) {
						strVal = (this.value/1000)+'k'
						return strVal;
					}else{
						return this.value
					}  */
					 return this.value
				}
			},
			  plotLines: [{
				 value: 0,
				 width: 1,
				 color: '#808080'
			  }]
		   };   
	
		   var tooltip = {
			  valueSuffix: mapx
		   }
		   //var series =  [
			  //{
				// name: '成交数量',
				// data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5]
			 // }
		  // ];
		  var plotOptions = {
				series:{
					events:{
					legendItemClick:function(e) {
						return false; // 直接 return false 即可禁用图例点击事件
						}
					}
				}
		  }
		   var json = {};
		   json.title = title;
		   json.subtitle = subtitle;
		   json.xAxis = xAxis;
		   json.yAxis = yAxis;
		   json.tooltip = tooltip;
		   json.series = series;
		   json.plotOptions = plotOptions;
			$(maptxa).highcharts(json);
	}
	function map_init(laa,lo,addname,add) {
		var myLatlng = new qq.maps.LatLng(laa,lo);
		var myOptions = {
			zoom: 16,
			center: myLatlng,
			disableDefaultUI: true,
			draggable:false
		};
		var map = new qq.maps.Map(document.getElementById("jun-newconnector-map"), myOptions);
		var anchorsa = new qq.maps.Point(16, 42),
	        size = new qq.maps.Size(32, 42),
	        origin = new qq.maps.Point(0, 0),
	        icon = new qq.maps.MarkerImage("${backStatic}/images/mo.png",size, origin,anchorsa);
		var marker = new qq.maps.Marker({
			/* icon: icon, */
			position: myLatlng,
			map: map
		});
		
		/* var label = new qq.maps.Label({
	        position: myLatlng,
	        map: map,
	        content:addname
	    }); */
		
		var infoWin = new qq.maps.InfoWindow({
	        map: map
	    });
		
		qq.maps.event.addListener(marker,"click",function(e){
			/* label.setMap(map); */
			infoWin.open();
			infoWin.setContent('<div style="font-size:14px"><p>名称:'+addname+'</p><p>地址:'+add+'</p></div>');
			infoWin.setPosition(myLatlng);
		}) 
	
	
		//调用Poi检索类
		searchService = new qq.maps.SearchService({
			complete : function(results){
				var pois = results.detail.pois;
				console.info(pois);
				switch(true){
					case pois[0].category.indexOf('公交')>=0:
						$('#bus').html(pois.length)
						break;
					case pois[0].category.indexOf('教育')>=0:
	
						$('#school').html(pois.length)
						break;
					case pois[0].category.indexOf('医疗')>=0:
						$('#yin').html(pois.length)
						break;
					case pois[0].category.indexOf('购物')>=0:
						$('#sops').html(pois.length)
						break;
				}
				return pois.length
			}
		});	
	}
	
	function searchKeyword(search,la,lo) {
	    var keyword = search;
	    region = new qq.maps.LatLng(la,lo);
	    searchService.setPageCapacity(2e3);
	    searchService.searchNearBy(keyword, region, 3000);//根据中心点坐标、半径和关键字进行周边检索。
	}
	
	
	/* 更多房源 */
	
	
	
	$.ajax({
		url:siteRoot+'/api/object/getMoreLinkers',
		data:{
			fyType:'${fyType}',
			currPage:1,
			pageSize:3
		},
		success:function(data){
			if(data.page.items){
				$(".more_houses").show();
				/* if(data.page.items.length==1){
					$(".more_houses").css("height","1.4rem");
					$(".more_houses_content>li:last-child").css("border-bottom","none");
				}else if(data.page.items.length==2){
					//$(".more_houses").css("height","3.2rem");
					$(".more_houses_content>li:last-child").css("border-bottom","none");
				} */
				data.page.items.map(function(value,index){
					$(".more_houses_content").append('<li><div class="more_houses_content_div1 fl"><img style="width:100%;height:100%;" src="'+cdn_url+value.coverImgUrl+'"></div><div class="more_houses_content_div2 fl" style="font-size:16px;">'+value.name+'</div></li>');
				});
				$('.more_houses').after('<div style="height:.24rem;background:url(${backStatic}/images/icon_banners.png)#f5f5f5 no-repeat center"></div>')
			}
			/*更多房源点击  */
			$(".more_houses_content").on("click","li",function(){
				var _index=$(this).index();
				window.location.href="${fns:getHost()}/linker/"+data.page.items[_index].linkerId;
			});
		}
	});
	
	function loadMessage(){
		$.ajax({
			url:'./getLinkerMessageList?linkerId='+objectId,
			data:{
				currPage:1,
				pageSize:3
			},
			success:function(data){
				var template=$("#templete").html();
				$(".mcount").html(data.page.totalCount);
				if(data.page.totalCount == 0){
					$(".jincailiuyans-more").hide();
					$('.jincailiuyans>.jincailiuyans-titles').css('border-bottom','none');
				}
				if(data.page.totalCount > 3){
					$(".jincailiuyans-more").removeAttr("style");
				}
				$("#messageContent").append(doT.template(template)(data.page.items));
			}
		});
	}
	
	loadMessage();
	
	$("#box2").on("click","li",function(){
		console.log(54545454);
		var cao =$(this).index()
	 	var openPhotoSwipe = function() {
	    var pswpElement = document.querySelectorAll('.pswp')[0];
	    var options = {
	        history: false,
	        focus: false,
			closeOnScroll:false,
			closeOnVerticalDrag:false,
			
	        showAnimationDuration: 0,
	        hideAnimationDuration: 0
	    };
		options.index = cao;
		console.log(pswpElement);
		console.log(PhotoSwipeUI_Default);
		console.log(itemssa_img);
		console.log(options);
	    var gallery = new PhotoSwipe( pswpElement, PhotoSwipeUI_Default, itemssa_img, options);
	    gallery.init();
	    
	};
	 openPhotoSwipe()
	 gallery.close();
	})
	 
	 
	$('.click-salo').click(function(){
		if($(this).attr('data-ifs') == 1){
			$('#jun-bus-info').css('height','1.2rem')
			$(this).attr('data-ifs',0)
			$(this).find('span').html('收起')
		}else{		
			$('#jun-bus-info').css('height','auto')
			$(this).attr('data-ifs',1)
			$(this).find('span').html('查看更多')
		}
	})
	
	
		function omnusick(){
		var audio=$("#audio")[0];
			if($('#play').hasClass('act')){
				$('#play').removeClass('act');
				$('#play').find('img').attr({'src':'./images/w_music.png'})
				audio.pause();
			}else{
				$('#play').addClass('act');
				$('#play').find('img').attr({'src':'./images/w_musics.png'})
				audio.play();
			}
	}
		
		$(".dbox").each(function(){
			var cont = $(this).find(".cont"),
				more = $(this).find(".more a");
			var obj= this;
			$(this).on("click", ".more", function(){
				cont.toggleClass("show");
				more.toggle();
				
			})
		})
		
		/* 房源特色单独定义的more */
		/* $(".more-fangyuan-tese").click(function(){
			$("#box").toggleClass("show");
			$(this).find("a").toggle(); 
		}) */
		
		
		/* $(".dbox").on('click','.more',function(){
			var cont = $(this).find(".cont"),
			more = $(this).find(".more a");
			console.log(cont);
			console.log(more);
			cont.removeClass("show");
			//cont.toggleClass("show");
			more.toggle();
		}) */
		// $('.new-fs').click(function(){
		// 	if($(this).attr('data-ifs')==1){
		// 		$('#box').css('height','auto')
		// 		$(this).attr('data-ifs','0')
		// 		$(this).html('<i class="jun-arrow-up"></i>收起');
		// 	}else{
		// 		$('#box').css({'height':'150px'})
		// 		$(this).attr('data-ifs','1')
		// 		$(this).html('<i class="jun-arrow-bottom"></i>查看更多');
		// 	}
		// })

		// $('.new-fss').click(function(){
		// 	if($(this).attr('data-ifs')==1){
		// 		$('#box1').css('height','auto')
		// 		$(this).attr('data-ifs','0')
		// 		$(this).html('<i class="jun-arrow-up"></i>收起');
		// 	}else{
		// 		$('#box1').css({'height':'150px'})
		// 		$(this).attr('data-ifs','1')
		// 		$(this).html('<i class="jun-arrow-bottom"></i>查看更多');
		// 	}
		// })

		// $('#new-fsst').click(function(){
		// 	if($(this).attr('data-ifs')==1){
		// 		$('#box2').css({'height':'150px','overflow-y':'hidden'})
		// 		$(this).attr('data-ifs','0')
		// 		$(this).html('<i class="jun-arrow-bottom"></i>查看更多');
			
			
		// 	}else{
		// 		$('#box2').css('height','auto')
		// 		$(this).attr('data-ifs','1')
		// 		$(this).html('<i class="jun-arrow-up"></i>收起');
		// 	}
		// })
		$('.jun-dianzan').one('click',function(){
})
		// $('.click_share_a').click(function(){
		// 	count_load('click',loadTime,'ZH_H5_PS0002',$(this).attr('data-unitid'),$(this).attr('url'))
		// })
		// $('.jun-dianzan').one('click',function(){
		// 	load_ad('like',loadTime,'ZH_H5_PS0002',$(this).attr('data-unitid'))
		// });
		// $('.click_share_no_a').one('click',function(){
		// 	load_ad('like',loadTime,'ZH_H5_PS0002',$(this).attr('data-unitid'))
		// });
		
	</script>
	
</body>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
</html>