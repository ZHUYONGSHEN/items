itemssa_img =[]
/*****连接器新房详情*******/

var LUrl=hi720url+'/Linker/Connector/xinfanglianjieqi.html?hid='+getUrlParam('hid')+'&agentId='+getUrlParam('user_id')
		+'&activityId='+getUrlParam('activityId')+'&user_type='+getUrlParam('user_type')+'&hbTypeForConnection='+getUrlParam('hbTypeForConnection')
		+'&guanggao=1#loupan_name='+getUrlParam('loupan_name')+'&cover_path='+getUrlParam('cover_path')+'&xiangmu_intro='+getUrlParam('xiangmu_intro');
$(function(){
	/*var url= baseurl + "/Linker/H5/newDetail";*/
	$.ajax({
		url:siteRoot+"/api/object/getFyInfoData",
		data:{
			linkerId:objectId
		},
		success: function(data){
			console.log(data);
			var $hea=$('.w_header_img');
			var heas='';
			heas +='<a class="bigp"  unitId="ZH_H5_C02001"><img src="'+cdn_url+data.fyInfo.headImgUrl+'" /></a>'
			/*if(decodeURIComponent(getUrlParam('audio')) !='null' && decodeURIComponent(getUrlParam('audio')) !=""){
				heas +='<a class="w_music" id="play" onclick="omnusick()"><img src="./images/w_music.png" /><audio controls="controls" id="audio"   loop="loop"  style="display:none" ><source  src="'
				+decodeURIComponent(getUrlParam('audio'))+'" type="audio/mpeg"  /></audio></a>'
			}else{
				
			}*/
			heas +='<div class="w_header_bg"><a class="w_kanfang" style="margin:0 auto;display:block;" href="javascript:window.history.back()"></a></div>'
			$hea.html(heas);
//			视频地址
			console.log(data.fyInfo.fyVideo+"opopopp")
			if(data.fyInfo.fyVideo){
				
				$("#n_video_demo").show();
				$("#newf_video").attr("src",cdn_url+data.fyInfo.fyVideo);
				$("#newf_video").attr("preload","auto");
				$('#n_video_demo').after('<div style="height:.24rem;background:url(${backStatic}/images/icon_banners.png)#f5f5f5 no-repeat center"></div>');
			}
//			去掉留言最后一个子元素的下边框
		
			$("#messageContent").children("div:last-child").css("border-bottom","0");
			
//			在售楼栋
			if(data.fyInfo.saleBuildingImage){
				$(".zaishou_loudong").show();
				$(".saleBuildingImage").attr("src",cdn_url+data.fyInfo.saleBuildingImage);
			}
			
//			地图
			map_init(data.fyInfo.latitude,data.fyInfo.longitude,data.fyInfo.name,data.fyInfo.detailAddress);
			
//			走势图
			
			if(data.turnoverTrends&&data.turnoverTrends.length>0){
				$("#containers_mian").show();
				var xAxies=[],yAxies=[];
				data.turnoverTrends.map(function(value,index){
					xAxies[index]=value.ttime.substr(2);
					yAxies[index]=value.taveragePrice;
				});
				var categories={
						categories:xAxies
					};
				var seriess=[{
					 name: '成交均价',
					 data: yAxies
					}];
				echarsmap(categories,seriess,'成交均价','#containers','元/㎡')
				$(".highcharts-yaxis-title").attr({"x":"60","y":"26"});
				$(".highcharts-yaxis-title").removeAttr("transform");
				$('#containers_mian').after('<div style="height:.24rem;background:#f5f5f5;background:url(${backStatic}/images/icon_banners.png) no-repeat center"></div>');
			}
			
//			跳转到腾讯地图周边服务页面
			/*$('#jun-newconnector-map-a').attr('href','./toHouserMsap?search=0&la='+data.fyInfo.latitude+'&lo='+data.fyInfo.longitude+'&add='+data.fyInfo.detailAddress+'&name='+data.fyInfo.name+'')*/
			
			$('#jun-newconnector-map-a').click(function(){
				window.location.href='./toHouserMsap?search=0&la='+data.fyInfo.latitude+'&lo='+data.fyInfo.longitude+'&add='+data.fyInfo.detailAddress+'&name='+data.fyInfo.name+'';
			})
			
			/*$('.h1tomap').click(function(){
				window.location.href='./toHouserMsap?search=0&la='+data.fyInfo.latitude+'&lo='+data.fyInfo.longitude+'&add='+data.fyInfo.detailAddress+'&name='+data.fyInfo.name+'';
			})*/
			
//			新房楼盘介绍
			if(data.fyInfo.name){
				$(".loupan_name>span").html(data.fyInfo.name);
			}
			
//			楼盘名字在地图上显示
			$(".loupanmingziss span").html(data.fyInfo.name);
			
			if(data.fyInfo.projectTag){
				var arr=data.fyInfo.projectTag.split(',');
				var background=["#e8f3fd","#ffeee9","#ebf9f0","#ffeee9","#ffeee9"];
				var fontcolor=["#32a6f2","#fd7a40","#5bcf88","#32a6f2","#fd7a40"];
				arr.map(function(val,i){
					if(val=='0'){
						arr[i]='教育地产';
					}else if(val=='1'){
						arr[i]='品牌开发商';
					}else if(val=='2'){
						arr[i]='豪华社区';
					}else if(val=='3'){
						arr[i]='低总价';
					}else if(val=='4'){
						arr[i]='刚需';
					}else if(val=='5'){
						arr[i]='投资地产';
					}else if(val=='6'){
						arr[i]='小户型';
					}else if(val=='7'){
						arr[i]='不限购';
					}else if(val=='8'){
						arr[i]='生态宜居';
					}else if(val=='9'){
						arr[i]='海景/水景地产';
					}else if(val=='10'){
						arr[i]='现房';
					}else if(val=='11'){
						arr[i]='旅游地产';
					}else if(val=='12'){
						arr[i]='花园洋房';
					}else if(val=='13'){
						arr[i]='地铁沿线';
					}
					$(".w_mian_ch_main_biaoqian").append('<span style="background:'+background[i]+';color:'+fontcolor[i]+'">'+arr[i]+'</span>');
				})
				
			}
			
//			判断二手房年代是否为空
			if(!data.fyInfo.years){
				$(".zhuangxiuzhuangkuang-parent").find("span").eq(0).css("margin-left","0");
			}
//			判断二手房朝向
//			if(data.fyInfo.orientations){
//				$(".louceng-parent").find("span").eq(0).css("margin-left","0");
//			}
			
			if(data.fyInfo.averagePrice){
				$(".junjia").html(data.fyInfo.averagePrice+"/㎡");
			}
			
			if(data.fyInfo.openTime||data.fyInfo.expectedOthers){
				$(".kaipanshijian").removeClass("hide_com");
				if(data.fyInfo.openTime){
					$(".kaipans-parent").removeClass("hide_com");
					$(".kaipans").html(data.fyInfo.openTime);
				}
				if(data.fyInfo.expectedOthers){
					$(".yujijiaofang-parent").removeClass("hide_com");
					$(".yujijiaofang").html(data.fyInfo.expectedOthers);
				}
			}
			
			if(data.fyInfo.detailAddress){
				$(".w_mian_jj_neirong_right01-parent").removeClass("hide_com");
				$(".w_mian_jj_neirong_right01").html(data.fyInfo.detailAddress);
			}
			if(data.fyInfo.decorateStatus != null){
				$(".zhuangxiuzhuangkuang-parent").removeClass("hide_com");
				$(".niandai-zhuangxiu").css("display","-webkit-flex");
				var decorateStatus;
				if(data.fyInfo.decorateStatus=='0'){
					decorateStatus='精装修';
				}else if(data.fyInfo.decorateStatus=='1'){
					decorateStatus='毛坯';
				}else if(data.fyInfo.decorateStatus=='2'){
					decorateStatus='简单装修';
				}else if(data.fyInfo.decorateStatus=='3'){
					decorateStatus='毛装修';
				}else if(data.fyInfo.decorateStatus=='4'){
					decorateStatus='公共部分精装修';
				}
				$(".zhuangxiuzhuangkuang").html(decorateStatus);
			}
			
			if(data.fyInfo.coverArea){
				$(".zhandimianjis-parent").removeClass("hide_com");
				$(".zhandimianjis").html(data.fyInfo.coverArea+"㎡");
			}
			
			if(data.fyInfo.buildArea){
				$(".jianzhumianji-parent").removeClass("hide_com");
				$(".jianzhumianji").html(data.fyInfo.buildArea+"㎡");
			}
			
			if(data.fyInfo.householdNum){
				$(".zhuhushus-parent").removeClass("hide_com");
				$(".zhuhushus").html(data.fyInfo.householdNum+"户");
			}
			
			if(data.fyInfo.plotRate){
				$(".rongjilv-parent").removeClass("hide_com");
				$(".rongjilv").html(data.fyInfo.plotRate+"%");
			}
			
			if(data.fyInfo.greenRate){
				$(".lvhualv-parent").removeClass("hide_com");
				$(".lvhualv").html(data.fyInfo.greenRate+"%");
			}
			
			if(data.fyInfo.carNum){
				$(".tingchewei-parent").removeClass("hide_com");
				$(".tingchewei").html(data.fyInfo.carNum+'个');
			}
			
			if(data.fyInfo.propertyYears){
				$(".chanquannianxian-parent").removeClass("hide_com");
				$(".chanquannianxian").html(data.fyInfo.propertyYears+'年');
			}
			
			if(data.fyInfo.developer){
				$(".kaifashang-parent").removeClass("hide_com");
				$(".kaifashang").html(data.fyInfo.developer);
			}
			
			if(data.fyInfo.houseUse){
				var houseUse = data.fyInfo.houseUse.split(",");
				var arr=[];
				$.each(houseUse, function(i, n){
					  if(n == 0){
						  arr[i] = "普通住宅"; 
					  }if(n == 1){
						  arr[i] = "商住两用"; 
					  }if(n == 2){
						  arr[i] = "商品房"; 
					  }if(n == 3){
						  arr[i] = "建筑综合体"; 
					  }if(n == 4){
						  arr[i] = "商铺"; 
					  }if(n == 5){
						  arr[i] = "写字楼"; 
					  }if(n == 6){
						  arr[i] = "别墅"; 
					  }if(n == 7){
						  arr[i] = "公寓"; 
					  }if(n == 8){
						  arr[i] = "洋房"; 
					  }if(n == 9){
						  arr[i] = "酒店"; 
					  }
				});
				$(".wuyeleixing-parent").removeClass("hide_com");
				$(".wuyeleixing").html(arr.join(","));
			}
			
			if(data.fyInfo.management){
				$(".wuyegongsi-parent").removeClass("hide_com");
				$(".wuyegongsi").html(data.fyInfo.management);
			}
			if(data.fyInfo.managementPrice){
				$(".wuyefei-parent").removeClass("hide_com");
				$(".wuyefei").html(data.fyInfo.managementPrice+"元/㎡.月");
			}
			
			if(data.fyInfo.business){
				$(".zhoubianshangye").removeClass("hide_com");
				$(".zhoubianshangye-content").html(data.fyInfo.business);
			}
			
			if(data.fyInfo.hospital){
				$(".zhoubianyiyuan").removeClass("hide_com");
				$(".zhoubianyiyuan-content").html(data.fyInfo.hospital);
			}
			
			if(fyType=='1'){
				$(".jun-newconnector-footer-one").width("3.4rem");
				$(".jun-newconnector-footer-one").css("margin-left","0.3rem")
				$(".jun-newconnector-footer-last").width("3.4rem");
			}
			
			if(data.fyInfo.traffic){
				$(".zhoubianjiaotong").removeClass("hide_com");
				$(".zhoubianjiaotong-content").html(data.fyInfo.traffic);
			}
//			主力户型
			if(data.fyAttachInfos.length>1){
				$("#w_mian_js").show();
				data.fyAttachInfos.map(function(value,i){
					$('#box2').append('<li><span class="ellipsis" style="display:inline-block;width:5.8rem;height:100%;line-height:53px;">'+value.householdDesc+'</span></li>');
					itemssa_img[i]={};
					itemssa_img[i].src=cdn_url+value.imgUrl;
					itemssa_img[i].w=800;
					itemssa_img[i].h=1142;
				})
				$('#w_mian_js').after('<div style="height:.24rem;background:url(${backStatic}/images/icon_banners.png)#f5f5f5 no-repeat center"></div>');
				
				if(data.fyAttachInfos.length<=3){
					$(".zhulihuxing-more").css("display","none");
					if(data.fyAttachInfos.length==1){
						$("#box2").css({"minHeight":"53px","margin-bottom":"0px"});
					}else if(data.fyAttachInfos.length==2){
						$("#box2").css({"minHeight":"106px","margin-bottom":"0px"});
					}else if(data.fyAttachInfos.length==3){
						$("#box2").css({"minHeight":"159px","margin-bottom":"0px"});
					}
				}
			}
			if(data.fyInfo.saleBuildingImage){
				$(".w_mian_sl").show();
				$(".w_loucen").attr("src",cdn_url+data.fyInfo.saleBuildingImage);
				$('.zaishou_loudong').after('<div style="height:.24rem;background:url(${backStatic}/images/icon_banners.png)#f5f5f5 no-repeat center"></div>');
			}
			
			
			if(fyType == 1){
				$(".totalMoney").html(data.fyInfo.totalMoney+"万");
				$(".fangxing").html(data.fyInfo.room+"房" + data.fyInfo.hall + "厅");
				$(".mianji").html(data.fyInfo.buildArea+"㎡");
				$(".ershoufangjieshao-content").find(".junjia").html(data.fyInfo.averagePrice+"/㎡");
				if(data.fyInfo.orientations){
					$(".chaoxaing-louceng").css("display","-webkit-flex");
					$(".chaoxiang-parent").show();
					$(".ershoufangjieshao-content").find(".chaoxiang").html(data.fyInfo.orientations);
				}
				
				if(data.fyInfo.currFloor!=null&&data.fyInfo.totalFloor){
					$(".chaoxaing-louceng").css("display","-webkit-flex");
					$(".louceng-parent").show();
					var curr = "";
					if(data.fyInfo.currFloor == 0){
						curr = "低楼层";
					}else if(data.fyInfo.currFloor == 1){
						curr = "中低楼层";
					}else if(data.fyInfo.currFloor == 2){
						curr = "中间楼层";
					}else if(data.fyInfo.currFloor == 3){
						curr = "中高楼层";
					}else if(data.fyInfo.currFloor == 4){
						curr = "高楼层";
					}else{
						curr = "低楼层";
					}
					$(".ershoufangjieshao-content").find(".louceng").html(curr+"/" + data.fyInfo.totalFloor);
				}
				
				if(data.fyInfo.years){
					$(".niandai-zhuangxiu").css("display","-webkit-flex");
					$(".niandai-parent").show();
					$(".ershoufangjieshao-content").find(".niandai").html(data.fyInfo.years);
				}
				
				if(data.fyInfo.district){
					$(".quyu-parent").show();
					$(".ershoufangjieshao-content").find(".quyu").html(data.fyInfo.district);
				}
				if(data.fyInfo.detailAddress){
					$(".xiaoqu-parent").show();
					$(".ershoufangjieshao-content").find(".xiaoqu").html(data.fyInfo.detailAddress);
				}
				
				if(data.fyInfo.fyItem){
					$(".fyts").show();
					$("#box").html(data.fyInfo.fyItem);
					if($("#box").html().length<=200){
						$(".fyts-more").hide();
						$(".fyts").css("margin-bottom","0px")
						$("#box").css("min-height","20px")
					}else{
						$(".fyts").css("margin-bottom","40px")
					}
				}
			
				var shoufu = data.fyInfo.totalMoney*10000* 0.3;
				var shangdai = data.fyInfo.totalMoney*10000*0.7;
				//某种利率
				var active = 5.6 * 10 / 12 * 0.001;
				var t1=Math.pow(1+active,360);
				var t2=t1-1;
				var tmp=t1/t2;
				//月利率
				var monthratio = active * tmp;
				 
				//每月支付本息
				var monthBack=shangdai*monthratio;
				//累计还款总额
				var totalBack=monthBack*360;
				//累计支付利息
				var totalInterest=totalBack-shangdai;
				//每月应付利息
				var monthInterest=totalInterest/360;
				var chart = echarts.init(document.getElementById('container12'));
				var yugongs;
				$(".zongjiass").html(data.fyInfo.totalMoney);
				$(".shoufuss").html((data.fyInfo.totalMoney*0.3).toFixed(2));
				$(".daikuanss").html((data.fyInfo.totalMoney*0.7).toFixed(2));
				$(".lixiss").html((totalInterest/10000).toFixed(2));
				if(monthBack > 10000){
					$(".yuegongsss").html((monthBack/10000).toFixed(2));
					$(".yuegongsss").next().html("万/月");
				}else{
					$(".yuegongsss").html(monthBack.toFixed(0));
				}
				
				
				var option = {
							title : {
				                /*text: "参考月供",
				                subtext: monthBack.toFixed(0)+'元/月',*/
				                x:'80',
				                y:'center',
			                    //正标题样式
			                    textStyle: {
			                          fontSize:16,
			                          fontWeight:80,
			                          color:'#999',
			                    },
			                  //副标题样式
			                    subtextStyle: {
			                          fontSize:15,
			                          color:"#333",  
			                     },
				        },
					    /*legend: {
					        orient: 'vertical',
					        x: 'right',
					        y: 'center', 
					        data:['首付','商贷','利息'],
					        selectedMode:false,
					        formatter: function(name){
					        	if(name == '首付'){
					        		return name+":"+data.fyInfo.totalMoney*0.3+'万(三成)';
					        	}else if(name == '商贷'){
					        		return name+":"+data.fyInfo.totalMoney*0.7+'万';
					        	}else if(name == '利息'){
					        		return name+":"+(totalInterest/10000).toFixed(2)+"万";
					        	}
					        	
					        }
					    },*/
					    color:['#50aff3', '#ffd25b','#38d4df']  ,
					    series: [
					        {
					            type:'pie',
					            radius: ['40%', '70%'],
					            avoidLabelOverlap: false,
					            center:['30%', '50%'],
					            itemStyle:{ 
					                normal:{ 
					                      label:{ 
					                        show: false, 
					                        formatter: '{b} : {c} ({d}%)' 
					                      }, 
					                      labelLine :{show:false} 
					                    } 
					                } ,
					            data:[
					                {value:shoufu, name:'首付'},
					                {value:shangdai, name:'商贷'},
					                {value:totalInterest, name:'利息'}
					            ],
					        }
					    ]
					};
				chart.setOption(option);
			}
			
			
		}
	})
})

