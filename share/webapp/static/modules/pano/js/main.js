/**
 * Created by shiyong on 4/29/16.
 */

var camera, scene, renderer, mesh;

var isUserInteracting = false,
    onMouseDownMouseX = 0, onMouseDownMouseY = 0,
    lon = 0, onMouseDownLon = 0,
    lat = 0, onMouseDownLat = 0,
    phi = 0, theta = 0;

function init() {

    var container;
    container = document.getElementById( 'container' );

    camera = new THREE.PerspectiveCamera( 75, window.innerWidth / window.innerHeight, 1, 1100 );
    camera.target = new THREE.Vector3( 0, 0, 0 );
    //camera.position.setY(500);

    scene = new THREE.Scene();

    var geometry = new THREE.SphereGeometry( 500, 60, 40 );
    geometry.scale( - 1, 1, 1 );

    var material = new THREE.MeshBasicMaterial( {
        map: new THREE.TextureLoader().load( './res/tar.jpg' )
    } );
    mesh = new THREE.Mesh( geometry, material );
    scene.add( mesh );

    renderer = new THREE.WebGLRenderer();
    renderer.setPixelRatio( window.devicePixelRatio );
    renderer.setSize(window.innerWidth, window.innerHeight);
    //renderer.setSize(900, 600);
    container.appendChild( renderer.domElement );

    container.addEventListener( 'mousedown', onDocumentMouseDown, false );
    container.addEventListener( 'mousemove', onDocumentMouseMove, false );
    container.addEventListener( 'mouseup', onDocumentMouseUp, false );
    container.addEventListener( 'mousewheel', onDocumentMouseWheel, false );
    container.addEventListener( 'MozMousePixelScroll', onDocumentMouseWheel, false);
    window.addEventListener( 'resize', onWindowResize, false );

}

function onWindowResize() {

    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();

    renderer.setSize( window.innerWidth, window.innerHeight );

}
function vec3toVec2(vec3) {
        var tmp = vec3.clone();
        var vector = tmp.project(camera);
        var obj = document.getElementsByTagName("canvas")[0];
        //var halfWidth = window.innerWidth / 2;
        //var halfHeight = window.innerHeight / 2;
        var halfWidth = obj.scrollWidth / 2;
        var halfHeight = obj.scrollHeight / 2;

        var result = {

            x: Math.round(vector.x * halfWidth + halfWidth),
            y: Math.round(-vector.y * halfHeight + halfHeight)

        };
        //console.log(result);
        return result;
}

var raycaster = new THREE.Raycaster();
var mouse = new THREE.Vector2();
var addrPoint = null;
var onPointerDownPointerX = null;
var onPointerDownPointerY = null;
function onDocumentMouseDown( event ) {

    event.preventDefault();

    mouse.x = ( event.clientX / window.innerWidth ) * 2 - 1;
    mouse.y = - ( event.clientY / window.innerHeight ) * 2 + 1;
    console.log(mouse);
    //
    raycaster.setFromCamera( mouse, camera );
    var intersects = raycaster.intersectObject( mesh );
    if (intersects.length > 0) {
        var pos = intersects[0].point;
        if (addrPoint === null) {
            addrPoint = pos;
        }
    }
    isUserInteracting = true;

    onPointerDownPointerX = event.clientX;
    onPointerDownPointerY = event.clientY;

    onPointerDownLon = lon;
    onPointerDownLat = lat;

}

function onDocumentMouseMove( event ) {

    if ( isUserInteracting === true ) {
        lon = ( onPointerDownPointerX - event.clientX ) * 0.1 + onPointerDownLon;
        lat = ( event.clientY - onPointerDownPointerY ) * 0.1 + onPointerDownLat;
    }

}

function onDocumentMouseUp( event ) {

    isUserInteracting = false;

}

var cameraMaxFov = 100;
var cameraMinFov = 25;
function onDocumentMouseWheel( event ) {

    // WebKit

    if ( event.wheelDeltaY ) {

        camera.fov -= event.wheelDeltaY * 0.05;

        // Opera / Explorer 9

    } else if ( event.wheelDelta ) {

        camera.fov -= event.wheelDelta * 0.05;

        // Firefox

    } else if ( event.detail ) {

        camera.fov += event.detail * 1.0;

    }

    if (camera.fov < cameraMinFov) camera.fov = cameraMinFov;
    if (camera.fov > cameraMaxFov) camera.fov = cameraMaxFov;
    camera.updateProjectionMatrix();

}

function animate() {

    requestAnimationFrame( animate );
    update();
    if (addrPoint !== null) {
        addrPoint = new THREE.Vector3(470.76959432260077, -75.1807271361399, 149.9030314497126);
        var pos2 = vec3toVec2(addrPoint);
        $("#addrPoint").offset({top: pos2.y, left: pos2.x});
    }

}

function update() {

    if ( isUserInteracting === false ) {
        //lon += 0.1;
    }

    lat = Math.max( - 85, Math.min( 85, lat ) );
    phi = THREE.Math.degToRad( 90 - lat );
    theta = THREE.Math.degToRad( lon );

    camera.target.x = 501 * Math.sin( phi ) * Math.cos( theta );
    camera.target.y = 500 * Math.cos( phi );
    camera.target.z = 500 * Math.sin( phi ) * Math.sin( theta );

    camera.lookAt( camera.target );

    /*
     // distortion
     camera.position.copy( camera.target ).negate();
     */

    renderer.render( scene, camera );

}

init();
animate();
