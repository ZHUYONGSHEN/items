/**
 * Created by shiyong on 5/1/16.
 */

function onSceneJumpClick() {
    var id = SLCUtility.getParentIdByClassId(event, "scene-jump-container");
    if (!id) return;
    create3DScene(scanInfo2, "container");
}
