var const_page_size = 10;
var SLCProjManage = {
    projs: null,
    currProj: null,
    deleteScene: function(project, sceneId) {
        for (var i = 0; i < project.scenes.length; i++) {
            if (project.scenes[i].id == sceneId) {
                project.scenes.splice(i, 1);
                break;
            }
        }
    },
    deleteProject: function(project) {
        for (var i = 0; i < SLCProjManage.projs.length; i++) {
            if (SLCProjManage.projs[i] == project) {
                SLCProjManage.projs.splice(i, 1);
                break;
            }
        }
        if (SLCProjManage.currProj == project)
            SLCProjManage.currProj = null;
    },
    getProjectById: function(id) {
        for (var i = 0; i < SLCProjManage.projs.length; i++) {
            if (SLCProjManage.projs[i].id == id) {
                return SLCProjManage.projs[i];
            }
        }
    },
    panoCatelog: null,
    materialList: null
};


function jumpUrlAnchor() {
    var anchor = window.location.hash;
    if (anchor == '#material') {
        onMaterialEditClick();
        return;
    } else if (anchor.indexOf("#project=") === 0) {
        var projectId = anchor.substring(("#project=").length);
        for (var i = 0; i < SLCProjManage.projs.length; i++) {
            if (SLCProjManage.projs[i].id == projectId)
                editProject(SLCProjManage.projs[i]);
        }
        return;
    } else if (anchor.indexOf("#editscene=") === 0) {
        var projectId = anchor.substring(("#editscene=").length);
        for (var i = 0; i < SLCProjManage.projs.length; i++) {
            if (SLCProjManage.projs[i].id == projectId) {
                editProject(SLCProjManage.projs[i]);
                $('.nav-tabs a[href="#prj-edit-scene-tab"]').tab('show');
            }
        }
        return;
    }

    $("#project-list-page").show();
}

$(document).ready(function() {
    checkAuth(true);
    var ret = SLCUtility.callFunc("POST", "getProjectList", {});
    if (!ret || ret.err_code !== 0) {
        return;
    }
    ret = SLCUtility.callFunc("POST", "getProject", {
        ids: ret.data,
        decode_res: false
    });
    if (!ret || ret.err_code !== 0) {
        return;
    }
    SLCProjManage.projs = ret.data.projects;

    var language = {
        "lengthMenu": "每页 _MENU_ 条记录",
        "zeroRecords": "没有找到记录",
        "sEmptyTable": "没有找到记录",
        "info": "第 _PAGE_ 页 ( 总共 _PAGES_ 页 )",
        "infoEmpty": "无记录",
        "infoFiltered": "(从 _MAX_ 条记录过滤)",
        "sSearch": "查找：",
        "oPaginate": {
            "sPrevious": "上一页",
            "sNext": "下一页"
        },
    };
    $('#project-tbl-id').dataTable({
        "fnRowCallback": function(row, aData, iDisplayIndex, iDisplayIndexFull) {
            $('td:eq(0)', row).html(iDisplayIndexFull + 1);
        },
        "language": language,
        "dom": '<"left"f>t<ip<"right page-leght-selector"l>>'
    });
    projectTblAddRows(SLCProjManage.projs);

    $('#scene-tbl-id').dataTable({
        "fnRowCallback": function(row, aData, iDisplayIndex, iDisplayIndexFull) {
            $('td:eq(0)', row).html(iDisplayIndexFull + 1);
        },
        "language": language,
        "dom": '<"left"f>t<ip<"right page-leght-selector"l>>'
    });

    $("#select_music").click(function(e) {
        e.preventDefault();
        $("#music").trigger('click');
    });
    $("#music").change(function(e) {
        var files = $('#music')[0].files;
        if (files.length > 0 && $("#music_title").val() === "") {
            $("#music_title").val(files[0].name);
        }
    });
    $("#select_material_sound").click(function(e) {
        var callback = function(selectFile) {
            if (!selectFile)
                return;
            $('#music').val("");
            var audio = $("#bg_music_player").get(0);
            var fs = ResourceMgr.find(selectFile.oorigin_id);
            if (!fs || fs.length == 0)
                return;
            audio.src = fs[0].access_url;
            $("#music_title").val(fs[0].name);
            $('#music')[0].res_id = selectFile.oorigin_id;
        };
        SelectMaterial($("#music-setting-mdl")[0], callback, "audio");
    });

    jumpUrlAnchor();
});

var showPage = (function() {
    var pageVec = ["project-list-page", "overall-view-setting",
        "project-setting-page", "scene-manage-page", "project-eidt-page",
        "material-edit-page"
    ];
    return function(id) {
        for (var i = 0; i < pageVec.length; i++) {
            if (pageVec[i] === id) {
                $("#" + pageVec[i]).show();
            } else {
                $("#" + pageVec[i]).hide();
            }
        }
    };
})();

function getProjectUrl(project) {
    var host = location.protocol+"//"+location.hostname;
    if(location.port!=""&&location.port!=80){
        host+=":"+location.port;
    }
    var url = host+ "/pano/" + project.id;
    return url;
}

function dateFromSecond(second) {
    var date = new Date();
    date.setTime(second * 1000);
    return date;
}

function projectTblAddRows(projects) {
    var tbl = $("#project-tbl-id").DataTable();
    for (var i = projects.length - 1; i >= 0; i--) {
        var project = projects[i];
        var date_string = dateFromSecond(project.create_time).toLocaleString();
        var url = getProjectUrl(project);
        var tr = $("<tr>" + "<td></td>" + '<td><div class="prj-tbl-url-div"><a target="_blank" class="prj-tbl-url-a text-center-hiddin-more" href="' + url +
            '">' +
            url + "</a><button class='btn btn-default copy-btn'>复制</button></div></td>" +
            '<td class="text-center-hiddin-more"><p class="project-title text-center-hiddin-more">' + project.title +
            '</p></td><td class="text-center-hiddin-more"><p class="text-center-hiddin-more project-desc">' +
            project.desc + "</p></td><td>" + date_string + "</td>" +
            "<td>" + project.like + "</td>" +
            '<td class="tbl-operation-d-cls"> \
            <span onclick="onEditProject(event)">编辑</span> \
            <span onclick="onDeleteProject(event)">删除</span> \
            </td></tr>');
        //<span onclick="onShareClick(event)">分享</span> \
        tr.data('id', project.id);
        tr.find('.copy-btn')
            .click(function() {
                var text = $(this).siblings('a').attr("href");
                var $temp = $("<input>")
                $("body").append($temp);
                $temp.val(text).select();
                document.execCommand("copy");
                $temp.remove();
            });
        tbl.rows.add(tr);
    }

    tbl.draw(false);
}

function getScenePreviewUrl(pid, nIdx) {
    var url = "http://" + window.location.hostname + "/pano/" + pid + "#id=" + nIdx;
    return url;
}

function sceneTblAddRows(scenes) {
    if (scenes instanceof Array) {
        var tbl = $("#scene-tbl-id").DataTable();
        for (var i = 0; i < scenes.length; i++) {
            var scene = scenes[i];
            var res_id = scene.thumbnail_res_id;
            if (res_id == '') {
                res_id = scene.res_id;
            }

            var fs = ResourceMgr.find(res_id);
            var strImg = '<img crossorigin="Anonymous" src="' + (fs && fs.length > 0 ? fs[0].access_url : '') + '" style="width: 80px; height: 60px;">';
            var date_string = dateFromSecond(scene.create_time).toLocaleString();
            var tr = $("<tr>" + "<td></td>" + "<td class='text-center-hiddin-more scene-title'>" + scene.name + "</td><td class='text-center-hiddin-more scene-desc'>" + scene.desc + "</td><td>" + strImg + "</td>" + "<td></td>" + "<td>" + date_string + "</td>" +
                '<td class="tbl-operation-d-cls"> \
            <span onclick="onDeleteScene(event);">删除场景</span> \
            <span onclick="onEditSceneBaseInfo(this)">编辑</span> \
            <span onclick="onScenePointEidt(this);">点位管理</span> \
            <span onclick="onScenePreview(this);">预览</span> \
            <span onclick="onBottomLogoEdit(this)">底部logo</span> \
            </td></tr>');
            tr.data('id', scene.id);
            tbl.rows.add(tr);
            updateSceneBottomLogo(scene, tr.get(0));
        }
        tbl.draw(false);
    } else {
        console.log("error params in sceneTblAddRows");
    }
}

function onCreateProjectClick(event) {
    $("#project-setting-mdl").modal({});
    $("#project-name-psm").val("");
    $("#project-description-psm").val("");
}

function updateProjectResource() {
    var ids = [];
    var resources = {};
    collectUnKnowRes(SLCProjManage.currProj, ids, resources);
    if (ids.length !== 0) {
        $.ajax({
            type: "post",
            data: JSON.stringify(ids),
            url: "/api/getFiles",
            success: function(res) {
                var fs = res.data;
                validResMap(fs, resources);
            },
            async: false
        });
    }
    ResourceMgr.update(resources);
}

function onDeleteProject(event) {
    if (confirm("您确定要删除此项目?") === false) {
        return;
    }
    var tr = $(event.target).closest('tr');
    var id = tr.data('id');
    $.ajax({
        type: "post",
        data: JSON.stringify({
            id: id
        }),
        url: "/api/deleteProject",
        success: function(res) {
            if (res.err_code === 0) {
                var tbl = $("#project-tbl-id").DataTable();
                tbl.row(tr).remove().draw(false);
                var project = SLCProjManage.getProjectById(id);
                SLCProjManage.deleteProject(project);
            }

        }
    });
}

$('#prj-edit-prj-generater .copy-btn').click(function() {
    $('#prj-generater-url').select();
    document.execCommand("copy");
});

function initPrjGenerater() {
    var url = getProjectUrl(SLCProjManage.currProj);

    $('#project-qrcode').empty();
    $('#project-qrcode').qrcode(url);
    $('#prj-generater-url').val(url);
    $('#prj-generater-url').attr('readonly', true);
}

function initPrjBaseInfo() {
    $('#prj-base-info-name').val(SLCProjManage.currProj.title).attr('readonly', true);
    $('#prj-base-info-desc').val(SLCProjManage.currProj.desc).attr('readonly', true);
    $('#edit-prj-base-info-btn').attr('disabled', false);
    $('#save-prj-base-info-btn').attr('disabled', true);
    $("#likeCheck").prop("checked", SLCProjManage.currProj.enable_like);
    $("#overlookCheck").prop("checked", SLCProjManage.currProj.enable_overlook);
    $("#autorotationCheck").prop("checked", SLCProjManage.currProj.enable_autorotation);
    $("#autoDeviceOrientationCheck").prop("checked", SLCProjManage.currProj.enable_orientation);
    $("#vrCheck").prop("checked", SLCProjManage.currProj.enable_vr);
}

function onEditProject(event) {
    var e = event || window.event;
    var currRow = e.target.parentNode.parentNode._DT_RowIndex;
    var idx = SLCProjManage.projs.length - 1 - currRow;
    var projInfo = SLCProjManage.projs[idx];
    editProject(projInfo);
}

function editProject(projInfo) {
    $("#scene-tbl-id").DataTable().clear().draw();
    $('#project-qrcode').empty();

    var ret = SLCUtility.callFunc("POST", "getProject", {
        ids: [projInfo.id],
        decode_res: false
    });
    if (!ret || ret.err_code !== 0) {
        return;
    }

    SLCProjManage.currProj = ret.data.projects[0];
    updateProjectInlist(SLCProjManage.currProj);

    var project = $("#tbl-scene-data-id");
    project.data('id', projInfo.id);

    updateProjectResource();
    var scenes = projInfo.scenes;
    if (scenes)
        sceneTblAddRows(scenes);

    showPage("project-eidt-page");
    $('a[href="#prj-scene-group-tab"]').trigger('shown.bs.tab')
    initPrjGenerater();
    initPrjBaseInfo();
}

function onCreateSceneClick() {
    $("#scene-setting-mdl").modal({
        keyboard: false,
        backdrop: false
    });

    $("#scene-setting-mdl").removeClass("lengthen");
    $(".main-process", "#scene-setting-mdl").show();
    $(".select-process", "#scene-setting-mdl").hide();

    $("#scene-setting-mdl")[0].editScene = null;
    $("#scene-setting-mdl")[0].scene = null;
    $('#scene-name-psm').val(null);
    $('#scene-description-psm').val(null);
    $("#scene-setting-mdl .scene-img-area").empty();
    $("#select_scenen_img").val(null);
    $("#scene-setting-mdl .modal-header .modal-title").text("创建场景");
}

function onDeleteScene(event) {
    if (confirm("您确定要删除此场景?") === false) {
        return;
    }
    var tr = $(event.target).closest('tr');
    var id = tr.data('id');
    var project_id = $("#tbl-scene-data-id").data("id");
    $.ajax({
        type: "post",
        data: JSON.stringify({
            id: project_id,
            scenes: [{
                id: id
            }]
        }),
        url: "/api/deleteScene",
        success: function(res) {
            if (res.err_code === 0) {
                var tbl = $("#scene-tbl-id").DataTable();
                SLCProjManage.deleteScene(SLCProjManage.currProj, id);
                tbl.row(tr).remove().draw(false);
            }
        }
    });
}

function onSaveProjectSettingClick() {
    var name = $("#project-name-psm").val();
    var descript = $("#project-description-psm").val();
    if (!name || name.length === 0) {
        alert("项目名称不能为空!");
        return;
    }
    $('#project-setting-mdl').modal('hide');
    var jsonObj = {
        title: name,
        desc: descript
    };
    //var jsonObj = {Id: "test"};
    var res = SLCUtility.callFunc("POST", "addProject", jsonObj);
    if (res && res.err_code === 0) {
        var proObj = res.data;
        SLCProjManage.projs.push(proObj);
        var tbl = $("#project-tbl-id").DataTable();
        tbl.clear();
        projectTblAddRows(SLCProjManage.projs);
        editProject(proObj);
    } else {
        alert("标题已被使用!")
    }
}

function onBackToProjectManageClick() {
    showPage("project-list-page");
}

function onShareClick(event) {
    var e = event || window.event;
    var idx = e.target.parentNode.parentNode.rowIndex;
}

function onEidtScene() {
    showPage("scene-manage-page");
}

function onSelectFileClick(event) {
    var scene = $("#scene-setting-mdl")[0].editScene;
    if (scene && hasPoints(scene)) {
        alert("不能更改已有点位的全景图。");
    } else {
        var e = event || window.event;
        $(e.target).siblings("input").click();
    }
}


function onEditSceneBaseInfo(elem) {
    $("#scene-setting-mdl").modal({
        keyboard: false,
        backdrop: false
    });

    $("#scene-setting-mdl").removeClass("lengthen");
    $(".main-process", "#scene-setting-mdl").show();
    $(".select-process", "#scene-setting-mdl").hide();

    var id = $(elem).closest("tr").data('id');
    var nIdx = sceneIdxById(id, SLCProjManage.currProj.scenes);
    var scene = SLCProjManage.currProj.scenes[nIdx];
    $("#scene-setting-mdl")[0].editScene = scene;
    $("#scene-setting-mdl")[0].scene = scene.res_id;
    $('#scene-name-psm').val(scene.name);
    $('#scene-description-psm').val(scene.desc);
    $("#scene-setting-mdl .modal-header .modal-title").text("编辑场景");

    $("#scene-setting-mdl .scene-img-area").empty();
    var obj = $('<div class="img-cls"></div>');
    var img = new Image();
    var fs = ResourceMgr.find(scene.res_id);
    if (fs && fs.length) {
        fs = fs[0];
    }
    img.crossOrigin = "Anonymous";
    img.src = fs ? fs.access_url : "";
    obj.append(img);
    obj.append($('<div class="file-name" title="' + (fs ? fs.name : "") + '">' + (fs ? fs.name : "") + '</div>'));
    $("#scene-setting-mdl .scene-img-area").append(obj);
}

function onScenePreview(elem) {
    var id = $(elem).closest("tr").data('id');
    var url = getScenePreviewUrl(SLCProjManage.currProj.id, id);

    $('#scene-preview-mdl')[0].sceneUrl = url;
    $('#scene-preview-mdl').modal('show');
}

$('#scene-preview-mdl').on('hidden.bs.modal', function(e) {
    $('#scene-preview-frame').remove();
}).on('shown.bs.modal', function(e) {
    $('.scene-preview-container-2').append('<iframe id="scene-preview-frame" scrolling="no" src="' + $('#scene-preview-mdl')[0].sceneUrl + '"></iframe>');
});

function onScenePointEidt(elem) {
    $('#scene-point-edit-mdl').modal();
    var iframeWnd = document.getElementById("scene-frame").contentWindow;
    var id = $(elem).closest("tr").data('id');
    var nIdx = sceneIdxById(id, SLCProjManage.currProj.scenes);
    iframeWnd.postMessage({
        type: "editScene",
        nSceneIdx: nIdx
    }, "*");
}

function updateSceneBottomLogo(scene, tr) {
    var tbl = $("#scene-tbl-id").DataTable();
    var str;
    if (scene.bottom_logo && 　scene.bottom_logo.res_id) {
        var fs = ResourceMgr.find(scene.bottom_logo.res_id);
        str = '<img crossorigin="Anonymous" src="' + (fs && fs.length > 0 ? fs[0].access_url : '') + '" style="width: 80px; height: 60px">';
    } else {
        str = '<p>该场景无底部logo</p>';
    }
    tbl.cell($(tr).children('td').eq(4)).data(str);
}

function onBottomLogoEdit(elem) {
    var tr = $(elem).closest("tr");
    var id = tr.data('id');
    var nIdx = sceneIdxById(id, SLCProjManage.currProj.scenes);

    var remove = function() {
        var scene = SLCProjManage.currProj.scenes[nIdx];
        updateSceneBottomLogo(scene, tr);
        $('#logo-setting-mdl').unbind('hide.bs.modal', remove);
    };

    $('#logo-link-wrap').hide();
    showLogoSetting(SLCProjManage.currProj.scenes[nIdx].bottom_logo);
    $('#logo-setting-mdl').bind('hide.bs.modal', remove);
}

function hasPoints(scene) {
    return (scene.jump_tags && scene.jump_tags.length) ||
        (scene.hyperlink_tags && scene.hyperlink_tags.length) ||
        (scene.introduce_tags && scene.introduce_tags.length) ||
        (scene.picture_tags && scene.picture_tags.length) ||
        (scene.voice_tags && scene.voice_tags.length);
}

$('#scene-point-edit-mdl').on('hidden.bs.modal', function(e) {
    var iframeWnd = document.getElementById("scene-frame").contentWindow;
    iframeWnd.postMessage({
        type: "clearScene"
    }, "*");

    var ret = SLCUtility.callFunc("POST", "getProject", {
        ids: [SLCProjManage.currProj.id],
        decode_res: false
    });
    if (!ret || ret.err_code !== 0) {
        return;
    }
    SLCProjManage.currProj = ret.data.projects[0];
    updateProjectResource();
});

function onScenePointClose(elem) {
    $('#scene-point-edit-mdl').modal('hide');
}

function onImgFileChange(event) {
    var e = event || window.event;
    var fileObj = e.target.files[0];
    if (!fileObj) return;
    $("#scene-setting-mdl")[0].scene = fileObj;
    $("#scene-setting-mdl .scene-img-area").empty();
    var obj = $('<div class="img-cls"></div>');
    var img = new Image();
    img.src = URL.createObjectURL(fileObj);
    img.crossOrigin = 'Anonymous'
    obj.append(img);
    obj.append($('<div class="file-name" title="' + fileObj.name + '">' + fileObj.name + '</div>'));
    $("#scene-setting-mdl .scene-img-area").append(obj);
    fileMd5(fileObj);

    return;
}

function lrzImg(imgFile, onUploadSucced, jqueryElem, isPanoramaPic,onUploadCancel) {
    var triggerUpload = {
        "size": 0,
        "currtent": 0,
        "trigger": function() {
            triggerUpload.currtent += 1;
            if (triggerUpload.currtent == triggerUpload.size) {
                resum.upload();
            }
        },
    };
    var resum = createUploadFileObj(onUploadSucced, triggerUpload, jqueryElem, isPanoramaPic,onUploadCancel);
    var strName = imgFile.name;
    var pos = strName.lastIndexOf('.');
    var ext = strName.substr(pos);
    var url = URL.createObjectURL(imgFile);
    var img = new Image();
    img.onload = function() {
        var iH = 256;
        var iW = 512;
        if (iW > img.width) {
            resum.cancel();
            alert("上传的全景图像素太低(最小要求512*256)");
            $(".img-cls").remove();
            $(".spinner").remove();
            $('#select_scenen_img').val("");
            return;
        }

        triggerUpload.size += 1;
        imgFile.md5Identifier = imgFile.md5 + ".original.original" + ext;
        resum.addFile(imgFile);
        while (iW <= img.width) {
            triggerUpload.size += 1;
            (function resizeImg(w, h) {
                var canvas = document.createElement('canvas');
                canvas.width = w;
                canvas.height = h;

                var context = canvas.getContext('2d');
                context.drawImage(img, 0, 0, w, h);

                function onBlob(blob) {
                    var rst_file;
                    if (f > -1) {
                        rst_file = new File([blob], imgFile.name, {
                            type: imgFile.type
                        });
                    } else {
                        rst_file = blob;
                        blob.name = imgFile.name;
                    }

                    var size_ext = "." + w.toString() + "." + h.toString();
                    rst_file.md5Identifier = imgFile.md5 + size_ext + ext;
                    resum.addFile(rst_file);
                }
                gainCanvasBlob(canvas, onBlob);
            })(iW, iH);
            iW *= 2;
            iH *= 2;
        }
    };
    img.src = url;
    return imgFile.md5;
}

//添加素材到图库
function addPanoFileInfo(md5) {
    var tagstr = "default";
    var index = 0;
    if ($("#pano_link").closest('li').hasClass('active')){
      var str = $("#catelog-list li.active").find("p:first").text();
      if("默认图册"!=str){tagstr = str}
        index = $("#catelog-list li.active").index();
    }
    var fileinfo = {
        oorigin_id: md5,
        category: "panorama",
        tags: [tagstr]
    };
    var fs = addfileinfo(fileinfo);
    if (SLCProjManage.panoCatelog&&SLCProjManage.panoCatelog.length>index) {
        SLCProjManage.panoCatelog[index].data.push(fs);
        if ($("#pano_pane")[0].tags && $("#pano_pane")[0].tags.length > index) {
        if(!$("#pano_pane")[0].tags[index].pane.filelist||$("#pano_pane")[0].tags[index].pane.filelist.length==0)$("#pano_pane")[0].tags[index].pane.filelist = [fileinfo];
            $("#pano_pane")[0].tags[index].pane.update(true);
        }
    }
}

function addMaterialFileInfo(md5) {
    var fileinfo = {
        oorigin_id: md5,
        category: "material"
    };
    var fs = addfileinfo(fileinfo);
    if (SLCProjManage.materialList) {
        SLCProjManage.materialList.push(fs);

        $("#material_pane")[0].update(true);
    }
}

function validResource(resArr) {
    var arrs = [];
    for (var i = 0; i < resArr.length; i++) {
        if (!resArr[i] || resArr[i] == "")
            continue;
        if (ResourceMgr.resources[resArr[i]] === undefined) {
            arrs.push(resArr[i]);
        }
    }
    if (arrs.length > 0) {
        var urls = SLCUtility.callFunc("POST", "getFiles", arrs).data;
        if (urls) {
            var ress = {};
            validResMap(urls, ress);
            ResourceMgr.update(ress);
        }
    }
}

function onSaveSceneSettingClick() {
    var name = $("#scene-name-psm").val();
    var descript = $("#scene-description-psm").val();
    if (!name || name.length === 0) {
        alert("场景名称不能为空!");
        return;
    }
    var isEdit = $("#scene-setting-mdl")[0].editScene !== null;

    function createScene(md5, thumb_md5) {
        var jsonObj = {
            id: SLCProjManage.currProj.id,
            scenes: [{
                name: name,
                desc: descript,
                "res_id": md5,
                thumbnail_res_id: thumb_md5
            }]
        };

        validResource([md5, thumb_md5]);
        var proObj = SLCUtility.callFunc("POST", "addScene", jsonObj);
        var success=true;
        if (proObj && proObj.err_code === 0) {
            for(var i=0;i<proObj.data.length;i++){
                var obj=proObj.data[i];
                if(obj.res_id==null||obj.res_id==""){
                    success=false;
                    break;
                }
            }
            sceneTblAddRows(proObj.data);
            var proj = SLCProjManage.currProj;
            if (proj.scenes === undefined || proj.scenes === null) {
                proj.scenes = [];
            }
            proj.scenes = proj.scenes.concat(proObj.data);
        }
        if(success){
            alert("场景上传成功");
            $("#scene-name-psm").val("");
            $("#scene-description-psm").val("");
            $("#scene-setting-mdl .img-cls").remove();
            $('#select_scenen_img').val("");
            $("#scene-setting-mdl").modal('hide');
        }else{
            alert("场景上传失败");
        }
    }

    function updateScene(md5, thumb_md5) {
        var scene = $('#scene-setting-mdl')[0].editScene;
        if (scene.name === name && scene.desc === descript && scene.res_id === md5) {
            $('#scene-setting-mdl').modal('hide');
            return;
        }

        scene.name = name;
        scene.desc = descript;
        scene.res_id = md5;
        if (thumb_md5)
            scene.thumbnail_res_id = thumb_md5;
        var jsonObj = {
            id: SLCProjManage.currProj.id,
            scenes: [scene]
        };
        validResource([md5, thumb_md5]);
        var proObj = SLCUtility.callFunc("POST", "updateScene", jsonObj);
        var success=true;
        if (proObj && proObj.err_code === 0) {
            for(var i=0;i<proObj.data.length;i++){
                var obj=proObj.data[i];
                if(obj.res_id==null||obj.res_id==""){
                    success=false;
                    break;
                }
            }
        }
        if(success){
            alert("场景更新成功");
            $("#scene-tbl-id").DataTable().clear();
            sceneTblAddRows(SLCProjManage.currProj.scenes);
            $("#scene-name-psm").val("");
            $("#scene-description-psm").val("");
            $("#scene-setting-mdl .img-cls").remove();
            $('#select_scenen_img').val("");
            $("#scene-setting-mdl").modal('hide');
        }else{
            alert("场景更新失败");
        }


    }

    function createDefaultThumb(df, sceneSrc) {
        var scene = $('#scene-setting-mdl')[0].editScene;
        if (scene && scene.res_id == sceneSrc)
            return df.resolve();
        var img = $("img", "#scene-setting-mdl .scene-img-area").get(0);
        var canvas = document.createElement("canvas");
        var camera = new THREE.PerspectiveCamera(75, 2, 1, 1100);
        camera.target = new THREE.Vector3(0, 0, 500);

        var scene = new THREE.Scene();

        var geometry = new THREE.SphereGeometry(500, 60, 40);
        geometry.scale(-1, 1, 1);

        var loader = new THREE.TextureLoader();
        loader.setCrossOrigin("");
        var texture = new THREE.Texture();
        texture.image = img;
        texture.needsUpdate = true;

        var material = new THREE.MeshBasicMaterial({
            map: texture
        });

        var mesh = new THREE.Mesh(geometry, material);

        scene.add(mesh);
        var renderer = new THREE.WebGLRenderer({
            preserveDrawingBuffer: true,
            canvas: canvas
        });
        renderer.setSize(256, 128);

        function clear() {
            scene.remove(mesh);
            geometry.dispose();
            texture.dispose();
            material.dispose();
            renderer.clear();
        }

        function complate(blob) {
            var dfInner = jQuery.Deferred();
            dfInner.done(function(blob, md5) {
                df.done(clear);
                uploadBlob(df, blob, md5, "thumb");
            });
            getBlobMd5(dfInner, blob);
        }

        function gain() {
            renderer.render(scene, camera);
            gainCanvasBlob(renderer.domElement, complate);
        }

        if (img.complete) {
            gain();
        } else {
            img.readystatechange = function() {
                gain();
            };
        }
    }

    function modifyScene(md5, thumb_md5, bfileInfo) {
        if(md5==null||md5==undefined||md5==""){
            alert("场景上传失败");
            return;
        }
        if (isEdit) {
            updateScene(md5, thumb_md5);
        } else {
            createScene(md5, thumb_md5);
        }
        if (bfileInfo)
            addPanoFileInfo(md5);
    }

    var src = $("#scene-setting-mdl")[0].scene;
    if (src === null || src === undefined || src == "") {
        if (isEdit) {
            updateScene(null);
        } else {
            alert("请选择场景!");
        }
        return;
    }
    if (typeof src == "string") {
        var df = jQuery.Deferred();
        df.done(function(thumb_md5) {
            modifyScene(src, thumb_md5, false);
        });
        createDefaultThumb(df, src);
    } else {
        $('#scene-setting-mdl button').attr('disabled', true);
        var onUploadSucced = (function(imgMd5) {
            return function() {
                var md5 = imgMd5;
                var df = jQuery.Deferred();
                df.done(function(thumb_md5) {
                    modifyScene(md5, thumb_md5, true);
                });
                createDefaultThumb(df, md5);
                $('#scene-setting-mdl button').removeAttr('disabled', true);
            }
        })(src.md5);
        var onUploadCancel=function () {
            $('#scene-setting-mdl button').removeAttr('disabled', true);
        };
        lrzImg(src, onUploadSucced, $("#scene-setting-mdl .modal-dialog"), true,onUploadCancel);
    }
}

function createSceneByOther() {
    var name = $("#scene-name-psm").val();
    var descript = $("#scene-description-psm").val();
    if (!name || name.length === 0) {
        alert("项目名称不能为空!");
        return;
    }

    if (ResourceMgr.resources[md5] === undefined) {
        var urls = SLCUtility.callFunc("POST", "getFiles", [md5]).data;
        if (urls) {
            var ress = {};
            validResMap(urls, ress);
            ResourceMgr.update(ress);
        }
    }
}

function playBackgroundMusic() {
    var files = $('#music')[0].files;
    var audio = $("#bg_music_player").get(0);
    if (files.length > 0 || (audio.src !== "" && audio.src !== undefined)) {
        if ($("#bg_music_player").get(0).paused) {
            if (files.length > 0) {
                var fileURL = URL.createObjectURL(files[0]);
                audio.src = fileURL;
            }
            audio.play();
            $("#tryMusic").html("暂停");
        } else {
            audio.pause();
            $("#tryMusic").html("试听");
        }

    } else {
        alert("Selecting a music file first, please.");
        $("#music").trigger('click');
    }
}

$("#set_music").click(function() {
    var music = SLCProjManage.currProj.background_music;
    if (music.title !== "") {
        $("#music_title").val(music.title);
    } else {
        $("#music_title").val("");
    }

    $('#music-setting-mdl').modal({
        backdrop: false,
        keyboard: false
    });

    var audio = $("#bg_music_player").get(0);
    if (music.res_id !== "") {
        audio.src = ResourceMgr.decodeRes(music.res_id);
    } else {
        audio.src = "";
    }

    $("#music").val("");
    $("#music")[0].res_id = "";
});

$("#music").change(function() {
    var files = $('#music')[0].files;
    if (files && files.length > 0) {
        fileMd5(files[0], null);
        $('#music')[0].res_id = "";
    }
});

$("#deleteMusic").click(function() {
    $("#music_title").val("");
    $('#music').val("");
    $("#bg_music_player").val("");
    var music = SLCProjManage.currProj.background_music;
    music.title = "";
    music.res_id = null;
});

$('#musicDone').click(function() {
    var music = SLCProjManage.currProj.background_music;
    if ($("#music_title").val() != music.title) {
        music.title = $("#music_title").val();
    }
    var files = $('#music')[0].files;
    if (($("#music_title").val() === "" || $("#music_title").val() === undefined) &&
        (files && files.length > 0 || $('#music')[0].res_id)
    ) {
        alert("标题不能为空");
        return;
    }
    if (files && files.length > 0) {
        var f = files[0];
        var strName = files[0].name;

        var buttons = $('#music-setting-mdl .modal-dialog button');
        buttons.each(function() {
            $(this).attr("disabled", true);
        });

        var pos = strName.lastIndexOf('.');
        var ext = strName.substr(pos);
        f.md5Identifier = f.md5 + ".original.original" + ext;

        var afterUploaded = function() {
            buttons.each(function() {
                $(this).removeAttr("disabled");
            });
            music.res_id = f.md5;
            $('#music').val("");
            res = SLCUtility.callFunc("POST", "updateProject", SLCProjManage.currProj);
            if (res && res.err_code === 0) {
                SLCProjManage.currProj = res.data;
                updateProjectInlist(SLCProjManage.currProj);
            }
            updateProjectResource();
            $('#music-setting-mdl').modal('hide');
        };
        var triggerUpload = {
            "size": 1,
            "currtent": 0,
            "trigger": function() {
                triggerUpload.currtent += 1;
                if (triggerUpload.currtent == triggerUpload.size) {
                    uploader.upload();
                }
            },
        };
        var uploader = createUploadFileObj(afterUploaded, triggerUpload, $('#music-setting-mdl .modal-dialog'));
        uploader.addFile(f);
    } else {
        if ($('#music')[0].res_id && $('#music')[0].res_id != "")
            music.res_id = $('#music')[0].res_id;
        res = SLCUtility.callFunc("POST", "updateProject", SLCProjManage.currProj);
        if (res && res.err_code === 0) {
            SLCProjManage.currProj = res.data;
            updateProjectInlist(SLCProjManage.currProj);
        }
        $('#music-setting-mdl').modal('hide');
    }
});

$('#generate-qrcode-btn').click(function(e) {
    var url = getProjectUrl(SLCProjManage.currProj);

    $('#project-qrcode').empty();
    $('#project-qrcode').qrcode(url);
});


function miniSceneItem(scene, onSelect) {
    if (!scene) {
        return;
    }

    var li = $('<li/>')
        .addClass('mini-scene-item dropdown-item')
        .data('idx', scene.id);
    li.click(onSelect);

    var fs = ResourceMgr.find(scene.res_id);
    var url = '';
    if (fs && fs.length > 0) {
        url = fs[0].access_url;
    }
    var img = $('<img crossorigin="Anonymous" />')
        .addClass('mini-scene-img')
        .attr('src', url)
        .appendTo(li);
    var title = $('<span/>', {
        text: scene.name
    }).appendTo(li);
    return li;
};

function appendMiniSceneComponent(sandTablePoint) {
    var spv = addSandTablePoint($('#sand-table-mdl .sand-table-view'), sandTablePoint);
    var pane = miniSceneComponent(sandTablePoint, spv);
    $('#sand-table-mdl .scene-list').append(pane);
    $(pane).find('li').trigger('click');
}

function miniSceneComponent(sandTablePoint, spv) {
    var scene = undefined;
    var scenes = SLCProjManage.currProj.scenes;
    for (var i = 0; i < scenes.length; ++i) {
        if (scenes[i].id == sandTablePoint.scene_id) {
            scene = scenes[i];
            break;
        }
    }

    if (!scene) {
        scene = {
            id: sandTablePoint.scene_id,
            name: '',
            res_id: ''
        }
    }

    var onSelect = function(e) {
        visible = $(li).siblings('form').is(':visible');
        $(e.target).closest('div')
            .siblings()
            .removeClass('selected-mini-scene')
            .children('form')
            .hide();
        $('#sand-table-mdl .sand-table-view .sand-table-arrow')
            .removeClass('current');
        if (!visible) {
            spv.addClass('current');
            $(li).closest('div').addClass('selected-mini-scene');
            $(li).siblings('form').show();
        } else {
            $(li).closest('div')
                .removeClass('selected-mini-scene')
                .children('form')
                .hide();
        }
    };
    var pane = $('<div></div>');
    var li = miniSceneItem(scene, onSelect);
    $(li).addClass('mini-scene-picked-item').appendTo(pane);
    var form = $.parseHTML(
        "<form class=\"sand-point-form clearfix\"> \
            <div class=\"clearfix\"> \
                <label class=\"left\" for=\"" + sandTablePoint.scene_id + "-x\">X\u8F74</label>\
                <input class=\"right\" id=\"" + sandTablePoint.scene_id + "-x\" type=\"range\" min=\"0\" max=\"1\" value=\"" + sandTablePoint.percentx + "\" step=\"0.01\">\
            </div>\
            <div class=\"clearfix\">\
                <label class=\"left\" for=\"" + sandTablePoint.scene_id + "-y\">Y\u8F74</label>\
                <input class=\"right\" id=\"" + sandTablePoint.scene_id + "-y\" type=\"range\" min=\"0\" max=\"1\" value=\"" + sandTablePoint.percenty + "\" step=\"0.01\">\
            </div>\
            <div class=\"clearfix\">\
                <label class=\"left\" for=\"" + sandTablePoint.scene_id + "-v\">\u89C6\u89D2</label>\
                <input class=\"right\" id=\"" + sandTablePoint.scene_id + "-v\" type=\"range\" min=\"0\" max=\"360\" value=\"" + sandTablePoint.angle + "\">\
            <div>\
        <form>");
    pane.append(form);

    var stv = $('#sand-table-mdl .sand-table-view');
    var preSel = '#' + sandTablePoint.scene_id + '-';
    $(form).find(preSel + 'x').on('input change', function() {
        spv.css('left', $(this).val() * stv.width());
    });
    $(form).find(preSel + 'y').on('input change', function() {
        spv.css('top', $(this).val() * stv.height());
    });
    $(form).find(preSel + 'v').on('input change', function() {
        spv.css('transform', 'rotate(' + $(this).val() + 'deg)');
    });
    $(form).hide();
    return pane;
}

$("#set-sand-table").click(function() {
    var sand_table = SLCProjManage.currProj.sand_table;
    if (sand_table.res_id) {
        var url = ResourceMgr.decodeRes(sand_table.res_id);
        $("#sand-table-pic").attr('src', url);
    }
    var files = $('#sand-pic-input')[0].files;
    var hasFile = (files && files.length > 0) || sand_table.res_id;
    if (hasFile && SLCProjManage.currProj.scenes.length) {
        $('#sand-add-scene').removeAttr('disabled');
    } else {
        $('#sand-add-scene').attr('disabled', true);
    }

    if (!sand_table.res_id) {
         $("#sand-table-pic").attr('src', "../img/add-pic.png");
    }

    $('.mini-scene-item').remove();
    for (var i = 0; i < sand_table.points.length; ++i) {
        appendMiniSceneComponent(sand_table.points[i]);
    }

    $('#sand-table-mdl').modal({
        backdrop: false,
        keyboard: false
    });
});

$('#sand-add-scene').click(function() {
    $('#sand-table-mdl .dropdown-menu').empty();
    $.each(SLCProjManage.currProj.scenes, function(i) {
        var scene = SLCProjManage.currProj.scenes[i];

        function onclick(e) {
            var item = $(e.target).closest('li');
            stp = {
                "percentx": 0.5,
                "percenty": 0.5,
                "angle": 0,
                "scene_id": item.data("idx")
            }
            appendMiniSceneComponent(stp);
        }
        $('#sand-table-mdl .dropdown-menu').append(miniSceneItem(scene, onclick));
    })
});

$("#sand-table-pic").click(function(e) {
    e.preventDefault();
    $("#sand-pic-input").trigger('click');
});

$("#sand-pic-input").change(function(e) {
    var files = $('#sand-pic-input')[0].files;
    if (files && files.length > 0) {
        fileMd5(files[0], null);
    }
    var img = $("#sand-table-pic").get(0);
    img.src = URL.createObjectURL(files[0]);
    $('#sand-add-scene').removeAttr('disabled')
});

function collectCurrentProjectSandPointInfo() {
    var sand_table = SLCProjManage.currProj.sand_table;
    sand_table.points = [];
    $('.scene-list form').each(function(i, form) {
        var inputs = $(form).find('input');
        var id = $(form).siblings('li').data('idx');
        var point = {
            'percentx': Number(inputs[0].value),
            'percenty': Number(inputs[1].value),
            'angle': Number(inputs[2].value),
            'scene_id': Number(id)
        };
        sand_table.points.push(point);
    })
}

$("#sand-del-scene").click(function() {
    var scene_id = $('.scene-list .selected-mini-scene li').data("idx");
    if (!scene_id) {
        return;
    }
    sandPointView(scene_id).remove();
    $('.scene-list .selected-mini-scene').remove();
});

$("#sand-table-del").click(function(){
    $("#sand-table-pic").attr('src', "../img/add-pic.png");
    $("#sand-table-pic").data('del', true);
    $('.sand-table-arrow').remove();
    $('#sand-table-mdl .scene-list').empty();
})

$("#sand-table-done").click(function() {
    collectCurrentProjectSandPointInfo();
    $('.scene-list').empty();
    var updatePrj = function() {
        res = SLCUtility.callFunc("POST", "updateProject", SLCProjManage.currProj);
        if (res && res.err_code === 0) {
            SLCProjManage.currProj = res.data;
            updateProjectInlist(SLCProjManage.currProj);
        }
        updateProjectResource();
        $('#sand-table-mdl').modal('hide');
        $('.sand-table-arrow').remove();
    };
    var sand_table = SLCProjManage.currProj.sand_table;
    var files = $('#sand-pic-input')[0].files;
    if (!files.length) {
        var del = $("#sand-table-pic").data('del');
        if (del == true) {
            $("#sand-table-pic").data('del', false);
            sand_table.res_id = null;
        }
        updatePrj();
        return;
    }

    var f = files[0];
    var strName = files[0].name;
    var pos = strName.lastIndexOf('.');
    var ext = strName.substr(pos);
    f.md5Identifier = f.md5 + ".original.original" + ext;

    var afterUploaded = function() {
        sand_table.res_id = f.md5;
        $('#sand-pic-input').val("");
        $('#sand-table-pic').val("");
        updatePrj();
    };
    var triggerUpload = {
        "size": 1,
        "currtent": 0,
        "trigger": function() {
            triggerUpload.currtent += 1;
            if (triggerUpload.currtent == triggerUpload.size) {
                uploader.upload();
            }
        },
    };
    var uploader = createUploadFileObj(afterUploaded, triggerUpload, $("#sand-table-mdl .modal-dialog"));
    uploader.addFile(f);
});

function adjustLogoImgSize(event) {
    var e = event || window.event;
    var img = e.target;
    var max = 250;
    if (img.width > max || img.height > max) {
        if (img.width / img.height > 1) {
            img.height = max * img.height / img.width;
            img.width = max;
        } else {
            img.width = max * img.width / img.height;
            img.height = max;
        }
    }
    $(img).css('display', '');
}

function showLogoSetting(logo, beforeSave) {
    if (logo && logo.title !== "") {
        $("#logo-title").val(logo.title);
    } else {
        $("#logo-title").val("");
    }

    $('#logo-setting-mdl').modal({
        backdrop: false,
        keyboard: false
    });

    var imgArea = $('#logo-img-area');
    imgArea.empty();
    if (logo.res_id !== "") {
        var img = new Image();
        img.crossOrigin = "Anonymous";
        img.src = ResourceMgr.decodeRes(logo.res_id);
        img.onload = adjustLogoImgSize;
        $(img).css('display', 'none');
        imgArea.append(img);
    } else {
        imgArea.append('<div>此项目没有设置对应的logo图标</div>');
    }
    setDoneLogo(logo, beforeSave);
}

$('#logo-setting-btn').click(function() {
    var beforeSave = function() {
        SLCProjManage.currProj.logo_link = $("#logo-link").val();
    };

    $('#logo-link-wrap').show();
    $('#logo-link').val(SLCProjManage.currProj.logo_link);
    showLogoSetting(SLCProjManage.currProj.logo, beforeSave);
});

$("#select-logo").click(function(e) {
    e.preventDefault();
    $("#file-logo").trigger('click');
});

$('#delete-logo').click(function(e) {
    $('#logo-img-area').empty();
    $("#logo-title").val('');
    $('#file-logo').val('');
    $('#file-logo').get(0).url = null;
});

$('#set-bottom-logo').click(function() {
    $('#logo-link-wrap').hide();
    showLogoSetting(SLCProjManage.currProj.bottom_logo);
});

$("#file-logo").change(function(e) {
    var files = $('#file-logo')[0].files;
    $('#file-logo')[0].url = null;
    if (files.length > 0) {
        if ($("#logo-title").val().length === 0) {
            $("#logo-title").val(files[0].name);
        }

        fileMd5(files[0], null);
        var img = new Image();
        var url = URL.createObjectURL(files[0]);
        img.src = url;
        $(img).css('display', 'none');
        img.onload = adjustLogoImgSize;
        $('#logo-img-area').empty();
        $('#logo-img-area').append(img);
    }
});

$('#set-share-logo').click(function() {
    $('#logo-link-wrap').hide();
    showLogoSetting(SLCProjManage.currProj.share_logo);
});

function setDoneLogo(logo, beforeSave) {
    $('#done-logo').unbind('click');
    $('#done-logo').bind('click', function() {
        var files = $('#file-logo')[0].files;
        var title = $("#logo-title").val();
        var childImg = $('#logo-img-area').children('img');
        if (childImg.length === 0) {
            logo.res_id = '';
        }
        if (beforeSave)
            beforeSave();
        if (files && files.length > 0) {
            if (title === "" || title === undefined) {
                alert("标题不能为空");
                return;
            }

            if (title != logo.title) {
                logo.title = title;
            }

            var opts = spinnerOpts();
            var spinner = new Spinner(opts).spin($("#logo-setting-mdl .modal-dialog").get(0));
            var buttons = $('#logo-setting-mdl .modal-dialog button');

            var f = files[0];
            var strName = files[0].name;
            var pos = strName.lastIndexOf('.');
            var ext = strName.substr(pos);
            f.md5Identifier = f.md5 + ".original.original" + ext;

            var afterUploaded = function() {
                logo.res_id = f.md5;
                $('#file-logo').val("");
                buttons.each(function() {
                    $(this).removeAttr("disabled");
                });
                res = SLCUtility.callFunc("POST", "updateProject", SLCProjManage.currProj);
                if (res && res.err_code === 0) {
                    SLCProjManage.currProj = res.data;
                    updateProjectInlist(SLCProjManage.currProj);
                }
                updateProjectResource();
                $(".spinner").remove();
                $('#logo-setting-mdl').modal('hide');
            };
            var triggerUpload = {
                "size": 1,
                "currtent": 0,
                "trigger": function() {
                    triggerUpload.currtent += 1;
                    if (triggerUpload.currtent == triggerUpload.size) {
                        uploader.upload();
                    }
                }
            };
            buttons.each(function() {
                $(this).attr("disabled", true);
            });
            var uploader = createUploadFileObj(afterUploaded, triggerUpload);
            uploader.addFile(f);
        } else {
            if ($('#file-logo')[0].url)
                logo.res_id = $('#file-logo')[0].url;
            if (title != logo.title) {
                logo.title = title;
            }
            res = SLCUtility.callFunc("POST", "updateProject", SLCProjManage.currProj);
            if (res && res.err_code === 0) {
                SLCProjManage.currProj = res.data;
                updateProjectInlist(SLCProjManage.currProj);
            }
            $('#logo-setting-mdl').modal('hide');
        }
    });
}

$('#edit-prj-base-info-btn').click(function(e) {
    $('#edit-prj-base-info-btn').attr('disabled', true);
    $('#save-prj-base-info-btn').attr('disabled', false);

    $('#prj-base-info-name').attr('readonly', false);
    $('#prj-base-info-desc').attr('readonly', false);
});

$('#save-prj-base-info-btn').click(function(e) {
    var title = $('#prj-base-info-name').val();
    var desc = $('#prj-base-info-desc').val();
    var origin = {
        title: SLCProjManage.currProj.title,
        desc: SLCProjManage.currProj.desc
    }
    if (!title) {
        alert("标题不能为空!");
        return;
    }
    SLCProjManage.currProj.title = title;
    SLCProjManage.currProj.desc = desc;
    var res = SLCUtility.callFunc("POST", "updateProject", SLCProjManage.currProj);
    if (res && res.err_code === 0) {
        SLCProjManage.currProj = res.data;
        $("#project-tbl-id").DataTable().clear();
        updateProjectInlist(SLCProjManage.currProj);
        projectTblAddRows(SLCProjManage.projs);


        $('#edit-prj-base-info-btn').attr('disabled', false);
        $('#save-prj-base-info-btn').attr('disabled', true);
        $('#prj-base-info-name').attr('readonly', true);
        $('#prj-base-info-desc').attr('readonly', true);

    } else {
        SLCProjManage.currProj.title = origin.title;
        SLCProjManage.currProj.desc = origin.desc;
        alert("标题已被使用!")
    }
});

function getLinkBtnRow() {
    var link_button_row =
        '<tr> \
        <td> \
            <img class="ico" src="../img/link.png" title="更改图标" disabled></img>\
            <input type="file" class="ico-input" accept="image/*" style="position: fixed; top: -100em" disabled> \
            <div> \
            <span class="used-other btn-primary disabled">素材库</span> \
            <span class="local-file btn-primary disabled">本地上传</span> \
            </div> \
        </td> \
        <td><input class="title" placeholder="输入标题" disabled></td> \
        <td><input class="url" placeholder="输入完整的链接或电话号码" disabled></td> \
        <td class="tbl-operation-d-cls"><span class="edit">编辑</span> <span class="delete">删除</span></td> \
    </tr>';
    var row = $(link_button_row);
    row.find('span.delete').click(function() {
        if (confirm("您确定要删除此项目?") === false) {
            return;
        }
        var tbl = $("#links-tbl-id").DataTable();
        tbl.row($(this).closest('tr')).remove().draw(false);
    });
    row.find('span.edit').click(function() {
        var tbl = row.closest('table');
        tbl.find('input').attr('disabled', true);
        tbl.find('img')
            .attr('disabled', true);
        tbl.find('span.used-other, span.local-file')
            .addClass('disabled');
        tbl.find('span.edit')
            .removeAttr('disabled')
            .removeClass('disabled');

        row.find('input').removeAttr('disabled');
        row.find('img').removeAttr('disabled');
        row.find('span.used-other, span.local-file')
            .removeClass('disabled')
        row.find('span.edit')
            .attr('disabled', true)
            .addClass('disabled');
    });
    row.find('.ico-input').change(function() {
        var files = row.find('.ico-input')[0].files;
        fileMd5(files[0]);
        var url = URL.createObjectURL(files[0]);
        row.find('img').attr('src', url);
    });
    row.find('.local-file').click(function() {
        row.find('.ico-input').trigger('click');
    });
    row.find('span.used-other').click(function() {
        if ($(this).hasClass('disabled')) {
            return;
        }
        var tbl = $("#links-tbl-id").DataTable();
        var callback = function(selectFile) {
            if (!selectFile)
                return;
            row.find('img').attr('src', ResourceMgr.decodeRes(selectFile.oorigin_id));
            row.find('.ico').data('res_id', selectFile.oorigin_id);
            tbl.row($(this).closest('tr')).draw(false);
        }
        SelectMaterial($("#custom-link-mdl")[0], callback);
    });
    return row;
}

function showLinksModal() {
    var tbl;
    if ($.fn.dataTable.isDataTable('#links-tbl-id')) {
        tbl = $("#links-tbl-id").DataTable();
    } else {
        tbl = $("#links-tbl-id").DataTable({
            "bPaginate": false,
            "bFilter": false,
            "bInfo": false,
            "language": {
                "zeroRecords": "没有找到记录",
                "sEmptyTable": "没有找到记录"
            }
        });
    }
    tbl.clear();
    var links = SLCProjManage.currProj.links;
    for (var i = 0; i < links.length; i++) {
        var lk = links[i];
        var fs = ResourceMgr.find(lk.ico);
        if (!fs) {
            updateResourceFromIds([lk.ico]);
            fs = ResourceMgr.find(lk.ico);
        }

        var imgUrl = fs && fs.length > 0 ? fs[0].access_url : "../img/link.png";
        var row = getLinkBtnRow();
        row.find('.ico')
            .attr('src', imgUrl).data('res_id', lk.ico);
        row.find('.title').val(lk.title);
        row.find('.url').val(lk.content);
        tbl.rows.add(row);
    }
    tbl.draw(false);
    $('#custom-link-mdl').modal('show');
}

$('#custom-link-add').click(function() {
    var row = getLinkBtnRow();
    var tbl = $("#links-tbl-id").DataTable();
    tbl.rows.add(row);
    tbl.draw(false);
    row.find('span.edit').trigger('click');
});

$("#custom-links-done").click(function() {
    var triggerUpload = {
        "size": 0,
        "currtent": 0,
        "trigger": function() {
            triggerUpload.currtent += 1;
            if (triggerUpload.currtent == triggerUpload.size) {
                resum.upload();
            }
        },
    };

    function onUploadSucced() {
        var links = [];
        var valid = true;
        $("#links-tbl-id tbody tr").each(function(i, elem) {
            var link = {
                "ico": $(elem).find('.ico').data('res_id'),
                "title": $(elem).find('.title').val(),
                "content": $(elem).find('.url').val()
            };
            if (!$(elem).find('.ico-input').length) {
                return false;
            }
            if (!link.title || !link.content) {
                valid = false;
                $(elem).find('span.edit').trigger('click');
                return false;
            }
            links.push(link);
        });
        if (!valid) {
            alert("标题和链接（或电话号码）都要求填写!");
            return;
        }
        SLCProjManage.currProj.links = links;
        var res = SLCUtility.callFunc("POST", "updateProject", SLCProjManage.currProj);
        if (res && res.err_code === 0) {
            SLCProjManage.currProj = res.data;
            updateProjectInlist(SLCProjManage.currProj);
        } else {
            alert("设置失败!");
        }
        $('#custom-link-mdl').modal('hide');
    };
    var changeIcos = 0;
    var resum = createUploadFileObj(onUploadSucced, triggerUpload);
    $("#links-tbl-id tbody tr").each(function(i, elem) {
        if (!$(elem).find('.ico-input').length) {
            return false;
        }
        var fs = $(elem).find('.ico-input')[0].files;
        if (fs.length) {
            triggerUpload.size += 1;
            changeIcos += 1;
            var strName = fs[0].name;
            var pos = strName.lastIndexOf('.');
            var ext = strName.substr(pos);
            fs[0].md5Identifier = fs[0].md5 + ".original.original" + ext;
            resum.addFile(fs[0]);
            $(elem).find('.ico').data('res_id', fs[0].md5)
        }
    });
    if (!changeIcos) {
        onUploadSucced();
    }
});

$('#set-links').click(function() {
    showLinksModal();
});

function showBtnsModal() {
    var tbl;
    if ($.fn.dataTable.isDataTable('#btns-tbl-id')) {
        tbl = $("#btns-tbl-id").DataTable();
    } else {
        tbl = $("#btns-tbl-id").DataTable({
            "bPaginate": false,
            "bFilter": false,
            "bInfo": false,
            "language": {
                "zeroRecords": "没有找到记录",
                "sEmptyTable": "没有找到记录"
            }
        });
    }
    tbl.clear();
    var buttons = SLCProjManage.currProj.buttons;
    for (var i = 0; i < buttons.length; i++) {
        var btn = buttons[i];
        var fs = ResourceMgr.find(btn.ico);
        if (!fs) {
            updateResourceFromIds([btn.ico]);
            fs = ResourceMgr.find(btn.ico);
        }
        var imgUrl = fs && fs.length > 0 ? fs[0].access_url : "../img/link.png";
        var row = getCustomBtnRow();
        row.find('.ico')
            .attr('src', imgUrl).data('res_id', btn.ico)
            .data('idx', i);
        row.find('.title').val(btn.title);
        row.find('.content').val(btn.content);
        tbl.rows.add(row);
    }
    tbl.draw(false);
    $('#custom-btn-mdl').modal('show');
}

function getCustomBtnRow() {
    var link_button_row =
        '<tr> \
        <td> \
            <img class="ico" src="../img/link.png" disabled></img>\
            <input type="file" class="ico-input" accept="image/*" style="position: fixed; top: -100em" disabled> \
            <div> \
            <span class="used-other btn-primary disabled">素材库</span> \
            <span class="local-file btn-primary disabled">本地上传</span> \
            </div> \
        </td> \
        <td><input placeholder="输入标题" class="title" disabled></td> \
        <td><textarea placeholder="输入你要呈现的内容（支持html）" class="content" disabled></textarea></td> \
        <td class="tbl-operation-d-cls"><span class="edit">编辑</span> <span class="preview">预览</span> <span class="delete">删除</span></td> \
    </tr>';
    var row = $(link_button_row);
    row.find('span.delete').click(function() {
        if (confirm("您确定要删除此项目?") === false) {
            return;
        }
        var tbl = $("#btns-tbl-id").DataTable();
        tbl.row($(this).closest('tr')).remove().draw(false);
    });
    row.find('span.preview').click(function() {
        var html = row.find('.content').val();
        var title = row.find('.title').val();
        $('#custom-btn-preview-mdl .modal-title').text(title);
        $('#custom-btn-preview-mdl .modal-body')
            .empty()
            .append($('<div>' + html + '</div>'));
        $('#custom-btn-preview-mdl').modal('show');
    });
    row.find('span.edit').click(function() {
        var tbl = row.closest('table');
        tbl.find('input').attr('disabled', true);
        tbl.find('textarea')
            .css('height', 'auto')
            .attr('disabled', true);
        tbl.find('img')
            .attr('disabled', true);
        tbl.find('span.used-other, span.local-file')
            .addClass('disabled');
        tbl.find('span.edit')
            .removeAttr('disabled')
            .removeClass('disabled');

        row.find('input').removeAttr('disabled');
        row.find('textarea')
            .css('height', '80px')
            .removeAttr('disabled');
        row.find('img').removeAttr('disabled');
        row.find('span.used-other, span.local-file')
            .removeClass('disabled')
        row.find('span.edit')
            .attr('disabled', true)
            .addClass('disabled');
    });

    row.find('.ico-input').change(function() {
        var files = row.find('.ico-input')[0].files;
        fileMd5(files[0]);
        var url = URL.createObjectURL(files[0]);
        row.find('img').attr('src', url);
    });
    row.find('span.local-file').click(function() {
        row.find('.ico-input').trigger('click');
    });

    row.find('span.used-other').click(function() {
        if ($(this).hasClass('disabled')) {
            return;
        }
        var tbl = $("#btns-tbl-id").DataTable();
        var callback = function(selectFile) {
            if (!selectFile)
                return;
            row.find('img').attr('src', ResourceMgr.decodeRes(selectFile.oorigin_id));
            row.find('.ico').data('res_id', selectFile.oorigin_id);
            tbl.row($(this).closest('tr')).draw(false);
        }
        SelectMaterial($("#custom-btn-mdl")[0], callback, "image");
    });
    return row;
}

$('#custom-btn-add').click(function() {
    var row = getCustomBtnRow();
    var tbl = $("#btns-tbl-id").DataTable();
    tbl.rows.add(row);
    tbl.draw(false);
    row.find('span.edit').trigger('click');
});

$("#custom-btns-done").click(function() {
    var triggerUpload = {
        "size": 0,
        "currtent": 0,
        "trigger": function() {
            triggerUpload.currtent += 1;
            if (triggerUpload.currtent == triggerUpload.size) {
                resum.upload();
            }
        },
    };

    function onUploadSucced() {
        var buttons = [];
        valid = true;
        $("#btns-tbl-id tbody tr").each(function(i, elem) {
            if (!$(elem).find('.ico-input').length) {
                return false;
            }
            var btn = {
                "ico": $(elem).find('.ico').data('res_id'),
                "title": $(elem).find('.title').val(),
                "content": $(elem).find('.content').val()
            };

            if (!btn.title || !btn.content) {
                valid = false;
                $(elem).find('span.edit').trigger('click');
                return false;
            }

            buttons.push(btn);
        });
        if (!valid) {
            alert("标题和html内容都要求填写！");
            return;
        }

        SLCProjManage.currProj.buttons = buttons;
        var res = SLCUtility.callFunc("POST", "updateProject", SLCProjManage.currProj);
        if (res && res.err_code === 0) {
            SLCProjManage.currProj = res.data;
            updateProjectInlist(SLCProjManage.currProj);
        } else {
            alert("设置失败!");
        }
        $('#custom-btn-mdl').modal('hide');
    };
    var changeIcos = 0;
    var resum = createUploadFileObj(onUploadSucced, triggerUpload);
    $("#btns-tbl-id tbody tr").each(function(i, elem) {
        if (!$(elem).find('.ico-input').length) {
            return false;
        }
        var fs = $(elem).find('.ico-input')[0].files;
        if (fs.length) {
            triggerUpload.size += 1;
            changeIcos += 1;
            var strName = fs[0].name;
            var pos = strName.lastIndexOf('.');
            var ext = strName.substr(pos);
            fs[0].md5Identifier = fs[0].md5 + ".original.original" + ext;
            resum.addFile(fs[0]);
            $(elem).find('.ico').data('res_id', fs[0].md5)
        }
    });
    if (!changeIcos) {
        onUploadSucced();
    }
});

$('#set-buttons').click(function() {
    showBtnsModal();
});

function updateProjectInlist(proj) {
    var projs = SLCProjManage.projs;
    for (var i = 0; i < projs.length; i++) {
        if (projs[i].id == proj.id) {
            projs[i] = proj;
            break;
        }
    }
}

function changeCheckSetting(item, checked) {
    SLCProjManage.currProj[item] = checked;
    var res = SLCUtility.callFunc("POST", "updateProject", SLCProjManage.currProj);
    if (res && res.err_code !== 0) {
        SLCProjManage.currProj[item] = !checked;
        alert("设置失败!");
    } else {
        updateProjectInlist(SLCProjManage.currProj);
    }

}

$("#likeCheck").click(function() {
    var checked = $("#likeCheck").is(":checked");
    changeCheckSetting("enable_like", checked);
});

$("#overlookCheck").click(function() {
    var checked = $("#overlookCheck").is(":checked");
    changeCheckSetting("enable_overlook", checked);
});

$("#autorotationCheck").click(function() {
    var checked = $("#autorotationCheck").is(":checked");
    changeCheckSetting("enable_autorotation", checked);
});

$("#autoDeviceOrientationCheck").click(function() {
    var checked = $("#autoDeviceOrientationCheck").is(":checked");
    changeCheckSetting("enable_orientation", checked);
});
$("#vrCheck").click(function() {
    var checked = $("#vrCheck").is(":checked");
    changeCheckSetting("enable_vr", checked);
});

function returnSceneSettingClick() {
    $("#scene-setting-mdl").removeClass("lengthen");
    $(".main-process", "#scene-setting-mdl").show();
    $(".select-process", "#scene-setting-mdl").hide();
}

function selectPanoClick() {
    var pane = $("#pano_select")[0];
    var name = "",
        url = "";
    if (pane.selected.length > 0) {
        $("#scene-setting-mdl")[0].scene = pane.selected[0].oorigin_id;
        var fs = ResourceMgr.find(pane.selected[0].oorigin_id);

        if (fs && fs.length > 0) {
            name = fs[0].name;
            url = fs[0].access_url;
        }
        pane.selected = [];
    } else {
        $("#scene-setting-mdl")[0].scene = "";
    }
    if (!$("#scene-name-psm").val()) {
        $("#scene-name-psm").val(name);
    }

    var obj = $('<div class="img-cls"></div>');
    var img = new Image();
    img.crossOrigin = "Anonymous";
    img.src = url;
    obj.append(img);
    if (name != "")
        obj.append($('<div class="file-name" title="' + name + '">' + name + '</div>'));
    $(".scene-img-area", "#scene-setting-mdl").empty();
    $(".scene-img-area", "#scene-setting-mdl").append(obj);

    returnSceneSettingClick();
}

function onDelPanoImage(elem) {
    var scene = $("#scene-setting-mdl")[0].editScene;
    if (scene && hasPoints(scene)) {
        alert("不能删除已有点位的全景图。");
        return;
    } else {
        if (confirm("你确定要删除此场景的全景图吗？") === false) {
            return;
        }
        $("#scene-setting-mdl .img-cls").remove();
        $('#select_scenen_img').val("");
        $("#scene-setting-mdl")[0].scene = null;
    }
}

function onSelectPanoClick(event) {
    function validShowName(name) {
        if (name == "default")
            return "默认图册";
        return name;
    }

    var scene = $("#scene-setting-mdl")[0].editScene;
    if (scene && hasPoints(scene)) {
        alert("不能更改已有点位的全景图。");
        return;
    }

    var container = $(event.target).closest(".main-process");
    if (container.length == 0)
        return;
    container.hide();
    container.siblings(".select-process").show();
    $("#scene-setting-mdl").addClass("lengthen");

    function click(elem) {
        var val = elem.dataSrc;
        var pane = $("#pano_select")[0];
        var select = [];
        for (var i = 0; i < pane.selected.length; i++) {
            if (pane.selected[i] == val) {
                select.push(pane.selected[i]);
                break;
            }
        }
        pane.selected = select;
        $(elem).siblings(".selected").removeClass("selected");
    }

    validPanoCatelog();
    var strTmpl = '<li><a href="#">{name}</a></li>'
    var select = $(".select-tag", "#pano_select");
    var ul = select.siblings(".dropdown-menu");
    ul.empty();
    ul.unbind('click');

    function show(li, index) {
        li.hide();
        li.siblings('li').show();
        select.html(validShowName(SLCProjManage.panoCatelog[index].name) + '  <span class="caret"></span>');
        initFileListPane($("#pano_select")[0], SLCProjManage.panoCatelog[index].data, 2, click);
    }
    for (var i = 0; i < SLCProjManage.panoCatelog.length; i++) {
        var liName = {name: validShowName(SLCProjManage.panoCatelog[i].name)};
        var li = $(strTmpl.format(liName));
        li.appendTo(ul);
    }
    ul.bind('click', function(e) {
        var li = $(e.target).closest('li');
        if (li.length > 0) {
            var index = $('li', ul).index(li[0]);
            show(li, index);
        }
        select.trigger('click');
        e.stopPropagation();
    });
    show($('li:first', ul), 0);
}

$('#pano_link').on('shown.bs.tab', function(e) {
    // 获取已激活的标签页的名称
    ShowPanoList();
});

function validPanoCatelog() {
    if (!SLCProjManage.panoCatelog ||
        SLCProjManage.panoCatelog.length == 0) {
        var filelist = getFileList("panorama");
        SLCProjManage.panoCatelog = splitCategory(filelist);
    }
}

function ShowPanoList() {
    validPanoCatelog();
    if (!$("#pano_pane")[0].tags || $("#pano_pane")[0].tags.length == 0)
        initPanoPane();
}

$('#material_link').on('shown.bs.tab', function(e) {
    // 获取已激活的标签页的名称
    ShowMaterialList();
});

function getMaterialList() {
    if (!SLCProjManage.materialList ||
        SLCProjManage.materialList.length == 0) {
        SLCProjManage.materialList = getFileList("material");
    }
    return SLCProjManage.materialList;
}

function ShowMaterialList() {
    initFileListPane($("#material_pane")[0], getMaterialList(), 2);
}

function updateFileinfo(fileinfos) {
    var ret = null;
    $.ajax({
        type: "POST",
        data: JSON.stringify(fileinfos),
        url: "/api/updateFileinfo",
        success: function(res) {
            if (res.err_code === 0) {
                ret = res.data;
            }
        },
        async: false
    });
    return ret;
}

function deleteFileinfo(fileinfos) {
    var ret = null;
    var tmp = [];
    for (var i = 0; i < fileinfos.length; i++)
        tmp.push(fileinfos[i].id)
    $.ajax({
        type: "POST",
        data: JSON.stringify(tmp),
        url: "/api/deleteFileinfo",
        success: function(res) {
            if (res.err_code === 0) {
                ret = res.data;
            }
        },
        async: false
    });
    return ret;
}

function deleteCatelogTag(name) {
    var ret = false;
    $.ajax({
        type: "POST",
        data: JSON.stringify({
            category: "panorama",
            tags: name
        }),
        url: "/api/deleteCategoryTag",
        success: function(res) {
            if (res.err_code === 0) {
                ret = true;
            }
        },
        async: false
    });
    return ret;
}

$("#create-category").bind('click', function() {
    var name = $("#category-name").val();
    if (name == "") {
        alert("名字不能为空");
        return;
    }

    var tags = $("#pano_pane")[0].tags;
    for (var i = 0; i < tags.length; i++) {
        if (tags[i].name == name || tags[i].title == name) {
            alert("名字已被使用");
            return;
        }
    }
    var fileinfo = {
        oorigin_id: "",
        category: "panorama",
        tags: [name]
    }
    addfileinfo(fileinfo);
    addCategoryTag(name, []);
    $("#create-tag-mdl").modal('hide');
});

function addCategoryTag(name, filelist, bForce) {
    function validShowName(name) {
        if (name == "default")
            return "默认图册";
        return name;
    }
    var strTmpl = '<li><a href="#"><p>{name}</p></a> </li>'
    var strPaneTmpl = '<div style="overflow:hidden; display: none">  \
                <div class="pane" style="overflow:hidden;">   \
                </div>  \
                <div class="page" style="margin-top: float:right">  \
                <label class="is-show-unique-wrap">不重复:<input class="is-show-unique" type="checkbox"></label>    \
                <button class="preview"> 上一页 </button>  \
                <span class="cur-page">1/1</span>   \
                <button class="next"> 下一页 </button> \
                <input class="jump-page"> </input>    \
                <button class="jump-btn">跳转</button>  \
                </div> </div>';

    var li = $(strTmpl.format({
        name: validShowName(name)
    }));
    li.appendTo($("#catelog-list"));

    var pane = $(strPaneTmpl).appendTo($("#pano_pane"));
    initFileListPane(pane[0], filelist, 2);
    var tag = {
        title: validShowName(name),
        name: name,
        data: filelist,
        pane: pane[0],
        head: li[0]
    };
    $("#pano_pane")[0].tags.push(tag);

    if (!bForce)
        $('<span class="glyphicon glyphicon-remove-circle panolist-delete-img"></span>').prependTo(li.children("a:first"));
}

function splitCategory(filelist) {
    var obj = {default: []};
    var order = ['default'];
    for (var i = 0; i < filelist.length; i++) {
        if (obj[filelist[i].tags[0]] === undefined)
            obj[filelist[i].tags[0]] = [];
        if (filelist[i].oorigin_id == "" &&
            filelist[i].tags[0] != 'default'){
            order.push(filelist[i].tags[0]);
        }
        obj[filelist[i].tags[0]].push(filelist[i]);
    }

    var list = [];
    for (var i = 0; i < order.length; i++) {
        var key = order[i];
        var tmp = [];
        for (var j = 0; j < obj[key].length; j++) {
            if (obj[key][j].oorigin_id !== "")
                tmp.push(obj[key][j]);
        }
        list.push({
            name: key,
            data: tmp
        });
    }
    return list;
}

function initPanoPane() {
    var list = SLCProjManage.panoCatelog;
    $("#pano_pane").empty();
    $("#pano_pane")[0].tags = [];
    if (list.length == 0)
        return;

    for (var i = 0; i < list.length; i++)
        addCategoryTag(list[i].name, list[i].data, list[i].name == "default");
    $("#catelog-list > li").eq(0).addClass("active");
    var tags = $("#pano_pane")[0].tags;
    $(tags[0].pane).show();

    function selectTag(event) {
        var li = $(event.target).closest("li");
        if (li.length == 0)
            return;
        var index = $("#catelog-list > li").index(li[0]);
        if (li.hasClass("active"))
            return;
        li.siblings(".active").removeClass("active");
        li.addClass("active");
        for (var i = 0; i < tags.length; i++)
            $(tags[i].pane).hide();
        $(tags[index].pane).show();
    }

    function deleteTag(event) {
        var li = $(event.target).closest("li");
        if (li.length == 0)
            return;

        var index = $("#catelog-list > li").index(li[0]);
        var newIdx = -1;
        if (li.hasClass('active')) {
            newIdx = index
            if (index + 1 == $("#pano_pane")[0].tags.length) {
                newIdx--;
            }
        }
        var bDelete = true;
        if (tags[index].data && tags[index].data.length > 0)
            bDelete = confirm("确定删除该图册及包含的图片？");
        if (!bDelete)
            return false;

        deleteCatelogTag(tags[index].name);
        $(tags[index].pane).hide();

        li.remove();
        $(tags[index].pane).remove();
        SLCProjManage.panoCatelog.slice(index, 1);
        $("#pano_pane")[0].tags.splice(index, 1);

        if (newIdx >= 0) {
            $(tags[newIdx].pane).show();
            $("#catelog-list > li").eq(newIdx).addClass("active");
        }
    }

    $("#catelog-list").bind('click', function(event) {
        if ($(event.target).closest('.panolist-delete-img').length != 0)
            return deleteTag(event);
        else
            return selectTag(event);
    });

}

var onMaterialEditClick = function() {
    var bInit = true;
    return function() {
        showPage("material-edit-page");
        if (bInit) {
            ShowPanoList();
            bInit = false;
        }
    };
}();

$("#upload_material").click(function(e) {
    $("#selectfile").val("");
    $("#file_title").text("文件名");
    $('#upload-file-mdl').modal({
        backdrop: false,
        keyboard: false
    });
});


$("#upload-pano").click(function(e) {
    $("#selectfile").val("");
    $("#file_title").text("文件名");
    $('#upload-file-mdl').modal({
        backdrop: false,
        keyboard: false
    });
});

$("#upload_file").click(function(e) {
    e.preventDefault();
    $("#selectfile").trigger('click');
});

$("#selectfile").change(function(e) {
    var files = $('#selectfile')[0].files;
    if (files.length > 0) {
        fileMd5(files[0], null);
        $("#file_title").text(files[0].name);
    }
});

$('#fileDone').click(function() {
    function uploadFileMaterial(f) {
        var opts = spinnerOpts();
        var buttons = $('#upload-file-mdl .modal-dialog button');
        var strName = f.name;
        var pos = strName.lastIndexOf('.');
        var ext = strName.substr(pos);
        f.md5Identifier = f.md5 + ".original.original" + ext;

        var afterUploaded = function() {
            buttons.each(function() {
                $(this).removeAttr("disabled");
            });
            $('#upload-file-mdl').modal('hide');

            var fileinfo = {
                oorigin_id: f.md5,
                category: "material"
            };
            addMaterialFileInfo(f.md5);
        };
        var triggerUpload = {
            "size": 1,
            "currtent": 0,
            "trigger": function() {
                uploader.upload();
            },
        };
        buttons.each(function() {
            $(this).attr("disabled", true);
        });
        var uploader = createUploadFileObj(afterUploaded, triggerUpload, $('#upload-file-mdl .modal-dialog'));
        uploader.addFile(f);
    }

    function uploadFilePano(f) {
        var buttons = $('#upload-file-mdl .modal-dialog button');
        buttons.each(function() {
            $(this).attr("disabled", true);
        });
        var onUploadSucced = (function(imgMd5) {
            var md5 = imgMd5;
            return function() {
                buttons.each(function() {
                    $(this).removeAttr("disabled");
                });
                addPanoFileInfo(md5);
                $('#upload-file-mdl').modal('hide');
            };
        })(f.md5);

        var onUploadCancel=function(){
            buttons.each(function() {
                $(this).removeAttr("disabled");
            });
        };
        lrzImg(f, onUploadSucced, $("#upload-file-mdl .modal-dialog"),false,onUploadCancel);

    }
    var files = $('#selectfile')[0].files;
    if (!files || files.length == 0)
        return;

    if ($("#pano_link").closest('li').hasClass('active'))
        uploadFilePano(files[0]);
    else if ($("#material_link").closest('li').hasClass('active'))
        uploadFileMaterial(files[0]);
});

$("#make_category").click(function() {
    $("#category-name").val("");
    $("#create-tag-mdl").modal({
        keyboard: false,
        backdrop: false
    });
});

function removeArrVals(arr, vals) {
    for (var i = 0; i < vals.length; i++) {
        var index = $.inArray(vals[i], arr);
        if (index >= 0)
            arr.splice(index, 1);
    }
}

function addArrVals(arr, vals) {
    for (var i = 0; i < vals.length; i++)
        arr.push(vals[i]);
}

function getSamePicFileInfos(fileInfos, selecteds) {
    function getTag(fileinfo) {
        var tag = null;
        if (fileinfo.tags && fileinfo.tags.length > 0)
            tag = fileinfo.tags[0];
        return tag;
    }
    var tmp = [];
    for (var i = 0; i < fileInfos.length; i++){
        var tag = getTag(fileInfos[i]);
        for (var j = 0; j < selecteds.length; j++){
            if (fileInfos[i].oorigin_id == selecteds[j].oorigin_id &&
                tag == getTag(selecteds[j]))
                tmp.push(fileInfos[i]);
        }
    }
    return tmp;
}

$("#to-other-tag").click(function() {
    if (!$("#to-other-tag").attr('aria-expanded'))
        return;

    function modifyTag(arr, tag) {
        for (var i = 0; i < arr.length; i++)
            arr[i].tags = [tag];
    }

    var tags = $("#pano_pane")[0].tags;
    var cateloglist = $("#catelog-list > li");
    var ul = $("#to-other-tag").siblings("ul:first");
    ul.empty();
    ul.unbind('click');
    if (tags.length <= 1)
        return false;
    var str = '<li><a href="#">{title}</a></li>';
    for (var i = 0; i < tags.length; i++) {
        var li = $(str.format(tags[i]));
        li.appendTo(ul);
        if (cateloglist.eq(i).hasClass("active"))
            li.hide();
    }

    ul.bind('click', function(event) {
        var oldIdx = $(cateloglist).index($('#catelog-list > .active')[0]);
        if (oldIdx < 0)
            return;
        var li = $(event.target).closest('li');
        if (li.length == 0)
            return;

        if (!tags[oldIdx].pane.selected ||
            tags[oldIdx].pane.selected.length == 0) {
            alert("请选择图片");
            $("#to-other-tag").trigger('click');
            return false;
        }

        var index = li.index();
        var vals = tags[oldIdx].pane.selected;
        var is_unique = $(".is-show-unique",  tags[oldIdx].pane)[0].checked;
        if(is_unique){
            vals = getSamePicFileInfos(tags[oldIdx].pane.filelist, vals);
        }

        tags[oldIdx].pane.selected = [];

        modifyTag(vals, tags[index].name);
        updateFileinfo(vals);

        addArrVals(tags[index].data, vals);
        removeArrVals(tags[oldIdx].data, vals);

        tags[index].pane.update(true);
        tags[oldIdx].pane.update(true);
        $("#to-other-tag").trigger('click');
        return false;
    });
});

$('#delete_pano').click(function() {
    event.stopPropagation();
    var index = $("#catelog-list > li").index($('#catelog-list > .active')[0]);
    if (index < 0)
        return;
    var tags = $("#pano_pane")[0].tags;
    if (!tags[index].pane.selected ||
        tags[index].pane.selected.length == 0) {
        alert("请选择图片");
        return;
    } else if (!confirm("是否确认删除选中的" + tags[index].pane.selected.length + "张图片")) {
        return;
    }

    var vals = tags[index].pane.selected;
    tags[index].pane.selected = [];

    var is_unique = $(".is-show-unique", tags[index].pane)[0].checked;
    if(is_unique){
        vals = getSamePicFileInfos(tags[index].pane.filelist, vals);
    }

    deleteFileinfo(vals);
    removeArrVals(tags[index].data, vals);
    tags[index].pane.update(true);
});


$('#delete_material').click(function() {
    event.stopPropagation();
    var pane = $("#material_pane")[0];
    if (!pane.selected ||
        pane.selected.length == 0) {
        alert("请选择图片");
        return;
    } else if (!confirm("是否确认删除选中的" + pane.selected.length + "张图片")) {
        return;
    }

    var vals = pane.selected;
    pane.selected = [];

    var is_unique = $(".is-show-unique", pane)[0].checked;
    if(is_unique){
        vals = getSamePicFileInfos(pane.filelist, vals);
    }

    deleteFileinfo(vals);
    removeArrVals(pane.filelist, vals);
    pane.update(true);
});

$("#used-logo").click(function(e) {
    var callback = function(selectFile) {
        var elem = $("#logo-title");
        if (elem.val == "") {
            elem.val(selectFile.name);
        }
        $('#file-logo')[0].files = null;
        var imgArea = $('#logo-img-area');
        imgArea.empty();
        if (selectFile.oorigin_id !== "") {
            var img = new Image();
            var fs = ResourceMgr.find(selectFile.oorigin_id);
            if (!fs)
                return false;

            $('#file-logo')[0].url = selectFile.oorigin_id;
            img.crossOrigin = "Anonymous";
            img.src = fs[0].access_url;
            if ($("#logo-title").val() == "")
                $("#logo-title").val(fs[0].name);
            img.onload = adjustLogoImgSize;
            $(img).css('display', 'none');
            imgArea.append(img);
        } else {
            imgArea.append('<div>此项目没有设置对应的logo图标</div>');
        }
    }
    SelectMaterial($("#logo-setting-mdl")[0], callback, "image");
});

function SelectMaterial(parent, callback, type) {
    var self = $("#mertial-select-mdl");
    var pane = $(".pane", self);
    var select = null;

    $(parent).modal('hide');
    self.modal({
        keyboard: false,
        backdrop: false
    });

    function click(elem) {
        var val = elem.dataSrc;
        if (select == val) {
            $(elem).removeClass("selected");
            select = null;
            pane.selected = [val];
        } else {
            $(elem).addClass("selected");
            select = val;
            pane.selected = [];
        }
        $(elem).siblings(".selected").removeClass("selected");
    }

    $(".btn-default", "#mertial-select-mdl").unbind('click');
    $(".btn-primary", "#mertial-select-mdl").bind('click', function() {
        if (!select) {
            alert("请选择文件");
            return false;
        }
        callback(select);
        self.modal('hide');
        $(parent).modal({
            keyboard: false,
            backdrop: false
        });
    });

    $(".btn-default", "#mertial-select-mdl").unbind('click');
    $(".btn-default", "#mertial-select-mdl").bind('click', function() {
        self.modal('hide');
        $(parent).modal({
            keyboard: false,
            backdrop: false
        });

        return false;
    });

    $(".btn-primary", "#mertial-select-mdl").unbind('click');
    $(".btn-primary", "#mertial-select-mdl").bind('click', function() {
        if (!select) {
            alert("请选择文件");
            return false;
        }
        $(parent).modal({
            keyboard: false,
            backdrop: false
        });
        callback(select);
        self.modal('hide');
    });

    var filelist = filterFile(getMaterialList(), type);
    var pane = $("#pano_select", self);
    initFileListPane(pane, filelist, 2, click);
}

$('#add-scene-group').click(function() {
    $('#create-group-mdl').modal({});
})


function addImgView(id, parent) {
    var scenes = SLCProjManage.currProj.scenes;
    var idx = sceneIdxById(id, scenes);
    if (idx >= 0) {
        sceneImageView(scenes[idx]).click(function() {
            if ($(this).hasClass('selected')) {
                $(this).removeClass('selected');
            } else {
                $(this).addClass('selected');
            }
        }).appendTo(parent);
    }
}

function validGroupName(name) {
    var list = $('#prj-scene-group-tab .scene-group-content .nav-pills li');
    var invalidName = false;
    list.each(function(idx, li) {
        var usedName = $(li).data('name');
        if (usedName === name) {
            invalidName = true;
        }
    });
    var patrn = /[`~!@ #$%^&*()+<>?:"{},.\/;'[\]]/im;
    return !invalidName && !patrn.test(name);
}

function createGroupUi(name, ids, silence, prepend) {
    if (!name) {
        if (!silence) {
            alert('分组名称不能为空!');
        }
        return null;
    }
    var list = $('#prj-scene-group-tab .scene-group-content .nav-pills li');
    var invalidName = !validGroupName(name);
    if (invalidName) {
        if (!silence) {
            alert('不能使用重复的名称或名称中包含`~!@ #$%^&*()+<>?:"{},.\/;\'[]等非法字符。');
        }
        return null;
    }

    var strTmp = '<li><a href="#' + name + '"  role="tab" data-toggle="tab"><span class="name"> ' + name + '</span>(' + ids.length + ')';
    var icoBtns = '<span class="glyphicon glyphicon-remove-circle panolist-delete-img"></span><span class="glyphicon glyphicon glyphicon-edit panolist-edit-name"></span></a></li>'
    strTmp += (prepend ? '</a></li>' : icoBtns);
    var nav = $(strTmp);
    nav.data('name', name)
        .click(function(e) {
            if (prepend) {
                $('#prj-scene-group-tab .btns-tbl').hide();
            } else {
                $('#prj-scene-group-tab .btns-tbl').show();
            }
        });

    if (prepend) {
        nav.insertBefore(list.first());
    } else {
        nav.insertBefore(list.last());
    }
    $('span.panolist-delete-img', nav).click(function() {
        var li = $(this).closest('li');
        var name = li.data('name');
        li.remove();

        var menu = $('#prj-scene-group-tab .add-group .dropdown-menu');
        var img_area = $('#prj-scene-group-tab #' + name + ' .scene-img-area');
        var scenes = SLCProjManage.currProj.scenes;

        $('.img-cls', img_area).each(function(i, elem) {
            var id = $(elem).data('_id');
            var idx = sceneIdxById(id, scenes);
            groupAddListItem(scenes[idx]).appendTo(menu);
            addImgView(id, $('#prj-scene-group-tab #默认 .scene-img-area'));
        })
        $('#prj-scene-group-tab #' + name).remove();
    });
    var tab_content = $('<div role="tabpanel" class="tab-pane"><div class="scene-img-area"></div></div>').attr('id', name);
    var img_area = $('.scene-img-area', tab_content);
    for (var i = 0; i < ids.length; i++) {
        addImgView(ids[i], img_area);
    }
    $('span.panolist-edit-name', nav).click(function() {
        var li = $(this).closest('li').get(0);
        $("#rename-mdl").data('info', {
            title: "场景分组重命名",
            value: $(li).data('name'),
            callback: function(name) {
                var origin_name = $(li).data('name');
                if (name == origin_name) {
                    return true;
                }
                if (!validGroupName(name)) {
                    alert('不能使用重复的名称或名称中包含`~!@ #$%^&*()+<>?:"{},.\/;\'[]等非法字符。');
                    return false;
                }
                $(li).data('name', name);
                var atext = $('a span.name', $(li)).text();
                $('a span.name', $(li)).text(' ' + name);
                $('a', $(li)).attr('href', '#' + name);
                $('#' + origin_name).attr('id', name);
                return true;

                // change href
                // change table id
            }
        });
        $("#rename-mdl").modal('show');
    });
    $('#prj-scene-group-tab .scene-group-content .tab-content').append(tab_content);
    return nav;
}

$('#rename-mdl').on('shown.bs.modal', function(e) {
    if (e.target !== $('#rename-mdl').get(0)) {
        return;
    }
    var info = $('#rename-mdl').data('info');
    if (info) {
        if (!info.title) {
            info.title = "重命名"
        }
        if (!info.value) {
            info.value = "";
        }
        $('.modal-title', $(this)).text(info.title);
        $('#rename-input', $(this)).val(info.value);
    }
    $("#rename-title").focus();
});

$('#rename-done').click(function() {
    var info = $('#rename-mdl').data('info');
    if (info && info.callback) {
        var res = info.callback($('#rename-input').val());
        if (!res) {
            return;
        }
    }
    $('#rename-mdl').modal('hide');
});

function groupAddListItem(scene) {
    return miniSceneItem(scene, function(e) {
        var li = $(e.target).closest('li');
        var id = li.data('idx');
        li.remove();
        var name = $('#prj-scene-group-tab .scene-group-content .nav li.active').data('name');
        var img_area = $('#prj-scene-group-tab #' + name + ' .scene-img-area');
        addImgView(id, img_area);
        var default_area = $('#prj-scene-group-tab #默认 .scene-img-area');
        $('.img-cls', default_area).each(function(i, elem) {
            if ($(elem).data('_id') == id) {
                $(elem.remove());
            }
        });
    });
}

function initGroupAddlist(ids) {
    var menu = $('#prj-scene-group-tab .add-group .dropdown-menu');
    menu.empty();
    var scenes = SLCProjManage.currProj.scenes;
    for (var i = 0; i < ids.length; i++) {
        var idx = sceneIdxById(ids[i], scenes);
        groupAddListItem(scenes[idx]).appendTo(menu);
    }
}

function initGroupInfo() {
    $('#prj-scene-group-tab .scene-group-content .tab-content').empty();
    var list = $('#prj-scene-group-tab .scene-group-content .nav-pills li');
    if (list.length > 1) {
        list.slice(0, list.length - 1).remove();
    }
    var scenes = SLCProjManage.currProj.scenes;
    var def_group = [];
    $.each(scenes, function(idx, elem) {
        def_group.push(elem.id);
    });
    var groups = SLCProjManage.currProj.scene_groups;
    for (var i = 0; i < groups.length; i++) {
        var grp = groups[i];
        def_group = $(def_group).not(grp.scenes).get();
        createGroupUi(grp.title, grp.scenes, true, false);
    }
    if (def_group.length) {
        var nav = createGroupUi('默认', def_group, true, true);
        initGroupAddlist(def_group);
    }
}

$('a[data-toggle="tab"]').on('shown.bs.tab', function(e) {
    var target = $(e.target).attr("href");
    if (target == '#prj-scene-group-tab') {
        initGroupInfo();
        $('#prj-scene-group-tab .scene-group-content .nav-pills li a[href="#默认"]').first().trigger('click');
        $('#group-scene-done').show();
    } else {
        $('#group-scene-done').hide();
    }
});

$('#create-group').click(function() {
    var name = $('#create-group-mdl #group-name').val();
    $('#create-group-mdl').modal('hide');
    var nav = createGroupUi(name, [], false, false);
    if (nav) {
        $('a', nav).trigger('click');
    }
})

$('#group-add-scene').on('click', function(e) {
    var name = $('#prj-scene-group-tab .scene-group-content .nav li.active').data('name');
    if (name === "默认") {
        alert('默认分组不能添加场景');
        e.stopPropagation();
    }
})

$('#group-del-scene').click(function() {
    var name = $('#prj-scene-group-tab .scene-group-content .nav li.active').data('name');
    if (name === "默认") {
        alert('默认分组不能删除场景');
        return;
    }

    var menu = $('#prj-scene-group-tab .add-group .dropdown-menu');
    var img_area = $('#prj-scene-group-tab #' + name + ' .scene-img-area');
    var scenes = SLCProjManage.currProj.scenes;

    $('.img-cls.selected', img_area).each(function(i, elem) {
        var id = $(elem).data('_id');
        var idx = sceneIdxById(id, scenes);
        groupAddListItem(scenes[idx]).appendTo(menu);
        addImgView(id, $('#prj-scene-group-tab #默认 .scene-img-area'));
    }).remove();
})

$('#group-scene-done').click(function() {
    var groups = [];
    $('#prj-scene-group-tab .tab-content .tab-pane').each(function(i, elem) {
        var id = $(elem).attr('id');
        if (id == '默认') {
            return;
        }
        var group = {
            'title': id,
            scenes: []
        };
        $('.scene-img-area .img-cls', $(elem)).each(function(j, scene) {
            group.scenes.push($(scene).data('_id'));
        })
        groups.push(group);
    });
    SLCProjManage.currProj.scene_groups = groups;
    res = SLCUtility.callFunc("POST", "updateProject", SLCProjManage.currProj);
    if (res && res.err_code === 0) {
        SLCProjManage.currProj = res.data;
        var selected = $('#prj-scene-group-tab .scene-group-content .nav li.active').data('name');
        initGroupInfo();
        $('#prj-scene-group-tab .scene-group-content .nav-pills li').each(function(i, elem) {
            if (selected && $(elem).data('name') == selected) {
                $('a', elem).trigger('click');
            }
        })
        alert('分组修改成功!');

        updateProjectInlist(SLCProjManage.currProj);
    }
    updateProjectResource();
})
