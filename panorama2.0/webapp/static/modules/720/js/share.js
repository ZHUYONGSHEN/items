
$(function(){
	if(!getUrlParam('house_detail')){
	var url = baseurl+"/Linker/H5/getNewCustomShare";
	var tracker = window.tracker || function(){
		console.log('tracker undefined');
	};
	$.ajax({
		type:'GET',
		url:url,
		dataType:'json',
		data: 
		{
			hid:getUrlParam('hid'),
		},
		success: function(data){
			var data=data.data;
			var name;
			var uesrtypeid
			if(data.custom_title!=""){
				name=data.custom_title
			}else{
				name=getUrlParam('loupan_name')
			}
			var shareimg;
			if(data.cover_path!=""){
				shareimg=data.cover_path
			}else{
				shareimg=getUrlParam('cover_path')
			}
			var share_details;
			if(data.custom_content!=""){
				share_details=data.custom_content
			}else{
				share_details=getUrlParam('xiangmu_intro')
			}
			if(getUrlParam('user_id')){
					uesrtypeid = '&agentId='+getUrlParam('user_id')
			}else{
				uesrtypeid = '&agentId='+getUrlParam('agentId')
			}
			//var LUrl=window.location.href.split("#")[window.location.href.split("#").length-1];
			var LUrl=hi720url+'/Linker/Connector/xinfanglianjieqi.html?hid='+getUrlParam('hid')+uesrtypeid+'&activityId='+getUrlParam('activityId')+'&user_type='+getUrlParam('user_type')+'&hbTypeForConnection='+getUrlParam('hbTypeForConnection')
			+'&guanggao=1#loupan_name='+getUrlParam('loupan_name')+'&cover_path='+getUrlParam('cover_path')+'&xiangmu_intro='+getUrlParam('xiangmu_intro');
				var linkUrl=window.location.href.split('#')[0];
				var linkUrl2=encodeURIComponent(linkUrl);
			    var accessUrl=hongbaourl+"/two/hbOutShare/shareCommon.sys?"+share_port+"&url="+linkUrl2;
			    $.ajax({
			        type : "get",
			        async : true,
			        dataType : "jsonp",
			        jsonp : "callbackparam",
			        url : accessUrl,
			        success : function(json) {
			             wx.config({
			            debug: false, //开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
			            appId: share_id, // 必填，公众号的唯一标识
			            timestamp:json.data.timestamp, // 必填，生成签名的时间戳
			            nonceStr:json.data.nonceStr, // 必填，生成签名的随机串
			            signature:json.data.signature,// 必填，签名，见附录1
			            jsApiList:['onMenuShareTimeline','onMenuShareAppMessage','onMenuShareTimeline','onMenuShareQQ','onMenuShareWeibo' ,'onMenuShareQZone' ] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
			            });
			            wx.ready(function(){
			            wx.onMenuShareAppMessage({
			                title:name, // 分享标题
			                desc:share_details, // 分享描述
			                link:LUrl, // 分享链接
							imgUrl: shareimg, // 分享图标
			                type: 'link', // 分享类型,music、video或link，不填默认为link
			                dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
			                success: function () { 
			                    // 用户确认分享后执行的回调函数
			                    tracker({ action: 'sharefriends' });
			                },
			                cancel: function () { 
			                    // 用户取消分享后执行的回调函数
			                }
			            });
			            wx.onMenuShareTimeline({
			                title:name, // 分享标题
			                link: LUrl, // 分享链接
			                imgUrl:shareimg, // 分享图标
			                success: function () { 
			                    // 用户确认分享后执行的回调函数
			                    tracker({ action: 'sharegroup' });
			                },
			                cancel: function () { 
			                    // 用户取消分享后执行的回调函数
			                }
			            });
						
						
						wx.onMenuShareQQ({
							title: name, // 分享标题
							desc:share_details, // 分享描述
							link: LUrl, // 分享链接
							imgUrl: shareimg, // 分享图标
							success: function () { 
							   // 用户确认分享后执行的回调函数
							   tracker({ action: 'sharefriends' });
							},
							cancel: function () { 
							   // 用户取消分享后执行的回调函数
							}
						});
						
						wx.onMenuShareWeibo({
							title: name, // 分享标题
							desc:share_details, // 分享描述
							link: LUrl, // 分享链接
							imgUrl: shareimg, // 分享图标
							success: function () { 
							   // 用户确认分享后执行的回调函数
							},
							cancel: function () { 
								// 用户取消分享后执行的回调函数
							}
						});
						
						wx.onMenuShareQZone({
							title: name, // 分享标题
							desc:share_details, // 分享描述
							link: LUrl, // 分享链接
							imgUrl: shareimg, // 分享图标
							success: function () { 
							   // 用户确认分享后执行的回调函数
							},
							cancel: function () { 
								// 用户取消分享后执行的回调函数
							}
						});	
						
						
						
			
			            }); 
			        },
			        error : function(XHR, textStatus, errorThrown) {
			            console.log(22222222)
			        }
			    });
		},
		error:function (data,err){    
			console.log(err);
		}
	})
	}else{
		var LUrl=hi720url+'/Linker/Connector/ershoufanglianjieqi.html?hid='+getUrlParam('hid')+'&user_id='+getUrlParam('user_id')+'&activityId='+getUrlParam('activityId')+'&user_type='+getUrlParam('user_type')+'&hbTypeForConnection='+getUrlParam('hbTypeForConnection')
			+'#loupan_name='+getUrlParam('loupan_name')+'&cover_path='+getUrlParam('cover_path')+'&xiangmu_intro='+getUrlParam('xiangmu_intro');
	
	
	var linkUrl=window.location.href.split('#')[0];
	var linkUrl2=encodeURIComponent(linkUrl);
	var accessUrl=hongbaourl+"/two/hbOutShare/shareCommon.sys?"+share_port+"&url="+linkUrl2;
	$.ajax({
		type : "get",
		async : true,
		dataType : "jsonp",
		jsonp : "callbackparam",
		url : accessUrl,
		success : function(json) {
			wx.config({
				debug: false, //开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
				appId: share_id, // 必填，公众号的唯一标识
				timestamp:json.data.timestamp, // 必填，生成签名的时间戳
				nonceStr:json.data.nonceStr, // 必填，生成签名的随机串
				signature:json.data.signature,// 必填，签名，见附录1
				jsApiList:['onMenuShareTimeline','onMenuShareAppMessage','onMenuShareTimeline','onMenuShareQQ','onMenuShareWeibo' ,'onMenuShareQZone' ] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
			});
			wx.ready(function(){
				wx.onMenuShareAppMessage({
					title:getUrlParam('loupan_name'), // 分享标题
					desc:getUrlParam('xiangmu_intro'), // 分享描述
					link:LUrl, // 分享链接
					imgUrl: getUrlParam('cover_path'), // 分享图标
					type: 'link', // 分享类型,music、video或link，不填默认为link
					dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
					success: function () { 
						// 用户确认分享后执行的回调函数
					    tracker({ action: 'sharefriends' });
					},
					cancel: function () { 
						// 用户取消分享后执行的回调函数
					}
				});
				wx.onMenuShareTimeline({
					title:getUrlParam('loupan_name'), // 分享标题
					link: LUrl, // 分享链接
					imgUrl:getUrlParam('cover_path'), // 分享图标
					success: function () { 
						// 用户确认分享后执行的回调函数
						tracker({ action: 'sharegroup' });
					},
					cancel: function () { 
						// 用户取消分享后执行的回调函数
					}
				});
				
				
				wx.onMenuShareQQ({
					title: getUrlParam('loupan_name'), // 分享标题
					desc:getUrlParam('xiangmu_intro'), // 分享描述
					link: LUrl, // 分享链接
					imgUrl: getUrlParam('cover_path'), // 分享图标
					success: function () { 
					   // 用户确认分享后执行的回调函数
					   tracker({ action: 'sharefriends' });
					},
					cancel: function () { 
					   // 用户取消分享后执行的回调函数
					}
				});
				
				wx.onMenuShareWeibo({
					title: getUrlParam('loupan_name'), // 分享标题
					desc:getUrlParam('xiangmu_intro'), // 分享描述
					link: LUrl, // 分享链接
					imgUrl: getUrlParam('cover_path'), // 分享图标
					success: function () { 
					   // 用户确认分享后执行的回调函数
					},
					cancel: function () { 
						// 用户取消分享后执行的回调函数
					}
				});
				
				wx.onMenuShareQZone({
					title: getUrlParam('loupan_name'), // 分享标题
					desc:getUrlParam('xiangmu_intro'), // 分享描述
					link: LUrl, // 分享链接
					imgUrl: getUrlParam('cover_path'), // 分享图标
					success: function () { 
					   // 用户确认分享后执行的回调函数
					},
					cancel: function () { 
						// 用户取消分享后执行的回调函数
					}
				});				
			}); 
		},
		error : function(XHR, textStatus, errorThrown) {
			console.log(22222222)
		}
	});
	}
})
