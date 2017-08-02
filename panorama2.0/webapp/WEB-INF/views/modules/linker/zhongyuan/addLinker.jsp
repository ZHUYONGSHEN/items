<!Doctype html><%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><html>
<!Doctype html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>添加连接器</title>
    <link href="leftMenu.css" rel="stylesheet"/>
    <link href="bootstrap.min.css" rel="stylesheet"/>
    <style>
        .main{
            width:1200px;
            margin:0 auto;
        }
        .right-content{
            width:1005px;
            float:right;
        }
        .cont-tit{
            margin-top:20px;
            width:140px;
            height:32px;
            line-height:32px;
            font-size:18px;
            text-align: center;
            background: #cccccc;
        }
        .info-form{
            border:1px solid #ddd;
            padding-top:20px;
            padding-bottom:30px;
        }
        .red-item {
            color: #f80040;
            margin-right: 3px;
        }
        .info-form .control-label{
            white-space: pre;
            width:130px;;
        }
        .info-form .controls{
            margin-left:140px;;
        }
    </style>
</head>
<body>
    <div class="main">
        <div class="left-menu">
            <li class="menu-item current-menu">连接器列表管理</li>
            <li class="menu-item">添加连接器</li>
        </div>
        <div class="right-content">
            <div class="cont-tit">
                添加连接器
            </div>
            <form class="form-horizontal info-form">
                <div class="control-group">
                    <label class="control-label" for="title"><span class="red-item">*</span>项目标题：</label>
                    <div class="controls">
                        <input type="text" id="title" >
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" ><span class="red-item">*</span>所在片区：</label>
                    <div class="controls">
                        <select>
                            <option>广东</option>
                            <option>广西</option>
                        </select>
                        <select>
                            <option>深圳</option>
                            <option>广州</option>
                        </select>
                        <select>
                            <option>南山</option>
                            <option>福田</option>
                        </select>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" ><span class="red-item">*</span>房        型：</label>
                    <div class="controls">
                        <select>
                            <option>一室</option>
                            <option>两室</option>
                            <option>三室</option>
                        </select>
                        <select>
                            <option>深圳</option>
                            <option>广州</option>
                        </select>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" ><span class="red-item">*</span>总        价：</label>
                    <div class="controls">
                        <select>
                            <option>两百万以下</option>
                            <option>200万-300万</option>
                        </select>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="up"><span class="red-item">*</span>单        价：</label>
                    <div class="controls">
                        <input type="text"  id="up" >&nbsp;&nbsp;元/m²
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="size"><span class="red-item">*</span>面        积：</label>
                    <div class="controls">
                        <input type="text"  id="size">&nbsp;&nbsp;m²
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="orientation"><span class="red-item">*</span>朝        向：</label>
                    <div class="controls">
                        <input type="text"  id="orientation">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="name"><span class="red-item">*</span>小区名称：</label>
                    <div class="controls">
                        <input type="text" id="name">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="website"><span class="red-item">*</span>链        接：</label>
                    <div class="controls">
                        <input type="text"  id="website">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" ><span class="red-item">*</span>封  面  图：</label>
                    <div class="controls">
                        <input type="text"  >
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="inputEmail">项目简介：</label>
                    <div class="controls">
                        <textarea></textarea>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="inputEmail">房源标签：</label>
                    <div class="controls">
                        <label class="checkbox inline">
                            <input type="checkbox" id="inlineCheckbox1" value=""> 满二/满五
                        </label>
                        <label class="checkbox inline">
                            <input type="checkbox" id="inlineCheckbox2" value=""> 红本在手
                        </label>
                        <label class="checkbox inline">
                            <input type="checkbox" id="inlineCheckbox3" value=""> 学位房
                        </label>
                        <label class="checkbox inline">
                            <input type="checkbox" id="" value=""> 地铁
                        </label>
                        <label class="checkbox inline">
                            <input type="checkbox" value=""> 南北通透
                        </label>
                        <label class="checkbox inline">
                            <input type="checkbox" value="">户型方正
                        </label>
                        <label class="checkbox inline">
                            <input type="checkbox" value="">随时看房
                        </label>
                        <label class="checkbox inline">
                            <input type="checkbox" value="">唯一住房
                        </label>
                        <label class="checkbox inline">
                            <input type="checkbox" value="">品牌开发商
                        </label>
                        <label class="checkbox inline">
                            <input type="checkbox" value="">刚需
                        </label>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="inputEmail">排        序：</label>
                    <div class="controls">
                        <input type="text"  placeholder="">
                    </div>
                </div>
                <div class="control-group">
                    <div class="controls">
                        <button type="submit" class="btn btn-primary">添加</button>
                        <button type="button" class="btn">取消</button>
                     </div>

                </div>
            </form>
        </div>
    </div>

</body>
</html>